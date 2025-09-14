@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set MAKE_DICT_CONTENT_BASE=%HASUNE_BASE%\utility\dictionary\make_dict_content
set ASSIGN_UNIGRAM_COSTS_PY=%MAKE_DICT_CONTENT_BASE%\hasune.assign_unigram_costs.py
set ASSIGN_BIGRAM_COSTS_PY=%MAKE_DICT_CONTENT_BASE%\hasune.assign_bigram_costs.py
set MAKE_DICT=%HASUNE_BASE%\target\release\make_dict.exe

set UNIDIC_LEX_CSV=unidic-cwj-202302_full\lex.csv
set DICT_CONTENT_NAME=main
set DICT_CONTENT_DIR=dictionary_content
set WORD_UNICOST_LIST_COST_UNASSIGNED=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.word_unicost_list
set WORD_UNIGRAM_LIST_COST_ASSIGNED=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.word_unicost_list.cost_assigned
set POS_BIGRAM_LIST_COST_UNASSIGNED=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.pos_bicost_list
set POS_BIGRAM_LIST_COST_ASSIGNED=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.pos_bicost_list.cost_assigned
set RECORD_LIST=%DICT_CONTENT_DIR%\%DICT_CONTENT_NAME%.record_list
set WORD_FREQUENCY_BASE=..\word_frequency\amplified_frequencies
set WORD_FREQUENCIES=%WORD_FREQUENCY_BASE%\word.merged_frequencies
set POS_UNIGRAM_FREQUENCIES=%WORD_FREQUENCY_BASE%\pos_uni.merged_frequencies
set POS_BIGRAM_FREQUENCIES=%WORD_FREQUENCY_BASE%\pos_bi.merged_frequencies
set DICT_SETTINGS_TXT=dict_settings.txt
set OUTPUT_DICT=%DICT_CONTENT_NAME%.dict

rem rem 100min
rem python %ASSIGN_UNIGRAM_COSTS_PY% ^
rem     %WORD_UNICOST_LIST_COST_UNASSIGNED% ^
rem     %RECORD_LIST% ^
rem     %WORD_FREQUENCIES% ^
rem     %POS_UNIGRAM_FREQUENCIES% ^
rem     %WORD_UNIGRAM_LIST_COST_ASSIGNED%

rem rem <1min
rem python %ASSIGN_BIGRAM_COSTS_PY% ^
rem     %POS_BIGRAM_LIST_COST_UNASSIGNED% ^
rem     %POS_BIGRAM_FREQUENCIES% ^
rem     %POS_BIGRAM_LIST_COST_ASSIGNED%

rem 1min
%MAKE_DICT% ^
    %DICT_SETTINGS_TXT% ^
    %OUTPUT_DICT%
exit /b 0
