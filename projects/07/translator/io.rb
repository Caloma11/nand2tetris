class IO

  attr_reader :commands

  def initialize(filepath)
    @filepath = filepath
    prepare_input
  end

  def prepare_input
    parsed_file = File.open(@filepath).read.gsub("\r", "")
    # Array of commands to be parsed
    commands = parsed_file.split("\n").reject { |line| line.match?(/^\/\//) || line.empty? }.map(&:strip)
    # Remove side comments
    @commands = commands.map { |c| c.match?(/\/\//) ? c.strip.gsub(" ", "").match(/(?<com>.+)\/\//)[:com] : c }
  end

  def write_it(hack_commands)
    File.write(@filepath.sub('.vm', '.asm'), hack_commands.flatten.join("\n"))
  end
end


