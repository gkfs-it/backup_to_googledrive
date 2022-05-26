@echo off

setlocal

set YY=%date:~6,5%
set MM=%date:~3,2%
set DD=%date:~0,2%

set SQL=[тут адрес сервера СУБД]
set DB=[тут название БД]
set PASS=[пароль]
set BCKDIR="d:\PathTo\Backups" - куда сохраняем бекап
set RDIR=[RemoteFolder] - каталог в гуглдрайве в GKFS
set CMD="c:\jobs\rclone\rclone.exe"

rem Все скрипты находятся в каталоге c:\jobs
rem Проверить путь к утилите, может отличаться в зависимости в от версии MSSQL
"c:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE" -U sa -P %PASS% -S %SQL% -i c:\jobs\backup_db.sql

d:
cd %BCKDIR%
::rem echo %YY%%MM%%DD%

"c:\Program Files\7-Zip\7z.exe" a %DB%_%YY%%MM%%DD%.7z *.bak -v512m -mx=0 -sdel
%CMD% delete GDrive:GKFS/%RDIR%/old
%CMD% move GDrive:GKFS/%RDIR%/upload GDrive:GKFS/%RDIR%/old
%CMD% mkdir GDrive:GKFS/%RDIR%/upload
%CMD% copy %BCKDIR%\ GDrive:GKFS/%RDIR%/upload --progress
%CMD% cleanup GDrive:

del /F *.7z.*

::rem pause
exit 0
