'$INCLUDE: 'D:\QUICKB\LOEWEPRT.BI'
'$INCLUDE: 'D:\QUICKB\LOEWE_B.BI'

DIM SHARED subs(500) AS STRING * 50          'Platz fÅr maximal 500 Unterroutinen
DIM SHARED subsver(500, 3) AS INTEGER        'Platz fÅr Seitenverweis, Zeilenverweis
                                             'Funktionstyp

DIM SHARED pflag%                            'Wenn Flag=0, alles hintereinander
                                             'Wenn Flag=1, Prozeduren und Funktionen
                                             'durch Striche getrennt
                                             'Wenn Flag%=2, Prozeduren und Funktionen jeweils
                                             'auf neue Seite

DIM SHARED pflag2%                           'Wenn Flag=0, Sofort drucken
                                             'Wenn Flag=1, in Reihe drucken

DIM SHARED pflag3%                           'Flag=1, Ausgabe des Inhaltsverzeichnisses
DIM SHARED pflag4%                           'Flag=1, Protokolierung am Bildschirm

DIM SHARED anzziff%                          'Anzahl der Ziffern der Zeilennumerierung
DIM SHARED zeilen%                           'ZeilenzÑhler pro Seite
DIM SHARED seiten%                           'SeitenzÑhler
DIM SHARED zeilennr&                         'ZeilenzÑhler gesamt
DIM SHARED anzfunc%                          'Anzahl Funktionen gesamt
DIM SHARED anzsub%                           'Anzahl Prozeduren gesamt
DIM SHARED anzfunk%                          'Anzahl Funktionen & Prozeduren
DIM SHARED Tbreite%                          'Breite des Textes
DIM SHARED lrand%                            'Linker Rand (Bundsteg)
DIM SHARED maxzeilen%                        'Anzahl Zeilen pro Seite
DIM SHARED kopfzeile$                        'Text der Kopfzeile
DIM SHARED datei$
DIM SHARED printprg$                         'Pfad von PRINT.COM
DIM SHARED drucker$

drucker$ = "LPT1:"

printprg$ = "C:\SYSTEM"

anzziff% = 5                                 '6-Stellige Numerierung
zeilennr& = 1                                'Zeilennummerierung beginnt bei
pflag% = 1                                   'Prozeduren durch Striche getrennt
pflag2% = 1                                  'In Datei drucken
pflag3% = 1                                  'Inhaltsverzeichnis ausgeben
pflag4% = 1                                  'Protokolierung am Bildschirm
Tbreite% = 96                                '96 Zeichen pro Zeile (Eliteschrift)
IF pflag2% = 0 THEN
     out$ = drucker$
ELSE
     out$ = mktemp$("LOEXXXXX") + ".TMP"
END IF
maxzeilen% = 58                              '58 Zeilen pro Seite

CLS
prtinit$ = CHR$(27) + "M"
kopfzeile$ = "Testausdruck eines Listing"    'Kopfzeile definieren

datei$ = FileSelect$("D:\*.bas", "")
OPEN datei$ FOR INPUT AS 1                   'Eingabedatei îffnen
OPEN out$ FOR OUTPUT AS 2                    'Ausgabedatei îffnen
WIDTH #2, Tbreite% + 1                       'Zeichenausgabe ermîglichen

PRINT #2, prtinit$;                          'Drucker initialisieren
SeitenWechsel                                'SeitenÅberschrift
PrintListing                                 'Listing ausdrucken
CLOSE 1                                      'Eingabedatei schlie·en
IF pflag3% = 1 THEN
     Inhaltsverzeichnis                      'Inhaltsverzeichnis ausgeben
ELSE
     SeitenEnde                              'Seiten-Ende drucken
END IF
CLOSE 2                                      'Datei schlie·en
IF out$ <> drucker$ THEN
     SHELL printprg$ + "\print /B:1024 /D:" + LEFT$(drucker$, 3) + " " + out$
END IF

