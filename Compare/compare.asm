;Brayden Roth-White
;CS 261
;Assembly assignment 1


prompt: db 	"Enter a string: "
plen: equ 	$-prompt
True: db 	"True",10
False: db	"False",10


SECTION .bss

word1: resb 	30
word2: resb 	30
wordlen: equ 	30

SECTION .text

global _start

_start:
	nop
	mov 	eax, 4 		;write
	mov 	ebx, 1 		;standard out
	mov 	ecx, prompt 	;prompt string
	mov 	edx, plen 	;length of prompt
	int 	80H

	mov 	eax, 3 		;read
	mov 	ebx, 0 		;standard in
	mov 	ecx, word1 	;into the input buffer
	mov 	edx, wordlen+1  ;word length	
	int 	80H

	mov 	eax, 4		;write
	mov 	ebx, 1		;standard out
	mov 	ecx, prompt 	;prompt string
	mov 	edx, plen	;length of prompt
	int 	80H

	mov 	eax, 3 		;read
	mov 	ebx, 0 		;standard in
	mov 	ecx, word2 	;into the input buffer
	mov 	edx, wordlen+1 	;word length		
	int 	80H

	cld
	mov 	esi, word1	;first string to esi
	mov 	edi, word2 	;second string to edi
	mov 	ecx, wordlen	;cap to loop
	mov 	edx, 0			

compare:
	lodsb 			;load esi byte to al
	mov 	bl, [edi + edx]	;push each letter into bl
	cmp 	al, 10H		;newline on first string
	je 	false 		;first string reached the newline

	cmp 	bl, 10H		;newline on second string
	je 	true 		;second string reached the newline

	inc 	edx 		;increment edx
	cmp 	al, bl 		;compare letters
	jg  	true 		;first is greater than
	jl 	false 		;second is greater than

	loop	compare 	;loop
	jmp 	false 		;gone through all resb therefore equal
 
true:
	mov 	eax, 4 		;write
	mov 	ebx, 1 		;standard out
	mov 	ecx, True 	;true string
	mov 	edx, 5 		;print 5 bytes from true
	int 	80H

	jmp 	exit

false:
	mov 	eax, 4 		;write
	mov 	ebx, 1 		;standard out
	mov 	ecx, False 	;false string
	mov 	edx, 6		;print 6 bytes from false
	int 	80H

exit:
	mov 	eax, 1				
	mov 	ebx, 0
	int 	80H		;terminates
