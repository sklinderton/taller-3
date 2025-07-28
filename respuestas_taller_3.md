# Respuestas Taller 3

## Parte 1

### a. Análisis del código ensamblador NASM

Cada línea del programa tiene las siguientes funciones:

- **`section .data`**: Define la sección de datos donde se almacenan las variables inicializadas del programa.
- **`msg db 'Hola Mundo', 0`**: Declara una cadena de texto terminada en null (0) que contiene el mensaje "Hola Mundo".
- **`section .text`**: Establece la sección de código ejecutable del programa.
- **`global _start`**: Declara el punto de entrada principal del programa, haciéndolo visible para el enlazador.
- **`_start:`**: Etiqueta que marca el inicio de la ejecución del programa.
- **Llamadas al sistema**: Las instrucciones siguientes realizan llamadas al sistema operativo para mostrar el mensaje y terminar el programa correctamente.

### b. Análisis del comando de compilación con NASM

El comando `nasm -f win64 holamundo.asm` realiza la compilación del código fuente ensamblador:

- **nasm**: Ejecuta el ensamblador NASM (Netwide Assembler)
- **-f win64**: Establece el formato de salida como objeto de 64 bits para sistemas Windows, generando un archivo con extensión .obj
- **holamundo.asm**: Especifica el archivo fuente de entrada
- **Resultado**: Produce un archivo objeto (.obj) que contiene el código máquina sin enlazar

### c. Análisis del comando de enlazado con GCC

El comando `gcc -m64 holamundo.obj -o holamundo.exe` ejecuta el proceso de enlazado:

- **gcc**: Invoca el compilador GNU que también funciona como enlazador
- **-m64**: Configura la compilación para arquitectura de 64 bits
- **holamundo.obj**: Especifica el archivo objeto de entrada generado por NASM
- **-o holamundo.exe**: Define el nombre del archivo ejecutable de salida
- **Resultado**: Crea el programa ejecutable final holamundo.exe

### d. Script de automatización (.bat)

```batch
@echo off
echo Compilando %1.asm...
nasm -f win64 %1.asm
if errorlevel 1 goto error

echo Enlazando %1.obj...
gcc -m64 %1.obj -o %1.exe
if errorlevel 1 goto error

echo Proceso completado exitosamente.
echo Ejecutable generado: %1.exe
goto end

:error
echo Error durante la compilación/enlazado.

:end
pause
```

**Uso**: `compilar holamundo`

## Parte 2

### a. Análisis del programa holaenc.c

El programa en C presenta la siguiente estructura:

- **`#include <stdio.h>`**: Incorpora la biblioteca de entrada/salida estándar
- **`#include <conio.h>`**: Incluye funciones específicas de consola (no estándar, típica de Windows)
- **`int main()`**: Define la función principal del programa
- **`printf("Hola mundo encriptado\n");`**: Muestra el mensaje en pantalla con salto de línea
- **`getch();`**: Pausa la ejecución esperando que el usuario presione cualquier tecla
- **`return 0;`**: Termina el programa devolviendo código de éxito

### b. Ejecución del programa compilado

La ejecución de `holaenc.exe` en el paso 8 inicia el programa compilado, el cual:
- Presenta el mensaje "Hola mundo encriptado" en la consola
- Mantiene la ventana abierta esperando una entrada del teclado
- Finaliza cuando el usuario presiona cualquier tecla

### c. Proceso de desensamblado

El comando `ndisasm holaenc.exe > holaenc.asm` ejecuta un proceso de ingeniería inversa:

- **ndisasm**: Herramienta de desensamblado que convierte código máquina a lenguaje ensamblador
- **holaenc.exe**: Archivo ejecutable de entrada para el análisis
- **> holaenc.asm**: Redirecciona la salida del desensamblador hacia un nuevo archivo
- **Propósito**: Permite examinar las instrucciones de máquina generadas por el compilador de C, facilitando el análisis del código ejecutable en formato legible
