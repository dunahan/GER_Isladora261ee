//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_chargeitem
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um ein ausgewähltes Item aufzuladen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Erfasse die aktuellen Ladungen des Gegenstandes
  int nActCharges = GetItemCharges(oSpeakTarg);

  // Addiere 10 Ladungen zu den aktuellen
  SetItemCharges(oSpeakTarg, nActCharges + 10);

}
