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

DECLARE SUB mouse (mousex%, mousey%, mousek%)
DECLARE FUNCTION mousex% ()
DECLARE FUNCTION mousey% ()
DECLARE FUNCTION mousek% ()
DECLARE FUNCTION Dfree& (lw%)
DECLARE FUNCTION mktemp$ ()
DECLARE FUNCTION initprt% (prtnr%)
DECLARE FUNCTION IsInp% ()
DECLARE FUNCTION prtstat% (prtnr%)
DECLARE FUNCTION readasc% ()
DECLARE FUNCTION readscan% ()
DECLARE FUNCTION shiftstat% ()
DECLARE FUNCTION alert% (text$, default%, lin%, menue$, col%, revcol%)
DECLARE FUNCTION AT$ (x%, y%)
DECLARE FUNCTION balert% (ausr%, text$, default%, menue$, col%, revcol%)
DECLARE FUNCTION bin$ (value&)
DECLARE FUNCTION calculate# (funktion$, mel$)
DECLARE FUNCTION CorrectDate$ (datum$)
DECLARE SUB rmousem (xm%, ym%)
DECLARE FUNCTION cut$ (text$, pos1%, pos2%)
DECLARE FUNCTION DateToString$ (text$)
DECLARE FUNCTION dir$ (lw%)
DECLARE FUNCTION DMKonv$ (text$, laenge%)
DECLARE FUNCTION mousestat% (buttonmode%)
DECLARE FUNCTION ChDrive% (lw%)
DECLARE FUNCTION getdrive% ()
DECLARE FUNCTION exist% (datei$, att%)
DECLARE FUNCTION FileSelect$ (path$)
DECLARE FUNCTION finput$ (xpos%, ypos%, laenge%, text$, tpe%, back%, col%)
DECLARE FUNCTION FoldNotEmpty% (pfad$)
DECLARE FUNCTION Formstr$ (anz%, Wert&)
DECLARE FUNCTION FormText$ (x1%, y1%, x2%, y2%, maxy%, X3%, Y3%, Winy%, text$, c%, flag%, OrgCol%)
DECLARE SUB ScrollUp (x1%, y1%, x2%, y2%, az%, att%)
DECLARE SUB ScrollDown (x1%, y1%, x2%, y2%, az%, att%)
DECLARE FUNCTION formular% (form() AS ANY, text() AS STRING, col%)
DECLARE FUNCTION FSFirst$ (pfad$, attribute%)
DECLARE FUNCTION FSNext$ (attribute%)
DECLARE FUNCTION max% (val1%, val2%)
DECLARE FUNCTION min% (val1%, val2%)
DECLARE FUNCTION Perfmenu% (menuvar() AS ANY, mtext() AS STRING, htext() AS STRING, phty AS INTEGER, c1%, c2%)
DECLARE FUNCTION PointKonv$ (text$)
DECLARE FUNCTION range% (value%, ende%)
DECLARE FUNCTION round# (value#, nachstell%)
DECLARE FUNCTION StringToDate$ (text$)
DECLARE FUNCTION TotTime$ ()
DECLARE FUNCTION using$ (value#, vorstell%, nachstell%)

DECLARE SUB ClearForm (form() AS ANY)
DECLARE SUB ClearTextArray (text() AS STRING)
DECLARE SUB EraseMP (pfad$, joker$)
DECLARE SUB filename (hole$, path$, finame$, lw%)
DECLARE SUB FormOut (text$, breite%, lfnr%, ausr%)
DECLARE SUB pause (sekunden%)
DECLARE SUB SetDD (path$)
DECLARE SUB SetLine (x%, y%, col%, text$)
DECLARE SUB SetPal ()
DECLARE SUB ShowDates (form() AS formstruc, text() AS STRING)

'*** C-Routinen:

DECLARE FUNCTION InvInstr% CDECL (text1$, text2$)
DECLARE FUNCTION rinstr% CDECL (text$, char$)
DECLARE FUNCTION scantoasc% CDECL (scan%)
DECLARE FUNCTION ShiftGet$ (keybit%)
DECLARE SUB dframe (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)
DECLARE SUB frame (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)
DECLARE SUB getwinkoord CDECL (winnum%, x1%, y1%, x2%, y2%)
DECLARE SUB konvprinter CDECL (text$)
DECLARE SUB konvstring CDECL (text$)
DECLARE SUB konvtext CDECL (x1%, y1%, farbe%, text$)
DECLARE SUB makewin (BYVAL winnum%, BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL attribute%)
DECLARE SUB rebuild (BYVAL winnum%)
DECLARE SUB repout (BYVAL x1%, BYVAL y1%, BYVAL char%, BYVAL rep%, BYVAL attr%)
DECLARE SUB reskonvert ()
DECLARE SUB setkonvert (BYVAL v1%, BYVAL v2%)
DECLARE SUB Settext CDECL (x1%, y1%, farbe%, text$)
DECLARE SUB sframe (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%, BYVAL att%)

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

