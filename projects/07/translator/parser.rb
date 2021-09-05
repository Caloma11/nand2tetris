require_relative 'code_writer'

class Parser

  attr_reader :hack_commands

  def initialize(commands, filename)
    @commands = commands
    @hack_commands = []
    @code_writer = CodeWriter.new(filename)
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
