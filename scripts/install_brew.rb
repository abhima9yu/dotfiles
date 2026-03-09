#!/usr/bin/env ruby
# Install Homebrew on macOS (https://brew.sh).

if system("which brew > /dev/null 2>&1")
  puts "Homebrew is already installed."
  system("brew --version")
  exit 0
end

puts "Installing Homebrew..."
system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"') || exit(1)
puts "Done. You may need to add Homebrew to PATH (see post-install instructions above)."
