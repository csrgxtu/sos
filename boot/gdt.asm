; GDT
gdt_start:

gdt_null:                       ; the mandatory null descriptor
    dd 0x00                     ; dd means define double word, i.e 4 bytes
    dd 0x00

gdt_code:                       ; the code segment descriptor
    ; base=0x0, limit=0xfffff,
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32 bit default)1 (64 bit seg)0 (avl)0 -> 1100b
    dw 0xffff                   ; limit bits 0-15
    dw 0x0                      ; base bits 0-15
    db 0x0                      ; base bits 16-23
    db 10011010b                ; 1st flags, type flags
    db 11001111b                ; 2nd flags, limit bits 16-19
    db 0x0                      ; base bits 24 - 31

gdt_data:                       ; the data segment descriptor
    ; same as code segment except for the type flags
    ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 --> 0010b
    dw 0xfff                    ; limit bit 0-15
    dw 0x0                      ; base bits 0-15
    db 0x0                      ; base bits 16-23
    db 10010010b                ; 1st flags, type flags
    db 11001111b                ; 2nd flags, limit bits 16-19
    db 0x0                      ; base bits 24 - 31

gdt_end:                        ; the reason for putting a label at the end of the
                                ; gdt is so we can have the assembler calculate the
                                ; size of the gdt for the gdt descriptor, below

; gdt descriptor
gdt_descriptor:
    dw gdt_end - gdt_start -1   ; size of our gdt, always less one
                                ; of the true size
    dd gdt_start                ; start address of our gdt


; define some handy constants for the gdt segment descriptor offsets, which
; are what segment registers must contain when in protected mode. for example
; when we set ds=0x10 in pm, the cpu knows that we mean it to use the segment
; described at offset 0x10 in our gdt, which in our case is the data segment
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
