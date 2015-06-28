#!/bin/sh
git pull
jekyll build
git add --all
git status
git commit -m "update"
git push


