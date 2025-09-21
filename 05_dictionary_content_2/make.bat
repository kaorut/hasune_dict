@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_DICT_CONTENT_BASE=%HASUNE_BASE%\utility\dictionary\make_dict_content
set MAKE_DICT_CONTENT_PY=%MAKE_DICT_CONTENT_BASE%\hasune.make_dict_content.py

set UNIDIC_LEX_CSV=..\unidic-cwj-202302_full\lex.csv
set OTHER_LEX_CSV_BASE=%MAKE_DICT_CONTENT_BASE%\data
set DICT_SRC_DIR=..\01_dictionary_content_1\dictionary_source
set COMPOUND_WORD_COMPOUND_DICT_SRC_DIR=..\04_cooccurrence\merged_compound_words
set DICT_CONTENT_NAME=main
set DICT_CONTENT_DIR=dictionary_content

rem 1min
time /t
rmdir /s /q %DICT_CONTENT_DIR%
mkdir %DICT_CONTENT_DIR%
echo python %MAKE_DICT_CONTENT_PY% ^
    %DICT_CONTENT_DIR% ^
    %DICT_CONTENT_NAME% ^
    %DICT_SRC_DIR%\unidic.expanded.lexicon ^
    %COMPOUND_WORD_COMPOUND_DICT_SRC_DIR%\compound_word.expanded.lexicon ^
    %DICT_SRC_DIR%\auxverb.lexicon ^
    %DICT_SRC_DIR%\particle.lexicon ^
    %DICT_SRC_DIR%\punctuation.lexicon
python %MAKE_DICT_CONTENT_PY% ^
    %DICT_CONTENT_DIR% ^
    %DICT_CONTENT_NAME% ^
    %DICT_SRC_DIR%\unidic.expanded.lexicon ^
    %COMPOUND_WORD_COMPOUND_DICT_SRC_DIR%\compound_word.expanded.lexicon ^
    %DICT_SRC_DIR%\auxverb.lexicon ^
    %DICT_SRC_DIR%\particle.lexicon ^
    %DICT_SRC_DIR%\punctuation.lexicon || exit /b 1

time /t
echo FINISHED!
exit /b 0
