#!/bin/bash
DOC_REPO=$1
RELEASE=$2

cd $DOC_REPO
git checkout master
git pull
scripts/genRelease $RELEASE
    %x( cd #{Rails.configuration.ofx[:documentation_repo][Rails.env]}; git pull )
    %x( #{Rails.configuration.ofx[:documentation_repo][Rails.env]}/scripts/genRelease TESTRELEASE )
