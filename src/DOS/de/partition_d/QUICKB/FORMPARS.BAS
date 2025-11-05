DECLARE FUNCTION funktionswert# (funktion$, mel$)
'*******************************************************************
'*** Formelparser, Funktionsauswertungsroutine *********************
'*******************************************************************

'Aufruf: funktionswert(funktions$,mel$)

'Parameter: funktions$: Textvariable, die die komplette Formel enthÑlt

'           mel$:       Textvariable die zurÅckgegeben wird, und die
'                       etwaige Fehlermeldungen enthÑlt.


DECLARE SUB VorzeichenFiltern (eval$)
DECLARE FUNCTION FEvaluate# (eval$)
DECLARE SUB transformiere ()
DECLARE FUNCTION OAuswerten# (OpString$)

DIM SHARED zeichen$, AltZeichen$, Pruefe$, FunkName$
DIM SHARED KBeg%, KEnd%, KLen%, KTerm%, KWert#, FunktionGefunden%
DIM SHARED LinkerAusdruck$, RechterAusdruck$, LinkerTerm$
DIM SHARED LEval$, Pos1%, Konst%, Ergebnis#, Fertig%, AnzOperatoren%
DIM SHARED LinkerWert#, LinkerRest$, RechterWert#, RechterRest$
DIM SHARED operator$(4), meldung$

CONST TRUE = -1, false = 0

