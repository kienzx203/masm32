INCLUDE Irvine32.inc
.data

array			dd		15 DUP(?)
Size_array		dd ?

.code

MAIN PROC
	mov		esi, OFFSET array
	call	INPUT
	mov		esi, OFFSET array
	push	Size_array
	call	BubbleSort
	mov		esi,OFFSET array
	call	OUTPUT
	push	0
	call	ExitProcess
MAIN ENDP

INPUT PROC 
	push	ebp
	mov		ebp,esp
	call	ReadDec
	mov		ecx,eax
	mov		Size_array,eax
L1:	call	ReadDec
	mov		[esi],eax
	add		esi,4
	loop	L1
	pop		ebp
	ret 
INPUT ENDP

OUTPUT PROC 
	push	ebp
	mov		ebp,esp
	mov		ecx,Size_array
L1:	mov		eax,[esi]
	call	WriteDec
	add		esi,4
	mov		al,' '
	call	WriteChar
	loop	L1
	pop		ebp
	ret 
OUTPUT ENDP

BubbleSort PROC
	push	ebp
	mov		ebp,esp
	mov		ecx,[ebp+8]
	dec		ecx

L1:push		ecx
	mov		esi, OFFSET array

L2:	mov		eax,[esi]
	cmp		[esi+4],eax
	jg		L3
	xchg	eax,[esi+4]
	mov		[esi],eax

L3 : add	esi,4
	loop	L2
	pop		ecx
	loop	L1

L4:	pop ebp
	ret
BubbleSort ENDP
END MAIN 