require_relative 'assembler'

filepath = ARGV[0]

if !filepath
  raise "No command line argument provided"
elsif !File.exist?(filepath)
  raise "Invalid file path"
end

Assembler.new(filepath)
