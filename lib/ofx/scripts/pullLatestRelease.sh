#!/bin/bash
DOC_REPO=$1
RELEASE=$2
DESTINATION=$3
echo "Entering doc repo"
cd $DOC_REPO
echo "Updating"
git checkout master
git pull
scripts/genRelease $RELEASE
echo "DONE PROCESSING"
echo "EOF"
exit 0

