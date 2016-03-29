;Brayden Roth-White
;Final Project

prompt: db 	"Enter a number: "
plen: equ 	$-prompt

badNum: db "Bad Number.",10
blen: equ $-badNum

newLine: db 10
nlen: equ $-newLine

gcdString: db "Greatest common divisor = "
glen: equ $-gcdString

SECTION .bss

num: resb 20
numlen: equ 20
buf: resb 1

global _start

SECTION .text

_start:
	call 	readNum

	push 	eax 			;save the first number return
	call 	readNum
	mov 	ebx, eax 		;move the second number return
	pop 	eax 			;restore the first number

	call	gcd

	push 	eax
	mov 	eax, 4
	mov 	ebx, 1
	mov 	ecx, gcdString
	mov 	edx, glen
	int 	80H
	pop 	eax

	call 	makeDecimal

	mov 	eax, 4
	mov 	ebx, 1
	mov 	ecx, newLine
	mov 	edx, nlen
	int 	80H

	jmp exit

readNum:
	mov 	eax, 4 			;write
	mov 	ebx, 1 			
	mov 	ecx, prompt 	
	mov 	edx, plen 		
	int 	80H

	mov 	eax, 3 			;read in a number
	mov 	ebx, 0
	mov 	ecx, num 
	mov 	edx, numlen + 1
	int 	80H

	call 	getNum

	ret

getNum:
	mov 	esi, num
	mov 	edi, num
	mov 	eax, 1 			;getNum set up
	mov 	ecx, 0
	mov 	edx, 0

getNumLoop:
	mov 	bl, [esi] 		;take a byte off esi
	inc 	esi 			;move the pointer to the next byte
	cmp 	bl, 0xa 		;compare b's byte to '\n'
	jne  	getNumLoop		;do it again if not equal

	dec 	esi 			;get off the null byte
	dec 	esi 			;get off the '\n' byte

nextDec:
	mov 	bl, [esi] 		;at the end of the string take last char

	cmp 	bl, 20h 		;check for space
	je  	return
	cmp 	bl, 30h 		;check bad numbers (less than 0)
	jl  	badNumber 		
	cmp 	bl, 39h 		;check bad numbers (greater than 9)
	jg  	badNumber

	sub 	bl, 30h 		;make a raw number from the character
	movzx 	ebx, bl 		;move it to 'double word' zero extension
	mov 	ecx, eax 		;save a copy of a in c
	mov 	eax, ebx 		;prep b into a for multiplication

	push 	edx 			;keep d register safe from mul
	mul 	ecx 			;a * c into a
	pop 	edx 			;restore the safe d register

	add 	edx, eax 		;result into the d register

	push 	edx 			;keep d register safe from mul
	mov 	eax, ecx 		;prep c into a for mul
	mov 	ebx, 10 		;move 10 into b
	mul 	ebx 			;multiply a by 10 into the a register
	pop 	edx 			;restore the result

	cmp 	esi, edi 		;compare if we're done
	je  	return
	dec 	esi 			;move down esi
	jmp 	nextDec

return:
	mov 	eax, edx
	ret

gcd:
	cmp 	eax, ebx 		;compare a and b
	jg 	greater 		;if they're not equal
	jl  less 			;is a less than b
	ret

less:
	sub 	ebx, eax  		;else, subtract b - a
	call 	gcd
	ret

greater:
	sub 	eax, ebx 		;since a > b, do a - b
	call 	gcd
	ret

makeDecimal:
	mov 	ebx, 10
	mov 	edx, 0
	div 	ebx 			;eax / 10, eax = quotient, edx = remainder
	cmp 	eax, 0 			;does eax = 0
	jg  	more 		

last:
	add 	edx, 30h 		;ascii value
	mov 	[buf], edx

	mov 	eax, 4 			;put a character remainder at a time
	mov 	ebx, 1
	mov 	ecx, buf
	mov 	edx, 1
	int 	80H

	ret

more:
	push 	edx 			;save d register as we go
	call 	makeDecimal 		;weren't quite done recurse
	pop 	edx 			;pop d register and get the 'last' remainder
	jmp 	last

exit:
	nop
	mov 	eax, 1 			;terminate
	mov 	ebx, 0
	int 	80H

badNumber:
	mov 	eax, 4 			;write bad number
	mov 	ebx, 1 			
	mov 	ecx, badNum 	
	mov 	edx, blen
	int 	80h

	jmp 	exit

