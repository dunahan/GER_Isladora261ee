/*
FIXED HORRIFIC APPEARANCE

changes:
1. proper save dc according to the creatures hit dice and charisma modifier,
instead of default 11, like it would be for the nwn sea hag
2. made effect permanent, not temporary
3. 2d6 strength damage instead of 2d8, at least for the sea hag
4. any creature that has a local integer called HORRIFIC_APPEARANCE_BANSHEE set
to 1 or higher, will affect targets as follows:

    - 1d4 permanent supernatural strengh decrease
    - 1d4 permanent supernatural dexterity decrease
    - 1d4 permanent supernatural constitution decrease

a creature that saves a banshee's (or sea hag's) horrific appearance is supposed
to not be affected by that same banshee's horrific appearance for 24 hours.
this should also be true for fear auras, but i couldn't think of any good way to
script that, and neither seems bioware, or they just didnt care, who knows.
doesn't make a lot of sense for nwn anyways...
*/

#include "X0_I0_SPELLS"

void main()
{

    object oTarget = GetEnteringObject();
    object oSource =  GetAreaOfEffectCreator();
    int nDC = 10+GetHitDice(oSource)/2+GetAbilityModifier(ABILITY_CHARISMA, oSource);
    float fDuration;
    int iDuration;

    // Declare all the required effects
    effect eVis1;
    effect eVis2;
    effect eAbility;

    // Is the target a valid creature
    if (GetIsEnemy(oTarget, oSource) && !GetIsReactionTypeFriendly(oTarget, oSource))
    {
        // Notify the Player that the are being attacked
        SignalEvent(oTarget, EventSpellCastAt(oSource, AOE_MOB_HORRIFICAPPEARANCE));

        // Prepare the visual effect for the casting and saving throw
        eVis1 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        eVis2 = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);

        if (GetLocalInt(oSource, "HORRIFIC_APPEARANCE_BANSHEE"))
        {
            eAbility = EffectLinkEffects(EffectAbilityDecrease(ABILITY_STRENGTH, d4()), EffectAbilityDecrease(ABILITY_DEXTERITY, d4()));
            eAbility = EffectLinkEffects(eAbility, EffectAbilityDecrease(ABILITY_CONSTITUTION, d4()));
        }

        // Create the 2d8 strength reduction effect
        // and make it supernatural so it can be dispelled
        else
            eAbility = EffectAbilityDecrease(ABILITY_STRENGTH, d6(2));

        eAbility = SupernaturalEffect(eAbility);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);

        // Make a Fortitude saving throw, DC 11 and apply the effect if it fails
        if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE, oSource))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAbility, oTarget);
        }
    }
}

