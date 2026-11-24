@echo off
rem ACM-LANZADOR
rem ============================================================
rem  ACM Activos Fijos - lanzador con actualizacion automatica
rem  Se instala EN LA CARPETA DONDE SE COLOCA ESTE ARCHIVO, por ejemplo:
rem    C:\Users\<usuario>\Desktop\ACM_ActivosFijos
rem  - Crea ahi el acceso directo "ACM Activos Fijos" con su icono
rem    (si ya existia uno que abria otro programa, lo conserva como
rem    "ACM Activos Fijos (anterior)").
rem  - Cada apertura: descarga desde GitHub la version mas reciente del
rem    programa, del icono y de este lanzador, y abre la herramienta.
rem    Sin internet abre la ultima copia local.
rem  No modifica ningun otro archivo de la carpeta.
rem  Los DATOS no se descargan ni se suben: se quedan en esta computadora.
rem ============================================================
setlocal
title ACM Activos Fijos
set "VERSION=3"
set "APP=%~dp0"
set "APP=%APP:~0,-1%"
set "LANZ=%~f0"
set "HTML=%APP%\ACM_Activos_Fijos.html"
set "ICO=%APP%\acm_activos_fijos.ico"
set "NUEVO=%APP%\lanzador.nuevo"
set "OK=%APP%\acm_acceso_v%VERSION%.ok"
set "VIEJO=%LOCALAPPDATA%\ACM\ActivosFijos"
set "BASE1=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/claude/inventario-activos-fijos-0e4oye"
set "BASE2=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/main"

if /i "%APP%"=="%USERPROFILE%\Downloads" (
  echo.
  echo Este archivo esta en la carpeta Descargas.
  echo Copielo a la carpeta donde quiere instalar la herramienta, por ejemplo:
  echo   %USERPROFILE%\Desktop\ACM_ActivosFijos
  echo y ejecutelo desde ahi con doble clic.
  echo.
  pause
  exit /b 1
)
rem El acceso directo va en la misma carpeta; en la instalacion anterior (AppData) iba en el Escritorio
set "LNKDIR=%APP%"
if /i "%APP%"=="%VIEJO%" for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "[Environment]::GetFolderPath('Desktop')"`) do set "LNKDIR=%%D"

echo Buscando la version mas reciente...
call :bajar "/index.html" "%APP%\programa.nuevo" "ACM-ACTIVOS-FIJOS-APP" 20000
if exist "%APP%\programa.nuevo" (
  if exist "%HTML%" copy /y "%HTML%" "%APP%\ACM_Activos_Fijos_anterior.html" >nul
  move /y "%APP%\programa.nuevo" "%HTML%" >nul
)
call :bajar "/instalador/acm_activos_fijos.ico" "%APP%\icono.nuevo" "" 1000
if exist "%APP%\icono.nuevo" (
  fc /b "%APP%\icono.nuevo" "%ICO%" >nul 2>&1 && del /q "%APP%\icono.nuevo" || (move /y "%APP%\icono.nuevo" "%ICO%" >nul & del /q "%OK%" >nul 2>&1)
)
if not exist "%OK%" call :acceso
call :bajar "/instalador/ACM_Activos_Fijos.cmd" "%NUEVO%" "ACM-LANZADOR" 1000

if not exist "%HTML%" (
  echo.
  echo No se pudo descargar la herramienta y no hay una copia local.
  echo Revise su conexion a internet e intente de nuevo.
  pause
  exit /b 1
)
set "URLF=file:///%HTML:\=/%"
set "CHROME="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" set "CHROME=%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
if defined CHROME (
  start "" "%CHROME%" --app="%URLF%"
) else (
  start "" msedge --app="%URLF%"
)
rem El lanzador se reemplaza al final y en un solo bloque para no interrumpir su propia ejecucion
if exist "%NUEVO%" (
  fc /b "%NUEVO%" "%LANZ%" >nul 2>&1 && del /q "%NUEVO%" || (move /y "%NUEVO%" "%LANZ%" >nul & exit /b 0)
)
exit /b 0

rem ---------- Crea o repara el acceso directo y refresca la cache de iconos ----------
:acceso
powershell -NoProfile -Command "$sh=New-Object -ComObject WScript.Shell; $l=Join-Path $env:LNKDIR 'ACM Activos Fijos.lnk'; if (Test-Path $l) { $t=$sh.CreateShortcut($l).TargetPath; $b=Join-Path $env:LNKDIR 'ACM Activos Fijos (anterior).lnk'; if (($t -ne $env:LANZ) -and -not (Test-Path $b)) { Copy-Item $l $b -Force }; Remove-Item $l -Force }; $s=$sh.CreateShortcut($l); $s.TargetPath=$env:LANZ; $s.WorkingDirectory=$env:APP; $s.WindowStyle=7; if (Test-Path $env:ICO) { $s.IconLocation=$env:ICO + ',0' } else { $s.IconLocation=$env:SystemRoot + '\System32\imageres.dll,109' }; $s.Description='Control de Activos Fijos (se actualiza solo)'; $s.Save(); if ($env:LNKDIR -ne $env:VIEJO) { $d=Join-Path ([Environment]::GetFolderPath('Desktop')) 'ACM Activos Fijos.lnk'; $mio=Join-Path $env:VIEJO 'ACM_Activos_Fijos.cmd'; if ((Test-Path $d) -and ($d -ne $l) -and ($sh.CreateShortcut($d).TargetPath -eq $mio)) { Remove-Item $d -Force } }"
ie4uinit.exe -show >nul 2>&1
ie4uinit.exe -ClearIconCache >nul 2>&1
del /q "%APP%\acm_acceso_v*.ok" >nul 2>&1
echo listo>"%OK%"
attrib +h "%OK%" >nul 2>&1
echo Acceso directo "ACM Activos Fijos" actualizado en %LNKDIR%.
exit /b 0

rem ---------- Descarga: %1 ruta en el repositorio, %2 destino, %3 marca a validar, %4 tamano minimo ----------
:bajar
if exist "%~2" del /q "%~2"
for %%U in ("%BASE1%" "%BASE2%") do if not exist "%~2" call :bajar1 "%%~U%~1" "%~2" "%~3" %4
exit /b 0

:bajar1
where curl.exe >nul 2>&1 && curl.exe -fsSL --max-time 30 -o "%~2" "%~1" >nul 2>&1
call :validar "%~2" "%~3" %4
if exist "%~2" exit /b 0
powershell -NoProfile -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri '%~1' -OutFile '%~2' -TimeoutSec 30 } catch { exit 1 }" >nul 2>&1
call :validar "%~2" "%~3" %4
exit /b 0

:validar
if not exist "%~1" exit /b 0
for %%A in ("%~1") do if %%~zA LSS %3 del /q "%~1"
if not exist "%~1" exit /b 0
if not "%~2"=="" findstr /m /c:"%~2" "%~1" >nul 2>&1 || del /q "%~1"
exit /b 0
