echo off
cls
echo ARES-Quell-Dateien werden als Sicherungs-Kopie
echo abgestellt. Bitte warten...
echo ----------------------------------------------

c:\system\format a:
mkdir a:\quickb
copy d:\mylib.c a:\
copy d:\*.bat a:\
copy d:\quickb\*.bas a:\quickb
copy d:\quickb\*.bi a:\quickb
echo Sirechungskopie wurde erstellt
echo on

