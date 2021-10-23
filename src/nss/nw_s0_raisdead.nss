//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001


// HABD Include
#include "habd_include"
#include "_isla_inc"
#include "ll_include"

#include "x2_inc_spellhook"


void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise = EffectResurrection();
    effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);

    LegendaryLevelsRecalculate(oTarget);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
    if(GetIsDead(oTarget))
    {
        //Apply raise dead effect and VFX impact
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
    }

    // HABD CODE START
    // Token, nachdem gesucht werden soll, bzw. das bei Ableben gespeichert wurde
    string sResapwnName = GetPCPlayerName(oTarget)+GetName(oTarget);

    if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE &&
        GetTag(oTarget )== "Clone_" + sResapwnName)
    {
      object oDeathScribe = GetWaypointByTag("nsc_adriael"); // Wegpunkt auf dem die Daten gespeichert sind

      // TokenString in dem Gesucht/Gespeichert/Gelöscht wird
      string sDeathScribe = GetLocalString(oDeathScribe, "The_Dead");

      DeleteTokenFromString(sDeathScribe, sResapwnName); // Lösche den Namen, wiederbelebt!

      //effect eVisual = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
      //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
    }

    HABDRaiseDeadSpell(oTarget);
    // HABD CODE END

}

