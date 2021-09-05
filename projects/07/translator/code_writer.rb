require_relative 'concerns/arithmetics'

class CodeWriter

  attr_accessor :current_command

  include Arithmetics

  BASE_ADDRESSES = {
    "local" => "LCL",
    "argument" => "ARG",
    "this" => "THIS",
    "that" => "THAT",
    "temp" => "5"
  }

  def initialize(filename)
    @filename = filename
  end

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

  def local(command_parts)
    standard_op(command_parts)
  end

  def argument(command_parts)
    standard_op(command_parts)
  end

  def this(command_parts)
    standard_op(command_parts)
  end

  def that(command_parts)
    standard_op(command_parts)
  end

  def temp(command_parts)
    standard_op(command_parts)
  end


  def pointer(command_parts)
    seg_addr = position == "0" ? "THIS" : "THAT"

    case operation

    when "push"
      ["// #{command_parts.join(" ")}",
      "@#{seg_addr}", # @THIS | @THAT
      "D=M",
      "@SP", # Grabs stack pointer
      "A=M", # Grabs RAM[spvalue]
      "M=D", # Puts the this or that value on top of stack
      "@SP",
      "M=M+1"] # Increment stack
    when "pop"
      ["// #{command_parts.join(" ")}",
      "@SP",
      "A=M-1",
      "D=M ",
      "@val",
      "M=D", # Set value of last stack el to 'val'
      "@SP",
      "M=M-1", # pop from stack
      "@val",
      "D=M",
      "@#{seg_addr}",
      "M=D"
    ]
    end
  end

  def static(command_parts)
    operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      ["// #{command_parts.join(" ")}",
      "@#{@filename}.#{position}", # @Foo.3
      "D=M",
      "@SP", # Grabs stack pointer
      "A=M", # Grabs RAM[spvalue]
      "M=D", # Puts the var value on top of stack
      "@SP",
      "M=M+1"] # Increment stack
    when "pop"
    ["// #{command_parts.join(" ")}",
      "@SP",
      "A=M-1",
      "D=M ",
      "@val",
      "M=D", # Set value of last stack el to 'val'
      "@SP",
      "M=M-1", # pop from stack
      "@val",
      "D=M",
      "@#{@filename}.#{position}",
      "M=D"
    ]
    end
  end

  private

  def standard_op(command_parts)
    operation = command_parts[0]
    segment = command_parts[1]
    position = command_parts[2]

    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@#{BASE_ADDRESSES[segment]}",
        "D=M", # Store value of base address
        "@#{position}",
        "D=D+A ",
        "@addr",
        "M=D", # Add it to offset and save in 'addr'
        "@addr",
        "A=M",
        "D=M", # Store value of ith local in D
        "@SP",
        "A=M", # Go to next available stack addr
        "M=D", # fill it with D
        "@SP", # increment sp
        "M=M+1"
      ]
    when "pop" # Pop from the stack and push it to local
      [
      "// #{command_parts.join(" ")}",
      "@SP",
      "A=M-1",
      "D=M ",
      "@val",
      "M=D", # Set value of last stack el to 'val'
      "@SP",
      "M=M-1", # pop from stack
      "@#{BASE_ADDRESSES[segment]}",
      "D=#{segment == "temp" ? "A" : "M"}", # Store value of base address
      "@#{position}",
      "D=D+A ",
      "@addr",
      "M=D", # Add it to offset and save in 'addr'
      "@val",
      "D=M", # Grab popped value
      "@addr",
      "A=M",
      "M=D" # Set it in RAM[addr]
    ]
    end
  end


end
