#!/usr/bin/env ruby
# Generate an SSH key pair (Mac: uses ssh-keygen).

require "optparse"

options = {
  type: "ed25519",
  comment: nil,
  path: nil,
  bits: nil,
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [OPTIONS]"
  opts.on("-t", "--type TYPE", "Key type: ed25519 (default) or rsa") { |v| options[:type] = v }
  opts.on("-C", "--comment COMMENT", "Comment (e.g. email)") { |v| options[:comment] = v }
  opts.on("-f", "--path PATH", "Output path (default: ~/.ssh/id_<type>)") { |v| options[:path] = v }
  opts.on("-b", "--bits BITS", "Bits for RSA (default 4096); ignored for ed25519") { |v| options[:bits] = v }
  opts.on("-h", "--help", "Show this help") { puts opts; exit }
end.parse!

path = options[:path] || File.expand_path("~/.ssh/id_#{options[:type]}")
comment_arg = options[:comment] ? ["-C", options[:comment]] : []
type_arg = ["-t", options[:type]]
bits_arg = (options[:type].downcase == "rsa" && options[:bits]) ? ["-b", options[:bits]] : []

cmd = ["ssh-keygen", "-q", "-N", "", "-f", path, *type_arg, *comment_arg, *bits_arg]
puts "Running: #{cmd.join(' ')}"
system(*cmd) || exit(1)
puts "Created: #{path} and #{path}.pub"
