//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_descriptio
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
  string sNewDes = GetLocalString(oSpeaker, "String1");
  SendServerMessageToPC(oSpeaker, "Neue Beschreibung: " + sNewDes);
  SetDescription(oSpeakTarg, sNewDes, TRUE);
}
