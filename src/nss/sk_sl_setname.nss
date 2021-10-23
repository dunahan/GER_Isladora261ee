//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_setname
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Beschreibung anzupassen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  string sNewName = GetLocalString(oSpeaker, "String1");
  SendServerMessageToPC(oSpeaker, "Neuer Name: " + sNewName);
  SetName(oSpeakTarg, sNewName);
}
