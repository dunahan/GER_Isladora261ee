void main()
{
  int iSpell  = GetLocalInt(OBJECT_SELF, "SpellID"); // Spell der gewirkt werden soll
  string sTag = GetLocalString(OBJECT_SELF, "Target"); // wo der Spell erscheinen soll
  ActionCastFakeSpellAtLocation(iSpell,GetLocation(GetObjectByTag(sTag)));
}

