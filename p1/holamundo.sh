#!/bin/bash
echo "Compilando archivo ASM con NASM..."
nasm -f elf64 holamundo.asm -o holamundo.o

echo "Enlazando archivo O con GCC..."
gcc holamundo.o -no-pie -o holamundo
