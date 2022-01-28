[org 0x8000]

push bx
mov bx, SECOND_STAGE_MSG
call print_string
pop bx

jmp Start32_Bit

%include "PrintString.asm"
%include "GDT.asm"
SECOND_STAGE_MSG: db "Entered second stage", 0
STARTING_32BITS_MSG: db "Starting 32 bit mode", 0
ENTERED_32BITS_MSG: db "Entered 32 bit mode", 0
STARTING_64BITS_MSG: db "Starting 64 bit mode", 0

Start32_Bit:
	push bx
	mov bx, STARTING_32BITS_MSG
	call print_string
	pop bx

	cli

	call EnableA20

	lgdt [GDT_DESCRIPTOR]
	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp CODESEG:Enter32_Bit

EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al

	ret

[bits 32]
vga_print:
	; BX string iterator
	; AL store current character
	; DL 8 bit color (0001 (blue background) 1111 (white forground))
	; ECX VGA pointer

	.Loop:
		cmp [bx], byte 0
		je .End

		shl ecx, 1
		add ecx, 0xB8000

		mov al, [bx]
		mov [ecx], al

		inc ecx

		mov [ecx], dl

		dec ecx

		sub ecx, 0xB8000
		shr ecx, 1

		inc ecx
		inc bx

		jmp .Loop

	.End:

	ret

Enter32_Bit:
	mov ax, DATASEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	;mov [0xB8000], byte 'A'

	push ecx
	push bx
	push dx

	mov ecx, 0
	mov dl, byte 00011111b
	mov bx, ENTERED_32BITS_MSG
	call vga_print

	mov ecx, 80
	mov bx, STARTING_64BITS_MSG
	call vga_print

	pop dx
	pop bx
	pop ecx

	jmp $


times 2048 db 0
