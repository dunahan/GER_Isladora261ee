void main()
{
  // 1++ Deklariere wichtige Operanden
  object oDoor  = OBJECT_SELF;
  string sOpen  = GetLocalString(oDoor, "Sequel");  string sOpenTlk  = GetLocalString(oDoor, "OpenTlk");
  string sClose = GetLocalString(oDoor, "Sequel");  string sCloseTlk = GetLocalString(oDoor, "CloseTlk");

  // 2++ Die T�r nun auf h�hrend stellen, damit diese sich
  //     �ffnen und Schlie�en kann
  SetListening(OBJECT_SELF, TRUE);
  SetListenPattern(OBJECT_SELF, sOpen , 2001);
  SetListenPattern(OBJECT_SELF, sClose, 2002);

  // 3++ Es wird nun gepr�ft ob die T�r geschlossen ist
  if (GetIsOpen(oDoor) == FALSE)
  {
    // 3.1 Danach wird das ausgesprochene Wort erfasst.
    int nMatch = GetListenPatternNumber();
    // 3.2 Sollte dies dem �ffnen-Wort entsprechen
    if (nMatch == 2001)
    {
      // 3.2.1 Teile dem Spieler mit, das die T�r sich �ffnet und
      SpeakString(sOpenTlk);
      // 3.2.2 �ffne diese dann anschlie�end
      AssignCommand(oDoor, SetLocked(oDoor, FALSE));
      AssignCommand(oDoor, ActionOpenDoor(oDoor));
    }
  }

  // 3.3 Die T�r ist geschlossen, also
  if (GetIsOpen(oDoor) == TRUE)
  {
    int nMatch = GetListenPatternNumber();

    // 3.4 Entspricht das gesprochene Wort dem Schlie�en-Wort
    if (nMatch == 2002)
    {
      // 3.2.1 Teile dem Spieler mit, das die T�r sich schlie�t und
      SpeakString(sCloseTlk);
      // 3.2.2 schlie�e diese dann anschlie�end
      AssignCommand(oDoor, SetLocked(oDoor, TRUE));
      AssignCommand(oDoor, ActionCloseDoor(oDoor));
    }
  }
}

