; load dh sectors to es:bx from drive dl
disk_load:
    push dx                     ; store dx on stack so later we can recall
                                ; how many sectors were request to be read
                                ; even if it is altered in the meantime
    mov ah, 0x02                ; bios read sector func
    mov al, dh                  ; read dh sector
    mov ch, 0x00                ; select cylinder 0
    mov dh, 0x00                ; select head 0
    mov cl, 0x02                ; start reading from second sector

    int 0x13                    ; bios interrupt

    jc disk_error               ; jump if error

    pop dx                      ; restore dx from stack
    cmp dh, al                  ; if al != dh display error
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; variables
DISK_ERROR_MSG db "Disk read error!", 0