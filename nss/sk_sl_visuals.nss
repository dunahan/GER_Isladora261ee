//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_visuals
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um Visuelle Effekte zu erstellen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main ()
{ // Deklariere Notwendiges
  int nEffNbr =  GetLocalInt(oSpeaker, "Int1");
  float fDur = GetLocalFloat(oSpeaker, "Float1");

  effect     eEffect = EffectVisualEffect(nEffNbr);

  // Zielort ist gültig und eine Kreatur
    if ( (GetIsObjectValid(oSpeakTarg) == TRUE ) &&
         (GetObjectType   (oSpeakTarg) == OBJECT_TYPE_CREATURE ) )
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpeakTarg, fDur);
    }

    // Zielort ist gültig und ein Gebiet
    else if ( GetIsObjectValid(GetAreaFromLocation(locSpeakTarg)) == TRUE )
    { ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eEffect, locSpeakTarg, fDur); }
} // Ende Void
