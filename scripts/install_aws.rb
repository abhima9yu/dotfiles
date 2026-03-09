#!/usr/bin/env ruby
# Install AWS CLI on Mac via Homebrew.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing AWS CLI..."
system("brew install awscli") || exit(1)
puts "Done. #{`aws --version`.strip}"
