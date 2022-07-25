.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data

	num_array		dd	40 DUP (?)
	num_output		dd	40 DUP (?)
	len				dd	?
	Tong_chan		dd	0
	Tong_le			dd	0
	space			db  20h, 0

.code
MAIN PROC
	push	40
	push	offset num_array
	call	StdIn
	push	offset num_array
	call	ATOI
	mov		len, eax

L1:	

	cmp		len, 0
	jz		L4
	push	40
	push	offset num_array
	call	StdIn
	dec		len
	push	offset num_array
	call	ATOI
	mov		ebx, 0
	mov		ecx, 0
	mov		ecx,eax
	mov		ebx, 2
	mov		edx, 0
	div		ebx
	cmp		edx, 0
	jz		L3
	jmp		L2

L2:	
	add		Tong_le,ecx
	jmp		L1
	
L3: 

	add		Tong_chan,ecx
	jmp		L1

L4:

	push	Tong_chan
	push	offset num_output
	call	REATOI
	push	offset num_output
	call	StdOut

	push	offset space
	call	StdOut

	push	Tong_le
	push	offset num_output
	call	REATOI
	push	offset num_output
	call	StdOut

	push	0
	call	ExitProcess

	
MAIN ENDP

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
END MAIN