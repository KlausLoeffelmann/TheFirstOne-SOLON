'$INCLUDE: 'd:\quickb\loewe_b.bi'
'$INCLUDE: 'd:\quickb\loewepd.bi'


DIM SHARED PullDown$(8, 20)
DIM SHARED Key$(8, 20)
DIM SHARED menpos(8) AS PdMenueStruc
DIM SHARED AnzEntry%(8)
DIM SHARED AnzTit%

SUB Menu (pd$()) STATIC

     curx% = POS(0)
     cury% = CSRLIN
     repout 1, 1, 32, 80, INVERS
     entrycount% = 1: Titelcount% = 1
     xcount% = 3                                                 'PositionszÑhler fÅr Titeltexte
     FOR z% = 1 TO UBOUND(pd$) - 1 STEP 2
          IF titprtflag% = 0 THEN
               titprtflag% = -1
               Settext xcount%, 1, INVERS, pd$(z%)
               menpos(Titelcount%).titx = xcount% - 1
               menpos(Titelcount%).framex = xcount% - 2         'Position der linken, oberen Ecke
               menpos(Titelcount%).framey = 2                   'des Pull-Down-Menues
               menpos(Titelcount%).framex = max(menpos(Titelcount%).framex, 1)
               xcount% = xcount% + LEN(pd$(z%)) + 2
          END IF
          IF LEFT$(pd$(z%), 1) = "#" THEN
               menpos(Titelcount%).framew = breite% + 2          'Breite des Pull-Down-Menues
               menpos(Titelcount%).frameh = entrycount%          'Hîhe des Pull-Down-Menues
               IF menpos(Titelcount%).framew + menpos(Titelcount%).framex > 80 THEN
                    menpos(Titelcount%).framex = 80 - menpos(Titelcount%).framew
               END IF
               breite% = 0
               AnzEntry%(Titelcount%) = entrycount% - 1          'Anzahl EintraÑge im Pull-Down-Menue
               entrycount% = 1                                   'EintragszÑhler zurÅcksetzen
               Titelcount% = Titelcount% + 1                     'TitelzÑhler erhîhen
               IF MID$(pd$(z%), 2, 1) = "#" THEN EXIT FOR
               titprtflag% = 0
          ELSE
               IF entrycount% = 1 THEN
                    PullDown$(Titelcount%, entrycount%) = " " + pd$(z%) + " "'EintrÑge in Pull-Down-Menue-Array Åbernehmen
               ELSE
                    PullDown$(Titelcount%, entrycount%) = "  " + pd$(z%)
               END IF
               Key$(Titelcount%, entrycount%) = pd$(z% + 1)      'relevante Tasten in Tastenspeicher Åbernehmen
               breite% = max(LEN(pd$(z%)) + 2, breite%)            'breitesten Eintrag des Menues ermitteln
               entrycount% = entrycount% + 1
          END IF
     NEXT z%
   
     AnzTit% = Titelcount% - 1
     PRINT AT$(curx%, cury%);

END SUB

SUB MenuICheck (titel%, entry%, flag%)
     IF flag% = TRUE THEN
          MID$(PullDown$(titel%, entry%), 1) = CHR$(251)
     ELSE
          MID$(PullDown$(titel%, entry%), 1) = CHR$(32)
     END IF
END SUB

SUB MenuIEnable (titel%, entry%, flag%)
     IF flag% = TRUE THEN
          MID$(PullDown$(titel%, entry%), 2) = CHR$(255)
     ELSE
          MID$(PullDown$(titel%, entry%), 2) = CHR$(32)
     END IF
END SUB

FUNCTION MenuT$ (titel%, entry%)
     MenuT$ = MID$(PullDown$(titel%, entry%), 3)
END FUNCTION

