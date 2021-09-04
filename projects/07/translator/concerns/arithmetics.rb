module Arithmetics

  def add(command_parts, index)
    [
      "// Add",
      # set sum to 0
      "@sum",
      "M=0",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # add last number to sum
      "@sum",
      "M=M+D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # add last number to sum
      "@sum",
      "M=M+D" ,
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1" ,
      # grab result
      "@sum" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1",
    ]
  end

  def sub(command_parts, index)
    [
      "// Sub",
      # set sum to 0
      "@sum",
      "M=0",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # subtract last number to sum
      "@sum",
      "M=M-D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # add last number to sum
      "@sum",
      "M=M+D" ,
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1" ,
      # grab result
      "@sum" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1"
    ]
  end

  def neg(command_parts, index)
    [
      "// Neg",
      # set result to 0
      "@result",
      "M=0",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # subtract last number to result
      "@result",
      "M=M-D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",

      # grab result
      "@result" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1"
    ]
  end

  # {-1 => true, 0 => false}
  def eq(command_parts, index)
    [
      "// EQ",
      "@SP", # select last number
      "A=M-1",
      "D=M",
      # set last number
      "@lastnumber",
      "M=D",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # select new last number
      "@SP",
      "A=M-1",
      "D=M",

      "@lastnumber",
      "D=D-M",

      "@EQUAL#{index}",
      "D;JEQ",


      "(NOTEQUAL#{index})",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to 0
      "@SP",
      "A=M",
      "M=0",
      "@END#{index}",
      "0;JMP",

      "(EQUAL#{index})",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to -1
      "@SP",
      "A=M",
      "M=-1",

      "(END#{index})",
      # Increment SP
      "@SP",
      "M=M+1"
    ]
  end

  def gt(command_parts, index)
    ["// GT",
    # select y
    "@SP",
    "A=M-1",
    "D=M",

    # set y
    "@y",
    "M=D",

    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",

    # select x
    "@SP",
    "A=M-1",
    "D=M",

    "@y",
    "D=D-M",

    "@GREATER#{index}",
    "D;JGT",


    "(NOTGREATER#{index})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END#{index}",
    "0;JMP",

    "(GREATER#{index})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END#{index})",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def lt(command_parts, index)
    ["// LT",
    # select y
    "@SP",
    "A=M-1",
    "D=M",

    # set y
    "@y",
    "M=D",

    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",

    # select x
    "@SP",
    "A=M-1",
    "D=M",

    "@y",
    "D=D-M",

    "@LESSER#{index}",
    "D;JLT",


    "(NOTLESSER#{index})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END#{index}",
    "0;JMP",

    "(LESSER#{index})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END#{index})",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def and(command_parts, index)
    [
      "// And",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      "@lastnumber",
      "M=D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # select new last number
      "@SP",
      "A=M-1",
      "D=M",

      # calc result
      "@lastnumber",
      "M=D&M" ,
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # grab result
      "@lastnumber" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1",
    ]
  end

  def or(command_parts, index)
    [
      "// OR",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      "@lastnumber",
      "M=D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # select new last number
      "@SP",
      "A=M-1",
      "D=M",

      # calc result
      "@lastnumber",
      "M=D|M" ,
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # grab result
      "@lastnumber" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1",
    ]
  end

  def not(command_parts, index)
    [
      "// Not",
      # select last number
      "@SP",
      "A=M-1",
      "D=M",
      # set result to not(last number)
      "@result",
      "M=!D",
      # Decrement sp, pop from the stack
      "@SP",
      "M=M-1",
      # grab result
      "@result" ,
      "D=M",
      # put result on last stack place
      "@SP" ,
      "A=M",
      "M=D",
      # increment sp
      "@SP",
      "M=M+1"
    ]
  end


end
