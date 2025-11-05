'$INCLUDE: 'd:\quickb\mylib.bi'

FUNCTION alert% (text$, default%, lin%, menue$, col%, revcol%)
        CONST KeyCurLeft = 75
        CONST KeyCurRight = 77
        CONST KeyRet = 13
     
        DIM men$(0 TO 3), char$(0 TO 3)
     
        menue$ = menue$ + "|"
        text$ = LEFT$(text$, 40)

        Count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND Count% <= 4
            ps2% = INSTR(ps%, menue$, "|")
            IF ps2% = 0 THEN EXIT DO
            men$(Count%) = SPACE$(8)
            temp$ = MID$(menue$, ps%, ps2% - ps%)
            MID$(men$(Count%), 5 - LEN(temp$) / 2) = temp$
            char$(Count%) = UCASE$(LEFT$(temp$, 1))
            Count% = Count% + 1
            ps% = ps2% + 1
        LOOP
     
        IF Count% = 0 THEN alter% = -1: EXIT FUNCTION

        SetLine 1, lin%, col%, text$

        FOR z% = 0 TO Count%
            CALL Settext(z% * 9 + 40, lin%, col%, men$(z%))
        NEXT z%

        MenPoint% = default%                                        'Menuezeiger auf Defaultwert setzten
     
        DO
            temp$ = men$(MenPoint%)
            CALL Settext(MenPoint% * 9 + 40, lin%, revcol%, temp$)
         
            DO
                c$ = ink$
            LOOP UNTIL c$ <> ""
     
            CALL Settext(MenPoint% * 9 + 40, lin%, col%, temp$)
        
            FOR z% = 0 TO Count%                                    'Auf Menue-Anfangsbuchstaben prÅfenAnf
                IF UCASE$(c$) = char$(z%) THEN EXIT FOR
            NEXT z%
            IF z% < Count% + 1 THEN
                MenPoint% = z%
            END IF

            IF c$ = CHR$(0) + CHR$(KeyCurRight) THEN
                MenPoint% = MenPoint% + 1
                MenPoint% = MenPoint% MOD Count%

            ELSEIF c$ = CHR$(0) + CHR$(KeyCurLeft) THEN
                MenPoint% = MenPoint% + Count% - 1
                MenPoint% = MenPoint% MOD Count%
                        
            END IF
    
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

        Count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND Count% <= 6
            ps2% = INSTR(ps%, text$, "|")
            IF ps2% = 0 THEN EXIT DO
            tline$(Count%) = MID$(text$, ps%, ps2% - ps%)
            Breite% = max(Breite%, LEN(tline$(Count%)))
            Count% = Count% + 1
            ps% = ps2% + 1
        LOOP
        TCount% = Count% - 1

        Count% = 0: ps% = 1
        DO WHILE ps% <> 0 AND Count% <= 4
            ps2% = INSTR(ps%, menue$, "|")
            IF ps2% = 0 THEN EXIT DO
            men$(Count%) = MID$(menue$, ps%, ps2% - ps%)
            char$(Count%) = UCASE$(LEFT$(men$(Count%), 1))
            men$(Count%) = " " + men$(Count%) + " "
            tb% = max(tb%, LEN(men$(Count%)))
            Count% = Count% + 1
            ps% = ps2% + 1
        LOOP
        Count% = Count% - 1

        FOR z% = 0 TO Count%
            temp$ = SPACE$(tb%)
            MID$(temp$, 1 + tb% / 2 - LEN(men$(z%)) / 2) = men$(z%)
            men$(z%) = temp$
        NEXT z%
       
        Breite% = max(Breite%, (Count% + 1) * tb%)
        Menx% = 40 - ((Count% + 1) * tb%) / 2

        IF Count% = 0 THEN balert% = -1: EXIT FUNCTION

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
       
        FOR z% = 0 TO Count%
            Settext Menx% + z% * tb%, al%, col%, men$(z%)
        NEXT z%
       
        MenPoint% = default%                                        'Menuezeiger auf Defaultwert setzten
     
        DO
         
            Settext MenPoint% * tb% + Menx%, al%, revcol%, men$(MenPoint%)
         
            DO
                c$ = ink$
            LOOP UNTIL c$ <> ""
     
            Settext MenPoint% * tb% + Menx%, al%, col%, men$(MenPoint%)
        
            FOR z% = 0 TO Count%                                    'Auf Menue-Anfangsbuchstaben prÅfenAnf
                IF UCASE$(c$) = char$(z%) THEN EXIT FOR
            NEXT z%
            IF z% < Count% + 1 THEN
                MenPoint% = z%
            END IF

            SELECT CASE c$

                CASE CHR$(0) + CHR$(KeyCurRight)
                    MenPoint% = MenPoint% + 1
                    MenPoint% = MenPoint% MOD (Count% + 1)

                CASE CHR$(0) + CHR$(KeyCurLeft)
                    MenPoint% = MenPoint% + Count%
                    MenPoint% = MenPoint% MOD (Count% + 1)
            
                CASE ELSE
    
            END SELECT
    
        LOOP UNTIL c$ = CHR$(KeyRet)

        balert% = MenPoint%
       
        rebuild 1

