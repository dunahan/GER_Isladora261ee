//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_npcvalid
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript ob NSC existiert


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
