void main()
{
  object oPC = GetLastUsedBy();                                  // Wer hats genutzt?
  location locReturn = GetLocalLocation(oPC, "AFK_RETURN_LOC");  // Lese dessen gespeicherte Position aus

  AssignCommand(oPC,ClearAllActions());                          // Beende alle Aktionen
  AssignCommand(oPC,ActionJumpToLocation(locReturn));            // Beame Nutzer zurueck
}
