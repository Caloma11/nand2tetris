// push constant 3030
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
A=M-1
D=M 
@val
M=D
@SP
M=M-1
@val
D=M
@THIS
M=D
// push constant 3040
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
A=M-1
D=M 
@val
M=D
@SP
M=M-1
@val
D=M
@THAT
M=D
// push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this 2
@SP
A=M-1
D=M 
@val
M=D
@SP
M=M-1
@THIS
D=M
@2
D=D+A 
@addr
M=D
@val
D=M
@addr
A=M
M=D
// push constant 46
@46
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that 6
@SP
A=M-1
D=M 
@val
M=D
@SP
M=M-1
@THAT
D=M
@6
D=D+A 
@addr
M=D
@val
D=M
@addr
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push pointer 1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// Add
@sum
M=0
@SP
A=M-1
D=M
@sum
M=M+D
@SP
M=M-1
@SP
A=M-1
D=M
@sum
M=M+D
@SP
M=M-1
@sum
D=M
@SP
A=M
M=D
@SP
M=M+1
// push this 2
@THIS
D=M
@2
D=D+A 
@addr
M=D
@addr
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// Sub
@sum
M=0
@SP
A=M-1
D=M
@sum
M=M-D
@SP
M=M-1
@SP
A=M-1
D=M
@sum
M=M+D
@SP
M=M-1
@sum
D=M
@SP
A=M
M=D
@SP
M=M+1
// push that 6
@THAT
D=M
@6
D=D+A 
@addr
M=D
@addr
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// Add
@sum
M=0
@SP
A=M-1
D=M
@sum
M=M+D
@SP
M=M-1
@SP
A=M-1
D=M
@sum
M=M+D
@SP
M=M-1
@sum
D=M
@SP
A=M
M=D
@SP
M=M+1