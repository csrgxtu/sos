; a boot sector that boots a c kernel in 32 bit pm
[org 0x7c00]
KERNEL_OFFSET equ 0x1000                    ; this is the mem offset to which we will load our kernel
    mov [BOOT_DRIVE], dl                    ; bios stores our boot drive in dl, so its
                                            ; best to remember this for later
    mov bp, 0x9000                          ; set up the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE                   ; announce that we r starting booting from 16 bit
    call print_string

    call load_kernel                        ; load our kernel
    call switch_to_pm                       ; switch to pm, from which we will not return

    jmp $

; include our useful routine
%include "./boot/print_string.asm"
%include "./boot/gdt.asm"
%include "./boot/print_string_pm.asm"
%include "./boot/switch_to_pm.asm"
%include "./boot/disk_load.asm"

[bits 16]
; load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL                 ; print a msg to say we r loading kernel
    call print_string

    mov bx, KERNEL_OFFSET                   ; set up params for our disk_load routine, so
    mov dh, 15                              ; that we load the first 15 sectors
    mov dl, [BOOT_DRIVE]                    ; from boot disk to address kernel offset
    call disk_load

    ret

[bits 32]
; this is where we arrive after switching to and init pm
BEGIN_PM:
    mov ebx, MSG_PROT_MODE                  ; use our 32 bit print routine
    call print_string_pm

    call KERNEL_OFFSET                      ; now jump to the address of our loaded kernel
                                            ; code, assume the brace position and cross your fingers.
    jmp $

; global variables
BOOT_DRIVE      db 0
MSG_REAL_MODE   db "Starting in 16 bit real mode", 0
MSG_PROT_MODE   db "Successfully landed in 32 bit pm", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; boot sector padding
times 510 - ($ - $$) db 0
dw 0xaa55