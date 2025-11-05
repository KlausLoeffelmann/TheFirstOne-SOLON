'$INCLUDE: 'd:\quickb\loewe_b.bi'
'$INCLUDE: 'd:\quickb\loewepd.bi'

DECLARE SUB GenQl ()
DECLARE SUB ClearScreen ()
DECLARE SUB Info ()

DIM SHARED fp%, pd%, tv%

DATA DESK,d,Information,i,----,-,"Programm beenden ",p,#,""
DATA QUICK-LIB,q,Textverarbeitung,t,Formelparser,f,Pull-Down-Menues,p,----,-,Quick-Lib generieren,q,##,""

CLS
DIM pd$(24)

FOR z% = 1 TO 24
     READ pd$(z%)
NEXT z%

Menu pd$()

DO
     a% = OnMenue%(titel%, entry%)

     IF a% THEN
          SELECT CASE MenuT$(titel%, entry%)

          CASE "Information"
               Info
         
          CASE "Programm beenden "
               EXIT DO
         
          CASE "Textverarbeitung"
               IF tv% = TRUE THEN
                    tv% = FALSE
                    MenuICheck titel%, entry%, FALSE
               ELSE
                    tv% = TRUE
                    MenuICheck titel%, entry%, TRUE
               END IF

          CASE "Formelparser"
               IF fp% = TRUE THEN
                    fp% = FALSE
                    MenuICheck titel%, entry%, FALSE
               ELSE
                    fp% = TRUE
                    MenuICheck titel%, entry%, TRUE
               END IF
         
          CASE "Pull-Down-Menues"
               IF pd% = TRUE THEN
                    pd% = FALSE
                    MenuICheck titel%, entry%, FALSE
               ELSE
                    pd% = TRUE
                    MenuICheck titel%, entry%, TRUE
               END IF
               
          CASE "Quick-Lib generieren"
               GenQl
               RUN

          CASE ELSE

          END SELECT
     END IF
LOOP
CLS

SUB ClearScreen
     FOR z% = 2 TO 24
          PRINT AT$(1, z%); SPACE$(80);
     NEXT z%
END SUB

SUB GenQl

     Settext 10, 10, LIGHT, "Loewe-Tools werden nun installiert."
     Settext 10, 11, LIGHT, "Wie in der Dokumentation beschrieben, mÅssen jedoch zuvor"
     Settext 10, 12, LIGHT, "zwei Disketten mit folgenden Inhalten vorbereitet sein:"
     Settext 10, 14, LIGHT, "DISK 1: LIBRARY"
     Settext 10, 15, LIGHT, "            - BQLB41.LIB  (u.U BQLB40.LIB in BQLB41.LIB umbenennen)"
     Settext 10, 16, LIGHT, "            - QB.LIB"
     Settext 10, 18, LIGHT, "DISK 2: LINKER"
     Settext 10, 19, LIGHT, "            - BCOM41.LIB (u.U. BCOM40.LIB in BCOM41.LIB umbenennen)"
     Settext 10, 20, LIGHT, "            - LINK.EXE"
     Settext 10, 21, LIGHT, "            - LIB.EXE"
     Settext 10, 23, LIGHT, "(Taste)"
     a$ = INPUT$(1)
     CLS

     t$ = "Bitte Loewe-Tools Disk I in Laufwerk A:,|"
     t$ = t$ + "LIBRARY-Diskette in Laufwerk B: einlegen!"
     a% = balert%(1, t$, 0, "OK|Abbruch", NORMAL, INVERS)
     IF a% = 0 THEN
          SHELL "copy a:\loewe_b.obj b:\"
          SHELL "copy a:\loewe_cl.obj b:\"
          IF fp% = TRUE THEN SHELL "copy a:\formpars.obj b:\"
          IF tv% = TRUE THEN SHELL "copy a:\formtext.obj b:\"
          IF pd% = TRUE THEN SHELL "copy a:\loewepd.obj b:\"
          t$ = "Bitte Library-Disk in Laufwerk A:,|"
          t$ = t$ + "Linker-Disk in Laufwerk B: einlegen"
          a% = balert%(1, t$, 0, "OK|Abbruch", NORMAL, INVERS)
          IF a% = 0 THEN
               SHELL "A:": SHELL "cd \"
               lib$ = "B:LIB loewe.lib+loewe_b.obj+loewe_cl.obj+qb.lib"
               IF tv% = TRUE THEN lib$ = lib$ + "+formtext.obj"
               IF pd% = TRUE THEN lib$ = lib$ + "+loewepd.obj"
               IF fp% = TRUE THEN lib$ = lib$ + "+formpars.obj"
               lib$ = lib$ + ";"
               IF exist("A:\loewe.lib", 1) THEN KILL "A:\loewe.lib"
               SHELL lib$
               SHELL "ERASE A:\*.obj"
               SHELL "B:\LINK /q loewe.lib,loewe.qlb,nul,bqlb41.lib b:\bcom41.lib; /ST 4000"
          END IF
     END IF
END SUB

SUB Info

     FOR x% = 38 TO 20 STEP -1
          y% = x% / 6
          dframe x%, y%, 80 - x%, 25 - y%, NORMAL
          sframe x% + 1, y% + 1, 80 - x% - 1, 25 - y% - 1, NORMAL
     NEXT x%

     Settext 27, 6, INVERS, "                          "
     Settext 27, 7, INVERS, " LOEWE-TOOLS INSTALLATION "
     Settext 27, 8, INVERS, "                          "

     Settext 25, 11, NORMAL, "Copyright (c) 1989 by LOEWE-SOFT"
     Settext 29, 12, NORMAL, "Autor: Klaus Lîffelmann"
     Settext 28, 13, NORMAL, "(Alle Rechte vorbehalten)"
     Settext 23, 18, NORMAL, "Loewe-Soft"
     Settext 23, 19, NORMAL, "LippstÑdter Stra·e 2-4"
     Settext 23, 20, NORMAL, "4775 Lippetal 1"
    
     pause 10

     FOR x% = 20 TO 38
          y% = x% / 6
          sframe x%, y%, 80 - x%, 25 - y%, NORMAL
          dframe x% + 1, y% + 1, 80 - x% - 1, 25 - y% - 1, NORMAL
     NEXT x%
     ClearScreen

END SUB

