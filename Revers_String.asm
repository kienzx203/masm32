.386
.model flat,stdcall
option casemap:none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data

	string1		db		30 DUP (?)
	
.code
MAIN PROC
	push	30
	push	offset	string1
	call	StdIn
	push	offset	string1
	call	REVERSE
	push	offset	string1
	call	StdOut
	push	0
	call	ExitProcess

MAIN ENDP

REVERSE PROC

	push	ebp
	mov		ebp, esp
	mov		esi, [ebp+8]
	mov		edi, [ebp+8]
	mov		ecx, 0
L1:	
	mov		eax, 0
	mov		al,	BYTE PTR [esi]
	cmp		al, 0
	jz		L2
	push	eax
	inc		esi
	inc		ecx
	jmp		L1
L2:			
	mov		eax, 0
	pop		eax
	mov		BYTE PTR [edi],al
	inc		edi
	loop	L2
	pop		ebp
	ret		4

REVERSE ENDP
END MAIN
