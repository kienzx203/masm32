.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	mode	db "1. Cong", 0Ah, "2. Tru", 0Ah, "3. Nhan", 0Ah, "4. Chia", 0
	s1		db "Num 1: ", 0
	s2		db "Num 2: ", 0
	mode1	db " + ", 0
	mode2	db " - ", 0
	mode3	db " * ", 0
	mode4	db " / ", 0
	bang	db " = ", 0
	input	db 3 dup(?)
	num1	db 30 dup(?)
	num2	db 30 dup(?)
	KQ1		db 31 dup(?)
	n		dd 0
	n1		dd 0
	n2		dd 0
	KQ		dd 0
	bspace	db 20, 0
	nline	db 0Ah, 0Dh, 0

.code
main PROC

	push	offset mode
	call	StdOut

	push	offset nline
	call	StdOut

	push	3
	push	offset input
	call	StdIn
	push	offset input
	call	ATOI
	mov		n, eax					

	push	offset s1
	call	StdOut
	push	30
	push	offset num1
	call	StdIn
	push	offset num1
	call	ATOI
	mov		n1, eax

	push	offset s2
	call	StdOut
	push	30
	push	offset num2
	call	StdIn
	push	offset num2
	call	ATOI
	mov		n2, eax

	mov		ecx, n
	cmp		ecx, 1					
	jz		CONG
	cmp		ecx, 2
	jz		TRU
	cmp		ecx, 3
	jz		NHAN
	cmp		ecx, 4
	jz		CHIA
	jmp		RE

CONG:

	push	offset num1
	call	StdOut
	push	offset mode1
	call	StdOut
	push	offset num2
	call	StdOut
	push	offset bang
	call	StdOut
	xor		edx, edx
	xor		eax, eax
	xor		ebx, ebx
	mov		eax, n1					
	mov		ebx, n2					
	add		eax, ebx
	mov		KQ, eax
	jmp		RE

TRU:

	push	offset num1
	call	StdOut
	push	offset mode2
	call	StdOut
	push	offset num2
	call	StdOut
	push	offset bang
	call	StdOut
	xor		edx, edx
	xor		eax, eax
	xor		ebx, ebx
	mov		eax, n1					
	mov		ebx, n2					
	sub		eax, ebx
	mov		KQ, eax
	jmp		RE

NHAN:

	push	offset num1
	call	StdOut
	push	offset mode3
	call	StdOut
	push	offset num2
	call	StdOut
	push	offset bang
	call	StdOut
	xor		edx, edx
	xor		eax, eax
	xor		ebx, ebx
	mov		eax, n1					
	mov		ebx, n2					
	mul		ebx
	mov		KQ, eax
	jmp		RE

CHIA:
		
	push	offset num1
	call	StdOut
	push	offset mode4
	call	StdOut
	push	offset num2
	call	StdOut
	push	offset bang
	call	StdOut
	xor		edx, edx
	xor		eax, eax
	xor		ebx, ebx
	mov		eax, n1					
	mov		ebx, n2					
	div		ebx
	mov		KQ, eax
	jmp		RE

RE:	
		
	push	KQ
	push	offset KQ1
	call	REATOI
	push	offset KQ1
	call	StdOut

	push	0
	call	ExitProcess

main ENDP

ATOI PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	mov		ebx, [ebp+08h]
	xor		esi, esi								
	xor		eax, eax
	mov		ecx, 10

L1:
	xor		edx, edx
	mov		dl, byte ptr [ebx+esi]				
	cmp		dl, 0								
	jz		L2
	sub 	edx, 30h							
	add		eax, edx							
	mul		ecx									
	inc		esi									
	jmp		L1

L2:
	div		ecx
	pop		ebx
	pop		ebp
	ret		4

ATOI ENDP

REATOI PROC

    push    ebp
    mov     ebp, esp
	xor		eax, eax
	xor		ebx, ebx
    mov     eax, [ebp + 0Ch]						
    mov     ebx, [ebp + 08h]						
    xor     esi, esi 
    mov     ecx, 10
    push    3Ah										

L1:
    xor     edx, edx
    div     ecx									
    or      edx, 30h						
    push    edx									
    cmp     eax, 0						
    jz      L2
    jmp     L1

L2:

    pop     edx
    cmp     dl, 3Ah								
    jz      L3						
    mov     byte ptr [ebx + esi], dl			
    inc     esi
    jmp     L2

L3:

    mov     byte ptr [ebx + esi], 0
    pop     ebp
    ret     8

REATOI ENDP

END main