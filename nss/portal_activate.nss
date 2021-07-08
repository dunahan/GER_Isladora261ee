void main()
{
  string sPortal = GetLocalString(OBJECT_SELF, "sPortal"); // Tag des Portals auslesen
  object oPortal = GetObjectByTag(sPortal);                // Suche das Portal

  string sAktiv = GetLocalString(oPortal, "sActive");      // Aktiviert?

  if (sAktiv == "deaktiv")
  { PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);           // Aktiv
    SetLocalString(oPortal, "sActive", "aktiv"); }
  if (sAktiv == "aktiv")
  { PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);         // Deaktiv
    SetLocalString(oPortal, "sActive", "deaktiv"); }
}
