@echo off
rem ACM-LANZADOR
rem ============================================================
rem  ACM Activos Fijos - lanzador con actualizacion automatica
rem  - Primera vez: se instala en %LOCALAPPDATA%\ACM\ActivosFijos y crea
rem    en el Escritorio el acceso directo "ACM Activos Fijos" con su icono.
rem  - Cada apertura: descarga desde GitHub la version mas reciente del
rem    programa, del icono y de este lanzador, y abre la herramienta.
rem    Sin internet abre la ultima copia local.
rem  Los DATOS no se descargan ni se suben: se quedan en esta computadora.
rem ============================================================
setlocal
title ACM Activos Fijos
set "VERSION=2"
set "APP=%LOCALAPPDATA%\ACM\ActivosFijos"
set "HTML=%APP%\ACM_Activos_Fijos.html"
set "ICO=%APP%\acm_activos_fijos.ico"
set "LANZ=%APP%\ACM_Activos_Fijos.cmd"
set "NUEVO=%APP%\lanzador.nuevo"
set "BASE1=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/claude/inventario-activos-fijos-0e4oye"
set "BASE2=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/main"

if not exist "%APP%" mkdir "%APP%"
if /i "%~f0"=="%LANZ%" goto actualizar
echo Instalando ACM Activos Fijos en %APP% ...
copy /y "%~f0" "%LANZ%" >nul
del /q "%APP%\acceso_v*.ok" >nul 2>&1

:actualizar
echo Buscando la version mas reciente...
call :bajar "/index.html" "%APP%\programa.nuevo" "ACM-ACTIVOS-FIJOS-APP" 20000
if exist "%APP%\programa.nuevo" (
  if exist "%HTML%" copy /y "%HTML%" "%APP%\ACM_Activos_Fijos_anterior.html" >nul
  move /y "%APP%\programa.nuevo" "%HTML%" >nul
)
call :bajar "/instalador/acm_activos_fijos.ico" "%APP%\icono.nuevo" "" 1000
if exist "%APP%\icono.nuevo" (
  fc /b "%APP%\icono.nuevo" "%ICO%" >nul 2>&1 && del /q "%APP%\icono.nuevo" || (move /y "%APP%\icono.nuevo" "%ICO%" >nul & del /q "%APP%\acceso_v*.ok" >nul 2>&1)
)
if not exist "%APP%\acceso_v%VERSION%.ok" call :acceso
call :bajar "/instalador/ACM_Activos_Fijos.cmd" "%NUEVO%" "ACM-LANZADOR" 1000

:abrir
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

rem ---------- Crea o repara el acceso directo del Escritorio y refresca iconos ----------
:acceso
powershell -NoProfile -Command "$app=Join-Path $env:LOCALAPPDATA 'ACM\ActivosFijos'; $ico=Join-Path $app 'acm_activos_fijos.ico'; $d=[Environment]::GetFolderPath('Desktop'); $l=Join-Path $d 'ACM Activos Fijos.lnk'; $b=Join-Path $app 'acceso_directo_anterior.lnk'; if ((Test-Path $l) -and -not (Test-Path $b)) { Copy-Item $l $b -Force }; if (Test-Path $l) { Remove-Item $l -Force }; $s=(New-Object -ComObject WScript.Shell).CreateShortcut($l); $s.TargetPath=Join-Path $app 'ACM_Activos_Fijos.cmd'; $s.WorkingDirectory=$app; $s.WindowStyle=7; if (Test-Path $ico) { $s.IconLocation=$ico + ',0' } else { $s.IconLocation=$env:SystemRoot + '\System32\imageres.dll,109' }; $s.Description='Control de Activos Fijos (se actualiza solo)'; $s.Save()"
ie4uinit.exe -show >nul 2>&1
ie4uinit.exe -ClearIconCache >nul 2>&1
echo listo>"%APP%\acceso_v%VERSION%.ok"
echo Acceso directo "ACM Activos Fijos" actualizado en el Escritorio.
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