FUNCTION OnMenue% (t%, e%)
    
     DO WHILE isinp% <> 0: d% = readasc%: LOOP
    
     k$ = ShiftGet$(ALTERNATE)
     IF k$ <> "" THEN
          IF k$ <> CHR$(0) + CHR$(0) THEN
               FOR z% = 1 TO AnzTit%
                    IF k$ = Key$(z%, 1) THEN EXIT FOR
               NEXT z%
               IF z% = AnzTit% + 1 THEN EXIT FUNCTION
               pdnr% = z%
               pdo% = TRUE
          ELSE
               pdnr% = 1
               pdo% = FALSE
          END IF
               
          IF pdo% = FALSE THEN
               Settext menpos(pdnr%).titx, 1, NORMAL, PullDown$(pdnr%, 1)
               DO
                    QuitLoop% = FALSE
                    DO
                         k$ = INKEY$
                         IF k$ <> "" THEN
                              QuitLoop% = TRUE
                              Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
                              EXIT DO
                         END IF
                         k$ = ShiftGet$(ALTERNATE)
                         IF k$ = CHR$(0) + CHR$(0) THEN
                              Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
                              EXIT FUNCTION
                         ELSEIF k$ <> "" THEN
                              Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
                              QuitLoop% = TRUE
                         END IF
                    LOOP UNTIL QuitLoop%
                   
                    IF k$ = CHR$(escape) THEN Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1): EXIT FUNCTION
                    IF k$ = CHR$(13) THEN pdo% = TRUE: Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1): EXIT DO
                    IF k$ = CHR$(0) + CHR$(kcurdown) THEN pdo% = TRUE: Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1): EXIT DO
                    IF k$ = CHR$(0) + CHR$(kcurright) THEN
                         Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
                         pdnr% = range(pdnr% + 1, AnzTit%)
                         Settext menpos(pdnr%).titx, 1, NORMAL, PullDown$(pdnr%, 1)
                   
                    ELSEIF k$ = CHR$(0) + CHR$(kcurleft) THEN
                         Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
                         pdnr% = range(pdnr% - 1, AnzTit%)
                         Settext menpos(pdnr%).titx, 1, NORMAL, PullDown$(pdnr%, 1)
                    ELSEIF QuitLoop% THEN
                         FOR z% = 1 TO AnzTit%
                              IF k$ = Key$(z%, 1) THEN EXIT FOR
                         NEXT z%
                         IF z% = AnzTit% + 1 THEN EXIT FUNCTION
                         pdnr% = z%
                         pdo% = TRUE
                         EXIT DO
                    END IF
               LOOP
               Settext menpos(pdnr%).titx, 1, INVERS, PullDown$(pdnr%, 1)
          END IF
              
          IF pdo% = TRUE THEN
               entry% = 2
               ShowMenue pdnr%
               DO
                    DO
                         k$ = INKEY$
                    LOOP UNTIL k$ <> ""
                    IF k$ = CHR$(escape) THEN UnshowMenue pdnr%: EXIT FUNCTION
                   
                    IF k$ = CHR$(13) THEN
                         OnMenue% = TRUE
                         e% = entry%
                         t% = pdnr%
                         UnshowMenue pdnr%
                         EXIT FUNCTION
                    END IF

                    IF k$ = CHR$(0) + CHR$(kcurright) THEN
                         UnshowMenue pdnr%
                         pdnr% = range(pdnr% + 1, AnzTit%)
                         ShowMenue pdnr%
                         entry% = 2
                    END IF
                   
                    IF k$ = CHR$(0) + CHR$(kcurleft) THEN
                         UnshowMenue pdnr%
                         pdnr% = range(pdnr% - 1, AnzTit%)
                         ShowMenue pdnr%
                         entry% = 2
                    END IF
                   
                    IF k$ = CHR$(0) + CHR$(kcurdown) THEN
                         Settext menpos(pdnr%).framex + 1, entry% + 1, NORMAL, PdText$(pdnr%, entry%)
                         entry% = range(entry%, AnzEntry%(pdnr%) - 1) + 1
                         DO WHILE PullDown$(pdnr%, entry%) = "  ----"
                              entry% = range(entry%, AnzEntry%(pdnr%) - 1) + 1
                         LOOP
                         Settext menpos(pdnr%).framex + 1, entry% + 1, INVERS, PdText$(pdnr%, entry%)
                    END IF

                    IF k$ = CHR$(0) + CHR$(kcurup) THEN
                         Settext menpos(pdnr%).framex + 1, entry% + 1, NORMAL, PdText$(pdnr%, entry%)
                         entry% = range(entry% - 2, AnzEntry%(pdnr%) - 1) + 1
                         DO WHILE PullDown$(pdnr%, entry%) = "  ----"
                              entry% = range(entry% - 2, AnzEntry%(pdnr%) - 1) + 1
                         LOOP
                         Settext menpos(pdnr%).framex + 1, entry% + 1, INVERS, PdText$(pdnr%, entry%)
                    END IF
               LOOP
               UnshowMenue pdnr%
          END IF
     END IF
END FUNCTION

FUNCTION PdText$ (titel%, entry%)
     PdText$ = PullDown$(titel%, entry%) + SPACE$(menpos(titel%).framew - LEN(PullDown$(titel%, entry%)) - 2)
END FUNCTION

SUB ShowMenue (titel%)

     x% = menpos(titel%).framex: y% = menpos(titel%).framey
     x2% = x% + menpos(titel%).framew - 1: y2% = y% + menpos(titel%).frameh - 1
     makewin 1, x%, y%, x2%, y2%, 32
     frame x%, y%, x2%, y2%, NORMAL
     xs1% = menpos(titel%).titx
     xs2% = xs1% + LEN(PullDown$(titel%, 1)) - 1
     Settext xs1%, 1, NORMAL, CHR$(179): Settext xs2%, 1, NORMAL, CHR$(179)
     Settext xs1%, 2, NORMAL, CHR$(193): Settext xs2%, 2, NORMAL, CHR$(193)
     FOR z% = 2 TO AnzEntry%(titel%)
          IF MID$(PullDown$(titel%, z%), 3) = "----" THEN
               Settext x%, 1 + z%, NORMAL, CHR$(195) + STRING$(menpos(titel%).framew - 2, 196) + CHR$(180)
          ELSE
               Settext x% + 1, 1 + z%, NORMAL, PdText$(titel%, z%)
          END IF
     NEXT z%
     Settext x% + 1, 3, INVERS, PdText$(titel%, 2)
END SUB

SUB UnshowMenue (titel%)
    
     rebuild 1
     xs1% = menpos(titel%).titx
     xs2% = xs1% + LEN(PullDown$(titel%, 1)) - 1
     Settext xs1%, 1, INVERS, " ": Settext xs2%, 1, INVERS, " "

END SUB

