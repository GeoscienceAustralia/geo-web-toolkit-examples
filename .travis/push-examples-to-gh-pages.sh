#!/bin/bash

if [ "$TRAVIS_REPO_SLUG" == "GeoscienceAustralia/geo-web-toolkit-examples" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  
  echo -e "Publishing examples...\n"
  
  cp -R src/examples $HOME/examples-latest
  
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/GeoscienceAustralia/geo-web-toolkit-examples gh-pages > /dev/null

  cd gh-pages
  git rm -rf * > /dev/null
  cp -Rf $HOME/examples-latest/* .
  git add -f .
  git commit -m "Lastest examples on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Published examples to gh-pages.\n"
  
fi
