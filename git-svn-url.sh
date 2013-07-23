#!/usr/bin/env sh

git svn info | grep ^URL | sed 's/URL: //' | pbcopy
