//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_factions
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Fraktion neu zu bestimmen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{ // Deklariere Notwendiges
  object oFaction;
  int nFaction = GetLocalInt(oSpeaker, "Int1");
  ChangeToStandardFaction(oSpeakTarg, nFaction);
/*  if ( (nFaction >= 0) && (nFaction <= 3) ) { ChangeToStandardFaction(oSpeakTarg, nFaction); }

  else
  {
    switch (nFaction){
      case 4: oFaction = GetObjectByTag("USER_FACTION_ANIMALS"); break;
      case 5: oFaction = GetObjectByTag("USER_FACTION_TRUENEUTRAL"); break;
      case 6: oFaction = GetObjectByTag("USER_FACTION_CNRANIMAL"); break;
      case 7: oFaction = GetObjectByTag("USER_FACTION_QUESTGIVER"); break; }

    ChangeFaction(oSpeakTarg, oFaction);
  }*/
}
