#!/usr/bin/env sh

forever logs --plain | grep ^data | awk '{ print $4 }' | xargs tail -f
