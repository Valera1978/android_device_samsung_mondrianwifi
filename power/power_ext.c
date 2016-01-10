/*
 * Copyright (c) 2014 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <ctype.h>

#define LOG_TAG "PowerHAL_H_Ext"
#include <utils/Log.h>

#define MAX_INPUTS 20
#define INPUT_PREFIX "/sys/class/input/input"
#define MAX_PATH_SIZE (strlen(INPUT_PREFIX) + 20)

static const char *names[] = { "sec_touchscreen", "gpio-keys" };
#define N_NAMES (sizeof(names) / sizeof(names[0]))
static char *paths[N_NAMES];
static int have_found_paths;

static size_t sysfs_read(char *path, char *buffer, size_t n)
{
    char buf[80];
    int fd;
    ssize_t len;

    if ((fd = open(path, O_RDONLY)) < 0) {
        if (errno != ENOENT) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error opening %s: %s\n", path, buf);
        }
        return 0;
    }

    len = read(fd, buffer, n);
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error reading from %s: %s\n", path, buf);
        return 0;
    }

    while (len > 0 && isspace(buffer[len-1])) len--;
    if ((size_t) len < n) buffer[len] = '\0';

    close(fd);

    return len;
}

static void sysfs_write(char *path, char *s)
{
    char buf[80];
    int len;
    int fd;

    if (path == NULL) return;

    if ((fd = open(path, O_WRONLY)) < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
    }

    close(fd);
}

static void
find_paths(void)
{
    size_t i, j;
    char path[MAX_PATH_SIZE];
    char name[20];

    for (i = 0; i < MAX_INPUTS; i++) {
        sprintf(path, "%s%d/name", INPUT_PREFIX, i);
        if (sysfs_read(path, name, sizeof(name)) > 0) {
            for (j = 0; j < N_NAMES; j++) {
                if (strcmp(name, names[j]) == 0) {
                    paths[j] = malloc(MAX_PATH_SIZE);
                    sprintf(paths[j], "%s%d/enabled", INPUT_PREFIX, i);
                    ALOGD("%s => %s\n", names[j], paths[j]);
                }
            }
        }
    }
}

void cm_power_set_interactive_ext(int on)
{
    size_t i;

    ALOGD("%s: %s input devices", __func__, on ? "enabling" : "disabling");

    if (! have_found_paths) {
        find_paths();
        have_found_paths = 1;
    }

    for (i = 0; i < N_NAMES; i++) sysfs_write(paths[i], on ? "1" : "0");
}
