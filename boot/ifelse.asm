;
; a simple boot sector program that illustrates if else
;
mov bx, 30

; if bx <= 4:
;   al = 'A'
; elif bx < 40:
;   al = 'B'
; else:
;   al = 'C'
cmp bx, 4
jle leq_four_block
; cmd bx, 40
; jl ll_fourty_block
jmp cmp_fourty_block
mov al, 'C'
jmp the_end_block

leq_four_block:
    mov al, 'A'

cmp_fourty_block:
    cmp bx, 40
    jl ll_fourty_block
    jmp the_end_block

the_end_block:

mov ah, 0x0e
int 0x10
jmp $
times 510 - ($ - $$) db 0
dw 0xaa55
