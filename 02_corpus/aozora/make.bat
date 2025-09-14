@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_AOZORA_TEXT_BASE=%HASUNE_BASE%\utility\corpus\make_aozora_text
set SELECT_FILES_PY=%MAKE_AOZORA_TEXT_BASE%\hasune.aozora.select_files.py
set EXTRACT_BODY_PY=%MAKE_AOZORA_TEXT_BASE%\hasune.aozora.extract_body.py
set MORPH_ANALYSIS_BASE=%HASUNE_BASE%\utility\corpus\morph_analysis
set ANALYZE_WITH_SUDACHI_PY=%MORPH_ANALYSIS_BASE%\hasune.morph_analyze_with_sudachi.py
set SUDACHI_POS_TO_HASUNE_PY=%MORPH_ANALYSIS_BASE%\hasune.sudachi_pos_to_hasune.py

set AOZORA_REPO=..\..\aozorabunko_text
set TAG_REMOVED_TXT=tag_removed.txt
set OLDEST_YEAR=1950
set SELECTED_DIR=selected
set PLAIN_TEXT_DIR=plain_text
set SUDACHI_ANALYZED_DIR=sudachi_analyzed
set HASUNE_POS_DIR=hasune_pos
set HASUNE_POS_LIST_TXT=..\..\01_dictionary_content_1\pos_list.txt

rem <1min
time /t
echo python %SELECT_FILES_PY% %AOZORA_REPO% %OLDEST_YEAR% %SELECTED_DIR%
python %SELECT_FILES_PY% %AOZORA_REPO% %OLDEST_YEAR% %SELECTED_DIR% || exit /b 1

rem <1min
time /t
echo python %EXTRACT_BODY_PY% %SELECTED_DIR% %PLAIN_TEXT_DIR%
python %EXTRACT_BODY_PY% %SELECTED_DIR% %PLAIN_TEXT_DIR% || exit /b 1

rem 1min
time /t
echo python %ANALYZE_WITH_SUDACHI_PY% ^
    %PLAIN_TEXT_DIR% ^
    %SUDACHI_ANALYZED_DIR%
python %ANALYZE_WITH_SUDACHI_PY% ^
    %PLAIN_TEXT_DIR% ^
    %SUDACHI_ANALYZED_DIR% ^
    || exit /b 1

rem <1min
time /t
echo python %SUDACHI_POS_TO_HASUNE_PY% ^
    %SUDACHI_ANALYZED_DIR% ^
    %HASUNE_POS_DIR% ^
    %HASUNE_POS_LIST_TXT%
python %SUDACHI_POS_TO_HASUNE_PY% ^
    %SUDACHI_ANALYZED_DIR% ^
    %HASUNE_POS_DIR% ^
    %HASUNE_POS_LIST_TXT% ^
    || exit /b 1

time /t
echo FINISHED!
exit /b 0
