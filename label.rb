#!/usr/bin/env ruby

require 'rubygems'
require 'plist'
# http://rubyforge.org/projects/plist/

label=ARGV[0]

dirname=Dir.pwd.split('/').pop()
infoplist_name=dirname+"-Info.plist"
infoplist_filepath=Dir.glob("**/#{infoplist_name}")[0]

plist_obj = Plist::parse_xml( infoplist_filepath )

if (nil == label || 0 == label.length) then
  current_version = plist_obj["CFBundleVersion"]
  components = current_version.split(".")
  major = components[0]
  minor = components[1]
  minor = (minor.to_i+1).to_s
  new_version = [major, minor].join(".")
  label = new_version
end

plist_obj["CFBundleVersion"] = label
plist_obj["CFBundleShortVersionString"] = label
updated_infoplist = plist_obj.to_plist
File.open(infoplist_filepath, 'w') {|f| f.write(updated_infoplist) }

tag = "v#{label}"
`git commit -am 'version bump to #{tag}' && git tag #{tag}`

puts "Labeled #{tag}"