chcp 65001
@echo off
:: Script para administración de sistemas en Windows Server
:: Menú principal
:MENU
cls
ECHO ================================
ECHO  Administración de Sistemas
ECHO ================================
ECHO 1. Ver información del sistema
ECHO 2. Diagnóstico de red
ECHO 3. Ver procesos activos
ECHO 4. Finalizar un proceso
ECHO 5. Escanear y reparar archivos del sistema
ECHO 6. Comprobar y reparar disco
ECHO 7. Configuración de usuarios
ECHO 8. Salir
ECHO ================================
set /p option="Elige una opción: "

:: Validar que la opción esté entre 1 y 8
IF "%option%"=="1" GOTO SYSTEMINFO
IF "%option%"=="2" GOTO NETWORK
IF "%option%"=="3" GOTO TASKLIST
IF "%option%"=="4" GOTO TASKKILL
IF "%option%"=="5" GOTO SFCSCAN
IF "%option%"=="6" GOTO CHKDSK
IF "%option%"=="7" GOTO USERCONFIG
IF "%option%"=="8" GOTO EXIT

:: Si la opción no es válida, mostrar mensaje y volver al menú
ECHO Opción no válida, por favor ingresa una opción entre 1 y 8.
pause
GOTO MENU

:: Comando para ver información del sistema
:SYSTEMINFO
:: Muestra detalles del sistema operativo y hardware
systeminfo
pause
GOTO MENU

:: Comandos para diagnóstico de red
:NETWORK
:: Muestra la configuración de red
ipconfig /all
:: Lista la tabla ARP
arp -a
:: Muestra la tabla de enrutamiento
route print
pause
GOTO MENU

:: Comando para ver procesos activos
:TASKLIST
:: Pregunta si se quiere aplicar un filtro
ECHO ¿Quieres aplicar un filtro? (S/N)
set /p applyFilter="Elige una opción: "

IF /I "%applyFilter%"=="S" (
    :: Si elige 'S', pide el filtro
    set /p filter="Ingresa el filtro (por ejemplo, IMAGENAME eq chrome.exe): "
    :: Verifica si el filtro está vacío
    IF NOT "%filter%"=="" (
        :: Ejecuta TASKLIST con el filtro
        TASKLIST /FI "%filter%"
    ) ELSE (
        :: Si el filtro está vacío, ejecuta TASKLIST sin filtro
        ECHO No se proporcionó un filtro válido.
        TASKLIST
    )
) ELSE (
    :: Si no elige 'S', ejecuta TASKLIST sin filtro
    TASKLIST
)
:: Mostrar lista de filtros válidos
ECHO ================================
ECHO  Filtros válidos para TASKLIST
ECHO ================================
ECHO Nombre de filtro   Operadores válidos    Valor(es) válido(s)
ECHO -------------------------------------------------------------
ECHO STATUS            eq, ne                 RUNNING | NOT RESPONDING | UNKNOWN
ECHO IMAGENAME         eq, ne                 Nombre de la imagen
ECHO PID               eq, ne, gt, lt, ge, le Valor de PID
ECHO SESSION           eq, ne, gt, lt, ge, le Número de la sesión
ECHO CPUtime           eq, ne, gt, lt, ge, le Tiempo de CPU con formato HH:MM:SS
ECHO MEMUSAGE          eq, ne, gt, lt, ge, le Uso de memoria en KB
ECHO USERNAME          eq, ne                 Cualquier nombre de usuario válido
ECHO SERVICES          eq, ne                 Nombre del servicio
ECHO WINDOWTITLE       eq, ne                 Título de la ventana
ECHO MODULES           eq, ne                 Nombre de DLL
ECHO ================================
pause
GOTO MENU

:: Comando para finalizar un proceso
:TASKKILL
:: Solicita el PID del proceso a finalizar
set /p pid="Ingresa el PID del proceso a finalizar: "
taskkill /PID %pid% /F
pause
GOTO MENU

:: Comando para escanear y reparar archivos del sistema
:SFCSCAN
:: Escanea y repara archivos dañados del sistema
sfc /scannow
pause
GOTO MENU

:: Comando para comprobar y reparar disco
:CHKDSK
:: Solicita la unidad a escanear
set /p drive="Ingresa la letra de la unidad (Ej. C): "
chkdsk %drive%: /f /r /x
pause
GOTO MENU

:: Configuración de usuarios
:USERCONFIG
:: Muestra opciones para gestionar usuarios
ECHO 1. Crear un usuario
ECHO 2. Eliminar un usuario
ECHO 3. Volver al menú principal
set /p useroption="Elige una opción: "
IF "%useroption%"=="1" GOTO ADDUSER
IF "%useroption%"=="2" GOTO DELUSER
IF "%useroption%"=="3" GOTO MENU

:ADDUSER
:: Solicita nombre de usuario y contraseña para crear un usuario
set /p username="Ingresa el nombre del usuario: "
set /p password="Ingresa la contraseña: "
net user %username% %password% /add
pause
GOTO USERCONFIG

:DELUSER
:: Solicita el nombre del usuario a eliminar
set /p delusername="Ingresa el nombre del usuario a eliminar: "
net user %delusername% /delete
pause
GOTO USERCONFIG

:: Salir del script
:EXIT
exit