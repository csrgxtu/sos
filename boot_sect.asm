;
; a simple boot sector program that loops forever
;
loop:                       ; define a label, loop, that will allow
                            ; us to jump back to it, forever
    jmp loop                ; use a simple cpu instruction that jumps to a new
                            ; memory address to continue exectuion. in our case,
                            ; jump to the address of current instruction

times 510 - ($ - $$) db 0    ; when compiled, our program must fit into 512 bytes,
                            ; with the last two bytes being the magic number, so
                            ; here, tell our assembly compiler to pad out our
                            ; program with enough zero bytes (db 0) to bring to
                            ; the 510th byte

dw 0xaa55
