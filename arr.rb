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

"(END)"
# Increment SP
"@SP"
"M=M+1"
]
