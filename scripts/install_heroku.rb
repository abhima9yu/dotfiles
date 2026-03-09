#!/usr/bin/env ruby
# Install Heroku CLI on Mac via Homebrew.

abort "Homebrew not found. Run: ruby scripts/install_brew.rb" unless system("which brew > /dev/null 2>&1")

puts "Installing Heroku CLI..."
system("brew tap heroku/brew && brew install heroku") || exit(1)
puts "Done. #{`heroku --version`.strip}"
