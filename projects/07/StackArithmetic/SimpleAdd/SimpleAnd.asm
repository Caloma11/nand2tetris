// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
// And
@SP
A=M-1
D=M
@lastnumber
M=D
@SP
M=M-1
@SP
A=M-1
D=M
@lastnumber
M=D&M
@SP
M=M-1
@lastnumber
D=M
@SP
A=M
M=D
@SP
M=M+1