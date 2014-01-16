#!/usr/bin/env sh

svn_parent_dir=$1
local_dir=`echo $svn_parent_dir | sed 's/.*\///'`
commit_msg='init new project folders'

svn mkdir $svn_parent_dir -m "$commit_msg"
svn mkdir $svn_parent_dir/trunk -m "$commit_msg"
svn mkdir $svn_parent_dir/tags -m "$commit_msg"
svn mkdir $svn_parent_dir/branches -m "$commit_msg"

git svn clone $svn_parent_dir/trunk $local_dir
