//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_loadstands
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
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
  // Zerstöre den Zuhörer, da nicht mehr gebraucht
  DestroyObject(GetNearestObjectByTag("sl_listener", oSpeaker));
}
