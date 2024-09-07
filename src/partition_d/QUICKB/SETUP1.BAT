REM Set path for LIBBUILD program
PATH D:\QUICKB
REM Make the Library directory the default directory
D:
CD \LIB
REM Run BUILDRTM
BUILDRTM /DEFAULT /LR /FPI 
REM Restore Original Path
PATH D:\QUICKC;C:\PM;D:\WORD;D:\QUICKB;C:\NORTON
