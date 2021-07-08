void main()
{
  // Die Tuer und der naechste Spielerchar definieren
  object oDoor = OBJECT_SELF;
  object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, CREATURE_TYPE_PLAYER_CHAR, oDoor);

  // Existiert der Char nicht, beeende das Skript!
  if (GetIsObjectValid(oPC) == FALSE) return;

  // Lese die Oeffnungszeit aus und wieviel Uhr es momentan ist
  int nHour = GetTimeHour();
  int nTime = GetLocalInt(oDoor, "OpeningTime");

  // Sollten die Stunden uebereinstimmen, dann oeffne die Tuer
  if (nHour == nTime)
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
