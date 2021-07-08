//::///////////////////////////////////////////////
//:: Larloch's Minor Drain
//:: minordrain.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

Larloch's Minor Drain (Alteration)
Level: Sor/Wiz 1
Innate Level: 1
Components: V,S,M
Range: Sight of caster
Casting Time: 1
Target: 1 creature
Duration: Instantaneous
Counter(s): None
Saving Throw: None
Spell Resistance: Yes
Metamagic: Empower, Maximize, Extend
Energy Substitution: Yes

With this spell the wizard drains the life force from a target and adds
it to his own. The target creature suffers 1-6 points of damage, while
the wizard gains 1-6 hit points. If the wizard goes over his maximum hit
point total with this spell, he looses them after 10 rounds.
  The material component for this spell is a living leech which is
flicked at the target during the casting of the spell.

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "nw_i0_spells"
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

    // FloatingTextStringOnCreature("Casting Larloch's Minor Drain", OBJECT_SELF, FALSE);

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = 1;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = d4();
    if(nDamage == 0)
    {
        nDamage = d4();
    }
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 4;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    //Limit damage to max hp + 10
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }
    //Declare effects
    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_S);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {

            //Signal spell cast at event
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(OBJECT_SELF, EventSpellCastAt(oTarget, SPELL_VAMPIRIC_TOUCH, FALSE));
            //Spell resistance
            if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
            {
                //Apply effects to target and caster
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                RemoveTempHitPoints();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nDuration));
            }
        }
    }
}

