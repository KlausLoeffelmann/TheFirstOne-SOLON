DECLARE SUB CopyProj ()
'$INCLUDE: 'd:\quickb\mylib.bi'
'$INCLUDE: 'd:\quickb\drakon.bi'

ClrScr
reskonvert
ON TIMER(1) GOSUB Zeitansage
TIMER ON
SetPal
HauptMenue
CLS

END
Zeitansage:
        zwy% = CSRLIN
        zwx% = POS(0)
        Settext 55, 1, 7, TotTime$
        LOCATE zwy%, zwx%
RETURN

SUB Auslagern
   
    ClrScr
    SetLine 1, 1, 7, "S O L O N             Projekt auslagern               "
    Settext 1, 2, 7, STRING$(80, "-")

    frame 30, 10, 50, 14, 15
    SetLine 1, 3, 23, "Nachr.: Eingabe des auszulagernden Projektes"
l1: Settext 31, 12, 15, "Projekt: úúúúúúúú"
    proj$ = finput$(40, 12, 8, proj$, 5, back%, 15)
    IF back% = 79 THEN EXIT SUB

    IF exist("C:\SOLON\" + proj$ + ".prj", 16) THEN
        IF a% = 0 THEN
            COLOR 15, 1: CLS : TIMER OFF
           
            SHELL "D:\backup C:\SOLON\" + proj$ + ".PRJ A: /S"
            PRINT "Projekt wurde gesichert"
            PRINT "Projekt wird gel”scht"
            SHELL "C:"
            EraseMP "C:\SOLON\" + proj$ + ".prj", "*.*"
            TIMER ON
            PRINT : PRINT : PRINT "Projekt wurde ausgelagert": SLEEP 2
        END IF
    ELSE
        BEEP: SetLine 1, 3, 23, "Nachr.: Projekt nicht vorhanden!": GOTO l1
    END IF

END SUB

SUB CopyProj
   
    ClrScr
    SetLine 1, 1, 7, "S O L O N             Projekt bernehmen              "
    Settext 1, 2, 7, STRING$(80, "-")

    frame 30, 10, 50, 18, 15
    SetLine 1, 3, 23, "Nachr.: Eingabe des zu bernehmenden Projektes"

r1: Settext 31, 12, 15, "Projekt: úúúúúúúú"
    Settext 31, 14, 15, "  bernehmen in"
    Settext 31, 16, 15, "Projekt: úúúúúúúú"
    proj$ = finput$(40, 12, 8, proj$, 5, back%, 15)
r2: proj2$ = finput$(40, 16, 8, proj2$, 0, back%, 15)
    IF exist("C:\SOLON\" + proj2$ + ".prj", 16) THEN
        BEEP: SetLine 1, 3, 23, "Nachr.: Projekt existiert schon!!!"
        GOTO r2
    END IF

    IF back% = 79 THEN EXIT SUB

    IF exist("C:\SOLON\" + proj$ + ".prj", 16) THEN
        COLOR 15, 1: CLS : TIMER OFF
        SHELL "MKDIR C:\SOLON\" + proj2$ + ".prj"
        SHELL "XCOPY C:\SOLON\" + proj$ + ".PRJ" + "\*.* C:\SOLON\" + proj2$ + ".PRJ /S"
    ELSE
        BEEP: SetLine 1, 3, 23, "Nachr.: Projekt nicht vorhanden!": GOTO r1
    END IF
END SUB

SUB Einlagern
   
    ClrScr
    SetLine 1, 1, 7, "S O L O N             Projekt einlagern               "
    Settext 1, 2, 7, STRING$(80, "-")

    frame 30, 10, 50, 14, 15
l2: SetLine 1, 3, 23, "Nachr.: Eingabe des einzulagernden Projektes"
    Settext 31, 12, 15, "Projekt: úúúúúúúú"
    proj$ = finput$(40, 12, 8, proj$, 5, back%, 15)
    IF back% = 79 THEN EXIT SUB

        IF a% = 0 THEN
            COLOR 15, 1: CLS : TIMER OFF
            SHELL "D:\restore A: C:\SOLON\" + proj$ + ".PRJ\*.* /S"
            PRINT : PRINT : PRINT "Projekt wurde eingelagert": SLEEP 2
            TIMER ON
        END IF

END SUB

SUB HauptMenue
   
    DO

        
        ClrScr
        SetLine 1, 1, 7, "D R A K O N           Hauptmenue                      " + TotTime$
        Settext 1, 2, 7, STRING$(80, "-")
        Settext 25, 5, 15, "H A U P T S E L E K T O R"

        Settext 25, 8, 15, "F 1 ... Systembedienung"
        Settext 25, 9, 15, "F 2 ... "
        Settext 25, 10, 15, "F 3 ... "
        Settext 25, 11, 15, "F 4 ... "
        Settext 25, 12, 15, "F 5 ... Auftragsverwaltung"
        Settext 25, 13, 15, "F 6 ... "
        Settext 25, 14, 15, "F 7 ... "
        Settext 25, 15, 15, "F 8 ... "
        Settext 25, 16, 15, "F 9 ..."
        Settext 25, 17, 15, "F10 ..."
        Settext 25, 18, 15, "F11 ..."
        Settext 25, 19, 15, "F12 ... "
        Settext 25, 20, 15, "F13 ... Textverarbeitung"
        Settext 25, 21, 15, "F14 ... "
        Settext 25, 22, 15, "F15 ... Programmende"

        DO
            c$ = ink$
        LOOP UNTIL c$ > ""
        c% = ASC(RIGHT$(c$, 1))

        SELECT CASE c%

            CASE 59: Systembed
           
            CASE 63: RUN "D:\SOLON"

            CASE 86: RUN "C:\TEXT\WORD5.0\WP50"
           
            CASE 88: EXIT DO

            CASE ELSE

        END SELECT

    LOOP

END SUB

SUB Sichern
   
    ClrScr
    SetLine 1, 1, 7, "S O L O N             Projekt sichern                 "
    Settext 1, 2, 7, STRING$(80, "-")

    frame 30, 10, 50, 14, 15
    SetLine 1, 3, 23, "Nachr.: Eingabe des zu sichernden Projektes"
l3: Settext 31, 12, 15, "Projekt: úúúúúúúú"
    proj$ = finput$(40, 12, 8, proj$, 5, back%, 15)
    IF back% = 79 THEN EXIT SUB

    IF exist("C:\SOLON\" + proj$ + ".prj", 16) THEN
        IF a% = 0 THEN
            COLOR 15, 1: CLS : TIMER OFF
            SHELL "D:\backup C:\SOLON\" + proj$ + ".PRJ A: /S"
            PRINT : PRINT : PRINT "Projekt wurde gesichert": SLEEP 2
            TIMER ON
        END IF
    ELSE
        BEEP: SetLine 1, 3, 23, "Nachr.: Projekt nicht vorhanden!": GOTO l3
    END IF
END SUB

SUB Systembed
       
    DO
   
        ClrScr
        SetLine 1, 1, 7, "D R A K O N           Systembedienung"
        Settext 1, 2, 7, STRING$(80, "-")

        Settext 25, 8, 15, "F 1 ... Projekt einlagern"
        Settext 25, 9, 15, "F 2 ... Projekt sichern"
        Settext 25, 10, 15, "F 3 ... Projekt archvieren und l”schen"
        Settext 25, 11, 15, "F 4 ... Projekt-Update auf Disk"
        Settext 25, 12, 15, "F 5 ..."
        Settext 25, 13, 15, "F 6 ... Altes Projekt bernehmen als neues Projekt"
        Settext 25, 14, 15, "F 7 ..."
        Settext 25, 15, 15, "F 8 ..."
        Settext 25, 16, 15, "F 9 ..."
        Settext 25, 17, 15, "F10 ..."
        Settext 25, 18, 15, "F11 ..."
        Settext 25, 19, 15, "F12 ..."
        Settext 25, 20, 15, "F13 ..."
        Settext 25, 21, 15, "F14 ..."
        Settext 25, 22, 15, "F15 ... Hauptmenue"

        DO
            c$ = ink$
        LOOP UNTIL c$ > ""
        c% = ASC(RIGHT$(c$, 1))

        SELECT CASE c%

            CASE 59: Einlagern

            CASE 60: Sichern

            CASE 61: Auslagern
           
            CASE 62: UpDate
           
            CASE 64: CopyProj
           
            CASE 88: EXIT DO
           
            CASE ELSE

        END SELECT

    LOOP

END SUB

SUB UpDate
   
    ClrScr
    SetLine 1, 1, 7, "S O L O N             Projekt-Update                  "
    Settext 1, 2, 7, STRING$(80, "-")

    frame 30, 10, 50, 14, 15
    SetLine 1, 3, 23, "Nachr.: Eingabe des zu sichernden Projektes"
l4: Settext 31, 12, 15, "Projekt: úúúúúúúú"
    proj$ = finput$(40, 12, 8, proj$, 5, back%, 15)
    IF back% = 79 THEN EXIT SUB

    IF exist("C:\SOLON\" + proj$ + ".prj", 16) THEN
        IF a% = 0 THEN
            COLOR 15, 1: CLS : TIMER OFF
            SHELL "D:\backup C:\SOLON\" + proj$ + ".PRJ A: /S /M"
            PRINT : PRINT : PRINT "Projektdaten wurden erg„nzt": SLEEP 2
            TIMER ON
        END IF
    ELSE
        BEEP: SetLine 1, 3, 23, "Nachr.: Projekt nicht vorhanden!": GOTO l4
    END IF

END SUB

