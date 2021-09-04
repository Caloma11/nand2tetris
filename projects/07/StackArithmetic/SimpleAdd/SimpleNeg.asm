// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 20
@20
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 5
@5
D=A
@SP
A=M
M=D
@SP
M=M+1
// Neg
@result
M=0
@SP
A=M-1
D=M
@result
M=M-D
@SP
M=M-1
@result
D=M
@SP
A=M
M=D
@SP
M=M+1