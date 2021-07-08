//::///////////////////////////////////////////////
//:: [Ressurection]
//:: [NW_S0_Ressurec.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with full
//:: health.
//:: When cast on placeables, you get a default error message.
//::   * You can specify a different message in
//::      X2_L_RESURRECT_SPELL_MSG_RESREF
//::   * You can turn off the message by setting the variable
//::     to -1
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Z on 2003-07-31
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


    //Get the spell target
    object oTarget = GetSpellTargetObject();

    LegendaryLevelsRecalculate(oTarget);

    //Check to make sure the target is dead first
    //Fire cast spell at event for the specified target
    if (GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
        if (GetIsDead(oTarget))
        {
            //Declare major variables
            int nHealed = GetMaxHitPoints(oTarget);
            effect eRaise = EffectResurrection();
            effect eHeal = EffectHeal(nHealed + 10);
            effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
            //Apply the heal, raise dead and VFX impact effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        }
        else
        {
            if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                int nStrRef = GetLocalInt(oTarget,"X2_L_RESURRECT_SPELL_MSG_RESREF");
                if (nStrRef == 0)
                {
                    nStrRef = 83861;
                }
                if (nStrRef != -1)
                {
                     FloatingTextStrRefOnCreature(nStrRef,OBJECT_SELF);
                }
            }
        }
    }

    // HABD CODE START
    // Token, nachdem gesucht werden soll, bzw. das bei Ableben gespeichert wurde
    string sResapwnName = GetPCPlayerName(oTarget)+GetName(oTarget);

    if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE &&
        GetTag(oTarget )== "Clone_" + sResapwnName)
    {
      object oDeathScribe = GetWaypointByTag("nsc_adriael"); // Wegpunkt auf dem die Daten gespeichert sind

      // TokenString in dem Gesucht/Gespeichert/Gel�scht wird
      string sDeathScribe = GetLocalString(oDeathScribe, "The_Dead");

      DeleteTokenFromString(sDeathScribe, sResapwnName); // L�sche den Namen, wiederbelebt!

      //effect eVisual = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
      //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
    }

    HABDResurrectionSpell(oTarget);
    // HABD CODE END

}