FUNCTION FEvaluate# (eval$)

        Pos1% = INSTR(eval$, ")")
       
        WHILE Pos1%
                FOR i% = Pos1% - 1 TO 1 STEP -1
                        zeichen$ = MID$(eval$, i%, 1)
                        IF zeichen$ = "(" THEN EXIT FOR
                NEXT i%
                IF i% < 1 THEN meldung$ = "'Klammer auf' fehlt": FEvaluate = 1: EXIT FUNCTION

                KBeg% = i%
                KEnd% = Pos1%
                KLen% = KEnd% - KBeg% - 1
                KTerm$ = MID$(eval$, KBeg% + 1, KLen%)
                KWert# = OAuswerten(KTerm$)
                '
                IF KBeg% >= 3 THEN
                        IF KBeg% = 3 THEN FunkName$ = MID$(eval$, 1, 3) ELSE FunkName$ = MID$(eval$, KBeg% - 3, 3)
                ELSE
                        FunkName$ = ""
                END IF
                FunktionGefunden% = TRUE
                transformiere

                IF FunktionGefunden% THEN
                        eval$ = LEFT$(eval$, KBeg% - 4) + STR$(KWert#) + MID$(eval$, KEnd% + 1)
                ELSE
                        eval$ = LEFT$(eval$, KBeg% - 1) + STR$(KWert#) + MID$(eval$, KEnd% + 1)
                END IF
                Pos1% = INSTR(eval$, ")")
        WEND

        IF INSTR(eval$, "(") THEN
                meldung$ = "'Klammer zu' fehlt"
                FEvaluate = 1
                EXIT FUNCTION
        END IF

        z# = OAuswerten#(eval$)
        FEvaluate# = z#

END FUNCTION

FUNCTION funktionswert# (funktion$, mel$) STATIC

        IF funktionsflag% = false THEN
                operator$(1) = "^"
                operator$(2) = "*/"
                operator$(3) = "\"
                operator$(4) = "#~"
                funktionsflag% = TRUE
        END IF
        '
        meldung$ = ""
        '
        FOR z% = 1 TO LEN(funktion$)
            c$ = MID$(funktion$, z%, 1)
            IF c$ = "∫" THEN EXIT FOR
            IF c$ = "," THEN MID$(funktion$, z%) = "."
        NEXT z%
        funktion$ = UCASE$(funktion$)
        VorzeichenFiltern funktion$
        funktionswert# = FEvaluate(funktion$)
        mel$ = meldung$

END FUNCTION

FUNCTION OAuswerten# (OpString$)

        FOR i% = 1 TO 4
                j% = 0
                DO
                        j% = j% + 1
                        zeichen$ = MID$(OpString$, j%, 1)
                        IF INSTR(operator$(i%), zeichen$) THEN
                                RechterAusdruck$ = ""
                                FOR k% = j% + 1 TO LEN(OpString$)
                                        Pruefe$ = MID$(OpString$, k%, 1)
                                        IF INSTR("#~*/^\", Pruefe$) THEN EXIT FOR
                                        RechterAusdruck$ = RechterAusdruck$ + Pruefe$
                                NEXT k%
                                RechterRest$ = MID$(OpString$, k%)
                                '
                                LinkerAusdruck$ = ""
                               
                                FOR k% = j% - 1 TO 1 STEP -1
                                        Pruefe$ = MID$(OpString$, k%, 1)
                                        IF INSTR("#~*/^\", Pruefe$) THEN EXIT FOR
                                        LinkerAusdruck$ = Pruefe$ + LinkerAusdruck$
                                NEXT k%
                                LinkerRest$ = LEFT$(OpString$, k%)
                                '
                                LinkerWert# = VAL(LinkerAusdruck$)
                                RechterWert# = VAL(RechterAusdruck$)
                                '
                                IF zeichen$ = "#" THEN
                                        Ergebnis# = LinkerWert# + RechterWert#
                                ELSEIF zeichen$ = "~" THEN
                                        Ergebnis# = LinkerWert# - RechterWert#
                                ELSEIF zeichen$ = "*" THEN
                                        Ergebnis# = LinkerWert# * RechterWert#
                                ELSEIF zeichen$ = "/" THEN
                                        IF RechterWert# = 0 THEN
                                                meldung$ = "Division durch 0"
                                                OAuswerten = 1
                                                EXIT FUNCTION
                                        ELSE
                                                Ergebnis# = LinkerWert# / RechterWert#
                                        END IF

                                ELSEIF zeichen$ = "\" THEN
                                        IF RechterWert# = 0 THEN
                                                meldung$ = "Division durch 0"
                                                OAuswerten = 1
                                                EXIT FUNCTION
                                        ELSE
                                                Ergebnis# = LinkerWert# \ RechterWert#
                                        END IF

                                ELSEIF zeichen$ = "^" THEN
                                        Ergebnis# = LinkerWert# ^ RechterWert#
                                END IF

                                LinkerTerm$ = LinkerRest$ + STR$(Ergebnis#)
                                OpString$ = LinkerTerm$ + RechterRest$
                                j% = LEN(LinkerTerm$)
                        END IF
                LOOP UNTIL j% = LEN(OpString$)
        NEXT i%
        OAuswerten# = VAL(OpString$)
END FUNCTION

SUB replace (such$, ersatz$, org$)

        Pos1% = INSTR(org$, such$)
        WHILE Pos1%
                org$ = LEFT$(org$, Pos1% - 1) + ersatz$ + MID$(org$, Pos1% + LEN(such$))
                Pos1% = INSTR(org$, such$)
        WEND

END SUB

SUB transformiere

        SELECT CASE FunkName$

        CASE "INT": KWert# = INT(KWert#)

        CASE "FIX": KWert# = FIX(KWert#)

        CASE "FRC": KWert# = FRAC(KWert#)

        CASE "ABS": KWert# = ABS(KWert#)

        CASE "SGN": KWert# = SGN(KWert#)

        CASE "SQR": KWert# = SQR(KWert#)

        CASE "EXP": KWert# = EXP(KWert#)

        CASE "LGN": KWert# = LOG(KWert#)

        CASE "SIN": KWert# = SIN(KWert#)

        CASE "COS": KWert# = COS(KWert#)

        CASE "TAN": KWert# = TAN(KWert#)

        CASE ELSE: FunktionGefunden% = false

        END SELECT

END SUB

SUB VorzeichenFiltern (eval$)

        Fertig% = false

        DO
                IF INSTR(eval$, "()") THEN
                        meldung$ = "UnzulÑssige Klammersetzung"
                        eval$ = "1"
                ELSE
                        Fertig% = TRUE
                END IF
        LOOP UNTIL Fertig%

        AltZeichen$ = "*"
        FOR i% = 1 TO LEN(eval$)
                zeichen$ = MID$(eval$, i%, 1)
                IF zeichen$ = "+" OR zeichen$ = "-" THEN
                        IF INSTR("#~*/^(\", AltZeichen$) = 0 THEN
                                IF zeichen$ = "+" THEN
                                        MID$(eval$, i%) = "#"
                                ELSE
                                        MID$(eval$, i%) = "~"
                                END IF
                        END IF
                END IF
                AltZeichen$ = MID$(eval$, i%, 1)
        NEXT i%

END SUB

