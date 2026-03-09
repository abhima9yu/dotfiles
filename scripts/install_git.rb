#!/usr/bin/env ruby
# Install Git on Mac via Homebrew.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing Git..."
system("brew install git") || exit(1)
puts "Done. #{`git --version`.strip}"
