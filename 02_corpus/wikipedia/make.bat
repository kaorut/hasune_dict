@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_WIKIPEDIA_TEXT_BASE=%HASUNE_BASE%\utility\corpus\make_wikipedia_text
set REMOVE_TAGS_PY=%MAKE_WIKIPEDIA_TEXT_BASE%\hasune.wikipedia.remove_tags.py
set SPLIT_TAG_REMOVED_PY=%MAKE_WIKIPEDIA_TEXT_BASE%\hasune.wikipedia.split_tag_removed.py
set REMOVE_DECORATIONS_PY=%MAKE_WIKIPEDIA_TEXT_BASE%\hasune.wikipedia.remove_decorations.py
set MORPH_ANALYSIS_BASE=%HASUNE_BASE%\utility\corpus\morph_analysis
set ANALYZE_WITH_SUDACHI_PY=%MORPH_ANALYSIS_BASE%\hasune.morph_analyze_with_sudachi.py
set SUDACHI_POS_TO_HASUNE_PY=%MORPH_ANALYSIS_BASE%\hasune.sudachi_pos_to_hasune.py

set WIKIPEDIA_XML=..\..\jawiki-20241101-pages-articles-multistream.xml
set TAG_REMOVED_TXT=tag_removed.txt
set TAG_REMOVED_DIR=tag_removed
set DECORATION_REMOVED_DIR=decoration_removed
set SUDACHI_ANALYZED_DIR=sudachi_analyzed
set HASUNE_POS_DIR=hasune_pos
set HASUNE_POS_LIST_TXT=..\..\01_dictionary_content_1\pos_list.txt

rem 20min
time /t
echo python %REMOVE_TAGS_PY% %WIKIPEDIA_XML% %TAG_REMOVED_TXT%
python %REMOVE_TAGS_PY% %WIKIPEDIA_XML% %TAG_REMOVED_TXT% || exit /b 1

rem 12min
time /t
echo python %SPLIT_TAG_REMOVED_PY% %TAG_REMOVED_TXT% %TAG_REMOVED_DIR%
python %SPLIT_TAG_REMOVED_PY% %TAG_REMOVED_TXT% %TAG_REMOVED_DIR% || exit /b 1

rem 4hours
time /t
echo python %REMOVE_DECORATIONS_PY% ^
    %TAG_REMOVED_DIR% ^
    %DECORATION_REMOVED_DIR%
python %REMOVE_DECORATIONS_PY% ^
    %TAG_REMOVED_DIR% ^
    %DECORATION_REMOVED_DIR% ^
    || exit /b 1

rem 4hours
time /t
echo python %ANALYZE_WITH_SUDACHI_PY% ^
    %DECORATION_REMOVED_DIR% ^
    %SUDACHI_ANALYZED_DIR%
python %ANALYZE_WITH_SUDACHI_PY% ^
    %DECORATION_REMOVED_DIR% ^
    %SUDACHI_ANALYZED_DIR% ^
    || exit /b 1

rem 22min
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
