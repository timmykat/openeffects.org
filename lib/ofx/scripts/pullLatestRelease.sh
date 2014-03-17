#!/bin/bash
DOC_REPO=$1
RELEASE=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "**> Entering doc repo"
cd $DOC_REPO
echo "**> Updating"
git checkout master
git pull
scripts/genRelease $RELEASE
cd $SCRIPT_DIR/../../../public
echo "**> Remaking unprepped doc directories"
rm -r unprepped
mkdir -p unprepped/api_ref
mkdir -p unprepped/guide
echo "**> Copying files from doc repo to unprepped doc directories"
cp -r $DOC_REPO/Documentation/Reference/* unprepped/api_ref/
cp -r $DOC_REPO/Documentation/Guide/* unprepped/guide/
