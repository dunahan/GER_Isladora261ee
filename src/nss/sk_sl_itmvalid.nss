//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_itmvalid
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript ob Gegenstand existiert


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

int StartingConditional()
{
  if (GetIsObjectValid(oSpeakTarg) == TRUE)
  { return TRUE; }
  else
  { return FALSE; }
}
