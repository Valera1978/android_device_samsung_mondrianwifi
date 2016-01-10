if [ $# -eq 0 ]; then
  SRC=adb
else
  if [ $# -eq 1 ]; then
    SRC=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
    echo ""
    echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
    echo "the device using adb pull."
    exit 1
  fi
fi

FP=$(cd ${0%/*} && pwd -P)
export VENDOR=$(basename $(dirname $FP))
export DEVICE=$(basename $FP)

function extract() {
  for FILE in `egrep -v '(^#|^$)' $1`; do
    echo "Extracting /system/$FILE ..."
    OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
    FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
    DEST=${PARSING_ARRAY[1]}
    if [ -z $DEST ]
    then
      DEST=$FILE
    fi
    DIR=`dirname $FILE`
    if [ ! -d $2/$DIR ]; then
      mkdir -p $2/$DIR
    fi
    if [ "$SRC" = "adb" ]; then
      adb pull /system/$FILE $2/$DEST
    # if file dot not exist try destination
      if [ "$?" != "0" ]
          then
          adb pull /system/$DEST $2/$DEST
      fi
    else
      cp $SRC/system/$FILE $2/$DEST
      # if file dot not exist try destination
      if [ "$?" != "0" ]
          then
          cp $SRC/system/$DEST $2/$DEST
      fi
    fi
  done
}

BASE_PROP=../../samsung/viennalte/proprietary-files.txt
BASE=vendor/samsung/viennalte
BASE_DIR=$BASE/proprietary
rm -rf ../../../$BASE/*

DEV_PROP=../../$VENDOR/$DEVICE/device-proprietary-files.txt
DEV_BASE=vendor/$VENDOR/$DEVICE
DEV_DIR=$DEV_BASE/proprietary
rm -rf ../../../$DEV_BASE/*

extract $BASE_PROP ../../../$BASE_DIR
extract $DEV_PROP ../../../$DEV_DIR

./../../samsung/viennalte/setup-makefiles.sh $BASE_PROP ../../../$BASE $BASE_DIR viennalte
./../../samsung/viennalte/setup-makefiles.sh $DEV_PROP ../../../$DEV_BASE $DEV_DIR $DEVICE

