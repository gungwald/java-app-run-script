@echo off
rem Skip over subroutine definitions.
goto :main

rem //////////////////////////////////////////////////////////////////////
rem
rem Writes a message if DEBUG is turned on.
rem
rem //////////////////////////////////////////////////////////////////////
:writeDebug
if defined DEBUG echo %programName%: DEBUG: %*
exit /b
rem The above "exit" returns from this subroutine.

rem //////////////////////////////////////////////////////////////////////
rem
rem Writes an error message to the standard error output stream.
rem
rem //////////////////////////////////////////////////////////////////////
:writeError
echo %programName%: ERROR: %* >&2
exit /b
rem The above "exit" returns from this subroutine.


rem //////////////////////////////////////////////////////////////////////
rem
rem Main Program
rem
rem //////////////////////////////////////////////////////////////////////
:main
setlocal EnableDelayedExpansion
set programName=%~0
title %programName%
rem Determine the directory this script is in and then remove the trailing
rem backslash.
set binDir=%~dp0
set binDir=%binDir:~0,-1%

rem //////////////////////////////////////////////////////////////////////
rem
rem Find application jar file to run
rem
rem //////////////////////////////////////////////////////////////////////

rem DO NOT try to put the search directories in a variable first because
rem then any space inside an individual directory will cause the directory
rem to get split into separate words. Putting the list in the "for" loop
rem allows the spaces in directory names to be preserved with the double-
rem quotes around each variable.
set jar=
for /d %%d in ("%binDir%" "%binDir%\..\lib" "%USERPROFILE%\lib" ^
               "%USERPROFILE%\Documents\lib" "%USERPROFILE%\Dropbox\lib") ^
               do (
    set potentialJarLocation=%%~d\%jarName%
    call :writeDebug Checking potentialJarLocation=!potentialJarLocation!
    if exist "!potentialJarLocation!" (
        set jar=!potentialJarLocation!
        call :writeDebug Found jar=!jar!
        rem No need to waste CPU time continuing this loop.
        goto :endOfJarSearch
    )
)
:endOfJarSearch

if not defined jar (
    call :writeError Application jar %jarName% not found.
    goto :end
)

rem //////////////////////////////////////////////////////////////////////
rem
rem Find java.exe, taking into account the JAVA_HOME setting.
rem
rem //////////////////////////////////////////////////////////////////////

rem Clear java variable so we can tell later if we set it to something.
set java=

rem Check for java.exe in JAVA_HOME\bin
if defined JAVA_HOME (
    set possibleJava=!JAVA_HOME!\bin\java.exe
    if exist "!possibleJava!" (
        set java=!possibleJava!
    )
)

if not defined java (
    rem Check for java in the PATH. This should be the case for a modern
    rem version of java, unless the user has modified their PATH variable.
    where java
    if %ERRORLEVEL%==0 (
        set java=java
    )
)

if not defined java (
    rem Find the highest version of Java. The last one set will be the
    rem highest version because they're processed in alphabetic order.
    for /d %%j in ("C:\Program Files (x86)\Java\jre*" ^
                   "C:\Program Files (x86)\Java\jdk*" ^
                   "C:\Program Files\Java\jre*" ^
                   "C:\Program Files\Java\jdk*") ^
                   do (
        set possibleJava=%%j\bin\java.exe
        if exist "!possibleJava!" (
            set java=!possibleJava!
        )
    )
)

if not defined java (
    call :writeError Java not found. Please install it or set JAVA_HOME.
    goto :end
)

rem //////////////////////////////////////////////////////////////////////
rem
rem All parts found. Run the app.
rem
rem //////////////////////////////////////////////////////////////////////

"%java%" -jar "%jar%" %*

:end

rem //////////////////////////////////////////////////////////////////////
rem
rem Pause if started from GUI
rem
rem //////////////////////////////////////////////////////////////////////

call :writeDebug CMDCMDLINE=%CMDCMDLINE%

for /f "tokens=2" %%a in ("%CMDCMDLINE%") do (
    if "%%a"=="/c" (
        pause
    )
)

title Command Prompt
endlocal

