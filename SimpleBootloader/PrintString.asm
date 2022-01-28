print_string:
	push ax

	mov ah, 0x0e

	.Loop:
		cmp [bx], byte 0
		je .End

		mov al, [bx]
		int 0x10
		inc bx

		jmp .Loop

	.End:
		mov al, 0xA
		int 0x10

		mov al, 0xD
		int 0x10

		pop ax

		ret
