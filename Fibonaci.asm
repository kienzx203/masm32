.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	n		db 100 dup(?)
	num_n	dd 0
	mmry	db 0
	print0	db '0', 20h, 0
	print1	db '1', 20h, 0
	s_f1	db '1', 99 dup(0), 0
	s_f2	db 100 dup(0), 0
	s_fn	db 101 dup(0)
	fn_fix	db 101 dup(0)
	bspace	db 20h, 0

.code
main PROC
	push	offset s_f1
	call	reverse

	push	100
	push	offset n
	call	StdIn

	push	offset n
	call	atoi
	mov		num_n, eax

	cmp		num_n, 0
	jz		print01
	cmp		num_n, 1
	jz		print01
	cmp		num_n, 2
	je		print03
	jmp		print_fibo

	print01:
		push	offset print0
		call	StdOut
		jmp		exit

	print02 :
		push	offset print1
		call	StdOut
		jmp		exit
	print03 :
		push	offset print0
		call	StdOut
		push	offset print1
		call	StdOut
		jmp		exit

	print_fibo:
		push	offset print0
		call	StdOut

		push	offset print1
		call	StdOut

		mov		ecx, 2
		mov		eax, num_n
		sub		eax, ecx
		mov		num_n, eax
		mov		eax, 0
		jmp		find_fibo

	find_fibo:
		mov		ecx, num_n
		cmp		num_n, 0
		je		exit

		push	offset s_f1
		push	offset s_f2
		push	offset s_fn
		call	ADD_TWO

		push	offset s_fn
		call	reverse
		push	offset s_fn
		call	StdOut
		push	offset s_fn
		call	reverse

		push	offset s_f1
		push	offset s_f2
		call	copy
		push	offset s_fn
		push	offset s_f1
		call	copy

		push	offset bspace
		call	StdOut
		mov		ecx, num_n
		dec		ecx
		mov		num_n, ecx
		jmp		find_fibo

	exit:
		push	0
		call	ExitProcess


main ENDP

ADD_TWO PROC
	
		push	ebp
		mov		ebp, esp
		mov		edx, [ebp + 8];		dia chi fn
		mov		edi, [ebp + 12];	dia chi f2
		mov		esi, [ebp + 16];	dia chi f1
		mov		eax, 0

	L1:
		cmp		byte ptr [esi], 0
		jz		exit
		mov		al, byte ptr[edi]
		mov		ah, byte ptr[esi]
		sub		ah, 30h
		cmp		al, 0h
		jz		L3
		sub		al, 30h
		add		al, ah
		add		al, [mmry]
		cmp		al, 0Ah
		jae		L2
		mov		[mmry], 0
		add		al, 30h
		mov		[edx], al
		inc		edx
		inc		edi
		inc		esi
		jmp		L1

	L2:
		sub		al, 0Ah
		mov		[mmry], 1
		add		al, 30h
		mov		[edx], al
		inc		edx
		inc		esi
		inc		edi
		jmp		L1

	L3:
		add		al, ah
		add		al, [mmry]
		cmp		al, 0Ah
		jae		L2
		mov		[mmry], 0
		add		al, 30h
		mov		[edx], al
		inc		edx
		inc		edi
		inc		esi
		jmp		L1

	exit:
		cmp		[mmry], 1
		jz		exit2
		pop ebp
		ret 12
	exit2: 
		mov		byte ptr [edx], 31h
		mov		[mmry], 0
		pop		ebp
		ret		12
			

ADD_TWO ENDP

copy PROC
	push	ebp	
	mov		ebp, esp
	push	eax
	push	ebx
	mov		eax, [ebp+0Ch]			;chuoi duoc cp
	mov		ebx, [ebp+08h]			;chuoi cp
	xor		esi, esi
	xor		edi, edi

	for_copy:
		xor		edx, edx
		mov		dl, byte ptr [eax+esi]
		cmp		dl, 0
		jz		done_copy
		mov		byte ptr [ebx+esi], dl
		inc		esi
		jmp		for_copy

	done_copy:
		mov		byte ptr [ebx+esi], 0
		pop		ebx
		pop		eax
		pop		ebp
		ret		8

copy ENDP

reverse PROC
	push	ebp
	mov		ebp, esp
	push	eax
	mov		eax, [ebp+08h]
	xor		esi, esi
	xor		edi, edi
	push	0h

	for_re:
		xor		edx, edx
		mov		dl, byte ptr [eax+esi]
		cmp		dl, 0
		jz		pop_re
		push	edx
		inc		esi
		jmp		for_re

	pop_re:
		xor		edx, edx
		pop		edx
		cmp		dl, 0h
		jz		break_re
		mov		byte ptr [eax+edi], dl
		inc		edi
		jmp		pop_re

	break_re:
		mov		byte ptr [eax+edi], 0
		pop		eax
		pop		ebp	
		ret		4

reverse ENDP

atoi PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	mov		ebx, [ebp+08h]
	xor		esi, esi
	xor		eax, eax
	mov		edi, 10

	for_atoi:
		xor		edx, edx
		mov		dl, byte ptr [ebx+esi]
		cmp		dl, 0
		jz		break_atoi
		sub		edx, 30h
		add		eax, edx
		mul		edi
		inc		esi
		jmp		for_atoi

	break_atoi:
		mov		byte ptr [ebx+esi], 0
		div		edi
		pop		ebx
		pop		ebp
		ret		4

atoi ENDP

itoa PROC
	push	ebp
	mov		ebp, esp
	push	eax
	push	ebx
	mov		eax, [ebp+0Ch]		;number
	mov		ebx, [ebp+08h]		;string
	xor		esi, esi
	mov		edi, 10
	push	69h

	for_itoa:
		xor		edx, edx
		div		edi
		xor		edx, 30h
		push	edx
		cmp		eax, 0
		jz		pop_itoa
		jmp		for_itoa

	pop_itoa:
		xor		edx, edx
		pop		edx
		cmp		dl, 69h
		jz		break_itoa
		mov		byte ptr [ebx+esi], dl
		inc		esi
		jmp		pop_itoa
	
	break_itoa:
		mov		byte ptr [ebx+esi], 0
;		div		edi
		xor		edi, edi
		pop		ebx
		pop		eax
		pop		ebp
		ret		8

itoa ENDP
END main
