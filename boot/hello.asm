;
; a simple boot sector that prints a message to the screen using a bios routine
;
mov ah, 0x0e    ; int 10/ah = 0eh -> scrolling teletype bios routines

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $           ; jump to the current address forever

;
; padding and magic bios number
;
times 510 - ($ - $$) db 0   ; pad the boot secotr out with zeros
dw 0xaa55