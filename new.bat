@echo off
set FILENAME_INPUT_STR=
set /P FILENAME_INPUT_STR="Choose a file name : "
hugo new blog/2020/%FILENAME_INPUT_STR%.md