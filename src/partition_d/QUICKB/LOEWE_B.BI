'*** Globale Definitionen fÅr Mylib.qlb ***

'*** Strukturdefinitionen fÅr Menues

TYPE menustructure
     xpos AS INTEGER
     ypos AS INTEGER
END TYPE

TYPE formstruc
     xpos AS INTEGER
     ypos AS INTEGER
     laenge AS INTEGER
     tpe AS INTEGER
END TYPE

'*** BASIC-Routinen:

DECLARE FUNCTION calculate# (funktion$, mel$)
DECLARE FUNCTION dir$ (lw%)
DECLARE SUB filename (hole$, path$, finame$, lw%)
DECLARE SUB SetDD (path$)
DECLARE FUNCTION FileSelect$ (path$)
DECLARE FUNCTION range% (value%, ende%)
DECLARE FUNCTION AT$ (x%, y%)
DECLARE FUNCTION bin$ (value&)
DECLARE FUNCTION mktemp$ (muster$)
DECLARE FUNCTION cut$ (text$, pos1%, pos2%)
DECLARE SUB pause (sekunden%)
DECLARE SUB ShowDates (form() AS formstruc, text() AS STRING)
DECLARE FUNCTION StringToDate$ (text$)
DECLARE FUNCTION Perfmenu% (menuvar() AS ANY, mtext() AS STRING, htext() AS STRING, phty AS INTEGER, c1%, c2%)
DECLARE FUNCTION DateToString$ (text$)
DECLARE FUNCTION CorrectDate$ (datum$)
DECLARE SUB ClearTextArray (text() AS STRING)
DECLARE FUNCTION formular% (form() AS ANY, text() AS STRING, col%)
DECLARE FUNCTION round# (value#, nachstell%)
DECLARE FUNCTION dninput$ (xpos%, ypos%, text$, flag%, col%)
DECLARE FUNCTION DMKonv$ (text$, laenge%)
DECLARE FUNCTION balert% (Ausr%, text$, default%, menue$, col%, revcol%)
DECLARE FUNCTION InvInstr% (text$, char$)
DECLARE FUNCTION InvRinstr% (text$, char$)
DECLARE FUNCTION ZerKill$ (text$)
DECLARE FUNCTION using$ (value#, vorstell%, nachstell%)
DECLARE SUB ClrScr ()
DECLARE SUB SetPal ()
DECLARE FUNCTION exist% (datei$, att%)
DECLARE FUNCTION min% (val1%, val2%)
DECLARE FUNCTION max% (val1%, val2%)
DECLARE FUNCTION PointKonv$ (text$)
DECLARE SUB SetLine (x%, y%, col%, text$)
DECLARE FUNCTION GetLFname$ (path$)
DECLARE FUNCTION alert% (text$, default%, lin%, menue$, col%, revcol%)
DECLARE FUNCTION finput$ (xpos%, ypos%, laenge%, text$, tpe%, back%, col%)
DECLARE FUNCTION Formstr$ (anz%, Wert&)
DECLARE FUNCTION TotTime$ ()
DECLARE FUNCTION FSFirst$ (pfad$, attribute%)
DECLARE FUNCTION FSNext$ (attribute%)
DECLARE SUB EraseMP (pfad$, joker$)
DECLARE FUNCTION FoldNotEmpty% (pfad$)
DECLARE FUNCTION FormText$ (x1%, y1%, x2%, y2%, maxy%, X3%, Y3%, Winy%, text$, c%, flag%, OrgCol%)

'*** C-Routinen:

DECLARE FUNCTION scantoasc% CDECL (scan%)
DECLARE FUNCTION mousestat% CDECL (mb%)
DECLARE SUB showm
DECLARE SUB hidem
DECLARE SUB mouse CDECL (x%, y%, k%)
DECLARE SUB setmouse (x%, y%)
DECLARE SUB gbuttonps (status%, button%, x%, y%)
DECLARE SUB gbuttonrs (status%, button%, x%, y%)
DECLARE SUB mousexr (minx%, maxx%)
DECLARE SUB mouseyr (miny%, maxy%)
DECLARE SUB gmouseform (hotx%, hoty%, pointer%)
DECLARE SUB tmouseform (cursor%, val1%, val2%)
DECLARE FUNCTION cdir% CDECL (temp$)
DECLARE SUB cmaketemp CDECL (text$)
DECLARE SUB ctottime CDECL (text$)
DECLARE FUNCTION ShiftGet$ (keybit%)
DECLARE FUNCTION cfsfirst% CDECL (pfad$, dnback$, attribute%)
DECLARE FUNCTION cfsnext% CDECL (dnback$, attribute%)
DECLARE SUB repout (BYVAL x1%, BYVAL y1%, BYVAL char%, BYVAL rep%, BYVAL attr%)
DECLARE SUB dframe (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)
DECLARE SUB frame (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)
DECLARE SUB sframe (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)
DECLARE SUB makewin (BYVAL winnum%, BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL attribute%)
DECLARE SUB getwinkoord CDECL (winnum%, x1%, y1%, x2%, y2%)
DECLARE SUB ScrollUp (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL anzz%, BYVAL attribut%)
DECLARE SUB ScrollDown (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL anzz%, BYVAL attribut%)
DECLARE SUB rebuild (BYVAL winnum%)
DECLARE SUB Settext CDECL (x1%, y1%, farbe%, text$)
DECLARE SUB reskonvert ()
DECLARE SUB konvtext CDECL (x1%, y1%, farbe%, text$)
DECLARE SUB konvprinter CDECL (text$)
DECLARE SUB setkonvert (BYVAL v1%, BYVAL v2%)
DECLARE FUNCTION cexist% CDECL (text$, attribute%)
DECLARE FUNCTION rinstr% CDECL (text$, char$)
DECLARE FUNCTION readasc% ()
DECLARE FUNCTION readscan% ()
DECLARE FUNCTION isinp% ()
DECLARE FUNCTION shiftstat& ()
DECLARE FUNCTION prtstat% (BYVAL prtnr%)
DECLARE SUB initprt (BYVAL prtnr%)
DECLARE SUB boot
DECLARE FUNCTION chdrive% (BYVAL drivenr%)
DECLARE SUB gettemp CDECL (text$)
DECLARE SUB konvstring CDECL (text$)
DECLARE FUNCTION dfree& (BYVAL drivenr%)
DECLARE FUNCTION getdrive% ()


'*** Tastaturdefinitionen

CONST kcurup = 72, kcurdown = 80, kcurleft = 75, kcurright = 77
CONST f1 = 59, f2 = 60, f3 = 61, f4 = 62, f5 = 63, f6 = 64, f7 = 65, f8 = 66, f9 = 67, f10 = 68
CONST kdelete = 83, kinsert = 82
CONST ret = 13, backspace = 8
CONST pgup = 73, pgdown = 81
CONST escape = 27
CONST pos1 = 71, ende = 79

'*** Typenbelegungen fÅr Finput

CONST TextType = 0                 'Einfache Texteingabe
CONST NumType = 1                  'numerische Eingabe mit 0 Formatierung
CONST DateType = 2                 'Datumseingabe
CONST DMType = 3                   'DM Eingabe --> LONG, 2 Nachkommastellen
CONST FloatType = 4                'DM Eingabe --> FLOAT, bel. Anz. NKS
CONST FileType = 5                 'Dateinamen kînnen eingegeben werden.
CONST FileTypeExt = 6              'Dateinamen + Extension kînnen eingegeben werden
CONST FileExt = 7                  'Nur Extension kînnen eingegeben werden

'*** Konstanten fÅr Monochromausgabe

CONST UNDERLINED = &H1                  'Unterstreichen
CONST NORMAL = &H7                      'Normale Anzeige
CONST LIGHTUNDERLINED = &H9             'Hell und unterstrichen
CONST LIGHT = &HF                       'Helle Anzeige
CONST INVERS = &H70                     'Inveriterte Anzeige
CONST FLASH = &H80                      'Blinkende Anzeige, Werte werden "geored"

'*** Konstaten fÅr Abfrage der Statustasten der Tastatur

CONST RSHIFT = 1
CONST LSHIFT = 2
CONST CTRL = 4
CONST ALTERNATE = 8
CONST SCROLLOCK = 16
CONST NUMLOCK = 32
CONST SHIFTLOCK = 64
CONST INSERTLOCK = 128

'*** Bool'sche Konstaten

CONST FALSE = 0
CONST TRUE = -1

