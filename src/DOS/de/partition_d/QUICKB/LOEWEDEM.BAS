'$INCLUDE: 'd:\quickb\loewe_b.bi'
'$INCLUDE: 'd:\quickb\loewepd.bi'

DECLARE SUB About ()
DECLARE SUB ClearScreen ()
DECLARE SUB FensterDemo ()
DECLARE SUB MaskenDemo ()
DECLARE SUB ShowTime ()

'*** Definition des Pull-Down-Menues

DATA INFO,i,"öber dieses Programm ",Å,----,-,"Uhrzeit",u,----,-,"Programm beenden",e,#,""
DATA MODULE,m,"Textverarbeitung ",t,"Formelauswertung",f,"Pull-Down-Menues",p,#,""
DATA DEMOS,d,"Datei-Auswahl ",d,"Warnbox",w,"Masken",m,"Fenster",f,##,""

'*** Definition der Eingabe-Maske

DATA 28,7,15,0
DATA 28,8,15,0
DATA 28,9,15,0
DATA 28,10,25,0
DATA 28,12,15,0
DATA 28,14,10,2

DIM pd$(36)                                    'Menue-Array definieren
DIM SHARED maske(0 TO 5) AS formstruc          'Masken-Array definieren
DIM SHARED MaskeT(0 TO 5) AS STRING

FOR z% = 1 TO 36                               'Und MenueeintrÑge in String-Array einlesen
     READ pd$(z%)
NEXT z%
'
FOR z% = 0 TO 5
     READ maske(z%).xpos: READ maske(z%).ypos: READ maske(z%).laenge: READ maske(z%).tpe
