PROGRAM_SPACE equ 0x8000

ReadDisk:
	mov ah, 0x02 ; CHS mode
	mov al, 5	 ; Sectors to read
	mov ch, 0x00 ; Cylinder number
	mov dh, 0x00 ; Head number
	mov cl, 0x02 ; Sector to start from
	mov dl, [BOOT_DRIVE] ; Boot drive
	mov bx, PROGRAM_SPACE ; Where to put read data

	int 0x13

	jc DISK_READ_ERROR

	ret

DISK_READ_ERROR:
	mov bx, DISK_READ_ERROR_MSG
	call print_string

	jmp $

DISK_READ_ERROR_MSG:
	db "Failed to read disk",0
