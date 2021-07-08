//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_plchardnes
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools f�r Isladora
    Skript um die H�rte eines Placeables zu �ndern


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
    SendServerMessageToPC(oSpeaker, "Du hast kein Placeable ausgew�hlt. Das n�chststehende Placeable zum Zielort wird ausgew�hlt.");
  }

  int nOldHard; int nSaved = GetLocalInt(oSpeakTarg, "OldHard");

  if (nSaved == 0) // Alte H�rte speichern, falls noch nicht getan
  { nOldHard = GetHardness(oSpeakTarg); SetLocalInt(oSpeakTarg, "OldHard", nOldHard); }
  else             // Ansonsten alte H�rte laden
  { nOldHard = nSaved; }

  int nNewHard = GetLocalInt(oSpeaker,"Int1");  // Neuen Wert auslesen

  if ( nNewHard >= 256 )  // Sollte die zuk�nftige H�rte �ber maximal liegen, alte wieder einsetzen!
  { SetHardness(nOldHard, oSpeakTarg);
    SendServerMessageToPC(oSpeaker, "H�rte wurde auf "+ IntToString(nOldHard) +" gesetzt."); }
  else                    // Ansonsten neuen Wert �bernehmen
  { SetHardness(nNewHard, oSpeakTarg);
    SendServerMessageToPC(oSpeaker, "H�rte wurde auf "+ IntToString(nNewHard) +" gesetzt."); }
}
