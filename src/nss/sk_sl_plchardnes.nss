//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_plchardnes
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Härte eines Placeables zu ändern


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  if ( (GetObjectType(oSpeakTarg) != OBJECT_TYPE_PLACEABLE) )
  {
    oSpeakTarg = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, locOfSpeaker);
    SendServerMessageToPC(oSpeaker, "Du hast kein Placeable ausgewählt. Das nächststehende Placeable zum Zielort wird ausgewählt.");
  }

  int nOldHard; int nSaved = GetLocalInt(oSpeakTarg, "OldHard");

  if (nSaved == 0) // Alte Härte speichern, falls noch nicht getan
  { nOldHard = GetHardness(oSpeakTarg); SetLocalInt(oSpeakTarg, "OldHard", nOldHard); }
  else             // Ansonsten alte Härte laden
  { nOldHard = nSaved; }

  int nNewHard = GetLocalInt(oSpeaker,"Int1");  // Neuen Wert auslesen

  if ( nNewHard >= 256 )  // Sollte die zukünftige Härte über maximal liegen, alte wieder einsetzen!
  { SetHardness(nOldHard, oSpeakTarg);
    SendServerMessageToPC(oSpeaker, "Härte wurde auf "+ IntToString(nOldHard) +" gesetzt."); }
  else                    // Ansonsten neuen Wert übernehmen
  { SetHardness(nNewHard, oSpeakTarg);
    SendServerMessageToPC(oSpeaker, "Härte wurde auf "+ IntToString(nNewHard) +" gesetzt."); }
}
