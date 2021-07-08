//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_npclvlup1
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um Npc Lvl positiv zu beeinflussen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  int nClassOne = GetLocalInt(oSpeaker, "Int1");
  int nClass    = GetClassByPosition(1, oSpeakTarg);        // Erste Klasse auslesen
  int n1stLvl   = GetLevelByPosition(1, oSpeakTarg);        // Lvl der ersten Klasse auslesen
  int nPackage  = GetCreatureStartingPackage(oSpeakTarg);   // Lvlpacket der Kreatur auslesen

  LevelUpHenchman(oSpeakTarg, nClass, FALSE, nPackage);

}

