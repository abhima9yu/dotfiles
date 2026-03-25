#!/usr/bin/env ruby
# Install Homebrew on macOS without sudo: unpacks into HOMEBREW_PREFIX (default ~/homebrew).
# See https://docs.brew.sh/Installation#untar-anywhere-unsupported

require "shellwords"
require "fileutils"

def brew_executable?(path)
  File.executable?(File.join(path, "bin", "brew"))
end

prefix = ENV.fetch("HOMEBREW_PREFIX", File.join(Dir.home, "homebrew"))

if system("command -v brew >/dev/null 2>&1")
  puts "Homebrew is already on PATH."
  system("brew", "--version")
  exit 0
end

if brew_executable?(prefix)
  puts "Homebrew already installed at #{prefix}. Add to your shell: eval \"$(#{prefix}/bin/brew shellenv)\""
  system("#{prefix}/bin/brew", "--version")
  exit 0
end

puts "Installing Homebrew to #{prefix} (no sudo; user-owned prefix)..."
FileUtils.mkdir_p(prefix)
escaped = Shellwords.escape(prefix)
tar_ok = system(
  "sh", "-c",
  "curl -fsSL https://github.com/Homebrew/brew/tarball/main | tar xz --strip-components 1 -C #{escaped}",
)
exit 1 unless tar_ok

brew_bin = File.join(prefix, "bin", "brew")
system(brew_bin, "update") || exit(1)
ENV["PATH"] = "#{File.join(prefix, 'bin')}:#{ENV['PATH']}"
system("brew", "--version") || exit(1)
puts "Done. Your setup script should run: eval \"$(#{prefix}/bin/brew shellenv)\""
