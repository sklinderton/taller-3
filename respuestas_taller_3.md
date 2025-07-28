# Respuestas Taller 3

## Parte 1

### a. Análisis del código ensamblador NASM

Cada línea del programa tiene las siguientes funciones:

- **`bits 64`**: Especifica que el código está destinado para arquitectura de 64 bits
- **`default rel`**: Establece el direccionamiento relativo como predeterminado para facilitar el código reubicable
- **`segment .data`**: Define la sección de datos donde se almacenan las variables inicializadas
- **`msg db "hola mundo!", 0xd, 0xa, 0`**: Declara una cadena con el mensaje, seguido de retorno de carro (0xd), salto de línea (0xa) y terminador null (0)
- **`segment .text`**: Establece la sección de código ejecutable
- **`global main`**: Declara la función main como símbolo global, accesible desde otros módulos
- **`extern ExitProcess`**: Declara ExitProcess como función externa de la API de Windows
- **`extern printf`**: Declara printf como función externa de la biblioteca C
- **`main:`**: Etiqueta que marca el punto de entrada de la función principal
- **`push rbp / mov rbp, rsp`**: Establece el marco de pila (stack frame) estándar
- **`sub rsp, 32`**: Reserva 32 bytes en la pila para el espacio de sombra requerido por la convención de llamadas de Windows x64
- **`lea rcx, [msg]`**: Carga la dirección del mensaje en el registro RCX (primer parámetro)
- **`call printf`**: Invoca la función printf para mostrar el mensaje
- **`xor rax, rax`**: Limpia el registro RAX (código de retorno 0)
- **`call ExitProcess`**: Termina el proceso usando la API de Windows

### b. Análisis del comando de ensamblado con NASM

El comando `nasm -fwin64 holamundo.asm` ejecuta el proceso de ensamblado:

- **nasm**: Invoca el ensamblador NASM (Netwide Assembler)
- **-fwin64**: Especifica el formato de salida como archivo objeto para Windows de 64 bits (formato PE/COFF)
- **holamundo.asm**: Archivo fuente de ensamblador de entrada
- **Producto generado**: Crea el archivo `holamundo.obj`, que contiene código máquina sin resolver las referencias externas (printf, ExitProcess)

### c. Análisis del comando de enlazado con GCC

El comando `gcc -m64 holamundo.obj -o holamundo.exe` realiza el enlazado final:

- **gcc**: Utiliza el compilador GNU como enlazador (linker)
- **-m64**: Especifica la generación de código para arquitectura de 64 bits
- **holamundo.obj**: Archivo objeto de entrada creado por NASM
- **-o holamundo.exe**: Define el nombre del archivo ejecutable de salida
- **Producto generado**: Crea `holamundo.exe`, un ejecutable completo que resuelve todas las referencias externas enlazando con las bibliotecas necesarias (msvcrt.dll para printf, kernel32.dll para ExitProcess)

### d. Script de automatización para Windows (.bat)

```batch
@echo off
if "%1"=="" (
    echo Uso: compilar [nombre_archivo_sin_extension]
    echo Ejemplo: compilar holamundo
    pause
    exit /b 1
)

echo Ensamblando %1.asm con NASM...
nasm -fwin64 %1.asm
if errorlevel 1 (
    echo Error durante el ensamblado de %1.asm
    pause
    exit /b 1
)

echo Enlazando %1.obj con GCC...
gcc -m64 %1.obj -o %1.exe
if errorlevel 1 (
    echo Error durante el enlazado de %1.obj
    pause
    exit /b 1
)

echo Compilacion exitosa: %1.exe generado correctamente
echo Para ejecutar: %1.exe
pause
```

**Instrucciones de uso**:
1. Guardar como `compilar.bat` en la misma carpeta que los archivos .asm
2. Ejecutar: `compilar holamundo`
3. El script procesará `holamundo.asm` y generará `holamundo.exe`

## Parte 2

### a. Análisis del programa holaenc.c

El programa en C presenta la siguiente estructura y funcionamiento:

- **`#include <conio.h>`**: Incluye la biblioteca de consola específica de sistemas DOS/Windows que proporciona funciones como getch()
- **`#include <stdio.h>`**: Incorpora la biblioteca estándar de entrada/salida de C para funciones como printf()
- **`int main()`**: Define la función principal del programa que retorna un valor entero
- **`printf("Hola mundo.");`**: Invoca la función de la biblioteca estándar para mostrar la cadena "Hola mundo." en la consola
- **`getch();`**: Función específica de conio.h que pausa la ejecución esperando que el usuario presione cualquier tecla sin mostrarla en pantalla
- **`return 0;`**: Finaliza la ejecución del programa retornando 0 al sistema operativo, indicando terminación exitosa

### b. Análisis de la ejecución del programa (Paso 8)

La ejecución del comando `holaenc` en el paso 8 ejecuta el programa compilado:

- **Proceso**: El sistema operativo carga el ejecutable holaenc.exe en memoria y transfiere el control a la función main()
- **Salida**: El programa muestra "Hola mundo." en la ventana de la consola
- **Pausa**: La función getch() mantiene la ventana abierta esperando entrada del usuario, evitando que la consola se cierre inmediatamente
- **Finalización**: Una vez presionada cualquier tecla, el programa termina y retorna el control al shell de comandos

### c. Análisis del desensamblado (Paso 9)

El comando `ndisasm holaenc.exe > holaenc.asm` ejecuta un proceso de ingeniería inversa:

- **ndisasm**: Herramienta de desensamblado incluida con NASM que convierte código máquina ejecutable de vuelta a instrucciones de ensamblador legibles
- **holaenc.exe**: Archivo ejecutable de entrada que será analizado
- **> holaenc.asm**: Operador de redirección que envía la salida del desensamblador a un archivo de texto
- **Resultado**: Genera el archivo holaenc.asm que contiene las instrucciones de ensamblador equivalentes al código máquina del ejecutable, incluyendo las llamadas a printf, getch y las estructuras del PE (Portable Executable) de Windows
- **Propósito**: Permite examinar cómo el compilador GCC tradujo el código C original a instrucciones de máquina, mostrando las optimizaciones aplicadas y el código generado para las funciones de biblioteca
