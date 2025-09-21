@echo off

setlocal
set HASUNE_BASE=C:\data\programs\hasune.rs
set COLLECT_PHRASES_BASE=%HASUNE_BASE%\utility\cooccurrence\collect_phrases
set COLLECT_PHRASES_PY=%COLLECT_PHRASES_BASE%\hasune.collect_phrases.py
set MERGE_PHRASES_PY=%COLLECT_PHRASES_BASE%\hasune.merge_phrases.py
set MERGE_PHRASES_PY=%COLLECT_PHRASES_BASE%\hasune.merge_phrases.py
set CALCULATE_NPMI_BASE=%HASUNE_BASE%\utility\cooccurrence\calculate_npmi
set CALCULATE_NPMI_PY=%CALCULATE_NPMI_BASE%\hasune.calculate_npmi.py
set COMPOUND_WORDS_BASE=%HASUNE_BASE%\utility\cooccurrence\compound_words
set EXTRACT_COMPOUND_WORDS_PY=%COMPOUND_WORDS_BASE%\hasune.extract_compound_words.py
set MERGE_COMPOUND_WORDS_PY=%COMPOUND_WORDS_BASE%\hasune.merge_compound_words.py

set WIKIPEDIA_MORPHEMES_DIR=..\02_corpus\wikipedia\hasune_pos
set WIKIPEDIA_PHRASES_DIR=wikipedia_phrases
set INTERMEDIATE_WIKIPEDIA_PHRASES_DIR=intermediate_merged_wikipedia_phrases
set MERGED_WIKIPEDIA_PHRASES_DIR=merged_wikipedia_phrases
set AOZORA_MORPHEMES_DIR=..\02_corpus\aozora\hasune_pos
set AOZORA_PHRASES_DIR=aozora_phrases
set INTERMEDIATE_AOZORA_PHRASES_DIR=intermediate_merged_aozora_phrases
set MERGED_AOZORA_PHRASES_DIR=merged_aozora_phrases
set WIKIPEDIA_WORD_FREQ_FILE=..\03_word_frequency_1\merged_wikipedia_frequencies\word.merged_frequencies
set WIKIPEDIA_NPMI_DIR=wikipedia_npmi
set AOZORA_WORD_FREQ_FILE=..\03_word_frequency_1\merged_aozora_frequencies\word.merged_frequencies
set AOZORA_NPMI_DIR=aozora_npmi
set SHORT_UNIT_LEXICON=..\01_dictionary_content_1\dictionary_source\unidic.expanded.lexicon
set WIKIPEDIA_COMPOUND_WORDS_DIR=wikipedia_compound_words
set AOZORA_COMPOUND_WORDS_DIR=aozora_compound_words
set MERGED_COMPOUND_WORDS_DIR=merged_compound_words

rem 19min
time /t
echo python %COLLECT_PHRASES_PY% ^
    %WIKIPEDIA_MORPHEMES_DIR% ^
    %WIKIPEDIA_PHRASES_DIR%
python %COLLECT_PHRASES_PY% ^
    %WIKIPEDIA_MORPHEMES_DIR% ^
    %WIKIPEDIA_PHRASES_DIR% ^
    || exit /b 1

rem 1min
time /t
echo python %COLLECT_PHRASES_PY% ^
    %AOZORA_MORPHEMES_DIR% ^
    %AOZORA_PHRASES_DIR%
python %COLLECT_PHRASES_PY% ^
    %AOZORA_MORPHEMES_DIR% ^
    %AOZORA_PHRASES_DIR% ^
    || exit /b 1

rem 7min
time /t
rmdir /s /q %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR%
mkdir %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR%
echo python %MERGE_PHRASES_PY% ^
    %WIKIPEDIA_PHRASES_DIR% ^
    phrase. ^
    %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR%
python %MERGE_PHRASES_PY% ^
    %WIKIPEDIA_PHRASES_DIR% ^
    phrase. ^
    %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR% ^
    || exit /b 1
rmdir /s /q %MERGED_WIKIPEDIA_PHRASES_DIR%
mkdir %MERGED_WIKIPEDIA_PHRASES_DIR%
echo python %MERGE_PHRASES_PY% ^
    %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR% ^
    phrase. ^
    %MERGED_WIKIPEDIA_PHRASES_DIR%
python %MERGE_PHRASES_PY% ^
    %INTERMEDIATE_WIKIPEDIA_PHRASES_DIR% ^
    phrase. ^
    %MERGED_WIKIPEDIA_PHRASES_DIR% ^
    || exit /b 1
rename ^
    %MERGED_WIKIPEDIA_PHRASES_DIR%\*.%INTERMEDIATE_WIKIPEDIA_PHRASES_DIR% ^
    *.merged_phrases

