@echo off
rem ============================================================
rem  ACM Activos Fijos - lanzador con actualizacion automatica
rem  1) La primera vez: se instala en %LOCALAPPDATA%\ACM\ActivosFijos
rem     y crea en el Escritorio el acceso directo "ACM Activos Fijos".
rem  2) Cada vez que se abre: descarga la version mas reciente desde
rem     GitHub y la abre. Si no hay internet, abre la ultima copia.
rem  Los DATOS no se descargan ni se suben: se quedan en esta computadora.
rem ============================================================
setlocal
title ACM Activos Fijos
set "APP=%LOCALAPPDATA%\ACM\ActivosFijos"
set "HTML=%APP%\ACM_Activos_Fijos.html"
set "TMPF=%APP%\descarga.tmp"
set "URL1=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/claude/inventario-activos-fijos-0e4oye/index.html"
set "URL2=https://raw.githubusercontent.com/daniellg94-hash/Activos-fijos/main/index.html"
set "MARCA=ACM-ACTIVOS-FIJOS-APP"

if not exist "%APP%" mkdir "%APP%"
if /i "%~dp0"=="%APP%\" goto actualizar

rem ---------- Instalacion (solo la primera vez) ----------
echo Instalando ACM Activos Fijos en %APP% ...
copy /y "%~f0" "%APP%\ACM_Activos_Fijos.cmd" >nul
powershell -NoProfile -Command "$app=Join-Path $env:LOCALAPPDATA 'ACM\ActivosFijos'; $d=[Environment]::GetFolderPath('Desktop'); $l=Join-Path $d 'ACM Activos Fijos.lnk'; if (Test-Path $l) { Copy-Item $l (Join-Path $app 'acceso_directo_anterior.lnk') -Force }; $s=(New-Object -ComObject WScript.Shell).CreateShortcut($l); $s.TargetPath=Join-Path $app 'ACM_Activos_Fijos.cmd'; $s.WorkingDirectory=$app; $s.WindowStyle=7; $s.IconLocation=$env:SystemRoot + '\System32\imageres.dll,109'; $s.Description='Control de Activos Fijos (se actualiza solo)'; $s.Save()"
echo Acceso directo "ACM Activos Fijos" creado en el Escritorio.

:actualizar
echo Buscando la version mas reciente...
if exist "%TMPF%" del /q "%TMPF%"
call :bajar "%URL1%"
if not exist "%TMPF%" call :bajar "%URL2%"
if not exist "%TMPF%" goto abrir
findstr /m /c:"%MARCA%" "%TMPF%" >nul 2>&1
if errorlevel 1 (del /q "%TMPF%" & goto abrir)
if exist "%HTML%" copy /y "%HTML%" "%APP%\ACM_Activos_Fijos_anterior.html" >nul
move /y "%TMPF%" "%HTML%" >nul
echo Version actualizada.

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
exit /b 0

:bajar
where curl.exe >nul 2>&1
if not errorlevel 1 curl.exe -fsSL --max-time 30 -o "%TMPF%" "%~1" >nul 2>&1
if exist "%TMPF%" for %%A in ("%TMPF%") do if %%~zA LSS 20000 del /q "%TMPF%"
if exist "%TMPF%" exit /b 0
powershell -NoProfile -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri '%~1' -OutFile '%TMPF%' -TimeoutSec 30 } catch { exit 1 }" >nul 2>&1
if exist "%TMPF%" for %%A in ("%TMPF%") do if %%~zA LSS 20000 del /q "%TMPF%"
exit /b 0
