require_relative 'concerns/arithmetics'

class CodeWriter

  include Arithmetics
  # There is no pop constant
  def constant(command_parts)
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
  def local(command_parts)
    case command_parts[0]
    when "pop"
      p "pop"
    when "push"
      p "push"
    end
  end

  def pointer(command_parts)

  end

  def this(command_parts)

  end

  def that(command_parts)

  end

  def static(command_parts)

  end

  def argument(command_parts)

  end

  def temp(command_parts)

  end


end
