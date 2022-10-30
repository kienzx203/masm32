.386
.model flat, stdcall
option casemap : none

	include \masm32\include\kernel32.inc
	include \masm32\include\masm32.inc
	includelib \masm32\lib\kernel32.lib
	includelib \masm32\lib\masm32.lib

.data

	len1	dd 0
	len2	dd 0
	lenmin	dd 0
	num1	db 20 dup(0)
	num2	db 20 dup(0)
	num3	db 20 dup(0)

.code

MAIN PROC
	push	20
	push	offset num1
	call	StdIn
	push	offset num1
	call	LEN
	mov	len1, eax
	mov	esi, offset num1
	mov	byte ptr [esi + eax + 1], 0h

	push	20
	push	offset num2
	call	StdIn
	push	offset num2
	call	LEN
	mov	len2, eax
	mov	esi, offset num2
	mov	byte ptr [esi + eax + 1], 0h
	push	offset num1
	call	CHECK
	push	offset num2
	call	CHECK
	mov	eax, len1
	cmp	eax, len2			; len1 > len2
	jg	L1
	cmp	eax, len2			; len1 < len2
	jle	L2

	L1 :
		mov	eax, len2
		mov	lenmin, eax
		push	offset num1
		push	offset num2
		push	lenmin
		call	ADD_TWO
		push	offset num3
		call	CHECK
		push	offset num3
		call	StdOut
		push	0
		call	ExitProcess

	L2 :
		mov	eax, len2
		mov	lenmin, eax
		push	offset num2
		push	offset num1
		push	lenmin
		call	ADD_TWO
		push	offset num3
		call	CHECK
		push	offset num3
		call	StdOut
		push	0
		call	ExitProcess

MAIN ENDP

ADD_TWO PROC
	push	ebp
	mov	ebp, esp
	mov	ecx, [ebp + 8]		;	lenmin
	mov	esi, [ebp + 12]		;	dia chi nho
	mov	edi, [ebp + 16]		;	dia chi lon
	mov	edx, OFFSET num3
	mov	eax, 0
	jmp	L1

	L2:
		sub	al, 0Ah
		xor	ah, ah
		mov	ah, 1
		jmp	L3
	L1:
		mov	ebx, 0
		add	bh, ah
		mov	eax, 0
		mov	bl, BYTE PTR[edi]
		mov	al, BYTE PTR[esi]
		cmp	al, 0
		jz	L9
		sub	al, 30h
	L9:
		sub	bl, 30h
		add	bl, bh
		add	al, bl
		cmp	al, 0Ah
		jge	L2
	L3:
		add	al, 30h
		mov	BYTE PTR[edx], al
		inc	esi
		inc	edx
		inc	edi
		loop	L1

		mov	ebx, lenmin
		cmp	ebx, len1
		jne	L4
		jmp	L7

	L4:
		mov	ebx, 0
		add	bh, ah
		mov	bl, BYTE PTR[edi]
		cmp	bl, 0h
		je	L7
		mov	eax, 0
		sub	bl, 30h
		add	bl, bh
		mov	eax, 0
		cmp	bl, 0Ah
		jge	L5

	L6:
		add	bl, 30h
		mov	BYTE PTR[edx], bl
		inc	edx
		inc	edi
		loop	L4

	L5:
		sub	bl, 0Ah
		xor	ah, ah
		mov	ah, 1
		jmp	L6

	L7 :
		cmp	ah, 1h
		je	L8
		inc	edx
		mov	BYTE PTR[edx], 0
		pop	ebp
		ret	12

	L8:
		mov	BYTE PTR[edx], 1
		add	BYTE PTR[edx], 30h
		inc	edx
		mov	BYTE PTR[edx], 0
		pop	ebp
		ret	12

ADD_TWO ENDP

CHECK PROC
	push	ebp
	mov	ebp, esp
	mov	esi, [ebp + 8]
	mov	edi, [ebp + 8]
	mov	ecx, 0
	L1:
		mov	eax, 0
		mov	al, BYTE PTR[esi]
		cmp	al, 0
		jz	L2
		push	eax
		inc	esi
		inc	ecx
		jmp	L1
	L2 :
		mov	eax, 0
		pop	eax
		mov	BYTE PTR[edi], al
		inc	edi
		loop	L2
		pop	ebp
		ret	4

CHECK ENDP

LEN PROC
	push	ebp
	mov	ebp, esp
	mov	ebx, [ebp + 8]
	mov	eax, 0

	L1:
		cmp	BYTE PTR[ebx], 0
		jz	L2
		inc	eax
		inc	ebx
		jmp	L1

	L2 :
		pop	ebp
		ret	4

LEN ENDP
END MAIN
