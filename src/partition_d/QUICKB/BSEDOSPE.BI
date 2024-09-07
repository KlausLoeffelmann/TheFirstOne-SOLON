'-----------------------------------------------------------------------------
'
'Module Name: BSEDOSPE.BI
'
'  OS/2 Base Include File - Program Execution Support
'
'  The Program Execution Support calls have been organized into the
'  following catagories:
'
'       National Language Support
'       Resource Management
'       Module Management
'       DateTime and Timer Support
'       Memory Management
'       Information Segments
'
' Copyright (c) 1987,1988 Microsoft Corporation
'-----------------------------------------------------------------------------

TYPE COUNTRYCODE
	country        AS INTEGER
	codepage       AS INTEGER
END TYPE

TYPE COUNTRYINFO
	country        AS INTEGER
	codepage       AS INTEGER
	fsDateFmt      AS INTEGER
	szCurrency     AS STRING * 5
	szThousandsSeperator AS STRING * 2
	szDecimal      AS STRING * 2
	szDateSeperator AS STRING * 2
	szTimeSeperator AS STRING * 2
	fsCurrencyFmt  AS STRING * 1
	cDecimalPlace  AS STRING * 1
	fsTimeFmt      AS STRING * 1
	abReserved1    AS STRING * 4
	szDataSeperator AS STRING * 2
	abReserved2    AS STRING * 10
END TYPE

TYPE DATETIME
	hour	       AS STRING * 1
	minutes        AS STRING * 1
	seconds        AS STRING * 1
	hundredths     AS STRING * 1
	day	       AS STRING * 1
	month	       AS STRING * 1
	year	       AS INTEGER
	timezone       AS INTEGER
	weekday        AS STRING * 1
END TYPE

'Predefined resource types for DosGetResource

CONST	RTPOINTER	=  1 'mouse pointer shape
CONST	RTBITMAP	=  2 'bitmap
CONST	RTMENU		=  3 'menu template
CONST	RTDIALOG	=  4 'dialog template
CONST	RTSTRING	=  5 'string tables
CONST	RTFONTDIR	=  6 'font directory
CONST	RTFONT		=  7 'font
CONST	RTACCELTABLE	=  8 'accelerator tables
CONST	RTRCDATA	=  9 'binary data
CONST	RTMESSAGE	= 10 'error msg tables
CONST	RTDLGINCLUDE	= 11 'dialog include file name
CONST	RTVKEYTBL	= 12 'key to vkey tables
CONST	RTKEYTBL	= 13 'key to UGL tables
CONST	RTCHARTBL	= 14 'glyph to character tables

' Segment attribute flags (used with DosAllocSeg)

CONST	SEGGIVEABLE	= &H0001
CONST	SEGGETTABLE	= &H0002
CONST	SEGDISCARDABLE	= &H0004

' Process type codes (local infor set typeProcess field)

CONST	PTFULLSCREEN	 = 0
CONST	PTREALMODE	 = 1
CONST	PTWINDOWABLEVIO  = 2
CONST	PTPM		 = 3
CONST	PTDETACHED	 = 4

'
' National Language Support
'

DECLARE FUNCTION DosGetCtryInfo%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS COUNTRYCODE,_
	SEG   P3 AS COUNTRYINFO,_
        SEG   P4 AS INTEGER)

DECLARE FUNCTION DosGetDBCSEv%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS COUNTRYCODE,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosCaseMap%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS COUNTRYCODE,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosGetCollate%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS COUNTRYCODE,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER,_
        SEG   P4 AS INTEGER)

DECLARE FUNCTION DosGetCp%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS INTEGER,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosSetCp%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

'
' Resource Management
'

DECLARE FUNCTION DosGetResource%( _
	BYVAL P1 AS INTEGER,_
	BYVAL P2 AS INTEGER,_
	BYVAL P3 AS INTEGER,_
	SEG   P4 AS INTEGER)

'
' Module Management Routines
'

DECLARE FUNCTION DosLoadModule%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER,_
        SEG   P4 AS INTEGER)

DECLARE FUNCTION DosFreeModule%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosGetProcAddr%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2s AS INTEGER,_ 
        BYVAL P2o AS INTEGER,_
        SEG   P3 AS LONG)

DECLARE FUNCTION DosGetModHandle%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION DosGetModName%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

'
' DateTime and Timer Support
'
DECLARE FUNCTION DosTimerAsync%( _
        BYVAL P1 AS LONG,_
        BYVAL P2 AS LONG,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosTimerStart%( _
        BYVAL P1 AS LONG,_
        BYVAL P2 AS LONG,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosTimerStop%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosGetDateTime%( _
	SEG   P1 AS DATETIME)

DECLARE FUNCTION DosSetDateTime%( _
	SEG   P1 AS DATETIME)

'
'Memory Management
'

DECLARE FUNCTION DosAllocSeg%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosAllocShrSeg%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2s AS INTEGER,_ 
        BYVAL P2o AS INTEGER,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosGetShrSeg%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION DosGiveSeg%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosGetSeg%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosLockSeg%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosUnlockSeg%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosMemAvail%( _
        SEG   P1 AS LONG)

DECLARE FUNCTION DosReallocSeg%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION DosFreeSeg%( _
        BYVAL P1 AS INTEGER)


DECLARE FUNCTION DosAllocHuge%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        SEG   P3 AS INTEGER,_
        BYVAL P4 AS INTEGER,_
        BYVAL P5 AS INTEGER)

DECLARE FUNCTION DosGetHugeShift%( _
        SEG   P1 AS INTEGER)

DECLARE FUNCTION DosReallocHuge%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosCreateCSAlias%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION DosSubAlloc%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosSubFree%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosSubSet%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

'
'Information Segments
'

DECLARE FUNCTION DosGetInfoSeg%( _
        SEG   P1 AS INTEGER,_
        SEG   P2 AS INTEGER)
