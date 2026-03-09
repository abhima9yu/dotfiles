#!/usr/bin/env ruby
# Install Rails gem (requires Ruby).

abort "Ruby not found. Run: ruby scripts/install_ruby.rb or use rbenv" unless system("which ruby > /dev/null 2>&1")

puts "Installing Rails..."
system("gem install rails") || exit(1)
puts "Done. #{`rails --version`.strip}"
