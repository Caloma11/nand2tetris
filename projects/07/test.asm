     // EQ
      // select last number
     @SP
     A=M-1
     D=M
      // set last number
     @lastnumber
     M=D
      // Decrement sp pop from the stack
     @SP
     M=M-1
      // select new last number
     @SP
     A=M-1
     D=M

    @lastnumber
    D=D-M

    @EQUAL
    D;JEQ


    (NOTEQUAL)
      // Decrement sp pop from the stack
     @SP
     M=M-1
    // Set bottom stack to 0
      @SP
      A=M
      M=0
      @END
      0;JMP

    (EQUAL)
    // Decrement sp pop from the stack
     @SP
     M=M-1
    // Set bottom stack to -1
    @SP
    A=M
    M=-1

    (END)
    // Increment SP
    @SP
    M=M+1
