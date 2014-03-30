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

# cd to app root directory
echo "Copying files from doc repo:"
echo "API doc..."
cp -r $DOC_REPO/doc/* $DESTINATION/api_doc/
echo "API reference..."
cp -r $DOC_REPO/Documentation/Reference/* $DESTINATION/reference/
echo "API guide..."
cp -r $DOC_REPO/Documentation/Guide/* $DESTINATION/guide/
echo "DONE"