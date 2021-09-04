require_relative 'concerns/arithmetics'

class CodeWriter

  include Arithmetics
  # There is no pop constant
  def constant(command_parts, i)
    ["// #{command_parts.join(" ")}",
    "@#{command_parts[2]}", # @17
    "D=A",
    "@SP", # Grabs stack pointer
    "A=M", # Grabs RAM[spvalue]
    "M=D", # Puts the number there (ex: 17)
    "@SP",
    "M=M+1"]
  end

  # LCL points to the *base* of local segment
  def local(command_parts, i)
    case command_parts[0]
    when "pop"
      p "pop"
    when "push"
      p "push"
    end
  end

  def pointer(command_parts, i)

  end

  def this(command_parts, i)

  end

  def that(command_parts, i)

  end

  def static(command_parts, i)

  end

  def argument(command_parts, i)

  end

  def temp(command_parts, i)

  end


end
