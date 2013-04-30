#!/usr/bin/env bash

git status -s | grep ^.D | sed -e 's/^.D.//' | xargs git rm
