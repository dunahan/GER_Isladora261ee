//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_listensave
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools f�r Isladora



*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Zerst�re den Zuh�rer, da nicht mehr gebraucht
  DestroyObject(GetNearestObjectByTag("sl_listener", oSpeaker));
}
