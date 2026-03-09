#!/usr/bin/env ruby
# Install Oh My Zsh (requires Zsh). Mac has zsh by default.

abort "Zsh not found." unless system("which zsh > /dev/null 2>&1")

if File.directory?(File.expand_path("~/.oh-my-zsh"))
  puts "Oh My Zsh is already installed."
  exit 0
end

puts "Installing Oh My Zsh..."
system('sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"') || exit(1)
puts "Done. Restart your terminal or run: zsh"
