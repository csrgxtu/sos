; kernel_entry.asm, ensures that we jump straight into the
; kernel's entry function
[bits 32]                       ; we r in pm by now, so use 32 bit instructions
[extern main]                   ; decalte that we will be referencing the extern symbol 'main'
                                ; so the linker can substitute the final address
call main                       ; invoke main() in our c kernel
jmp $                           ; hang forever when we return from kernel