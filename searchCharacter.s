# Objective: search character in a string
# First enter a string, then enter a character, search if the string contains the character
# 1) if found, return "Success! Location:X", where X is the first time the character appears in the string
# 2) if not found, return "Fail!"
# 3) support entering the next character until '?' which indicates the end of the program

.data

buffer: .space 20
str1: .asciiz "Enter string(max 20 chars):"
str2: .asciiz "Enter character:"
FailMsg: .asciiz "\nFail!\n"
SuccMsg: .asciiz "\nSuccess!Location:"
msg0: .asciiz "\n"

.text
main:
	li $v0,4  #print "Enter string"
	la $a0,str1
	syscall
	
	li $v0,8 #take in input
	la $a0, buffer #load byte space into address
	li $a1,20 # allot byte space for string
	syscall
	move $s0,$a0 #save string to s0
	
INPUT:
	li $v0,4  #print "Enter character
	la $a0,str2
	syscall
	
	li $v0,12 #read character and saved in $v0
	syscall
	li $t0,'?' #quit when entered '?'
	beq $v0,$t0,EXIT
	li $s1,0 #set index to 0
	
LOOP:
	add $s2,$s1,$s0 #find address
	lb $t0,($s2) #load byte(character) into $t0
	addi $s1,$s1,1 #index ++
	beq $t0,$0,FAIL #reach end of string
	beq,$t0,$v0,SUCC #found character
	j LOOP

FAIL:
	la $a0, FailMsg	
	li $v0,4
	syscall
	j INPUT
	
SUCC:
	la $a0, SuccMsg
	li $v0,4
	syscall
	move $a0,$s1
	li $v0,1
	syscall
	la $a0,msg0
	li $v0,4
	syscall
	j INPUT
	
	

EXIT:
	li $v0,10
	syscall
