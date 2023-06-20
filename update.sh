#! /bin/bash

cd $(dirname $0)

echo "Arg: $1"

if [[ -z "$1" ]] ; then

  LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac_Arm%2FLAST_CHANGE?alt=media"
  REVISION=$(curl -s -S $LASTCHANGE_URL)
  echo "latest revision is $REVISION"

  if [ -d $REVISION ] ; then
    echo "already have latest version"
    exit
  fi
else
  REVISION=$1
fi
ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac_Arm%2F$REVISION%2Fchrome-mac.zip?alt=media"

ZIP_FILE="${REVISION}-chrome-mac.zip"

echo "fetching $ZIP_URL"

rm -rf $REVISION
mkdir $REVISION
pushd $REVISION
curl -# $ZIP_URL > $ZIP_FILE
echo "unzipping.."
unzip $ZIP_FILE
popd

# Update the latest alias only when run without arguments
if [ $# -eq 0 ] ; then
  rm -f ./latest
  ln -s $REVISION/chrome-mac/ ./latest
fi
