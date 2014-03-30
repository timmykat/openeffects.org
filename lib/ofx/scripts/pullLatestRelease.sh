#!/bin/bash
DOC_REPO=$1
RELEASE=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Entering doc repo"
cd $DOC_REPO
echo "Updating"
git checkout master
git pull
scripts/genRelease $RELEASE

# cd to app root directory
cd $SCRIPT_DIR/../../..
echo "Copying files from doc repo:"
echo "API doc..."
cp -r $DOC_REPO/doc/* public/unprepped/api_doc/
echo "API reference..."
cp -r $DOC_REPO/Documentation/Reference/* public/unprepped/reference/
echo "API guide..."
cp -r $DOC_REPO/Documentation/Guide/* public/unprepped/guide/
echo "DONE"