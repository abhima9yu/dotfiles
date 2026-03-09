#!/usr/bin/env ruby
# Install rbenv and ruby-build on Mac via Homebrew.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing rbenv and ruby-build..."
system("brew install rbenv ruby-build") || exit(1)
puts "Done. Add to your shell config (e.g. ~/.bashrc or ~/.zshrc):"
puts '  eval "$(rbenv init -)"'
puts "Then run: rbenv install -l   # list versions, then rbenv install <version>"
