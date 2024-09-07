'-----------------------------------------------------------------------------
'
'Module Name: BSEDOSPC.BI
'
'  OS/2 Base Include File - Process Control and Interprocess Communication
'
'  The Process Control and Interprocess Communication calls have been
'  organized into the following catagories:
'
'       Process Control
'       Semaphores
'       Signals
'       Pipes and Queues
'       Error Handling and Messages
'       Session Manager
'
' Copyright (c) 1987,1988 Microsoft Corporation
'-----------------------------------------------------------------------------

TYPE ADDRESS
        Offset     AS INTEGER
        Segment    AS INTEGER
END TYPE

TYPE RESULTCODES
	codeTerminate  AS INTEGER
	codeResult     AS INTEGER
END TYPE


TYPE STARTDATA
	cb	       AS INTEGER
	Related        AS INTEGER
	FgBg           AS INTEGER
	TraceOpt       AS INTEGER
	PgmTitle       AS ADDRESS 'Address of STRING
	PgmName        AS ADDRESS 'Address of STRING
	PgmInputs      AS ADDRESS 'Address of STRING
	TermQ          AS ADDRESS 'Address of STRING
END TYPE

TYPE STATUSDATA
	cb	       AS INTEGER
	SelectInd      AS INTEGER
	BindInd        AS INTEGER
END TYPE

TYPE PIDINFO
	pid	       AS INTEGER
	tid	       AS INTEGER
	pidParent      AS INTEGER
END TYPE

' codeTerminate values for RESULTCODES type

CONST TCEXIT		 = 0
CONST TCHARDERROR	 = 1
CONST TCTRAP		 = 2
CONST TCKILLPROCESS	 = 3

' Action Code Values for DosCWait

CONST DCWAPROCESS	 = 0
CONST DCWAPROCESSTREE	 = 1

' Wait option values for DosCWait

CONST DCWWWAIT		 = 0
CONST DCWWNOWAIT	 = 1

' DosExecPgm functions

CONST EXECSYNC		 = 0
CONST EXECASYNC 	 = 1
CONST EXECASYNCRESULT	 = 2
CONST EXECTRACE 	 = 3
CONST EXECBACKGROUND	 = 4
CONST EXECLOAD		 = 5

' Priority scopes for DosGetPtry/DosSetPtry

CONST	PRTYSPROCESS	 = 0
CONST	PRTYSPROCESSTREE = 1
CONST	PRTYSTHREAD	 = 2

' Priority classes for DosGetPtry/DosSetPtry

CONST	PRTYCNOCHANGE	 = 0
CONST	PRTYCIDLETIME	 = 1
CONST	PRTYCREGULAR	 = 2
CONST	PRTYCTIMECRITICAL= 3

' Process scopes for DosKillProcess

CONST	DKPPROCESS	 = 0
CONST	DKPROCESSTREE	 = 1

'Semaphore Types for DosCreateSem

CONST	CSEMPRIVATE	 = 0
CONST	CSEMPUBLIC	 = 1

'DosHoldSignal constants

CONST	HLDSIGENABLE	 = 0
CONST	HLDSIGDISABLE	 = 1

'Flag numbers for DosFlagProcess

CONST	PFLGA		 = 0   'Process Flag A
CONST	PFLGB		 = 1   'Process Flag B
CONST	PFLGC		 = 2   'Process Flag C

'DosFlagProcess codes

CONST	FLGPSUBTREE	 = 0
CONST	FLGPPID 	 = 1

'Signal actions

CONST	SIGAKILL	 = 0
CONST	SIGAIGNORE	 = 1
CONST	SIGAACCEPT	 = 2
CONST	SIGAERROR	 = 3
CONST	SIGAACKNOWLEDGE  = 4


'
'Process Control
'

DECLARE FUNCTION DosBeep%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE SUB DosExit( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

DECLARE FUNCTION DosCWait%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
	SEG   P3 AS RESULTCODES,_
        SEG   P4 AS INTEGER,_
        BYVAL P5 AS INTEGER)

DECLARE FUNCTION DosSleep%( _
        BYVAL P1 AS LONG)

DECLARE SUB DosEnterCritSec()

DECLARE SUB DosExitCritSec()


DECLARE FUNCTION DosExecPgm%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER,_
        BYVAL P4s AS INTEGER,_ 
        BYVAL P4o AS INTEGER,_
        BYVAL P5s AS INTEGER,_ 
        BYVAL P5o AS INTEGER,_
	SEG   P6 AS RESULTCODES,_
        BYVAL P7s AS INTEGER,_ 
        BYVAL P7o AS INTEGER)

DECLARE FUNCTION DosGetPid%( _
	SEG   P1 AS PIDINFO)

DECLARE FUNCTION DosGetPrty%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosSetPrty%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER,_
        BYVAL P4 AS INTEGER)

DECLARE FUNCTION DosKillProcess%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

'
' Semaphores
'

DECLARE FUNCTION DosSemClear%( _
        BYVAL P1 AS LONG)

DECLARE FUNCTION DosSemRequest%( _
        BYVAL P1 AS LONG,_
        BYVAL P2 AS LONG)

