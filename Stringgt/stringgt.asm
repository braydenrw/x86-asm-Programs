;Brayden Roth-White
;CS 261
;Assembly assignment 1

SECTION .bss

wordlen: equ 	30

global stringgt

SECTION .text
stringgt:
	nop

	push 	ebp 			;set up stack pointer
	mov 	ebp, esp

	push 	edi			;push registers
	push 	esi
	push 	ebx
	push 	ecx
	push 	edx

	mov 	esi, dword [ebp + 8]	;first arg
	mov 	edi, dword [ebp + 12] 	;second arg

	cld
	mov 	ecx, wordlen		;cap to loop
	mov 	edx, 0			

compare:
	lodsb 				;load esi byte to al
	mov 	bl, [edi + edx]		;push each letter into bl
	cmp 	al, 0xa			;newline on first string
	je 	false 			;first string reached the newline

	cmp 	bl, 0xa			;newline on second string
	je 	true 			;second string reached the newline
	
	inc 	edx 			;increment edx
	cmp 	al, bl 			;compare letters
	jg  	true 			;first is greater than
	jl 	false 			;second is greater than

	loop	compare 		;loop
	jmp 	false 			;gone through all resb therefore equal
 
true:
	mov 	eax, 1			;return a non 0
	jmp 	exit

false:
	mov 	eax, 0			;set up to return 0

exit:
	pop 	edx			;pop registers
	pop 	ecx
	pop 	ebx
	pop 	esi
	pop 	edi
	mov 	esp, ebp
	pop 	ebp
	ret				;return
