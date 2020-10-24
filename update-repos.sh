#!/bin/bash

update_repo()
{
  #Based on https://gist.github.com/markrickert/2919901

  #Get master HEAD branch name
  BRANCHNAME="$(git symbolic-ref --short -q HEAD)"

  # Track all branches
  git branch -r | grep -v HEAD | grep -v $BRANCHNAME | while read branch; do
    git branch --track ${branch##*/} $branch
  done

  #Pull all remote data and tags
  git fetch --all
  git fetch --tags
  #git pull --all #causes another fetch --all
  git pull
  git gc --auto # Cleanup unnecessary files and optimize the local repository
}

for d in ./*/ ; do (cd "$d" && echo "Processing $d" && update_repo); done
