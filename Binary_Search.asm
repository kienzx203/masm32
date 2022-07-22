INCLUDE Irvine32.inc
.data

array			dd		15 DUP(?)
Size_array		dd		?
Search_value	dd		?
first			dd		?
last			dd		?
mid				dd		?


.code

MAIN PROC
	mov		esi, OFFSET array
	call	INPUT
	mov		esi, OFFSET array
	push	Size_array
	call	BubbleSort
	call	Binary_Search
	call	WriteDec
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
	call	ReadDec
	mov		Search_value,eax
	pop		ebp
	ret 
INPUT ENDP

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

L4:	pop		ebp
	ret		
BubbleSort ENDP

Binary_Search PROC
	push	ebp
	mov		ebp,esp
	mov		ecx,[ebp+8]
	dec		ecx
	mov		first,0
	mov		last,ecx
	mov		edi,Search_value
	mov		esi,OFFSET array
L1:	mov		eax,first
	cmp		eax,last
	jg		L5
	mov		eax,last
	add		eax,first
	shr		eax,1
	mov		mid,eax
	mov		ebx,mid
	shl		ebx,2
	mov		edx,[esi+ebx]
	cmp		edx,edi
	jge		L2
	mov		eax,mid
	inc		eax
	mov		first,eax
	jmp		L4
L2:	cmp		edx,edi
	jle		L3
	mov		eax,mid
	dec		eax
	mov		last,eax
	jmp		L4
L3:	mov		eax,mid
	jmp		L6
L4:	jmp		L1
L5:	mov		eax,-1
L6:	pop		ebp
	ret

Binary_Search ENDP
END MAIN 