rem 1min
time /t
rmdir /s /q %INTERMEDIATE_AOZORA_PHRASES_DIR%
mkdir %INTERMEDIATE_AOZORA_PHRASES_DIR%
echo python %MERGE_PHRASES_PY% ^
    %AOZORA_PHRASES_DIR% ^
    phrase. ^
    %INTERMEDIATE_AOZORA_PHRASES_DIR%
python %MERGE_PHRASES_PY% ^
    %AOZORA_PHRASES_DIR% ^
    phrase. ^
    %INTERMEDIATE_AOZORA_PHRASES_DIR% ^
    || exit /b 1
rmdir /s /q %MERGED_AOZORA_PHRASES_DIR%
mkdir %MERGED_AOZORA_PHRASES_DIR%
echo python %MERGE_PHRASES_PY% ^
    %INTERMEDIATE_AOZORA_PHRASES_DIR% ^
    phrase. ^
    %MERGED_AOZORA_PHRASES_DIR%
python %MERGE_PHRASES_PY% ^
    %INTERMEDIATE_AOZORA_PHRASES_DIR% ^
    phrase. ^
    %MERGED_AOZORA_PHRASES_DIR% ^
    || exit /b 1
rename ^
    %MERGED_AOZORA_PHRASES_DIR%\*.%INTERMEDIATE_AOZORA_PHRASES_DIR% ^
    *.merged_phrases

rem 1min
time /t
rmdir /s /q %WIKIPEDIA_NPMI_DIR%
mkdir %WIKIPEDIA_NPMI_DIR%
echo python %CALCULATE_NPMI_PY% ^
    %WIKIPEDIA_WORD_FREQ_FILE% ^
    %MERGED_WIKIPEDIA_PHRASES_DIR%\phrase.merged_phrases ^
    %WIKIPEDIA_NPMI_DIR%\phrase.npmi
python %CALCULATE_NPMI_PY% ^
    %WIKIPEDIA_WORD_FREQ_FILE% ^
    %MERGED_WIKIPEDIA_PHRASES_DIR%\phrase.merged_phrases ^
    %WIKIPEDIA_NPMI_DIR%\phrase.npmi ^
    || exit /b 1

rem 1min
time /t
rmdir /s /q %AOZORA_NPMI_DIR%
mkdir %AOZORA_NPMI_DIR%
echo python %CALCULATE_NPMI_PY% ^
    %AOZORA_WORD_FREQ_FILE% ^
    %MERGED_AOZORA_PHRASES_DIR%\phrase.merged_phrases ^
    %AOZORA_NPMI_DIR%\phrase.npmi
python %CALCULATE_NPMI_PY% ^
    %AOZORA_WORD_FREQ_FILE% ^
    %MERGED_AOZORA_PHRASES_DIR%\phrase.merged_phrases ^
    %AOZORA_NPMI_DIR%\phrase.npmi ^
    || exit /b 1

rem <1min
time /t
rmdir /s /q %WIKIPEDIA_COMPOUND_WORDS_DIR%
mkdir %WIKIPEDIA_COMPOUND_WORDS_DIR%
echo python %EXTRACT_COMPOUND_WORDS_PY% ^
    %WIKIPEDIA_NPMI_DIR%\phrase.npmi ^
    %SHORT_UNIT_LEXICON% ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.frequencies ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\rest_phrase.npmi
python %EXTRACT_COMPOUND_WORDS_PY% ^
    %WIKIPEDIA_NPMI_DIR%\phrase.npmi ^
    %SHORT_UNIT_LEXICON% ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.frequencies ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\rest_phrase.npmi ^
    || exit /b 1

rem <1min
time /t
rmdir /s /q %AOZORA_COMPOUND_WORDS_DIR%
mkdir %AOZORA_COMPOUND_WORDS_DIR%
echo python %EXTRACT_COMPOUND_WORDS_PY% ^
    %AOZORA_NPMI_DIR%\phrase.npmi ^
    %SHORT_UNIT_LEXICON% ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.frequencies ^
    %AOZORA_COMPOUND_WORDS_DIR%\rest_phrase.npmi
python %EXTRACT_COMPOUND_WORDS_PY% ^
    %AOZORA_NPMI_DIR%\phrase.npmi ^
    %SHORT_UNIT_LEXICON% ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.frequencies ^
    %AOZORA_COMPOUND_WORDS_DIR%\rest_phrase.npmi ^
    || exit /b 1

rem <1min
time /t
rmdir /s /q %MERGED_COMPOUND_WORDS_DIR%
mkdir %MERGED_COMPOUND_WORDS_DIR%
echo python %MERGE_COMPOUND_WORDS_PY% ^
    %MERGED_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.lexicon
python %MERGE_COMPOUND_WORDS_PY% ^
    %MERGED_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %WIKIPEDIA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    %AOZORA_COMPOUND_WORDS_DIR%\compound_word.lexicon ^
    || exit /b 1

time /t
echo FINISHED!
exit /b 0
