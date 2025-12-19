@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM  QuestaSim 10.6c UVM Runner (FORCE UVM-1.2)
REM  Commands:
REM    run.bat comp  [uvm_test] [seed] [-g|--debug]
REM    run.bat sim   [uvm_test] [seed] [-g|--debug]   (console)
REM    run.bat gui   [uvm_test] [seed] [-g|--debug]   (GUI + wave auto)
REM    run.bat run   [uvm_test] [seed] [-g|--debug]   (comp+sim)
REM    run.bat debug [uvm_test] [seed]               (comp+gui with -g)
REM    run.bat clean
REM ============================================================

set ROOT=%~dp0
cd /d %ROOT%

REM ---- user config ------------------------------
set QUESTA_HOME=C:\questasim64_10.6c
set TOP=sim_top
set FILELIST=tb\filelist.f

set SIMDIR=sim
set WORKDIR=%SIMDIR%\work

set DEFAULT_CASE=my_test
set CASE=%DEFAULT_CASE%

set DEFAULT_SEED=1
set SEED=%DEFAULT_SEED%

REM External UVM-1.2 source (Questa built-in)
set UVM_HOME=%QUESTA_HOME%\verilog_src\uvm-1.2\src

REM Use Questa built-in UVM DPI dll (base name, no .dll)
set UVM_DPI_BASE=%QUESTA_HOME%\uvm-1.2\win64\uvm_dpi

REM vopt cache name
set OPT_TOP=%TOP%_opt

REM default: debug OFF
set DBG=0
REM ------------------------------------------------

REM ---- setup PATH for questa --------------------
if exist "%QUESTA_HOME%\win64\vsim.exe" (
    set PATH=%QUESTA_HOME%\win64;%PATH%
) else (
    echo [ERROR] QUESTA_HOME invalid: %QUESTA_HOME%
    exit /b 1
)

REM ---- parse cmd --------------------------------
if "%1"=="" goto HELP
set CMD=%1

if not "%2"=="" set CASE=%2
if not "%3"=="" set SEED=%3

REM parse optional flags from %4..%9
for %%A in (%4 %5 %6 %7 %8 %9) do (
    if /i "%%~A"=="-g"      set DBG=1
    if /i "%%~A"=="--debug" set DBG=1
)

REM default UVM opts
set UVM_OPTS=+UVM_TESTNAME=%CASE% +ntb_random_seed=%SEED%

REM When debug switch ON: add traces
set UVM_TRACE_OPTS=+UVM_VERBOSITY=UVM_HIGH +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE

REM ---- build options by DBG switch --------------
set DBG_VLOG=
set DBG_VOPT=
set DBG_VSIM=

if "%DBG%"=="1" (
    echo [MODE] DEBUG/SINGLE-STEP = ON
    set DBG_VLOG=-classdebug
    set DBG_VSIM=
    set UVM_OPTS=%UVM_OPTS% %UVM_TRACE_OPTS%
) else (
    echo [MODE] DEBUG/SINGLE-STEP = OFF
)

REM vlog options
set VLOG_OPTS=-sv -timescale=1ns/1ps -work work -l %SIMDIR%\vlog.log -mfcu -incr %DBG_VLOG%

REM ------------------------------------------------
if /i "%CMD%"=="clean" goto CLEAN
if /i "%CMD%"=="run"   goto RUN_GROUP
if /i "%CMD%"=="debug" goto DEBUG_GROUP
if /i "%CMD%"=="comp"  goto COMP
if /i "%CMD%"=="sim"   goto SIM
if /i "%CMD%"=="gui"   goto GUI
goto HELP

REM ============================================================
:CLEAN
echo [CLEAN] cleaning outputs under %SIMDIR% ...
if exist "%SIMDIR%" (
    if exist "%WORKDIR%" vdel -lib "%WORKDIR%" -all >nul 2>nul
    del /f /q "%SIMDIR%\*.log" >nul 2>nul
    del /f /q "%SIMDIR%\*.wlf" >nul 2>nul
    del /f /q "%SIMDIR%\transcript" >nul 2>nul
    del /f /q "%SIMDIR%\*.ucdb" >nul 2>nul
    del /f /q "modelsim.ini" >nul 2>nul
    del /f /q "%OPT_TOP%" >nul 2>nul
)
echo [CLEAN] done.
exit /b 0

REM ============================================================
:COMP
echo [COMP] prepare sim folder...

if not exist "%SIMDIR%" mkdir "%SIMDIR%"
if not exist "%WORKDIR%" vlib "%WORKDIR%"

