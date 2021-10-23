void main()
{
//string sPortal = GetLocalString(OBJECT_SELF, "sPortal"); // Tag des Portals auslesen
  object oPortal = OBJECT_SELF;                            // Suche das Portal

  string sAktiv = GetLocalString(oPortal, "sActive");      // Aktiviert?

  if (sAktiv == "aktiv")
  { PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE); }         // Aktiv

  if (sAktiv == "deaktiv")
  { PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE); }       // Deaktiv

}
