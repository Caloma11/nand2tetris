require 'pry-byebug'
require_relative 'code_writer'

class Parser

  attr_reader :hack_commands

  def initialize(commands)
    @commands = commands
    @hack_commands = []
    @code_writer = CodeWriter.new
    parse
  end

  def parse
    @commands.each_with_index do |command, i|
      @code_writer.current_command = i
      @hack_commands << route(command)
    end
  end

  private

  # Routes either a mem_seg or an arithmetic command
  def route(command)
    if command.count(" ") == 2
      @code_writer.send(command.split(' ')[1], command.split(' '))
    else
      @code_writer.send(command)
    end
  end
end


# 0–15 Sixteen virtual registers, usage described below
# 16–255 Static variables (of all the VM functions in the VM program)
# 256–2047 Stack
# 2048–16483 Heap (used to store objects and arrays)
# 16384–24575 Memory mapped I/O


#SP => RAM[0] => Points to the next address of the stack
# LCL => RAM[1] => Points to the base of 'local'
# ARG => RAM[2] =>  Points to the base of 'argument'
# THIS => RAM[3] => POints to the base of 'this' => half of 'pointer'
# THAT => RAM[4] => POints to the base of 'that' => half of 'pointer'
# RAM[5-12] => 'temp'
# RAM[13-15] =....
