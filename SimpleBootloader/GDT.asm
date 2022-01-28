NULL:
	dd 0x0
	dd 0x0

CODE:
	 dw 0xFFFF
	 dw 0x0000
	 db 0x00

	 db 10011010b ; Access byte
	 db 11001111b ; Flags | Limit

	 db 0x0

DATA:
	 dw 0xFFFF
	 dw 0x0000
	 db 0x00

	 db 10010010b ; Access byte
	 db 11001111b ; Flags | Limit

	 db 0x0

GDT_END:

GDT_DESCRIPTOR:
	dw GDT_END - NULL -1 ; GDT size
	dq NULL 			 ; Pointer to GDT

CODESEG equ CODE - NULL
DATASEG equ DATA - NULL
