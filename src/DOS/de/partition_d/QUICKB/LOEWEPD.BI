TYPE PdMenueStruc
     titx AS INTEGER
     framex AS INTEGER
     framey AS INTEGER
     framew AS INTEGER
     frameh AS INTEGER
END TYPE

DECLARE SUB MenuICheck (titel%, entry%, flag%)
DECLARE FUNCTION MenuT$ (titel%, entry%)
DECLARE FUNCTION OnMenue% (t%, e%)
DECLARE FUNCTION PdText$ (titel%, entry%)
DECLARE SUB UnshowMenue (pdnr%)
DECLARE SUB Menu (pd$())
DECLARE SUB ShowMenue (titel%)

