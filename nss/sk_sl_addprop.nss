//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_addprop
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools für Isladora
    Skript um Visuelle Effekte zu erstellen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main ()
{ // Deklariere Notwendiges
  int nFstProp = GetLocalInt(oSpeaker, "Int1");  int nSndProp = GetLocalInt(oSpeaker, "Int2");
  int nTrdProp = GetLocalInt(oSpeaker, "Int3");  int nFthProp = GetLocalInt(oSpeaker, "Int4");

  object oItem = GetSpellTargetObject();

  AddHWSProp(oItem, nFstProp, nSndProp, nTrdProp, nFthProp);
}
