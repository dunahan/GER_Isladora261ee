//::///////////////////////////////////////////////
//:: Dancing Lights
//:: dancinlight.nss
//:: Copyright (c) Dunahan
//:://////////////////////////////////////////////
/*
    Creates, if cast on a creature, an blinkin' aura.
    If cast at a location, it creates a random walkin
    creature. Enemies will attack it, on a successful
    savingthrow against wisdom will let them know that
    it is only an illusion.
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan from Schwerterkueste.de
//:: Created On: 22-01-2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
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
    object     oCaster = OBJECT_SELF;
    object     oTarget = GetSpellTargetObject();
    location locTarget = GetSpellTargetLocation();
    effect      eLink1 = EffectACDecrease(1, AC_NATURAL_BONUS);
    effect      eLink2 = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_YELLOW);
    effect     eImpact = EffectLinkEffects(eLink1, eLink2);
    float    fDuration = HoursToSeconds(GetCasterLevel(oCaster));
    int     nMetaMagic = GetMetaMagicFeat();;
    int          nRoll = d3();

// Duration extended through metamagic?
  if (nMetaMagic == METAMAGIC_EXTEND)
  {
      fDuration = fDuration *2; //Duration is +100%
  }

// The spell
    if (oTarget == OBJECT_INVALID) // If target is a location
    {
        // Create Dancing Lights Creature
        object   oLight = CreateObject(OBJECT_TYPE_CREATURE, "dancing_light", locTarget);
                          SetLocalInt(oLight, "TIMER", FloatToInt(fDuration / 6.0));
        AssignCommand(oLight, ActionRandomWalk());
    }

    else // If target is a creature, placeable, item...
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImpact, oTarget, fDuration);
        if (nRoll = 3){ AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionRandomWalk());}
    }
}