NEXT z%
'
CLS
Menu pd$()
'
DO
     IF TimeOn% THEN ShowTime
     a% = OnMenue%(titel%, entry%)
     IF a% THEN
         
          SELECT CASE MenuT$(titel%, entry%)

          CASE "öber dieses Programm "
               About

          CASE "Uhrzeit"
               IF TimeOn% = TRUE THEN
                    TimeOn% = FALSE
                    MenuICheck titel%, entry%, FALSE
                    Settext 40, 1, INVERS, SPACE$(40)
               ELSE
                    TimeOn% = TRUE
                    MenuICheck titel%, entry%, TRUE
               END IF

          CASE "Textverarbeitung "

               PRINT AT$(5, 4); "Loewe-Tools stellen Ihnen einen umfangreichen Texteditor"
               PRINT AT$(5, 5); "mit Merkmalen einer professionellen Textverarbeitung zur VerfÅgung"
               PRINT AT$(5, 6); "(z.B. AbsÑtze, Direktformatierung, etc.). Dieser Texteditor ist direkt"
               PRINT AT$(5, 7); "als BASIC-Befehl verfÅgbar und kann dementsprechend einfach genutzt werden:"
               '
               PRINT AT$(5, 9); "Beispiel: a$=FormText$(10,15,60,23,50,10,15,4,vg$,INVERS,0,NORMAL)"
               PRINT AT$(5, 10); "                         Eingabe-  ≥  Fenster-  ≥  Farbsteuerung"
               PRINT AT$(5, 11); "                         fenster   ≥  steuerung ≥"
               PRINT AT$(5, 12); "                           Anzahl Textzeilen   Vorgabetext"
               PRINT AT$(5, 14); "Der Editor wird mit END verlassen! (Taste drÅcken)"
              
               a$ = INPUT$(1)
               vg$ = "Vorgabetext"
               a$ = FormText$(10, 16, 60, 23, 50, 10, 16, 4, vg$, INVERS, 0, NORMAL)
              
               ClearScreen
              
          CASE "Formelauswertung"

               PRINT AT$(5, 4); "Probleme bereitet es, Formeln irgendwelcher Art"
               PRINT AT$(5, 5); "innerhalb eines Programms zu berechnen. Loewe-Tools"
               PRINT AT$(5, 6); "stellt daher einen Formelauswerter zur VerfÅgung, mit"
               PRINT AT$(5, 7); "dem dieses Problem nichtig wird. Ein Beispiel: Geben Sie"
               PRINT AT$(5, 8); "bitte einen mathematischen Ausdruck Ihrer Wahl ein:"
              
               a$ = finput$(5, 10, 50, "5+5", TextType, back%, NORMAL)
               PRINT AT$(5, 12); "Das Ergebnis lautet :"; calculate#(a$, back$)
               PRINT AT$(5, 13); "Der Fehlerstatus ist:"; back$
               a$ = INPUT$(1)
               ClearScreen

          CASE "Pull-Down-Menues"
         
               PRINT AT$(5, 4); "Loewe-Tools verwalten eigenstÑndig Pull-Down-Menues"
               PRINT AT$(5, 5); "Anhand des Listing dieses Programms kînnen Sie ersehen,"
               Settext 5, 6, LIGHT, "wie"
               PRINT AT$(9, 6); "einfach die Definition und das Handeling der Pull-Down-Menues"
               PRINT AT$(5, 7); "vonstatten geht. Auch das Abhaken und Sperren von Menue-EintrÑgen"
               PRINT AT$(5, 8); "ist fÅr Loewe-Tools kein Problem. Probieren Sie dies doch einmal"
               PRINT AT$(5, 9); "am Beispiel der Uhrzeit im ersten Pull-Down-Menue aus!"
               PRINT AT(5, 10); "(Taste drÅcken)"
               a$ = INPUT$(1)
               ClearScreen
         
          CASE "Datei-Auswahl "

               PRINT AT$(5, 4); "Ein bisher gro·es Manko war die Auswahl von Dateien"
               PRINT AT$(5, 5); "innerhalb von Programmen, da QUICK-BASIC nicht"
               PRINT AT$(5, 6); "das Vorhandensein einer Datei auf Diskette oder Platte"
               PRINT AT$(5, 7); "feststellen konnte. Mithilfe der FileSelect$-Funktion bieten"
               PRINT AT$(5, 8); "Loewe-Tools fÅr Programmierer und (spÑteren) Anwender einen"
               PRINT AT$(5, 9); "komfortabelen Kompromiss: (Bitte Diskette in Laufwerk A: einlegen,"
               PRINT AT$(5, 10); "Taste drÅcken)"
               a$ = INPUT$(1)
               dn$ = FileSelect$("a:\*.*")
               PRINT AT$(5, 12); "Sie haben die Datei " + dn$ + " ausgewÑhlt. (Taste drÅcken)";
               a$ = INPUT$(1)
               ClearScreen
         
          CASE "Warnbox"

               t$ = "Dies ist ein Beispiel fÅr|eine Loewe-Warnbox. Auch|hier ist das Handling|"
               t$ = t$ + "stark vereinfacht, oder nicht?"
               a% = balert%(1, t$, 0, "Ja|Nein|Vielleicht", NORMAL, INVERS)
         
          CASE "Masken"

               MaskenDemo
         
          CASE "Fenster"

               FensterDemo

          CASE ELSE
         
          END SELECT
         
          IF MenuT$(titel%, entry%) = "Programm beenden" THEN EXIT DO
    
     END IF

LOOP
CLS

PRINT AT(1, 1); "Loewe-Tools V1.0 PC MS-BASIC/QUICK-BASIC kosten 89.- incl. Mwst."
Settext 1, 3, LIGHT, "Loewe-Soft"

Settext 1, 4, LIGHT, "LippstÑdter Stra·e 2-4"
Settext 1, 6, LIGHT, "4775 Lippetal 1"
PRINT AT$(1, 10);

SUB About
    
     FOR x% = 38 TO 20 STEP -1
          y% = x% / 6
          dframe x%, y%, 80 - x%, 25 - y%, NORMAL
          sframe x% + 1, y% + 1, 80 - x% - 1, 25 - y% - 1, NORMAL
     NEXT x%
    
     Settext 21, 4, INVERS, "   L O E W E - T O O L -DEMONSTRATION  "
     Settext 21, 6, NORMAL, " Dies ist ein Demonstrationsprogramm,"
     Settext 21, 7, NORMAL, " das kurz die Features der Loewe-Tools"
     Settext 21, 8, NORMAL, " zum Besten gibt."
     Settext 21, 10, NORMAL, " Das Programm ist Public-Domain, d.h."
     Settext 21, 11, NORMAL, " es  darf  beliebig  kopiert und ver-"
     Settext 21, 12, NORMAL, " breitet werden."
     Settext 21, 14, NORMAL, " Falls Sie weitere Informationen Åber"
     Settext 21, 15, NORMAL, " Loewe-Tools  benîtigen,  wenden  Sie"
     Settext 21, 16, NORMAL, " sich an:"
     Settext 21, 18, LIGHT, " Loewe-Soft Herr Klaus Lîffelmann"
     Settext 21, 19, LIGHT, " LippstÑdter Stra·e 2-4"
     Settext 21, 20, LIGHT, " 4775 Lippetal 1"
     Settext 21, 21, LIGHT, " Tel.: 02945 / 6418            "
     SLEEP 15
    
     FOR x% = 20 TO 38 STEP 1
          y% = x% / 6
          sframe x%, y%, 80 - x%, 25 - y%, NORMAL
          dframe x% + 1, y% + 1, 80 - x% - 1, 25 - y% - 1, NORMAL
     NEXT x%
     ClearScreen

