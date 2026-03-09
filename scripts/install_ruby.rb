#!/usr/bin/env ruby
# Install Ruby on Mac via Homebrew.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing Ruby..."
system("brew install ruby") || exit(1)
puts "Done. #{`ruby --version`.strip}"
