#!/bin/bash
DOC_REPO=$1
RELEASE=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "((Entering doc repo))"
cd $DOC_REPO
echo "((Updating))"
git checkout master
git pull
scripts/genRelease $RELEASE
cd $SCRIPT_DIR/../../../public
echo "((Remaking unprepped doc directories))"
rm -r unprepped
mkdir -p unprepped/api_doc
mkdir -p unprepped/guide
mkdir -p unprepped/reference
echo "((Copying files from doc repo))"
echo "((API doc))"
cp -r $DOC_REPO/doc/* unprepped/api_doc/
echo "((API reference))"
cp -r $DOC_REPO/Documentation/Reference/* unprepped/reference/
echo "((API guide))"
cp -r $DOC_REPO/Documentation/Guide/* unprepped/guide/
echo "DONE"