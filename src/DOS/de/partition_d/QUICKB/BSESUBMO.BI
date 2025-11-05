'-----------------------------------------------------------------------------
'
'Module Name: BSESUBMO.BI
'
' OS/2 Subroutine Include File - Mouse Support
'
' Copyright (c) 1987,1988 Microsoft Corporation
'-----------------------------------------------------------------------------

TYPE MOUEVENTINFO
	fs	       AS INTEGER
	Time	       AS LONG
	row	       AS INTEGER
	col	       AS INTEGER
END TYPE

TYPE NOPTRRECT
	row	       AS INTEGER
	col	       AS INTEGER
	cRow	       AS INTEGER
	cCol	       AS INTEGER
END TYPE

TYPE PTRSHAPE
	cb	       AS INTEGER
	col	       AS INTEGER
	row	       AS INTEGER
	colHot	       AS INTEGER
	rowHot	       AS INTEGER
END TYPE

TYPE PTRLOC
	row	       AS INTEGER
	col	       AS INTEGER
END TYPE

TYPE MOUQUEINFO
	cEvents        AS INTEGER
	cmaxEvents     AS INTEGER
END TYPE

TYPE SCALEFACT
	rowScale       AS INTEGER
	colScale       AS INTEGER
END TYPE

'Key definitions for MouGetHotKey/MouSetHotKey

CONST	MHKBUTTON1	= &H0001
CONST	MHKBUTTON2	= &H0002
CONST	MHKBUTTON3	= &H0004


DECLARE FUNCTION MouRegister%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        BYVAL P2s AS INTEGER,_ 
        BYVAL P2o AS INTEGER,_
        BYVAL P3 AS LONG)

DECLARE FUNCTION MouDeRegister%( _
        )

DECLARE FUNCTION MouFlushQue%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION MouGetHotKey%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouSetHotKey%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetPtrPos%( _
	SEG   P1 AS PTRLOC,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouSetPtrPos%( _
	SEG   P1 AS PTRLOC,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetPtrShape%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
	SEG   P2 AS PTRSHAPE,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION MouSetPtrShape%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
	SEG   P2 AS PTRSHAPE,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION MouGetDevStatus%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetNumButtons%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetNumMickeys%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouReadEventQue%( _
	SEG   P1 AS MOUEVENTINFO,_
        SEG   P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION MouGetNumQueEl%( _
	SEG   P1 AS MOUQUEINFO,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetEventMask%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouSetEventMask%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouGetScaleFact%( _
	SEG   P1 AS SCALEFACT,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouSetScaleFact%( _
	SEG   P1 AS SCALEFACT,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouOpen%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION MouClose%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION MouRemovePtr%( _
	SEG   P1 AS NOPTRRECT,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouDrawPtr%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION MouSetDevStatus%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION MouInitReal%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER)

DECLARE FUNCTION MouSynch%( _
	BYVAL P1  AS INTEGER)
