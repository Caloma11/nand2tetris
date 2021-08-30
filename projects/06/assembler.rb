

comps = {
  "0" => "0101010",
  "1" => "0111111",
  "-1" => "0111010",
  "D" => "0001100",
  "A" => "0110000",# M
  "M" => "1110000",
  "!D" => "0001101",
  "!A" => "0110001",# !M
  "!M" => "1110001",
  "-D" => "0001111",
  "-A" => "0110011", #-M
  "-M" => "1110011",
  "D+1" => "0011111",
  "A+1" => "0110111", #M+1
  "M+1" => "1110111",
  "D-1" => "0001110",
  "A-1" => "0110010", #M-1
  "M-1" => "1110010",
  "D+A" => "0000010", #D+M
  "D+M" => "1000010",
  "D-A" => "0010011", #D-M
  "D-M" => "1010011",
  "A-D" => "0000111", #M-D
  "M-D" => "1000111",
  "D&A" => "0000000", #D&M
  "D&M" => "1000000",
  "D|A" => "0010101", #D|M
  "D|M" => "1010101"
}

dests = {
  "null" => "000",
  "M" => "001",
  "D" => "010",
  "MD" => "011",
  "A" => "100",
  "AM" => "101",
  "AD" => "110",
  "AMD" => "111"
}

jumps = {
  "null" => "000",
  "JGT" => "001",
  "JEQ" => "010",
  "JGE" => "011",
  "JLT" => "100",
  "JNE" => "101",
  "JLE" => "110",
  "JMP" => "111"
}

symbols = {
  "R0" => "0",
  "R1"=>"1",
  "R2"=>"2",
  "R3"=>"3",
  "R4"=>"4",
  "R5"=>"5",
  "R6"=>"6",
  "R7"=>"7",
  "R8"=>"8",
  "R9"=>"9",
  "R10"=>"10",
  "R11"=>"11",
  "R12"=>"12",
  "R13"=>"13",
  "R14"=>"14",
  "R15"=>"15",
  "SP" => "0",
  "LCL" => "1",
  "ARG" => "2",
  "THIS" => "3",
  "THAT" => "4",
  "SCREEN" => "16384",
  "KBD" => "24576"
}



# a instruction => @21
# 000000000010101op code + 15-bit constant
# regex => @\d+


# c instruction
# \D+=.+
# 111 a c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3

# REMOVE WHITESPACES


# WHAT ABOUT SYMBOLS?
# Ex: @LOOP ; @i ; @sum; @R0; @R1
#
# Variable symbols => reprsenet memory locations ( doesn't matter where ) (@sum, @x, @i)
  # It's not predefined and it's not accompanied by a label declaration statement
  # Each such variable is assigned a memory address starting at 16
  # @i => @16 ; @sum => @17
  # Always appear in the context of an A instruction


# Label symbols => represent destinations of go-to commands (@LOOP, @STOP, @END)
  # (LOOP), (END) ... => Declaration of label (it;s a pseudocommand, it does not generate code)
  # We will have to keep track of instruction numbers (pseudocommands do not count)
  # @LOOP means go to the line after the declaration of (LOOP) => keep track of where it was declared
  # Translate @LOOP to @4

# Pre-defined symbols => (SCREEN, KEYBOARD, @R0, @R1 ....)
  # They only happen in A instructions
  # Simply replace the symbol with the corrsponding tranlsation of decimal to binary


# It's a two-step assembly prossess

# FIRSTPASS
  #  When dealing with symbols, we'll use a hash initialized with all the predefined symbols
  #  Then, let us look to a line of code that looks like (LABEL) and add it to the table, value should be @NEXTLINE

# SecondPass
  # Whenever we see a symbol that is not in the table, we know it's a variable
  # Add it to the table, from 16 onward


file_path = ARGV[0]

if !file_path
  raise "No command line argument provided"
elsif !File.exist?(file_path)
  raise "Invalid file path"
end

# should be taken as a command line argument
parsed_file = File.open(file_path).read.gsub("\r", "")

# Array of commands to be parsed
commands = parsed_file.split("\n").reject { |line| line.match?(/^\/\//) || line.empty? }.map(&:strip)
require 'pry-byebug'
# binding.pry

# remove side comments
commands.map! do |c|
  if c.match?(/\/\//)
    c.strip.gsub(" ", "").match(/(?<com>.+)\/\//)[:com]
  else
    c
  end
end

# First Pass
fp_commands = []
symbol_value = 16
commands.each do |command|

  # p "#{index_counter} - #{command}"

  # Define if it needs to be parsed
  if command.match?(/@\D/)
    symbol = command[1..-1]
    # Checks if it's predefiened
    p command
    if symbols.has_key?(symbol)
      fp_commands << command.sub(symbol, symbols[symbol])
    #Checks if it's a label
    elsif commands.include?("(#{symbol})")

      commands_until_here = commands[0..commands.index("(#{symbol})")]
      label_amount = commands_until_here.count { |c| c.match?(/\(.+\)/) }

      index = (commands.index("(#{symbol})") - label_amount) + 1

      fp_commands << "@#{index}"

    # It is just  a regular variable
    else
      symbols[symbol] = symbol_value.to_s
      fp_commands << "@#{symbol_value}"
      symbol_value += 1
    end

  # Does not need to be parsed
  elsif !command.match?(/\(.+\)/)
    fp_commands << command
  end
end

p fp_commands

# Second pass
binary_result = []
fp_commands.each do |command|
  # /checks if it's an A-instruction
  if command[0] == "@"
    binary_result << format('%016d', command[1..-1].to_i.to_s(2))
  else
    start_binary = "111"

    c_instruction = command.match(/(?<dest>.+)=(?<comp>.+)|(?<comp>.+);/)

    dest = c_instruction[:dest]
    if dest
      dest_binary = dests[dest]
    else
      dest_binary = "000"
    end

    comp = c_instruction[:comp]
    comp_binary = comps[comp]

    jump = command.match(/;(?<jmp>.+)/)

    if jump && jump[:jmp]
     jump_binary = jumps[jump[:jmp]]
    else
      jump_binary = "000"
    end


    begin
    binary_result << ("111" + comp_binary + dest_binary + jump_binary)
    rescue
      binding.pry
    end
  end
end



# # ...
# # A instruction to bin


File.write(file_path.sub('.asm', '.myhack'), binary_result.join("\n"))










