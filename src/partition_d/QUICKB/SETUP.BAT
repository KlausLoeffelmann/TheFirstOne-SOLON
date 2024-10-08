ECHO OFF
IF "%1" == "" GOTO VerwendungEnde
IF "%2" == "" GOTO VerwendungEnde
%1
IF EXIST %2\*.* GOTO AusfSetup
md %2
:AusfSetup
copy a:*.bat
CLS
ECHO �
ECHO Beachten Sie bitte, da� ungef�hr 1 MegaByte auf Ihrer Festplatte
ECHO frei sein mu�; falls Sie weniger als 1 MegaByte haben, beenden Sie
ECHO SETUP und kopieren nur die Dateien, die Sie wirklich ben�tigen.
ECHO �
setup1 %1 %2 %3 %4

:VerwendungEnde
CLS
ECHO Verwendung:   A:SETUP Laufwerk  Arbeitsverz  [ExeVerz [BibVerz] ]
ECHO �
ECHO Wobei
ECHO       Laufwerk       Laufwerk auf dem QuickBASIC installiert
ECHO                      werden soll                        (Bsp: C:)
ECHO       Arbeitsverz    Pfadname, der angibt wohin das QuickBASIC
ECHO                      Quellprogramm kopiert werden soll  (Bsp: \QB4)
ECHO       ExeVerz        Pfadname, der angibt wo die ausf�hrbaren
ECHO                      Dateien abgelegt werden sollen     (Bsp: \BIN)
ECHO       BibVerz        Pfadname, der angibt wo die Bibliotheksdateien
ECHO                      abgelegt werden sollen             (Bsp: \LIB)
ECHO �
ECHO Beispiele :   a:setup c: \qb4 \bin \lib
ECHO               a:setup c: \qb4   (kopiert ALLE Dateien nach c:\qb4)
ECHO �
ECHO Hinweis: Diese Setup-Batch-Datei beabsichtigt nur, Sie beim
ECHO          installieren von QuickBASIC auf Ihrer Festplatte zu
ECHO          unterst�tzen. Ihre Verwendung ist wahlfrei; Sie k�nnen
ECHO          auch einfach alle Dateien in ein Verzeichnis(se) Ihrer
ECHO          Wahl kopieren.  Wenn Sie keine Festplatte haben, lesen Sie
ECHO          den Abschnitt "QuickBASIC installieren: Auf Diskette" in
ECHO          "Lernen und Anwenden von QuickBASIC".
