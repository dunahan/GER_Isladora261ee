int StartingConditional()
{
  if ( GetIsObjectValid(OBJECT_SELF) == TRUE )
  {
    SetCustomToken(55500, IntToString(GetLocalInt(GetPCSpeaker(), "Int1")) );

    // Verbesserung Eins
    SetCustomToken(55510, GetLocalString(OBJECT_SELF, "55510") );
    SetCustomToken(55511, IntToString(GetLocalInt(OBJECT_SELF, "Opt1Gold")) );
    SetCustomToken(55512, IntToString(GetLocalInt(OBJECT_SELF, "Opt1XP")) );

    // Verbesserung Zwei
    SetCustomToken(55520, GetLocalString(OBJECT_SELF, "55520") );
    SetCustomToken(55521, IntToString(GetLocalInt(OBJECT_SELF, "Opt2Gold")) );
    SetCustomToken(55522, IntToString(GetLocalInt(OBJECT_SELF, "Opt2XP")) );

    // Verbesserung Drei
    SetCustomToken(55530, GetLocalString(OBJECT_SELF, "55530") );
    SetCustomToken(55531, IntToString(GetLocalInt(OBJECT_SELF, "Opt3Gold")) );
    SetCustomToken(55532, IntToString(GetLocalInt(OBJECT_SELF, "Opt3XP")) );

    // Verbesserung Vier
    SetCustomToken(55540, GetLocalString(OBJECT_SELF, "55540") );
    SetCustomToken(55541, IntToString(GetLocalInt(OBJECT_SELF, "Opt4Gold")) );
    SetCustomToken(55542, IntToString(GetLocalInt(OBJECT_SELF, "Opt4XP")) );
  }
  return TRUE;  // Immer einen Wert zurueckgeben.
}
