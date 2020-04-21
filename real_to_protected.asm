; a boot sector that enter 32-bit protected mode
[org 0x7c00]
    mov bp, 0x9000              ; set the stack
    mov sp, bp
    mov bx, MSG_REAL_MODE
    call print_string
    call switch_to_pm           ; note that we never return from here
    jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]
; this is where we arrive after switching to and initializing protected mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm        ; use our 32 bit print routine
    jmp $                       ; hang

; global variables
MSG_REAL_MODE   db "Started in 16-bit real mode", 0
MSG_PROT_MODE   db "successfully landed in 32-bit protected mode", 0

; boot sector padding
times 510 - ($ - $$) db 0
dw 0xaa55