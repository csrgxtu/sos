;
; a simple boot sector program that demonstrate the stack
;
mov ah, 0x0e
mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10        ; C

pop bx
mov al, bl
int 0x10        ; B

mov al, [0x7ffe]    ; 0x8000 - 0x2
int 0x10        ; A

jmp $

times 510 - ($ - $$) db 0
dw 0xaa55