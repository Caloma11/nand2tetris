// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

  // This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.



// Adds 1+...+100.

(BEGIN)

@SCREEN
D=A
@addr
M=D // save screen address

@8192
D=A

@n
M=D // change n to 8192

@i
M=0 // sets i to 0 for counting

(FILLLOOP)
@i
D=M
@n
D=D-M
@BEGIN
D;JGT //check if the height is reached

// IF Not


@KBD
D=M // Checks whats inside keyboard register

@SKIPBLACK
D;JEQ


@addr
A=M
M=-1 // paints the address black

@SKIPWHITE
0;JMP

(SKIPBLACK)
@addr
A=M
M=0 // paints the address WHITE


(SKIPWHITE)

@i
M=M+1 // adds one to i

@1 // how many pixels until your next paint (change)
D=A

@addr
M=D+M // new address to paint

@FILLLOOP
0;JMP // goto loop

(FILLEND)

@FILLEND
0;JMP
