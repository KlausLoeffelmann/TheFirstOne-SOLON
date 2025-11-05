'$INCLUDE: 'd:\quickb\mylib.bi'

FUNCTION alert% (text$, default%, lin%, menue$, col%, revcol%)

        CONST KeyCurLeft = 75
        CONST KeyCurRight = 77
        CONST KeyRet = 13
     
        DIM men$(0 TO 3), char$(0 TO 3)
     
        menue$ = menue$ + "|"
        text$ = LEFT$(text$, 40)

        count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND count% <= 4
            ps2% = INSTR(ps%, menue$, "|")
            IF ps2% = 0 THEN EXIT DO
            men$(count%) = SPACE$(8)
            temp$ = MID$(menue$, ps%, ps2% - ps%)
            MID$(men$(count%), 5 - LEN(temp$) / 2) = temp$
            char$(count%) = UCASE$(LEFT$(temp$, 1))
            count% = count% + 1
            ps% = ps2% + 1
        LOOP
     
        IF count% = 0 THEN alter% = -1: EXIT FUNCTION

        SetLine 1, lin%, col%, text$

        FOR z% = 0 TO count%
            CALL Settext(z% * 9 + 40, lin%, col%, men$(z%))
        NEXT z%

        MenPoint% = default%                                        'Menuezeiger auf Defaultwert setzten
     
        DO
         
            CALL Settext(MenPoint% * 9 + 40, lin%, revcol%, men$(MenPoint%))
         
            DO
                c$ = INKEY$
            LOOP UNTIL c$ <> ""
     
            CALL Settext(MenPoint% * 9 + 40, lin%, col%, men$(MenPoint%))
        
            FOR z% = 0 TO count%                                    'Auf Menue-Anfangsbuchstaben prÅfenAnf
                IF UCASE$(c$) = char$(z%) THEN EXIT FOR
            NEXT z%
            IF z% < count% + 1 THEN
                MenPoint% = z%
            END IF

            SELECT CASE c$

                CASE CHR$(0) + CHR$(KeyCurRight)
                    MenPoint% = MenPoint% + 1
                    MenPoint% = MenPoint% MOD count%

                CASE CHR$(0) + CHR$(KeyCurLeft)
                    MenPoint% = MenPoint% + count% - 1
                    MenPoint% = MenPoint% MOD count%
            
                CASE ELSE
    
            END SELECT
    
        LOOP UNTIL c$ = CHR$(KeyRet)

        alert% = MenPoint%

END FUNCTION

