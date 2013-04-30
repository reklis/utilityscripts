#!/usr/bin/env bash

port selfupdate; port selfupdate # run twice in case version changed
port upgrade outdated

gem update --system
gem update
sh -c 'GEM_HOME=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8 gem cleanup -q'
gem cleanup -q

# uninstall
#gem list --no-versions | xargs sudo gem uninstall -aIx -i /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8
#gem list --no-versions | xargs sudo gem uninstall -aIx -i /Library/Ruby/Gems/1.8 

npm update -g
