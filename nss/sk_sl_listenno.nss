//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_listento
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools f�r Isladora
    Skript um die zu speichernden Variablen auf der
    Kreaturen Haut des Sl abzuspeichern.

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