FUNCTION balert% (Ausr%, text$, default%, menue$, col%, revcol%)
       
        CONST KeyCurLeft = 75
        CONST KeyCurRight = 77
        CONST KeyRet = 13

        DIM men$(0 TO 3), char$(0 TO 3), tline$(0 TO 6)
    
        menue$ = menue$ + "|"
        text$ = text$ + "|"

        count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND count% <= 6
            ps2% = INSTR(ps%, text$, "|")
            IF ps2% = 0 THEN EXIT DO
            tline$(count%) = MID$(text$, ps%, ps2% - ps%)
            Breite% = max(Breite%, LEN(tline$(count%)))
            count% = count% + 1
            ps% = ps2% + 1
        LOOP
        TCount% = count% - 1

        count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND count% <= 4
            ps2% = INSTR(ps%, menue$, "|")
            IF ps2% = 0 THEN EXIT DO
            men$(count%) = MID$(menue$, ps%, ps2% - ps%)
            char$(count%) = UCASE$(LEFT$(men$(count%), 1))
            men$(count%) = " " + men$(count%) + " "
            tb% = max(tb%, LEN(men$(count%)))
            count% = count% + 1
            ps% = ps2% + 1
        LOOP
        count% = count% - 1

        FOR z% = 0 TO count%
            temp$ = SPACE$(tb%)
            MID$(temp$, 1 + tb% / 2 - LEN(men$(z%)) / 2) = men$(z%)
            men$(z%) = temp$
        NEXT z%
       
        Breite% = max(Breite%, (count% + 1) * tb%)
        Menx% = 40 - ((count% + 1) * tb%) / 2

        IF count% = 0 THEN balert% = -1: EXIT FUNCTION

        WLen% = TCount% + 4
        WBre% = Breite% + 3

        x1% = 40 - WBre% / 2
        x2% = 40 + WBre% / 2
      
        IF Ausr% = 0 THEN
            y1% = 1: y2% = WLen% + 1
        ELSEIF Ausr% = 1 THEN
            y2% = 12 + (WLen% / 2)
            y1% = y2% - WLen%
        ELSEIF Ausr% = 2 THEN
            y2% = 24
            y1% = 24 - WLen%
        ELSE
            y2% = Ausr%
            y1% = Ausr% - WLen%
        END IF
       
        makewin 1, x1%, y1%, x2%, y2%, col%
        frame x1%, y1%, x2%, y2%, col%
        FOR z% = 0 TO TCount%
            Settext 40 - LEN(tline$(z%)) / 2, y1% + z% + 1, col%, tline$(z%)
        NEXT z%
       
        al% = y1% + z% + 2
       
        FOR z% = 0 TO count%
            Settext Menx% + z% * tb%, al%, col%, men$(z%)
        NEXT z%
       
        MenPoint% = default%                                        'Menuezeiger auf Defaultwert setzten
     
        DO
         
            Settext MenPoint% * tb% + Menx%, al%, revcol%, men$(MenPoint%)
         
            DO
                c$ = INKEY$
            LOOP UNTIL c$ <> ""
     
            Settext MenPoint% * tb% + Menx%, al%, col%, men$(MenPoint%)
        
            FOR z% = 0 TO count%                                    'Auf Menue-Anfangsbuchstaben prÅfenAnf
                IF UCASE$(c$) = char$(z%) THEN EXIT FOR
            NEXT z%
            IF z% < count% + 1 THEN
                MenPoint% = z%
            END IF

            SELECT CASE c$

                CASE CHR$(0) + CHR$(KeyCurRight)
                    MenPoint% = MenPoint% + 1
                    MenPoint% = MenPoint% MOD (count% + 1)

                CASE CHR$(0) + CHR$(KeyCurLeft)
                    MenPoint% = MenPoint% + count%
                    MenPoint% = MenPoint% MOD (count% + 1)
            
                CASE ELSE
    
            END SELECT
    
        LOOP UNTIL c$ = CHR$(KeyRet)

        balert% = MenPoint%
       
        rebuild 1

END FUNCTION

SUB BWait (Ausr%, text$, col%, sekunden%)

     DIM tline$(0 TO 6)
         
     text$ = text$ + "|"

     count% = 0: ps% = 1
     DO WHILE ps% <> 0 AND count% <= 6
         ps2% = INSTR(ps%, text$, "|")
         IF ps2% = 0 THEN EXIT DO
         tline$(count%) = MID$(text$, ps%, ps2% - ps%)
         Breite% = max(Breite%, LEN(tline$(count%)))
         count% = count% + 1
         ps% = ps2% + 1
     LOOP
     TCount% = count% - 1

     WLen% = TCount% + 4
     WBre% = Breite% + 3

     x1% = 40 - WBre% / 2
     x2% = 40 + WBre% / 2
           
     IF Ausr% = 0 THEN
         y1% = 1: y2% = WLen% + 1
     ELSEIF Ausr% = 1 THEN
         y2% = 12 + (WLen% / 2)
         y1% = y2% - WLen%
     ELSEIF Ausr% = 2 THEN
         y2% = 24
         y1% = 24 - WLen%
     ELSE
         y2% = Ausr%
         y1% = Ausr% - WLen%
     END IF
            
     makewin 1, x1%, y1%, x2%, y2%, col%
     frame x1%, y1%, x2%, y2%, col%
     FOR z% = 0 TO TCount%
         Settext 40 - LEN(tline$(z%)) / 2, y1% + z% + 1, col%, tline$(z%)
     NEXT z%

     Pause sekunden%

     rebuild 1

END SUB

SUB Center (zeile%, text$, col%)
    
     Settext 40 - LEN(text$) / 2, zeile%, col%, text$

END SUB

