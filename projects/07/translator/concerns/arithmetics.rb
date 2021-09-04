module Arithmetics

  def add(command_parts)
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

  def sub(command_parts)
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

  def neg(command_parts)
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
  def eq(command_parts)
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

      "@EQUAL",
      "D;JEQ",


      "(NOTEQUAL)",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to 0
      "@SP",
      "A=M",
      "M=0",
      "@END",
      "0;JMP",

      "(EQUAL)",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to -1
      "@SP",
      "A=M",
      "M=-1",

      "(END)",
      # Increment SP
      "@SP",
      "M=M+1"
    ]
  end

  def gt(command_parts)
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

    "@GREATER",
    "D;JGT",


    "(NOTGREATER)",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END",
    "0;JMP",

    "(GREATER)",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END)",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def lt(command_parts)
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

    "@LESSER",
    "D;JLT",


    "(NOTLESSER)",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END",
    "0;JMP",

    "(LESSER)",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END)",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def and(command_parts)
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

  def or(command_parts)
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

  def neg(command_parts)
    [
      "// Neg",
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