END SUB

SUB ClearScreen
              
     FOR x% = 4 TO 23
          PRINT AT$(1, x%); SPACE$(80);
     NEXT x%

END SUB

SUB FensterDemo
              
     PRINT AT$(5, 4); "Vielerlei Anwendungen machen die Zwischenspeicherung"
     PRINT AT$(5, 5); "von bestimmten Bildschirmausschnitten sehr wichtig."
     PRINT AT$(5, 6); "Unsere Pull-Down-Menues oder die Datei-Auswahl-Box sollen"
     PRINT AT$(5, 7); "hier nur zwei Beispiele sein."
     PRINT AT$(5, 8); "Loewe-Tools bietet Ihnen die Mîglichkeit zur Speicherung"
     PRINT AT$(5, 9); "fÅnf verschiedener Bildschirmausschnitte. Die Wieder-"
     PRINT AT$(5, 10); "herstellung eines Ausschnittes erfolgt dabei (fast) voll-"
     PRINT AT$(5, 11); "automatisch. Ein Beispiel auch hierfÅr: (Taste)"
     a$ = INPUT$(1)
    
     makewin 1, 5, 5, 45, 15, 32
     dframe 5, 5, 45, 15, NORMAL
     PRINT AT$(10, 10); "Dies ist ein Bildschirmausschnitt": SLEEP 3
     FOR z% = 1 TO 2000
          PRINT AT$(RND * 38 + 6, RND * 8 + 6); "*"
     NEXT z%
     rebuild 1
     PRINT AT$(5, 13); "Jetzt ist alles wieder so, wie es war!!! (Taste)"
     a$ = INPUT$(1)
     ClearScreen

END SUB

SUB MaskenDemo

     PRINT AT$(5, 4); "AusfÅllen von Formularen mit verschiedenen Datentypen"
     PRINT AT$(5, 5); "kînnen in Quick-BASIC oft zur Tortur werden, gerade"
     PRINT AT$(5, 6); "wenn bestimmen Typen formatiert eingegeben werden sollen."
     PRINT AT$(5, 7); "Loewe-Tools stellen eine bequeme Lîsung dieses Problems"
     PRINT AT$(5, 8); "mit Hilfe der eingebauten Maskensteuerung dar."
     PRINT AT$(5, 9); "Auch dafÅr ein Beispiel (Taste drÅcken):"
     a$ = INPUT$(1)
     dframe 10, 4, 70, 20, NORMAL
     FOR z% = 5 TO 19: PRINT AT$(11, z%); SPACE$(59); : NEXT
     PRINT AT$(31, 5); "MASKENDEMONSTRATION:"
     PRINT AT$(12, 7); "NAME:"
     PRINT AT$(12, 8); "VORNAME:"
     PRINT AT$(12, 9); "STRASSE:"
     PRINT AT$(12, 10); "PLZ, ORT:"
     PRINT AT$(12, 12); "TELEFON:"
     PRINT AT$(12, 14); "GEBURTSDATUM:"
     Settext 15, 19, INVERS, "  Maskeneditierung mit " + CHR$(24) + " " + CHR$(25) + " [RETURN]; Ende mit [F1]  "
    
     a% = formular(maske(), MaskeT(), NORMAL)
    
     ClearScreen
     PRINT AT$(12, 5); "Ergebnis des Maskeneditierung in masket$():"
     FOR z% = 0 TO 5
          PRINT AT$(15, 7 + z%); "masket$("; z%; "):  "; MaskeT$(z%)
     NEXT z%
     PRINT AT$(35, 22); "(Taste drÅcken)"
     a$ = INPUT$(1)
     ClearScreen

END SUB

SUB ShowTime
    
     Settext 56, 1, INVERS, TotTime$

END SUB