SUB ClearForm (form() AS formstruc)
   
     CONST col = 7

     FOR z% = 0 TO UBOUND(form)
          IF form(z%).tpe = 4 THEN
               laenge% = form(z%).laenge
               vslaen% = laenge% \ 16
               nslaen% = laenge% MOD 16
               laenge% = vslaen% + 2 + nslaen%
               Settext form(z%).xpos, form(z%).ypos, col, STRING$(laenge%, 250)
          ELSE
               Settext form(z%).xpos, form(z%).ypos, col, STRING$(form(z%).laenge%, 250)
          END IF
     NEXT z%
END SUB

SUB ClearTextArray (text() AS STRING)
     FOR z% = LBOUND(text) TO UBOUND(text)
          text(z%) = ""
     NEXT z%
END SUB

SUB ClrScr
  
    COLOR 15, 0

    CLS

END SUB

FUNCTION CorrectDate$ (datum$) STATIC
    
     IF datum$ = "" OR (INSTR(datum$, ".") = 0 AND INSTR(datum$, "/") = 0 AND INSTR(datum$, ",") = 0) THEN
          CorrectDate$ = "01.01.1000"
     ELSE
          FOR x% = 1 TO LEN(datum$)
               IF MID$(datum$, x%, 1) = "/" OR MID$(datum$, x%, 1) = "," THEN
                    MID$(datum$, x%) = "."
               END IF
          NEXT x%

          posi1% = INSTR(datum$, ".")
          posi2% = INSTR(posi1% + 1, datum$, ".")

          tag& = VAL(LEFT$(datum$, posi1%)): tag& = tag& MOD 32
          IF tag& = 0 THEN
               tag& = tag& + 1
          END IF

          monat& = VAL(MID$(datum$, posi1% + 1, 2)): monat& = monat& MOD 13
          IF monat& = 0 THEN
               monat& = monat& + 1
          END IF

          jahr& = VAL(RIGHT$(datum$, LEN(datum$) - posi2%))

          IF jahr& < 100 THEN
               jahr& = jahr& + 1900
          END IF
      
          IF jahr& > 99 AND jahr& < 1000 THEN
               jahr& = jahr& * 10
          END IF

          CorrectDate$ = Formstr$(2, tag&) + "." + Formstr$(2, monat&) + "." + Formstr$(4, jahr&)
     END IF

END FUNCTION

FUNCTION DateToString$ (text$)
    
     IF text$ = "" OR LEFT$(text$, 1) = CHR$(0) OR LEFT$(text$, 1) = " " THEN
        DateToString$ = ""
     ELSE
        DateToString$ = MID$(text$, 7, 2) + "." + MID$(text$, 5, 2) + "." + LEFT$(text$, 4)
     END IF

END FUNCTION