END FUNCTION

SUB ClrScr
  
    COLOR 15, 0

    CLS

END SUB

FUNCTION DMKonv$ (text$, laenge%)

    vorstell% = laenge% \ 16
    nachstell% = laenge% MOD 16
   
    IF vorstell% > 11 THEN vorstell% = 11
    IF nachstell% > 5 THEN nachstell% = 5
    
    text$ = PointKonv$(text$)

    value# = VAL(text$): IF value# < 0 THEN vflag% = -1
    IF value# <= -1000000000# OR value# >= 1000000000# THEN
        DMKonv$ = STRING$(vorstell%, "*") + "," + STRING$(nachstell%, "*")
    END IF

    value# = INT(value# * 10 ^ nachstell% + .50005)
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
    ELSE
        vk$ = " " + vk$
    END IF
    vk$ = SPACE$(vorstell% - LEN(vk$)) + vk$
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
                ELSE
                    EraseMP ordner$ + "\" + dn$, joker$
                END IF
            ELSE
                KILL joker$
            END IF
        LOOP UNTIL NOT exist%(ordner$, 16)
        CHDIR ".."
        RMDIR ordner$
    END IF
END SUB

FUNCTION exist% (datei$, att%)

    IF cexist(datei$ + CHR$(0), att%) = 1 THEN
        exist% = -1
    ELSE
        exist% = 0
    END IF

END FUNCTION

FUNCTION finput$ (xpos%, ypos%, laenge%, text$, tpe%, back%, col%) STATIC

     IF tpe% = 5 THEN
        IF exist("C:\solon\finput.txt", 0) THEN
            OPEN "C:\solon\finput.txt" FOR INPUT AS 1
            LINE INPUT #1, text$
            CLOSE 1
            text$ = LEFT$(text$, laenge%)
        END IF
     END IF
    
     IF tpe% = 2 THEN
        vslaen% = laenge% \ 16
        nslaen% = laenge% MOD 16
        laenge% = vslaen% + 1 + nslaen%
     END IF

     COLOR col% MOD 16, INT(col% / 16)
    
     LOCATE ypos%, xpos%: PRINT STRING$(laenge%, "˙")
     LOCATE ypos%, xpos%: PRINT text$;
  
     IF LEN(text$) = laenge% THEN
          Count% = laenge% - 1
     ELSEIF LEN(text$) > laenge% THEN
          text$ = LEFT$(text$, laenge%): Count% = laenge%
     ELSEIF LEN(text$) <> laenge% THEN
          Count% = LEN(text$): text$ = text$ + STRING$(laenge% - LEN(text$), "˙")
     END IF
   
     LOCATE ypos%, xpos% + Count%, 1, 0, 11
        
     DO