SUB Inhaltsverzeichnis

     SeitenWechsel
     PLine ""
     t$ = "I N H A L T S V E R Z E I C H N I S"
     PLine SPACE$(Tbreite% / 2 - LEN(t$) / 2) + t$
     t$ = "==================================="
     PLine SPACE$(Tbreite% / 2 - LEN(t$) / 2) + t$
     PLine ""

     FOR z% = 1 TO anzfunk% - 1
          par1# = subsver(z%, 1)
          par2# = subsver(z%, 2)
          IF subsver(z%, 3) = 0 THEN
               t$ = "FUNKTION"
          ELSE
               t$ = "PROZEDUR"
          END IF
          PLine subs(z%) + " Z:" + using$(par1#, (anzziff%), 0) + " S:" + using$(par2#, 4, 0) + " " + t$
     NEXT z%
     PLine ""
     PLine ""
     PLine SPACE$(anzzif%) + "   Anzahl Prozeduren gesamt: " + STR$(anzsub%)
     PLine SPACE$(anzzif%) + "   Anzahl Funktionen gesamt: " + STR$(anzfunc%)
     SeitenEnde
END SUB

SUB PLine (text$)
    
     IF LEN(text$) > Tbreite% THEN text$ = LEFT$(text$, Tbreite% - 3) + "..."
     PRINT #2, text$
    
     IF pflag4% = 1 THEN
          IF LEN(text$) > 80 AND text$ <> STRING$(Tbreite%, "-") THEN text$ = LEFT$(text$, 77) + "..."
          Settext 1, 22, NORMAL, LEFT$(text$, 80): ScrollUp 0, 0, 79, 22, 1, NORMAL
     END IF
     Settext 1, 24, NORMAL, "Zeile: " + STR$(zeilennr&) + "    Seite: " + STR$(seiten%)
     zeilen% = zeilen% + 1
     zeilennr& = zeilennr& + 1
     IF zeilen% = maxzeilen% THEN
          SeitenWechsel
          zeilen% = 0
          seiten% = seiten% + 1
     END IF

END SUB

SUB PrintListing

     zeilen% = 1: seiten% = 1
     DO WHILE NOT EOF(1)
          LINE INPUT #1, zeile$                                  'Zeile einlesen
          czeile$ = zeile$
          zeile$ = RTRIM$(LTRIM$(zeile$))                        'Leerzeichen in Zeile entfernen
          eew% = INSTR(zeile$, " ")                              'Ende des 1. Wortes finden
          IF eew% <> 0 THEN                                      'Wenn gefunden, dann
               bwort$ = LEFT$(zeile$, eew%)                      'Befehls-Wort herausziehen
               zew% = INSTR(eew% + 1, zeile$, " ")               'Argument, wenn
               IF zew% = 0 THEN zew% = LEN(zeile$)
               awort$ = cut$(zeile$, eew%, zew%)                 'vorhanden, ermitteln
              
               IF bwort$ = "SUB " OR bwort$ = "FUNCTION " THEN   'Wenn neue Funktion,
                    IF subflag% = 0 THEN
                         subflag% = 1
                         IF pflag% = 1 THEN
                              PLine STRING$(Tbreite%, "-")
                         ELSEIF pflag% = 2 THEN
                              SeitenWechsel
                         END IF
                    END IF
                    subs(anzfunk%) = awort$                      'Funktion merken
                    subsver(anzfunk%, 1) = zeilennr&             'Zeilennummer merken
                    subsver(anzfunk%, 2) = seiten%               'Seitennummer merken
                    IF bwort$ = "SUB " THEN
                         subsver(anzfunk%, 3) = 1                'Prozedur oder
                         anzsub% = anzsub% + 1
                    ELSE
                         subsver(anzfunk%, 3) = 2                'Funktion
                         anzfunc% = anzfunc% + 1
                    END IF
                    anzfunk% = anzfunk% + 1
               END IF
              
               PLine Formstr$(anzziff%, zeilennr&) + ":  " + czeile$   'Zeile ausgeben
              
               IF bwort$ = "END " THEN
                    IF awort$ = " SUB" OR awort$ = " FUNCTION" THEN
                         IF pflag% = 1 THEN
                              PLine STRING$(Tbreite%, "-")
                         ELSEIF pflag% = 2 THEN
                              SeitenWechsel
                         END IF
                    END IF
               END IF
          ELSE
               PLine Formstr$(anzziff%, zeilennr&) + ":  " + czeile$   'Zeile ausgeben
          END IF
     LOOP
END SUB

SUB SeitenEnde
    
     FOR z% = zeilen% TO maxzeilen%
          PRINT #2,
     NEXT z%
     seite$ = "Seite -" + STR$(seiten%) + " -"
     PRINT #2,
     PRINT #2,
     PRINT #2, datei$ + SPACE$(Tbreite% - LEN(datei$) - LEN(seite$)) + seite$
     PRINT #2, CHR$(12)

END SUB

SUB SeitenWechsel STATIC
    
    
     IF swflag% = 0 THEN
          swflag% = 1
     ELSE
          IF zeilen% < maxzeilen% THEN
               FOR z% = zeilen% TO maxzeilen%
                    PRINT #2,
               NEXT z%
          END IF
          seite$ = "Seite -" + STR$(seiten%) + " -"
          PRINT #2,
          PRINT #2,
          PRINT #2, datei$ + SPACE$(Tbreite% - LEN(datei$) - LEN(seite$)) + seite$
          PRINT #2, CHR$(12)
     END IF
     
     PRINT #2, kopfzeile$ + SPACE$(Tbreite% - (LEN(kopfzeile$) + 24)) + TotTime$;
     PRINT #2, STRING$(Tbreite%, "-")
     PRINT #2,
     PRINT #2,
END SUB

