.386
.model flat, stdcall
option casemap: none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
	message		db	40 dup(?)			
.code
main PROC
	push	40
	push	offset message
	call	StdIn			
	mov	ebx ,offset message
	push    ebx
	call	Uppercase
	push	0
	call	ExitProcess
main ENDP
Uppercase PROC
	push	ebp
	mov	ebp,esp
	mov	eax,[ebp+8]
L1:
	cmp	BYTE PTR [eax], 0		
	jz 	input
	cmp	BYTE PTR [eax], 'a'		
	jl	nhay					
	cmp	BYTE PTR [eax], 'z'		
	jg	nhay			
	sub	BYTE PTR [eax],  20h
nhay :
	inc	eax
	jmp	L1
input :
	push	offset message
	call	StdOut
	pop	ebp
	ret		

Uppercase ENDP
END main
