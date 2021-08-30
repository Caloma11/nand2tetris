require_relative 'hack_translations'

class Assembler

  include HackTranslations

  def initialize(filepath)
    @filepath = filepath
    @symbol_value = 16
    @binary_result = []

    prepare_input
    first_pass
    second_pass
    write
  end

  private

  def prepare_input
    parsed_file = File.open(@filepath).read.gsub("\r", "")
    # Array of commands to be parsed
    commands = parsed_file.split("\n").reject { |line| line.match?(/^\/\//) || line.empty? }.map(&:strip)
    # Remove side comments
    @commands = commands.map { |c| c.match?(/\/\//) ? c.strip.gsub(" ", "").match(/(?<com>.+)\/\//)[:com] : c }
  end

  def first_pass
    @fp_commands = []
    @commands.each do |command|
      # Define if it needs to be parsed
      if command.match?(/@\D/)
        symbol = command[1..-1]

        # Checks if it's a predefined symbol
        if SYMBOLS.has_key?(symbol)
          @fp_commands << command.sub(symbol, SYMBOLS[symbol])

        #Checks if it's a label
        elsif @commands.include?("(#{symbol})")
          commands_until_here = @commands[0..@commands.index("(#{symbol})")]
          label_amount = commands_until_here.count { |c| c.match?(/\(.+\)/) }
          index = (@commands.index("(#{symbol})") - label_amount) + 1
          @fp_commands << "@#{index}"

        # It is just  a regular variable
        else
          SYMBOLS[symbol] = @symbol_value.to_s
          @fp_commands << "@#{@symbol_value}"
          @symbol_value += 1
        end

      # Does not need to be parsed
      elsif !command.match?(/\(.+\)/)
        @fp_commands << command
      end
    end
  end


  def second_pass
    @fp_commands.each do |command|
      # checks if it's an A-instruction
      if command[0] == "@"
        @binary_result << format('%016d', command[1..-1].to_i.to_s(2))

      # It's a C-instruction
      else
        c_instruction = command.match(/(?<dest>.+)=(?<comp>.+)|(?<comp>.+);/)

        # Translate 'dest' bits
        dest = c_instruction[:dest]
        dest_binary = dest ? DESTS[dest] : "000"

        # Translate 'comp' bits
        comp = c_instruction[:comp]
        comp_binary = COMPS[comp]

        # Translate 'jmp' bits
        jump = command.match(/;(?<jmp>.+)/)
        jump_binary = (jump && jump[:jmp]) ? JUMPS[jump[:jmp]] : "000"

        @binary_result << ("111" + comp_binary + dest_binary + jump_binary)
      end
    end
  end

  def write
    File.write(@filepath.sub('.asm', '.myhack'), @binary_result.join("\n"))
  end

end