REM map logical lib "work" -> physical path sim\work
vmap work "%WORKDIR%" >nul 2>nul

REM check external UVM source
if not exist "%UVM_HOME%\uvm_pkg.sv" (
    echo [ERROR] uvm_pkg.sv not found under %UVM_HOME%
    exit /b 7
)

REM check DPI dll
if not exist "%UVM_DPI_BASE%.dll" (
    echo [ERROR] built-in uvm_dpi.dll not found: %UVM_DPI_BASE%.dll
    exit /b 11
)

REM check filelist
if not exist "%FILELIST%" (
    echo [ERROR] filelist not found: %FILELIST%
    exit /b 2
)

REM ---- 1) compile external UVM-1.2 into work (override built-in)
echo [COMP] compile external UVM-1.2 into work
vlog %VLOG_OPTS% +incdir+%UVM_HOME% "%UVM_HOME%\uvm_pkg.sv"
if errorlevel 1 (
    echo [ERROR] compile UVM-1.2 failed. Check %SIMDIR%\vlog.log
    exit /b 8
)

REM ---- 2) compile your TB/RTL
echo [COMP] vlog (incremental) -f %FILELIST%
vlog %VLOG_OPTS% +incdir+%UVM_HOME% -f "%FILELIST%"
if errorlevel 1 (
    echo [ERROR] vlog failed. Check %SIMDIR%\vlog.log
    exit /b 3
)

REM ---- 3) vopt cache after compile
REM IMPORTANT: Always keep visibility for waveform/debug: +acc
REM If you prefer: replace +acc with -access +rwc
echo [COMP] vopt cache -> %OPT_TOP% (with +acc)
if "%DBG%"=="1" (
    vopt %TOP% -o %OPT_TOP% -work work -l %SIMDIR%\vopt.log +acc
) else (
    vopt %TOP% -o %OPT_TOP% -work work -l %SIMDIR%\vopt.log +acc
)
if errorlevel 1 (
    echo [ERROR] vopt failed. Check %SIMDIR%\vopt.log
    exit /b 4
)

echo [COMP] done.
exit /b 0

REM ============================================================
:SIM
echo [SIM] running test=%CASE% seed=%SEED% (console)...

vsim %OPT_TOP% ^
  -lib work ^
  -l %SIMDIR%\vsim.log ^
  %DBG_VSIM% ^
  -sv_lib "%UVM_DPI_BASE%" ^
  -sv_seed %SEED% ^
  -onfinish stop ^
  -c ^
  %UVM_OPTS% ^
  -do "log -r /*; run -all; quit -f"

if errorlevel 1 (
    echo [ERROR] sim failed. Check %SIMDIR%\vsim.log
    exit /b 5
)

echo [SIM] done.
exit /b 0

REM ============================================================
:GUI
echo [GUI] running test=%CASE% seed=%SEED% (GUI)...

vsim %OPT_TOP% ^
  -lib work ^
  -l %SIMDIR%\vsim.log ^
  %DBG_VSIM% ^
  -sv_lib "%UVM_DPI_BASE%" ^
  -sv_seed %SEED% ^
  -onfinish stop ^
  -wlf %SIMDIR%\vsim.wlf ^
  %UVM_OPTS% ^
  -do "log -r /*; add wave -r /*; run -all"

exit /b 0

REM ============================================================
:RUN_GROUP
call "%~f0" comp %CASE% %SEED% %4 %5 %6 %7 %8 %9
if errorlevel 1 exit /b !errorlevel!
call "%~f0" sim %CASE% %SEED% %4 %5 %6 %7 %8 %9
exit /b 0

REM ============================================================
:DEBUG_GROUP
call "%~f0" comp %CASE% %SEED% -g
if errorlevel 1 exit /b !errorlevel!
call "%~f0" gui %CASE% %SEED% -g
exit /b 0

REM ============================================================
:HELP
echo.
echo Usage:
echo   run.bat run   [uvm_test] [seed] [-g^|--debug]
echo   run.bat gui   [uvm_test] [seed] [-g^|--debug]
echo   run.bat comp  [uvm_test] [seed] [-g^|--debug]
echo   run.bat sim   [uvm_test] [seed] [-g^|--debug]
echo   run.bat debug [uvm_test] [seed]        ^<-- comp+gui with debug ON
echo   run.bat clean
echo.
echo External UVM-1.2: %UVM_HOME%
echo DPI dll         : %UVM_DPI_BASE%.dll
echo Default test    : %DEFAULT_CASE%
echo Default seed    : %DEFAULT_SEED%
echo.
exit /b 0