FUNCTION DMKonv$ (text$, laenge%)

    vorstell% = laenge% \ 16
    vorstell% = vorstell% + 1
    nachstell% = laenge% MOD 16
   
    IF vorstell% > 11 THEN vorstell% = 11
    IF nachstell% > 5 THEN nachstell% = 5
    
    text$ = PointKonv$(text$)

    value# = VAL(text$): IF value# < 0 THEN vflag% = -1
    IF value# <= -1000000000# OR value# >= 1000000000# THEN
        DMKonv$ = STRING$(vorstell%, "*") + "," + STRING$(nachstell%, "*")
    END IF

    value# = INT(value# * 10 ^ nachstell% + .5)
    value$ = MID$(STR$(value#), 2)
    p% = INSTR(value$, ".")
    IF p% > 0 THEN
        value$ = LEFT$(value$, p%)
    END IF
    nk$ = RIGHT$(STRING$(20, "0") + value$, nachstell%)
    lennk% = LEN(RIGHT$(value$, nachstell%))
    vk$ = LEFT$(value$, LEN(value$) - lennk%)
    IF vk$ = "" THEN vk$ = "0"
    IF LEN(vk$) > vorstell% THEN
        vk$ = STRING$(vorstell% - 1, "*")
        nk$ = STRING$(nachstell%, "*")
    END IF
    vk$ = SPACE$(vorstell% - 1 - LEN(vk$)) + vk$
    IF vflag% THEN
        vk$ = "-" + vk$
    ELSE
        vk$ = " " + vk$
    END IF
    DMKonv$ = vk$ + "," + nk$

END FUNCTION

SUB EraseMP (ordner$, joker$)

    IF exist(ordner$, 16) THEN
        DO
            CHDIR ordner$
            attribute% = 16: dn$ = FSFirst(joker$, attribute%)
            IF attribute% = 16 AND dn$ = "." THEN
                attribute% = 16: dn$ = FSNext(attribute%)
                attribute% = 16: dn$ = FSNext(attribute%)
            END IF
          
            IF dn$ = "" THEN EXIT DO

            IF attribute% = 16 THEN
                IF NOT FoldNotEmpty(dn$) THEN
                    RMDIR dn$
                    PRINT "REMOVE DIR", ordner$ + dn$
                ELSE
                    EraseMP ordner$ + "\" + dn$, joker$
                END IF
            ELSE
                KILL joker$
            END IF
        LOOP UNTIL NOT exist%(ordner$, 16)
        CHDIR ".."
        RMDIR ordner$
        PRINT "REMOVE DIR", ordner$ + dn$
    END IF
END SUB

FUNCTION exist% (datei$, att%)

    IF cexist(datei$ + CHR$(0), att%) = 1 THEN
        exist% = -1
    ELSE
        exist% = 0
    END IF

END FUNCTION

FUNCTION finput$ (xpos%, ypos%, laen%, text$, tpe%, back%, col%) STATIC

     laenge% = laen%
     datei$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890?*#+-_ôéö" + CHR$(8) + CHR$(27) + CHR$(13) + CHR$(127)
    
     IF tpe% = DateType AND text$ <> "" THEN
          text$ = DateToString$(text$)
          laenge% = 10
     END IF
         
     IF tpe% = FloatType THEN
          tlaenge% = laenge%
          vslaen% = laenge% \ 16
          nslaen% = laenge% MOD 16
          laenge% = vslaen% + 2 + nslaen%
          IF text$ <> "" THEN
               IF LEFT$(text$, 1) = CHR$(255) THEN MID$(text$, 1) = " "
               temp$ = LTRIM$(MID$(text$, 2))
               text$ = LEFT$(text$, 1) + temp$
          END IF
     END IF
    
     IF tpe% = DMType AND text$ <> "" THEN
          IF LEFT$(text$, 1) = "-" THEN
               vz% = -1
          ELSE
               vz% = 1
          END IF
          text$ = MID$(text$, 2)
          text# = VAL(text$)
          text# = text# * vz% / 100
          text$ = DMKonv$(STR$(text#), (laenge% + 1) * 16 + 2)
          z% = InvInstr(text$, " ")
          IF z% > 0 THEN
               text$ = MID$(text$, z%)
          END IF
          laenge% = laenge% + 4
     END IF
    
     IF tpe% = FileType THEN
          laenge% = 8
     END IF
    
     Settext xpos%, ypos%, col%, STRING$(laenge%, 250)
     Settext xpos%, ypos%, col%, text$
  
     IF LEN(text$) = laenge% THEN
          count% = laenge% - 1
     ELSEIF LEN(text$) > laenge% THEN
          text$ = LEFT$(text$, laenge%): count% = laenge%
     ELSEIF LEN(text$) <> laenge% THEN
          count% = LEN(text$): text$ = text$ + STRING$(laenge% - LEN(text$), "˙")
     END IF
   
     LOCATE ypos%, xpos% + count%, 1, 0, 11
        
     DO
          DO
               key$ = INKEY$
               IF tpe% <> FileType AND key$ <> "" THEN EXIT DO
               IF LEN(key$) = 2 THEN EXIT DO
          LOOP UNTIL key$ <> "" AND tpe% = FileType AND LEN(key$) = 1 AND INSTR(datei$, UCASE$(key$)) <> 0

          IF tpe% = FileType THEN
               key$ = UCASE$(key$)
          END IF

          IF key$ = CHR$(8) AND count% > 0 THEN
               IF count% > 0 THEN
                    count% = count% - 1: LOCATE ypos%, xpos% + count%
               END IF

               text$ = LEFT$(text$, count%) + RIGHT$(text$, laenge% - 1 - count%)
               text$ = text$ + "˙"
               Settext xpos%, ypos%, col%, text$
               LOCATE ypos%, xpos% + count%
          END IF

          IF key$ = CHR$(27) THEN
               text$ = STRING$(laenge%, "˙")
               count% = 0
               LOCATE ypos%, xpos%: PRINT text$;
               LOCATE ypos%, xpos%
          END IF

          IF LEN(key$) = 1 AND count% < laenge% AND key$ <> CHR$(8) AND key$ <> CHR$(27) AND key$ <> CHR$(13) THEN
               text$ = LEFT$(text$, count%) + "˙" + RIGHT$(text$, laenge% - count%)
               text$ = LEFT$(text$, LEN(text$) - 1)
               MID$(text$, count% + 1) = key$
               Settext xpos%, ypos%, col%, text$
               IF (count% + 1) < laenge% THEN
                    count% = count% + 1
               END IF
               LOCATE ypos%, xpos% + count%
          ELSE
            
               SELECT CASE key$

                    CASE CHR$(0) + CHR$(77)
                        
                           IF count% + 1 < laenge% THEN
                              count% = count% + 1: LOCATE ypos%, xpos% + count%
                           END IF

                    CASE CHR$(0) + CHR$(75)

                          IF count% > 0 THEN
                              count% = count% - 1: LOCATE ypos%, xpos% + count%
                          END IF

                    CASE CHR$(0) + CHR$(82)

                         text$ = LEFT$(text$, count%) + "˙" + RIGHT$(text$, laenge% - count%)
                         text$ = LEFT$(text$, LEN(text$) - 1)
                         LOCATE ypos%, xpos%: PRINT text$;
                         LOCATE ypos%, xpos% + count%

                    CASE CHR$(0) + CHR$(83)
         
                         text$ = LEFT$(text$, count%) + RIGHT$(text$, laenge% - 1 - count%)
                         text$ = text$ + "˙"
                         LOCATE ypos%, xpos%: PRINT text$;
                         LOCATE ypos%, xpos% + count%

                    CASE ELSE

               END SELECT
          END IF
     LOOP UNTIL key$ = CHR$(13) OR key$ = CHR$(0) + CHR$(72) OR key$ = CHR$(0) + CHR$(80) OR key$ = CHR$(0) + CHR$(59) OR key$ = CHR$(0) + CHR$(60) OR key$ = CHR$(0) + CHR$(73) OR key$ = CHR$(0) + CHR$(80) OR key$ = CHR$(0) + CHR$(79)

     IF INSTR(text$, CHR$(250)) > 0 THEN
          text$ = LEFT$(text$, INSTR(text$, CHR$(250)) - 1)
     END IF
            
     IF LEN(key$) = 1 THEN
          back% = ASC(key$)
     ELSE
          back% = ASC(RIGHT$(key$, 1))
     END IF
  
    LOCATE ypos%, xpos%
  
     IF tpe% = NumType AND text$ <> "" THEN
         tnum& = VAL(text$)
         text$ = Formstr$(laenge%, tnum&)
         PRINT text$
     END IF

     IF tpe% = DateType AND text$ <> "" THEN
          text$ = CorrectDate$(text$): PRINT text$
          text$ = StringToDate$(text$)
     END IF
    
     IF tpe% = FloatType AND text$ <> "" THEN
          text$ = DMKonv$(text$, tlaenge%)
          PRINT text$
          IF text$ <> "" THEN
               IF LEFT$(text$, 1) = " " THEN MID$(text$, 1) = CHR$(255)
          END IF
     END IF
    
     IF tpe% = DMType AND text$ <> "" THEN
          text$ = DMKonv$(text$, (laenge% - 3) * 16 + 2)
          PRINT text$
          temp& = INT(VAL(PointKonv$(text$)) * 100)
          IF temp& < 0 THEN
               text$ = "-" + Formstr$(laenge% - 2, temp&)
          ELSE
               text$ = CHR$(255) + Formstr$(laenge% - 2, temp&)
          END IF
     END IF

     finput$ = text$
     LOCATE , , 0

END FUNCTION

FUNCTION FoldNotEmpty% (pfad$)

    attribute% = 16: dn$ = FSFirst(pfad$ + "\*.*", attribute%)
    IF attribute% = 16 AND dn$ = "." THEN
        attribute% = 16: dn$ = FSNext(attribute%)
        attribute% = 16: dn$ = FSNext(attribute%)
    END IF
    IF dn$ = "" THEN
        FoldNotEmpty% = 0
    ELSE
        FoldNotEmpty% = -1
    END IF

END FUNCTION

FUNCTION Formstr$ (anz%, Wert&)

     kn$ = STR$(Wert&)
     kn$ = RIGHT$(kn$, LEN(kn$) - 1)
     IF LEN(kn$) > anz% THEN
          kn$ = RIGHT$(kn$, anz)
     END IF
     temp$ = STRING$(anz% - LEN(kn$), "0") + kn$
     Formstr$ = temp$

END FUNCTION

FUNCTION formular% (form() AS formstruc, text() AS STRING)

     CONST col% = 7

     maxs% = UBOUND(form)

     DO
          text(count%) = finput$(form(count%).xpos, form(count%).ypos, form(count%).laenge, text(count%), form(count%).tpe, back%, col%)

          IF back% = ret OR back% = curdown THEN
               count% = count% + 1
               count% = count% MOD (maxs% + 1)
          END IF

          IF back% = curup THEN
               count% = count% - 1
               count% = (count% + maxs% + 1) MOD (maxs% + 1)
          END IF

     LOOP UNTIL back% = f1 OR back% = f2

     formular% = back%

END FUNCTION

FUNCTION FSFirst$ (pfad$, attribute%)

    temp$ = SPACE$(13)
    temp% = cfsfirst(pfad$ + CHR$(0), temp$, attribute%)
    IF temp% = 0 THEN FSFirst$ = "": EXIT FUNCTION
    temp$ = RTRIM$(temp$)
    FSFirst$ = LEFT$(temp$, LEN(temp$) - 1)
END FUNCTION

FUNCTION FSNext$ (attribute%)

    temp$ = SPACE$(13)
    temp% = cfsnext%(temp$, attribute%)
    IF temp% = 0 THEN FSNext$ = "": EXIT FUNCTION
    temp$ = RTRIM$(temp$)
    FSNext$ = LEFT$(temp$, LEN(temp$) - 1)
END FUNCTION

FUNCTION InvInstr% (text$, char$)

    FOR z% = 1 TO LEN(text$)
        IF MID$(text$, z%, 1) <> char$ THEN EXIT FOR
    NEXT z%
    IF z% = LEN(text$) + 1 THEN z% = 0
    InvInstr% = z%

END FUNCTION

FUNCTION InvRinstr% (text$, char$)
   
    FOR z% = LEN(text$) TO 1 STEP -1
        IF MID$(text$, z%, 1) <> char$ THEN EXIT FOR
    NEXT z%
    InvRinstr% = z%

END FUNCTION

SUB KoordTest
    
     x% = 1
     y% = 1
     DO
          DO
               key$ = INKEY$
          LOOP UNTIL key$ <> ""
          IF key$ = CHR$(0) + CHR$(curright) THEN
               x% = x% + 1
          END IF
          IF key$ = CHR$(0) + CHR$(curleft) THEN
               x% = x% - 1
          END IF
          IF key$ = CHR$(0) + CHR$(curup) THEN
               y% = y% - 1
          END IF
          IF key$ = CHR$(0) + CHR$(curdown) THEN
               y% = y% + 1
          END IF
          LOCATE 1, 1: PRINT x%, y%: LOCATE , , 1
          LOCATE y%, x%
     LOOP UNTIL key$ = CHR$(ret)
END SUB

FUNCTION max% (val1%, val2%)

    IF val1% >= val2% THEN
        max% = val1%
    ELSE
        max% = val2%
    END IF

END FUNCTION

FUNCTION min% (val1%, val2%)
   
    IF val1% <= val2% THEN
        min% = val1%
    ELSE
        min% = val2%
    END IF

END FUNCTION

SUB Pause (sekunden%)
    
     FOR z% = 1 TO sekunden%
          a$ = TIME$
          DO
          LOOP UNTIL a$ <> TIME$
     NEXT z%

END SUB

FUNCTION Perfmenu% (menuvar() AS menustructure, mtext() AS STRING, htext() AS STRING, phty AS INTEGER, c1%, c2%) STATIC
  
     ede% = UBOUND(menuvar)

     FOR z% = 0 TO ede%
          Settext menuvar(z%).xpos, menuvar(z%).ypos, c1%, mtext(z%)
     NEXT z%

     Settext menuvar(0).xpos, menuvar(0).ypos, c2%, mtext(0)
     Settext 2, phty, c2%, htext(0)
     count% = start%
 
     DO
          key$ = INKEY$
     
          IF key$ = CHR$(0) + CHR$(f2) THEN
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c1%, mtext(count%)
               count% = ede%
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c2%, mtext(count%)
               Settext 2, phty, c2%, htext(count%)
          END IF
       
          IF key$ = (CHR$(0) + CHR$(curdown)) OR key$ = (CHR$(0) + CHR$(curright)) OR key$ = " " THEN
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c1%, mtext(count%)
               count% = count% + 1
               count% = count% MOD (ede% + 1)
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c2%, mtext(count%)
               Settext 2, phty, c2%, htext(count%)
          END IF

          IF key$ = CHR$(0) + CHR$(curup) OR key$ = CHR$(0) + CHR$(curleft) OR key$ = CHR$(backspace) THEN
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c1%, mtext(count%)
               count% = count% - 1
               count% = (count% + ede% + 1) MOD (ede% + 1)
               Settext menuvar(count%).xpos, menuvar(count%).ypos, c2%, mtext(count%)
               Settext 2, phty, c2%, htext(count%)
          END IF

     LOOP UNTIL key$ = CHR$(0) + CHR$(f1) OR key$ = CHR$(ret)

     Settext menuvar(count%).xpos, menuvar(count%).ypos, c1%, mtext(count%)
     Perfmenu% = count%

END FUNCTION

FUNCTION PointKonv$ (test$)

    a% = INSTR(test$, ",")
    IF a% <> 0 THEN
        MID$(test$, a%) = "."
    END IF
    PointKonv$ = test$

END FUNCTION

FUNCTION round# (valuen#, nachstell%)

    value# = valuen#
    vorstell% = 11
    IF value# < 0 THEN vflag% = -1
    IF value# <= -1000000000# OR value# >= 1000000000# THEN
        round# = 0: EXIT FUNCTION
    END IF

    value# = INT(value# * 10 ^ nachstell% + .5)
    value$ = MID$(STR$(value#), 2)
    p% = INSTR(value$, ".")
    IF p% > 0 THEN
        value$ = LEFT$(value$, p%)
    END IF
    nk$ = RIGHT$(STRING$(20, "0") + value$, nachstell%)
    lennk% = LEN(RIGHT$(value$, nachstell%))
    vk$ = LEFT$(value$, LEN(value$) - lennk%)
    IF vk$ = "" THEN vk$ = "0"
    IF LEN(vk$) > vorstell% - 1 THEN
        vk$ = STRING$(vorstell% - 1, "*")
        nk$ = STRING$(nachstell%, "*")
    END IF
    IF vflag% THEN
        vk$ = "-" + vk$
    END IF
    round# = VAL(vk$ + "." + nk$)

END FUNCTION

SUB SetLine (x%, y%, col%, text$)
   
    CALL Settext(x%, y%, col%, text$ + SPACE$(81 - LEN(text$) - x%))

END SUB

SUB SetPal

    DIM pal%(0 TO 15)
    FOR pal% = 0 TO 15
        pal%(pal%) = pal%
    NEXT pal%
    PALETTE USING pal%(0)
    ERASE pal%

END SUB

SUB ShowDates (form() AS formstruc, text() AS STRING)
    
     DIM tex AS STRING

     FOR z% = 0 TO UBOUND(form)
          tex = text(z%)
          LOCATE form(z%).ypos, form(z%).xpos
       
          IF form(z%).tpe = FloatType THEN
               laenge% = form(z%).laenge
               vslaen% = laenge% \ 16
               nslaen% = laenge% MOD 16
               laenge% = vslaen% + 2 + nslaen%
          ELSE
               laenge% = form(z%).laenge
          END IF
          PRINT tex + STRING$(laenge% - LEN(tex), 250)
     NEXT z%
END SUB

FUNCTION StringToDate$ (text$)
    
     IF text$ <> "" THEN
          StringToDate$ = MID$(text$, 7, 4) + MID$(text$, 4, 2) + LEFT$(text$, 2)
     END IF

END FUNCTION

FUNCTION TotTime$

    ctext$ = SPACE$(26)
    CALL ctottime(ctext$)
    TotTime$ = LEFT$(ctext$, 24)

END FUNCTION

FUNCTION using$ (value#, vorstell%, nachstell%)
   
    DIM ue$(1 TO 10), nl$(0 TO 10)
   
    IF vorstell% > 11 THEN vorstell% = 11
    IF nachstell% > 5 THEN nachstell% = 5

    ue$(1) = " *,"
    ue$(2) = " **,"
    ue$(3) = " ***,"
    ue$(4) = " *.***,"
    ue$(5) = " **.***,"
    ue$(6) = " ***.***,"
    ue$(7) = " *.***.***,"
    ue$(8) = " **.***.***,"
    ue$(9) = " ***.***.***,"
    ue$(10) = "*.***.***.***,"

    nl$(1) = " 0,"
    nl$(2) = "  0,"
    nl$(3) = "   0,"
    nl$(4) = "     0,"
    nl$(5) = "      0,"
    nl$(6) = "       0,"
    nl$(7) = "         0,"
    nl$(8) = "          0,"
    nl$(9) = "           0,"
    nl$(10) = "             0,"
 
    nvalue# = value#
    IF nvalue# <= -10 ^ vorstell% THEN
        using$ = "-" + ue$(vorstell%) + STRING$(nachstell%, "*")
        EXIT FUNCTION
    END IF

    IF nvalue# >= 10 ^ vorstell% THEN
        using$ = " " + ue$(vorstell%) + STRING$(nachstell%, "*")
        EXIT FUNCTION
    END IF
 
    IF nvalue# < 0 THEN vz% = -1: nvalue# = ABS(nvalue#)               'Vorzeichen merken

    IF nvalue# = 0 THEN
        using$ = nl$(vorstell%) + STRING$(nachstell%, "0")
        EXIT FUNCTION
    END IF
 
    nvalue# = INT(nvalue# * 10 ^ nachstell% + .5)
    value$ = MID$(STR$(nvalue#), 2)
    p% = INSTR(value$, ".")
    IF p% > 0 THEN
        value$ = LEFT$(value$, p%)
    END IF
    nk$ = RIGHT$(STRING$(10, "0") + value$, nachstell%)
    lennk% = LEN(RIGHT$(value$, nachstell%))
    vk$ = LEFT$(value$, LEN(value$) - lennk%)
    IF vk$ = "" THEN vk$ = "0"

    orglenvk% = LEN(vk$)                                            'OriginallÑnge der VKS ohne Tausenderpunkte merken
    temp$ = vk$: vk$ = ""                                           'Tausenderpunkte einfÅgen

    ltemp% = LEN(temp$)
    FOR z% = 0 TO ltemp% - 1
        IF z% = 3 OR z% = 6 OR z% = 9 OR z% = 12 THEN
            vk$ = "." + vk$
        END IF
        vk$ = MID$(temp$, ltemp% - z%, 1) + vk$
    NEXT z%

    vorstell% = vorstell% + (INT((vorstell% - 1) / 3))
    temp$ = SPACE$(vorstell% - LEN(vk$))
 
    IF vz% = -1 THEN
        vk$ = "-" + vk$
    ELSE
        vk$ = " " + vk$
    END IF
    using$ = temp$ + vk$ + "," + nk$

END FUNCTION

FUNCTION ZerKill$ (text$)

    ps% = rinstr(text$, "˙"): IF ps% > LEN(text$) THEN ps% = 0
    ZerKill$ = LEFT$(text$, ps%)

END FUNCTION

