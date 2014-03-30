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
echo "API doc from ${DOC_REPO}/doc to ${DESTINATION}/api_doc..."
cp -r $DOC_REPO/doc/* $DESTINATION/api_doc/
echo "API reference from ${DOC_REPO}/Reference to ${DESTINATION}/reference..."
cp -r $DOC_REPO/Documentation/Reference/* $DESTINATION/reference/
echo "API guide from ${DOC_REPO}/Guide to ${DESTINATION}/guide..."
cp -r $DOC_REPO/Documentation/Guide/* $DESTINATION/guide/
echo "DONE"