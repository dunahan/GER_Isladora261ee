//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_listenspaw
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools f�r Isladora
    Skript um den zuh�hrer auf Listening zu stellen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Setze ihn auf Zuh�hren
  SetListening(OBJECT_SELF, TRUE);
  // Setze die zu h�hrenden Worte auf jegliche und in das Feld 2002 f�r Int1 usw...
  SetListenPattern(OBJECT_SELF, "SL ** **", 82002);
}