lab1:
          DO
               key$ = ink$
          LOOP UNTIL key$ <> ""
          IF tpe% = 6 THEN
              IF key$ = "." OR key$ = "," OR key$ = "\" OR key$ = ";" OR key$ = "*" OR key$ = "?" THEN GOTO lab1
          END IF
          IF key$ = CHR$(8) AND Count% > 0 THEN
                       
               IF Count% > 0 THEN
                    Count% = Count% - 1: LOCATE ypos%, xpos% + Count%
               END IF

               text$ = LEFT$(text$, Count%) + RIGHT$(text$, laenge% - 1 - Count%)
               text$ = text$ + "˙"
               LOCATE ypos%, xpos%: PRINT text$;
               LOCATE ypos%, xpos% + Count%

          END IF

          IF key$ = CHR$(27) THEN

               text$ = STRING$(laenge%, "˙")
               Count% = 0
               LOCATE ypos%, xpos%: PRINT text$;
               LOCATE ypos%, xpos%
          END IF

          IF LEN(key$) = 1 AND Count% < laenge% AND key$ <> CHR$(8) AND key$ <> CHR$(27) AND key$ <> CHR$(13) THEN
            
                text$ = LEFT$(text$, Count%) + "˙" + RIGHT$(text$, laenge% - Count%)
                text$ = LEFT$(text$, LEN(text$) - 1)
               MID$(text$, Count% + 1) = key$
               LOCATE ypos%, xpos%: PRINT text$;
               IF (Count% + 1) < laenge% THEN
                    Count% = Count% + 1
               END IF
               LOCATE ypos%, xpos% + Count%
       
          ELSE
            
               SELECT CASE key$

                    CASE CHR$(0) + CHR$(77)
                        
                           IF Count% + 1 < laenge% THEN
                              Count% = Count% + 1: LOCATE ypos%, xpos% + Count%
                           END IF

                    CASE CHR$(0) + CHR$(75)

                          IF Count% > 0 THEN
                              Count% = Count% - 1: LOCATE ypos%, xpos% + Count%
                          END IF

                    CASE CHR$(0) + CHR$(82)

                         text$ = LEFT$(text$, Count%) + "˙" + RIGHT$(text$, laenge% - Count%)
                         text$ = LEFT$(text$, LEN(text$) - 1)
                         LOCATE ypos%, xpos%: PRINT text$;
                         LOCATE ypos%, xpos% + Count%

                    CASE CHR$(0) + CHR$(83)
         
                         text$ = LEFT$(text$, Count%) + RIGHT$(text$, laenge% - 1 - Count%)
                         text$ = text$ + "˙"
                         LOCATE ypos%, xpos%: PRINT text$;
                         LOCATE ypos%, xpos% + Count%

                      
                    CASE ELSE

                    END SELECT



          END IF

     LOOP UNTIL key$ = CHR$(13) OR key$ = CHR$(0) + CHR$(72) OR key$ = CHR$(0) + CHR$(80) OR key$ = CHR$(0) + CHR$(59) OR key$ = CHR$(0) + CHR$(60) OR key$ = CHR$(0) + CHR$(73) OR key$ = CHR$(0) + CHR$(80) OR key$ = CHR$(0) + CHR$(79)

     FOR x% = LEN(text$) TO 1 STEP -1
          IF MID$(text$, x%, 1) <> "˙" THEN
               EXIT FOR
          END IF
     NEXT x%

     text$ = LEFT$(text$, x%)

            
     IF LEN(key$) = 1 THEN
          back% = ASC(key$)
     ELSE
          back% = ASC(RIGHT$(key$, 1))
     END IF
  
    LOCATE ypos%, xpos%
  
     IF tpe% = 1 AND text$ <> "" THEN
         tnum& = VAL(text$)
         text$ = Formstr$(laenge%, tnum&)
         PRINT text$
     END IF

    IF tpe% = 2 AND text$ <> "" THEN
        text$ = DMKonv$(text$, vslaen% * 16 + nslaen%)
        PRINT text$
    END IF
    
    IF tpe% = 5 THEN
        OPEN "C:\solon\finput.txt" FOR OUTPUT AS 1
        PRINT #1, text$
        CLOSE 1
        text$ = LEFT$(text$, laenge%)
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
     Formstr$ = STRING$(anz% - LEN(kn$), "0") + kn$

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

FUNCTION ink$

    IF isinp% <> 0 THEN
        k% = readasc%
        IF (k% AND 255) = 0 THEN
            ink$ = CHR$(0) + CHR$(shiftleft(k%))
        ELSE
            ink$ = CHR$(k% AND 255)
        END IF
    END IF

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

FUNCTION kstring$ (text$)

    konvstring (text$)
    kstring$ = text$

END FUNCTION

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

FUNCTION oz$ (text$)

    FOR z% = 1 TO LEN(text$)
        IF MID$(text$, z%, 1) = "0" THEN
            temp$ = temp$ + " "
        ELSE
            temp$ = temp$ + MID$(text$, z%)
            EXIT FOR
        END IF
    NEXT z%
    oz$ = temp$
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

    value# = INT(value# * 10 ^ nachstell% + .50001)
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

