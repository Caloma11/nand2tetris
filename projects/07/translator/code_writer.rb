require_relative 'concerns/arithmetics'

class CodeWriter

  attr_accessor :current_command

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
  # any one of these segments should be translated to assembly code that
  # accesses address (base þ i) in the RAM, where base is the current value stored
  # in the register dedicated to the respective segment.
  def local(command_parts)
    operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@LCL",
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
      "@LCL",
      "D=M", # Store value of base address
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

  def argument(command_parts)
    operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@ARG",
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
      "@ARG",
      "D=M", # Store value of base address
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

  def this(command_parts)
    operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@THIS",
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
      "@THIS",
      "D=M", # Store value of base address
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

  def that(command_parts)
    operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@THAT",
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
      "@THAT",
      "D=M", # Store value of base address
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

  def pointer(command_parts)

  end

  def static(command_parts)

  end


  def temp(command_parts)
operation = command_parts[0]
    position = command_parts[2]
    case operation
    when "push"
      [
        "// #{command_parts.join(" ")}",
        "@5",
        "D=A", # Store value of base address
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
      "@5",
      "D=A", # Store value of base address
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
