//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_listenspaw
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um den zuhöhrer auf Listening zu stellen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Setze ihn auf Zuhöhren
  SetListening(OBJECT_SELF, TRUE);
  // Setze die zu höhrenden Worte auf jegliche und in das Feld 2002 für Int1 usw...
  SetListenPattern(OBJECT_SELF, "SL ** **", 82002);
}
