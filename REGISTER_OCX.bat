@echo off
echo ^_^_^_^_^_ ^_^_^_^_^_ ^_^_   ^_^_ ^_^_^_^_^_^_ ^_^_^_^_^_ ^_^_^_^_^_ ^_^_^_^_^_ ^_^_^_^_^_ ^_^_^_^_^_^_^_^_^_^_^_  ^_^_^_ ^_^_^_^_^_ ^_^_^_^_^_^_^_^_^_^_^_ 
echo ^|  ^_  ^/  ^_^_ ^\^\ ^\ ^/ ^/ ^| ^_^_^_ ^\  ^_^_^_^|  ^_^_ ^\^_   ^_^/  ^_^_^_^|^_   ^_^| ^_^_^_ ^\^/ ^_ ^\^_   ^_^|  ^_  ^| ^_^_^_ ^\
echo ^| ^| ^| ^| ^/  ^\^/ ^\ V ^/  ^| ^|^_^/ ^/ ^|^_^_ ^| ^|  ^\^/ ^| ^| ^\ `--.  ^| ^| ^| ^|^_^/ ^/ ^/^_^\ ^\^| ^| ^| ^| ^| ^| ^|^_^/ ^/
echo ^| ^| ^| ^| ^|     ^/   ^\  ^|    ^/^|  ^_^_^|^| ^| ^_^_  ^| ^|  `--. ^\ ^| ^| ^|    ^/^|  ^_  ^|^| ^| ^| ^| ^| ^|    ^/ 
echo ^\ ^\^_^/ ^/ ^\^_^_^/^\^/ ^/^^\ ^\ ^| ^|^\ ^\^| ^|^_^_^_^| ^|^_^\ ^\^_^| ^|^_^/^\^_^_^/ ^/ ^| ^| ^| ^|^\ ^\^| ^| ^| ^|^| ^| ^\ ^\^_^/ ^/ ^|^\ ^\ 
echo  ^\^_^_^_^/ ^\^_^_^_^_^/^\^/   ^\^/ ^\^_^| ^\^_^\^_^_^_^_^/ ^\^_^_^_^_^/^\^_^_^_^/^\^_^_^_^_^/  ^\^_^/ ^\^_^| ^\^_^\^_^| ^|^_^/^\^_^/  ^\^_^_^_^/^\^_^| ^\^_^|
echo.
echo Assembled by Do@a
echo.

:check
openfiles >nul
if %errorlevel%==1 echo [*] Closing... & timeout 3 >nul & exit
(wmic os get osarchitecture | find /i "64 bits")>nul
if %errorlevel%==0 (cd "%windir%/SysWOW64") else (cd "%windir%/System32") 

:main
set /a y=0
set /a n=0
REM if you want to register all DLL just change ocx to dll.
echo Return Code, Info
for %%f in (*.ocx) do (
call :regit %%f
echo>nul
)
echo Done. %y% registred and %n% non registred.
choice /c YN /M "Delete non working OCX?"
if errorlevel 1 goto :del
del bad_ocx.log
exit

:regit
regsvr32 /s %1
if not %errorlevel%==0 (echo [%errorlevel%] Error while registring %1. & set /a n+=1 &echo %1>>bad_ocx.log) else (echo [%errorlevel%] %1 is registred. & set /a y+=1)

exit /b %errorlevel%


:del
REM May not work sometimes. 
for /f "tokens=*" %%a in (bad_ocx.log) do (
del %%a
)
echo Done.
del bad_ocx.log
pause
exit
