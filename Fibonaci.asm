.386
.model flat,stdcall
option casemap:none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	
	input		dd		30 DUP (?)
	output		dd		30 DUP (?)
	num			dd		0
	num2		dd		1
	num3		dd		1

.code
MAIN PROC
	push	30
	push	offset input
	call	StdIn
	push	offset input
	call	ATOI
 	mov		num, eax
	call	FIBONACI
	push	eax
	push	offset output
	call	REATOI
	push	offset output
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

FIBONACI PROC
	push	ebp
	mov		ebp, esp
	mov		ecx, 0
	mov		ecx, num
	xor		eax, eax
	xor		ebx, ebx
	jmp		L1

L3:	
	mov		eax, ecx
	pop		ebp
	ret		4

L1:
	
	cmp		ecx, 0
	je		L3
	cmp		ecx, 1
	je		L3
	cmp		ecx, 2
	je		L6
	jmp		L4

L4:
	xor		eax, eax
	xor		ebx, ebx
	mov		eax, num2
	mov		ebx, num3
	mov		num2,ebx
	add		eax, ebx
	mov		num3,eax
	cmp		ecx, 3
	je		L5
	loop	L4
	pop		ebp
	ret		4
L5:
	xor		eax, eax
	mov		eax, num3
	pop		ebp
	ret		4

L6:
	mov		eax, 1
	pop		ebp
	ret		4
	
FIBONACI ENDP
END MAIN

