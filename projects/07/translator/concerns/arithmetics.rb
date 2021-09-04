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


end
