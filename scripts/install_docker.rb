#!/usr/bin/env ruby
# Install Docker Desktop on Mac via Homebrew cask.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing Docker Desktop..."
system("brew install --cask docker") || exit(1)
puts "Done. Open Docker from Applications or run: open -a Docker"
