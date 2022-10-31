.386
.model flat, stdcall
option casemap : none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data

	input		db	100 DUP(? )
	input1		db	20  DUP(? )
	dem			dd  0
	len1		dd  	0
	output		db	20  DUP(? )
	space		db	' ', 0
	check		db	1
	line_feed	db	0Ah, 0Dh, 0

.code
MAIN PROC

	push	100
	push	offset	input
	call	StdIn

	push	20
	push	offset	input1
	call	StdIn

	push	offset input1
	call	LEN
	mov	len1, eax

	mov	esi, offset	input
	mov	edi, offset	input1
	mov	ebx, 0
	mov	eax, 0
	L1:
		mov	edx, 0
		mov	eax, 0
		mov	dl, BYTE PTR[esi + ebx]
		mov	dh, BYTE PTR[edi + eax]
		cmp	dl, 0
		jz	L5
		cmp	dl, dh
		je	L2
		inc	ebx
		jmp	L1

	L2 :
		mov	edx, 0
		mov	dl, BYTE PTR[esi + ebx]
		mov	dh, BYTE PTR[edi + eax]
		cmp	dh, 0
		jz	L3
		inc	ebx
		inc	eax
		cmp	dh, dl
		je	L2
		jmp	L1

	L3 :
		cmp	check, 0
		jz	L6
		mov	eax, 0
		mov	eax, dem
		inc	eax
		mov	dem, eax
		sub	ebx, len1
		inc	ebx
		jmp	L1

	L5 :
		cmp	check, 0
		jz	L7
		push	dem
		push	offset output
		call	REATOI

		push	offset output
		call	StdOut

		push	offset	line_feed
		call	StdOut

		mov	check, 0
		mov	ebx, 0
		mov	eax, 0
		jmp 	L1

	L6 :
		mov	eax, 0
		mov	eax, ebx
		sub	eax, len1
		push	eax
		push	offset output
		call	REATOI

		push	offset output
		call	StdOut

		push	offset space
		call	StdOut
		sub	ebx, len1
		inc	ebx
		jmp	L1

	L7 :

		push	0
		call	ExitProcess

MAIN ENDP

LEN PROC

	push	ebp
	mov	ebp, esp
	mov	ecx, [ebp + 08h]
	xor 	esi, esi
	xor 	eax, eax

	L1 :
		cmp	BYTE PTR[ecx + esi], 0
		jz	L2
		inc	esi
		jmp	L1

	L2 :
		mov	eax, esi
		pop	ebp
		ret	4

LEN ENDP

REATOI PROC

	push    ebp
	mov     ebp, esp
	push	ebx
	push	ecx
	push	eax
	push	esi
	push	edi
	xor 	eax, eax
	xor 	ebx, ebx
	mov     eax, [ebp + 0Ch]
	mov     ebx, [ebp + 8h]
	mov	esi, 0
	mov     ecx, 10
	push    3Ah

	L1 :
		xor 	edx, edx
		div     ecx
		or 	edx, 30h
		push    edx
		cmp     eax, 0
		jz      L2
		jmp     L1

	L2 :

		pop     edx
		cmp     dl, 3Ah
		jz      L3
		mov     BYTE PTR[ebx + esi], dl
		inc     esi
		jmp     L2

	L3 :

		mov     BYTE PTR[ebx + esi], 0
		pop	edi
		pop	esi
		pop	eax
		pop	ecx
		pop	ebx
		pop     ebp
		ret     8

REATOI ENDP
END MAIN
