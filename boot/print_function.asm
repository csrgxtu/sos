;
; a boot sector that prints a string using our function
;
[org 0x7c00]
mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $

print_string:
    pusha
    mov ah, 0x0e
loop:
    mov al, [bx]
    int 0x10
    add bx, 1
    cmp al, 0
    jne loop
    popa
    ret

; Data
HELLO_MSG:
    db 'Hello, World!', 0

GOODBYE_MSG:
    db 'Goodbye!', 0

times 510 - ($ - $$) db 0
dw 0xaa55