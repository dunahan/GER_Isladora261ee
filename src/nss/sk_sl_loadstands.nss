//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_loadstands
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools f�r Isladora
    Skript um Standardeinstellungen des Sl zu laden
    und auf der Kreaturen Haut dessen zu speichern.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  LoadSlDBVariables(oSpeaker);
  // Zerst�re den Zuh�rer, da nicht mehr gebraucht
  DestroyObject(GetNearestObjectByTag("sl_listener", oSpeaker));
}