DECLARE FUNCTION DosSemSet%( _
        BYVAL P1 AS LONG)

DECLARE FUNCTION DosSemSetWait%( _
        BYVAL P1 AS LONG,_
        BYVAL P2 AS LONG)

DECLARE FUNCTION DosSemWait%( _
        BYVAL P1 AS LONG,_
        BYVAL P2 AS LONG)

DECLARE FUNCTION DosCreateSem%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS LONG,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosOpenSem%( _
        SEG   P1 AS LONG,_
        BYVAL P2s AS INTEGER,_ 
        BYVAL P2o AS INTEGER)

DECLARE FUNCTION DosCloseSem%( _
        BYVAL P1 AS LONG)

DECLARE FUNCTION DosMuxSemWait%( _
        SEG   P1 AS INTEGER,_
	BYVAL P2s AS INTEGER,_
	BYVAL P2o AS INTEGER,_
        BYVAL P3 AS LONG)

'
' Signals
'

DECLARE FUNCTION DosHoldSignal%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosFlagProcess%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER,_
        BYVAL P4 AS INTEGER)

DECLARE FUNCTION DosSendSignal%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER)

'
' Pipes and Queues
'

DECLARE FUNCTION DosMakePipe%( _
        SEG   P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        BYVAL P3 AS INTEGER)

DECLARE FUNCTION DosCloseQueue%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosCreateQueue%( _
        SEG   P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosOpenQueue%( _
        SEG   P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosPeekQueue%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS LONG,_
        SEG   P3 AS INTEGER,_
        SEG   P4 AS LONG,_
        SEG   P5 AS INTEGER,_
        BYVAL P6 AS INTEGER,_
        BYVAL P7s AS INTEGER,_ 
        BYVAL P7o AS INTEGER,_
        BYVAL P8 AS LONG)

DECLARE FUNCTION DosPurgeQueue%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosQueryQueue%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION DosReadQueue%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS LONG,_
        SEG   P3 AS INTEGER,_
        SEG   P4 AS LONG,_
        BYVAL P5 AS INTEGER,_
        BYVAL P6 AS INTEGER,_
        BYVAL P7s AS INTEGER,_ 
        BYVAL P7o AS INTEGER,_
        BYVAL P8 AS LONG)

DECLARE FUNCTION DosWriteQueue%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS INTEGER,_
        BYVAL P4s AS INTEGER,_ 
        BYVAL P4o AS INTEGER,_
        BYVAL P5 AS INTEGER)

'
' Error Handling and Messages
'

DECLARE FUNCTION DosError%( _
        BYVAL P1 AS INTEGER)

DECLARE FUNCTION DosGetMessage%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER,_
        BYVAL P4 AS INTEGER,_
        BYVAL P5 AS INTEGER,_
        BYVAL P6s AS INTEGER,_ 
        BYVAL P6o AS INTEGER,_
        SEG   P7 AS INTEGER)

DECLARE FUNCTION DosErrClass%( _
        BYVAL P1 AS INTEGER,_
        SEG   P2 AS INTEGER,_
        SEG   P3 AS INTEGER,_
        SEG   P4 AS INTEGER)

DECLARE FUNCTION DosInsMessage%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER,_
        BYVAL P4 AS INTEGER,_
        BYVAL P5s AS INTEGER,_ 
        BYVAL P5o AS INTEGER,_
        BYVAL P6 AS INTEGER,_
        SEG   P7 AS INTEGER)

DECLARE FUNCTION DosPutMessage%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER)

DECLARE FUNCTION DosGetEnv%( _
        SEG   P1 AS INTEGER,_
        SEG   P2 AS INTEGER)

DECLARE FUNCTION DosScanEnv%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER,_
	SEG   P2  AS ADDRESS)

DECLARE FUNCTION DosSearchPath%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2s AS INTEGER,_ 
        BYVAL P2o AS INTEGER,_
        BYVAL P3s AS INTEGER,_ 
        BYVAL P3o AS INTEGER,_
        BYVAL P4s AS INTEGER,_ 
        BYVAL P4o AS INTEGER,_
        BYVAL P5 AS INTEGER)

DECLARE FUNCTION DosGetVersion%( _
        SEG   P1 AS INTEGER)

DECLARE FUNCTION DosGetMachineMode%( _
        BYVAL P1s AS INTEGER,_ 
        BYVAL P1o AS INTEGER)

'
' Session Manager
'

DECLARE FUNCTION DosStartSession%( _
	SEG   P1 AS STARTDATA,_
        SEG   P2 AS INTEGER,_
        SEG   P3 AS INTEGER)

DECLARE FUNCTION DosSetSession%( _
        BYVAL P1 AS INTEGER,_
	SEG   P2 AS STATUSDATA)

DECLARE FUNCTION DosSelectSession%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS LONG)

DECLARE FUNCTION DosStopSession%( _
        BYVAL P1 AS INTEGER,_
        BYVAL P2 AS INTEGER,_
        BYVAL P3 AS LONG)
