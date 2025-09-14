@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_DICT_CONTENT_BASE=%HASUNE_BASE%\utility\dictionary\make_dict_content
set UNIDIC_TO_DICT_SRC_PY=%MAKE_DICT_CONTENT_BASE%\hasune.unidic_to_dict_src.py
set MAKE_DICT_CONTENT_PY=%MAKE_DICT_CONTENT_BASE%\hasune.make_dict_content.py
set MAKE_POS_LIST_PY=%MAKE_DICT_CONTENT_BASE%\hasune.make_pos_list.py

set UNIDIC_LEX_CSV=mini_lex.csv
set OTHER_LEX_CSV_BASE=%MAKE_DICT_CONTENT_BASE%\data
set DICT_SRC_DIR=dictionary_source
set DICT_CONTENT_NAME=main
set DICT_CONTENT_DIR=dictionary_content
set RECORD_LIST=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.record_list
set POS_LIST_TXT=pos_list.txt

rem 5min
rmdir /s /q %DICT_SRC_DIR%
mkdir %DICT_SRC_DIR%
python %UNIDIC_TO_DICT_SRC_PY% ^
    %UNIDIC_LEX_CSV% ^
    %OTHER_LEX_CSV_BASE%\auxverb.csv ^
    %OTHER_LEX_CSV_BASE%\particle.csv ^
    %OTHER_LEX_CSV_BASE%\punctuation.csv ^
    %DICT_SRC_DIR% || exit /b 1

rem 1min
rmdir /s /q %DICT_CONTENT_DIR%
mkdir %DICT_CONTENT_DIR%
python %MAKE_DICT_CONTENT_PY% ^
    %DICT_CONTENT_DIR% ^
    %DICT_CONTENT_NAME% ^
    %DICT_SRC_DIR%\unidic.expanded.lexicon ^
    %DICT_SRC_DIR%\auxverb.lexicon ^
    %DICT_SRC_DIR%\particle.lexicon ^
    %DICT_SRC_DIR%\punctuation.lexicon || exit /b 1

rem rem <1min
rem python %MAKE_POS_LIST_PY% %RECORD_LIST% %POS_LIST_TXT%
exit /b 0
