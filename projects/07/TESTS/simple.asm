@SP
A=M-1
D=M  // Value of last stack el

@val
M=D

@SP
M=M-1

@LCL
D=M

@position
D=D+A
M=D

@val
D=M

@position
A=M
M=D
