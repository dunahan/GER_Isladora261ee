//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_destroyall
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um alles mögliche zu zerstören


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"


void main()
{

  object oTarget  = GetObjectByTag(GetLocalString(oSpeaker, "Stored"));
  int nObjectType = GetObjectType (oTarget);

       if (nObjectType == OBJECT_TYPE_TRIGGER)     // Ein Auslöser gespeichert
  { DestroyObject(oTarget, 0.3); }

  else if (nObjectType == OBJECT_TYPE_PLACEABLE)   // Ein Placeable gespeichert
  { DestroyObject(oTarget, 0.3); }

  else if (nObjectType == OBJECT_TYPE_ITEM)        // Ein Gegenstand gespeichert
  { DestroyObject(oTarget, 0.3); }

  else if (nObjectType == OBJECT_TYPE_CREATURE)    // Eine Kreatur gespeichert
  { DestroyObject(oTarget, 0.3); }

  else                                             // Nichts gespeichert, es wurde auf etwas geklickt
  { DestroyObject(oSpeakTarg, 0.3); }
}
