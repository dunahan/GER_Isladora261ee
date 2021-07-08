//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_plcnouse
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um ein Placeable un/benutzbar zu machen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  if (GetObjectType(oSpeakTarg) != OBJECT_TYPE_PLACEABLE)
  {
    oSpeakTarg = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, locOfSpeaker);
    SendServerMessageToPC(oSpeaker, "Du hast kein Placeable ausgewählt. Das nächststehende Placeable zum Zielort wird ausgewählt.");
  }

  int iGuseable = GetUseableFlag(oSpeakTarg);
  if (iGuseable == TRUE)
  { SetUseableFlag(oSpeakTarg, FALSE);
    SendServerMessageToPC(oSpeaker, "Placeable deaktiviert."); }

  if(iGuseable == FALSE)
  { SetUseableFlag(oSpeakTarg, TRUE);
    SendServerMessageToPC(oSpeaker, "Placeable aktiviert."); }
}
