.386
.model flat, stdcall
option casemap: none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
	msg	db	"Hello_world", 0Ah

.code
main PROC
	mov	ah,0
	mov al,'4'
	mov bl,2
	div bl
	aad
	or al, 30h

main ENDP
END main