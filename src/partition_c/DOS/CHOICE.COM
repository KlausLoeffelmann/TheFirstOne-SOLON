�JN                                                                                                                                Wartet auf die Auswahl des Benutzers der angezeigten Optionen.

 CHOICE [/C[:]Tasten] [/N] [/S] [/T[:]c,nn] [Text]

 /C[:]Tasten  Angabe der zul�ssigen Tasten. Standard ist JN.
/N           Keine Anzeige eines ?-Zeichens am Ende der Meldung.
/S           Gro�-/Kleinschreibung f�r Tasten wird beachtet.
/T[:]c,nn    Nach nn Sekunden wird Standardauswahl c ausgef�hrt.
Text         Meldung, die angezeigt wird.

ERRORLEVEL ist auf die Position der gedr�ckten Taste aus der
Tastenauswahl gesetzt.

 Ung�ltige Einstellung in der Befehlszeile. Erwartete Form:
     CHOICE: Ung�ltige Syntax der Tasteneinstellung. Erwartete Form: /C[:]Tasten
 CHOICE: Ung�ltige Wartezeit-Syntax.  Erwartete Form Tc,nn oder T:c,nn.
 CHOICE: Standardwartezeit (oder Standardauswahl) bei Option nicht angegeben.
 CHOICE: Nur eine Meldung ist erlaubt. Erwartete Form:
     CHOICE: Setzt MS-DOS 4.0 oder h�her voraus.
                                                                                                                                            ���0�!<���W���N�e���� �����!G�=&�� +ã����>����� �<u�8</tA< t�<	t��= u <"u�"��/��<t�:�t�F��</t�F�Ļ��������������<?t$<Ct7<Ntm<Ttq<Su�� �����������������������<:uF�< t<	t<t
</t�F��� ���t�A����^���U� �.��<:uF�<tN</tJ< tF<	tB�F�<,u8F�<0r1<9w-���F�<0s���<9v�����
 ����âF������ ���� �����>t��� ���< t
��� �F���� ��t�[� ��� �� �>u)���[�!���!G�= t��,�!���]�!��?�!�> t-�,�!�6��!���� u�,�!86t�6�u����!��>t�E �= t�t
�����!�ݴ���!���!��
�!���ǴL�!PWR�3���� t�!G��Z_X�SW<ar<zw, �<�r�>���2�+�&�_[