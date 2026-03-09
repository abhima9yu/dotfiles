#!/usr/bin/env ruby
# Install Visual Studio Code on Mac via Homebrew cask.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing Visual Studio Code..."
system("brew install --cask visual-studio-code") || exit(1)
puts "Done. Open from Applications or run: code"
