require_relative 'io'
require_relative 'parser'

filepath = ARGV[0]

if !filepath
  raise "No command line argument provided"
elsif !File.exist?(filepath)
  raise "Invalid file path"
end

io = IO.new(filepath)

parser = Parser.new(io.commands)

io.write(parser.hack_commands)
