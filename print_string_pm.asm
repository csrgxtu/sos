[bits 32]
; define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x02

; prints a null-terminated string pointed by edx
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY               ; set edx to the start of vid mem

print_string_pm_loop:
    mov al, [ebx]                       ; store the char at ebx in al
    mov ah, WHITE_ON_BLACK              ; store the attribute in ah

    cmp al, 0                           ; if al == 0, at the end of string
    je print_string_pm_done             ; jump to done

    mov [edx], ax                       ; store char and attribute at current
                                        ; character cell
    add ebx, 1                          ; increment ebx to the next char in string
    add edx, 2                          ; move to the next character cell in vid mem

    jmp print_string_pm_loop            ; loop around to print the next char

print_string_pm_done:
    popa
    ret                                 ; return from the function