org 0x7C00
bits 16

main:
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00

    mov ax, 13h
    int 10h

    call draw_circle
.end:
    hlt
    jmp .end

draw_circle:
    mov ah, 0Ch
    mov al, 4
    mov bh, 0

    mov cx, 0
    mov dx, 0

.draw:
    cmp cx, 319
    je .jump_line

    push cx
    push dx
    push ax

    mov ax, 100

    sub cx, 159
    sub dx, 100

    mov ax, cx
    imul ax, ax
    mov cx, ax

    mov ax, dx
    imul ax, ax

    add ax, cx

    cmp ax, [radius_squared]

    pop ax
    pop dx
    pop cx
    ja .draw_border

    int 10h
    jmp .inc_line
.draw_border:
    mov al, 6
    int 10h
    mov al, 4
.inc_line:
    inc cx
    jmp .draw

.jump_line:
    xor cx, cx
    inc dx

    cmp dx, 199
    jne .draw

    ret

radius_squared dw 2500

times 510-($-$$) db 0
dw 0AA55h
