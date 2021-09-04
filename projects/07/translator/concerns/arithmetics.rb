module Arithmetics

  def add
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

  def sub
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

  def neg
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
  def eq
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

      "@EQUAL#{@current_command}",
      "D;JEQ",


      "(NOTEQUAL#{@current_command})",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to 0
      "@SP",
      "A=M",
      "M=0",
      "@END#{@current_command}",
      "0;JMP",

      "(EQUAL#{@current_command})",
      # Decrement sp pop from the stack
      "@SP",
      "M=M-1",
      # Set bottom stack to -1
      "@SP",
      "A=M",
      "M=-1",

      "(END#{@current_command})",
      # Increment SP
      "@SP",
      "M=M+1"
    ]
  end

  def gt
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

    "@GREATER#{@current_command}",
    "D;JGT",


    "(NOTGREATER#{@current_command})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END#{@current_command}",
    "0;JMP",

    "(GREATER#{@current_command})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END#{@current_command})",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def lt
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

    "@LESSER#{@current_command}",
    "D;JLT",


    "(NOTLESSER#{@current_command})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to 0
    "@SP",
    "A=M",
    "M=0",
    "@END#{@current_command}",
    "0;JMP",

    "(LESSER#{@current_command})",
    # Decrement sp pop from the stack
    "@SP",
    "M=M-1",
    # Set bottom stack to -1
    "@SP",
    "A=M",
    "M=-1",

    "(END#{@current_command})",
    # Increment SP
    "@SP",
    "M=M+1"
    ]
  end

  def and
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

  def or
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

  def not
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
