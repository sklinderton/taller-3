bits 64
default rel

section .data
    msg db "¡Hola mundo desde Linux!", 0xA, 0

section .text
global main
extern printf

main:
    push rbp
    mov rbp, rsp

    lea rdi, [rel msg]     ; Primer argumento para print
    xor eax, eax           ; Limpieza para función variádica
    call printf

    mov eax, 0             ; Código de salida
    pop rbp
    ret

