@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_DICT=%HASUNE_BASE%\target\release\make_dict.exe

set DICT_CONTENT_NAME=main
set DICT_SETTINGS_TXT=dict_settings.txt
set OUTPUT_DICT=%DICT_CONTENT_NAME%.dict

rem 1min
time /t
echo %MAKE_DICT% ^
    %DICT_SETTINGS_TXT% ^
    %OUTPUT_DICT%
%MAKE_DICT% ^
    %DICT_SETTINGS_TXT% ^
    %OUTPUT_DICT% ^
    || exit /b 1

time /t
echo FINISHED!
exit /b 0
