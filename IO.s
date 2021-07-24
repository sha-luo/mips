# Purpose: 
# Complete simple I/O 
# Read inputs from keyboard, make transformation based on the following requirement and output to the screen:
# 1) if input is a character or number, translate into corresponding letter and output to screen
# 2) if input is neither character nor number, output "*" to screen
# 3) whenever a character is typed as an input, translate immediately and output to scrren
# 4) support receiving inputs repetitively until receive "?" which indicates end of program

.data # Define the program data.


msg0: .asciiz "*\n"

CapitalMsg: .asciiz "Alpha   \n","Bravo   \n","China   \n","Delta   \n","Echo    \n","Foxtrot \n","Golf    \n","Hotel   \n",
"India   \n","Juliet  \n","Kilo    \n","Lima    \n","Mary    \n","November\n","Oscar   \n","Paper   \n","Quebec  \n",
"Research\n","Sierra  \n","Tango   \n","Uniform \n","Victor  \n","Whisky  \n","X-ray   \n","Yankee  \n","Zulu    \n" 

LetterMsg: .asciiz "alpha   \n","bravo   \n","china   \n","delta   \n","echo    \n","foxtrot \n","golf    \n","hotel   \n",
"india   \n","juliet  \n","kilo    \n","lima    \n","mary    \n","november\n","oscar   \n","paper   \n","quebec  \n",
"research\n","sierra  \n","tango   \n","uniform \n","victor  \n","whisky  \n","x-ray   \n","yankee  \n","zulu    \n"

NumberMsg:	.asciiz "zero   \n","First  \n","Sceond \n","Third  \n","Fourth \n","Fifth  \n","Sixth  \n","Seventh\n",
"Eighth \n","Ninth  \n"

LetterLen: .word 10

NumberLen: .word 9



.text # Define the program instructions.
main: # Label to define the main program.
start:
	li $v0,12 # Load 12 into $v0 to indicate read character
 	syscall # read character
 	
 	li $s0,'?'
 	beq $v0,$s0,EXIT

	li $s0,'0'  #less than '0' means this is not a number nor a letter
	sub $v1,$v0,$s0
	blt $v1,0,SEP # input < '0', go to SEP
	
	li $s0,'9'  #greater than '0' but less than '9'
	sub $v1,$v0,$s0
	ble $v1,0,NUMBER #input < '9', goto NUMBER
	
	li $s0,'A'  #less than 'A'
	sub $v1,$v0,$s0
	blt $v1,0,SEP # input < 'A', go to SEP
	
	li $s0,'Z' #less than or equal to 'Z'
	sub $v1,$v0,$s0
	ble $v1,0,CAPITAL # input <= 'Z', go to CAP
	
	li $s0,'a'  #less than 'a'
	sub $v1,$v0,$s0
	blt $v1,0,SEP # input < 'A', go to SEP
 	
 	li $s0,'z' #less than or equal to 'z'
	sub $v1,$v0,$s0
	ble $v1,0,LETTER # input <= 'z', go to LOW
	


 EXIT:
 	li $v0,10
 	syscall
 
 SEP: 
 	li $v0,4
 	la $a0,msg0
 	syscall
 	j start
 	
 NUMBER:
 	addi $v0,$v0,-48
 	lw $t0,NumberLen
 	mul $v0,$v0,$t0
 	la $a0,NumberMsg
 	add $a0,$a0,$v0
	li $v0,4
 	syscall
 	j start
 	
 CAPITAL:
 	addi $v0,$v0,-65
 	lw $t0,LetterLen
 	mul $v0,$v0,$t0
 	la $a0,CapitalMsg
 	add $a0,$a0,$v0
 	li $v0,4
 	syscall
 	j start
 	
 LETTER:
 	addi $v0,$v0,-97
 	lw $t0,LetterLen
 	mul $v0,$v0,$t0
 	la $a0,LetterMsg
 	add $a0,$a0,$v0
 	li $v0,4
 	syscall
 	j start
