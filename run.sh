#! /bin/bash

BASEDIR=$(dirname $0)
VERSIONDIR=latest

if [ "$1" == "help" ] ; then
  echo "run [version]"
  echo ""
  echo "version - Must be a locally copied directory."
  exit 1;
fi

if [[ ! -z "$1" ]] ; then
  if [ -d "$BASEDIR/$1" ] ; then
    VERSIONDIR=$1/chrome-mac
  else
    echo "Version \"$1\" not found"
    exit
  fi
fi

BASENAME="$(cd "$(dirname "$BASENAME")"; pwd)/$(basename "$BASENAME")"
USER_DATA_DIR="$(realpath $BASENAME/user-data-dir)"

open $BASEDIR/$VERSIONDIR/Chromium.app --args --user-data-dir="$USER_DATA_DIR" ${*:2} &> /dev/null &
# open /Applications/Google\ Chrome\ Dev.app --args --user-data-dir="$BASEDIR/user-data-dir" ${*:2} &> /dev/null &
# $BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &
