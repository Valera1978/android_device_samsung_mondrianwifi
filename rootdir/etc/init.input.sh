#!/system/bin/sh

for i in /sys/class/input/input*
do
    name=`cat $i/name`
    if [ "$name" = gpio-keys -o "$name" = sec_touchscreen ]
    then
        echo "Found $name at $i"
        chown system $i/enabled
        chmod 644 $i/enabled
    fi
done
