//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_rename
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um etwas umzubenennen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main ()
{ // Deklariere Notwendiges
  string sOldName = GetName(oSpeakTarg);
  string sNewName = GetLocalString(oSpeaker, "String1");

  SetName(oSpeakTarg, sNewName);

  //Debug(sOldName + " wurde erfolgreich zu " + GetName(oTarget) + " umbenannt.");
}
