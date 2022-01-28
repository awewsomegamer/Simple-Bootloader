[org 0x7c00]
mov [BOOT_DRIVE], dl

push bx
mov bx, BOOT_MSG
call print_string
pop bx

push bx
mov bx, PRE_READ_DISK
call print_string
pop bx

call ReadDisk

push bx
mov bx, POST_READ_DISK
call print_string
pop bx

jmp PROGRAM_SPACE

%include "PrintString.asm"
%include "DiskRead.asm"

BOOT_DRIVE: db 0

BOOT_MSG: db "Booted", 0
PRE_READ_DISK: db "Reading disk", 0
POST_READ_DISK: db "Read disk", 0

times 510-($-$$) db 0
dw 0xAA55
