@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set COOCCURRENCES_BASE=%HASUNE_BASE%\utility\cooccurrence\cooccurrences
set EXTRACT_COOCCURRENCES_PY=%COOCCURRENCES_BASE%\hasune.extract_cooccurrences.py

set WIKIPEDIA_NPMI=..\04_cooccurrence\wikipedia_npmi\phrase.npmi
set AOZORA_NPMI=..\04_cooccurrence\aozora_npmi\phrase.npmi
set SHORT_UNIT_RECORD_LIST=..\05_dictionary_content_2\dictionary_content\main.record_list
set COOCCURRENCE_DIR=cooccurrences

rem 1min
time /t
rmdir /s /q %COOCCURRENCE_DIR%
mkdir %COOCCURRENCE_DIR%
echo python %EXTRACT_COOCCURRENCES_PY% ^
    %WIKIPEDIA_NPMI% ^
    %SHORT_UNIT_RECORD_LIST% ^
    %COOCCURRENCE_DIR%\wikipedia.cooccurrence
python %EXTRACT_COOCCURRENCES_PY% ^
    %WIKIPEDIA_NPMI% ^
    %SHORT_UNIT_RECORD_LIST% ^
    %COOCCURRENCE_DIR%\wikipedia.cooccurrence ^
    || exit /b 1
echo python %EXTRACT_COOCCURRENCES_PY% ^
    %AOZORA_NPMI% ^
    %SHORT_UNIT_RECORD_LIST% ^
    %COOCCURRENCE_DIR%\aozora.cooccurrence
python %EXTRACT_COOCCURRENCES_PY% ^
    %AOZORA_NPMI% ^
    %SHORT_UNIT_RECORD_LIST% ^
    %COOCCURRENCE_DIR%\aozora.cooccurrence ^
    || exit /b 1

time /t
echo FINISHED!
exit /b 0
