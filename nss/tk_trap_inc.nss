//::///////////////////////////////////////////////
//:: Trap include
//:: tk_trap_inc
//:://////////////////////////////////////////////
//:: Helper functions for traps.
//:: Some of these were in includes for spells,
//:: but I did not want to overwrite those files.
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "x3_inc_string"


// -----------------------------------------------
// PROTOTYPES
// -----------------------------------------------


// Implements acid blob traps.
// Duration is in rounds.
void DoBlobTrap(int nDamage, int nDuration, int nDC);

// Implements electrical traps.
// nDice is the number of d6 to roll for damage.
// nSecondaryTargets is the number of creatures that can be hit in addition to
// the one who triggered the trap.
void DoElectricalTrap(int nDice, int nSecondaryTargets, int nDC);

// Implements fire traps.
// nDice is the number of d6 to roll for damage.
// Radius is a RADIUS_SIZE_* constant.
void DoFireTrap(int nDice, float fRadius, int nDC);

// Implements frost traps.
// Duration is in rounds.
void DoFrostTrap(int nDamage, int nDuration, int nDC);

// Implements gas traps.
// Duration is in rounds.
void DoGasTrap(int nDuration, string sOnEnterScript="****", string sHeartbeatScript="****", string sOnExitScript="****");

// Implements holy traps.
// nUndeadDamage is the damage to inflict if the target is undead.
// nOtherDamage is the damage to inflict otherwise.
void DoHolyTrap(int nUndeadDamage, int nOtherDamage);

// Implements negative traps.
// eNegative will be made supernatural in this function.
void DoNegativeTrap(int nDamage, effect eNegative, int nDC);

// Implements sonic traps.
// nDice is the number of d4 to roll for damage. Duration is in rounds.
void DoSonicTrap(int nDice, int nDuration, int nDC);

// Implements spike traps.
void DoSpikeTrap(int nDamage, int nDC);

// Implements acid splash traps.
void DoSplashTrap(int nDamage, int nDC);

// Implements tangle traps.
// Radius is a RADIUS_SIZE_* constant. Duration is in rounds.
void DoTangleTrap(int nDuration, float fRadius, int nDC);

// Provides simulated feedback to oPlayer about a save rolled by oTarget.
// Set nEvasion to 1 if the feedback should mention evasion; 2 for improved evasion.
void SavingThrowFeedback(object oPlayer, object oTarget, int bSuccess, int nDC, int nSavingThrow, int nSaveType=SAVING_THROW_TYPE_NONE, int nEvasion=0);

// Handles damage in a trap script so that the trap creator gets credit for it.
// Use fDelay to delay the application of the damage.
// oCreator usually does not need to be supplied; internal use "mostly".
// oTrap does not need to be supplied; internal use only.
void TrapDamage(object oTarget, int nDamage, int nType, float fDelay=0.0, object oCreator=OBJECT_INVALID, object oTrap=OBJECT_INVALID);

// Handles healing in a trap script so that the trap creator gets credit for it.
void TrapHeal(object oTarget, int nHeal);

// Wrapper for GetReflexAdjustedDamage() that also gives the trap creator some feedback.
// This kind of assumes nDamage is at least 2.
int TrapReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_TRAP);

// Replacement for MySavingThrow() (nw_i0_spells) that
// 1) does better handling of immunities, given the needs of traps; and
// 2) gives the trap creator some feedback.
// Returns TRUE if the save was successful, FALSE if failed.
int TrapSavingThrow(object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_TRAP, int nSavingThrow=SAVING_THROW_REFLEX);

// Returns an appropriate "chunk" visual effect number based upon oTarget's blood type.
int TrapVFXGore(object oTarget);


// -----------------------------------------------
// FUNCTION DEFINITIONS
// -----------------------------------------------


// Implements acid blob traps.
// Duration is in rounds.
void DoBlobTrap(int nDamage, int nDuration, int nDC)
{
    object oTarget = GetEnteringObject();
    effect eHold = ExtraordinaryEffect(EffectLinkEffects(
                        EffectParalyze(),
                        EffectVisualEffect(VFX_DUR_PARALYZED)));

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID),
                          GetLocation(oTarget));

    // Allow a saving throw.
    if ( !TrapSavingThrow(oTarget, nDC) )
    {
        // Apply hold.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHold, oTarget,
                            RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_COM_HIT_ACID), oTarget);
    }

    // Damage regardless of the save.
    TrapDamage(oTarget, nDamage, DAMAGE_TYPE_ACID);
}


// Implements electrical traps.
// nDice is the number of d6 to roll for damage.
// nSecondaryTargets is the number of creatures that can be hit in addition to
// the one who triggered the trap.
void DoElectricalTrap(int nDice, int nSecondaryTargets, int nDC)
{
    // Declare major variables
    object oPrimary = GetEnteringObject();
    location lTarget = GetLocation(oPrimary);
    int nDamageMaster = d6(nDice);
    int nDamage; // Set for each target.
    // Set some spiffy visuals.
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oPrimary, BODY_NODE_CHEST);
    effect eVis  = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eHalf = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
    effect eArea = nDice < 10 ? // Minor
                        EffectVisualEffect(VFX_COM_HIT_ELECTRICAL) :
                  (nDice < 50 ? // Non-epic
                        EffectVisualEffect(VFX_IMP_LIGHTNING_S) :
                        EffectVisualEffect(VFX_IMP_LIGHTNING_M));   // Lightning strike. Overkill? Meh, it is epic.

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eArea, lTarget);

    // Primary target: save vs. traps and no beam.
    nDamage = TrapReflexAdjustedDamage(nDamageMaster, oPrimary, nDC);
    if ( nDamage > 0 )
    {
        // Apply damage.
        TrapDamage(oPrimary, nDamage, DAMAGE_TYPE_ELECTRICAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            nDamage < nDamageMaster ? eHalf : eVis,
                            oPrimary);
    }

    // Secondary targets: Cycle through the objects in the affected area.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget);
    while ( oTarget != OBJECT_INVALID  &&  nSecondaryTargets > 0 )
    {
        // Exclude the primary target and check PvP settings.
        if ( oTarget != oPrimary  &&  !GetIsReactionTypeFriendly(oTarget) )
        {
            // Allow a saving throw.
            nDamage = TrapReflexAdjustedDamage(nDamageMaster, oTarget, nDC,
                                               SAVING_THROW_TYPE_ELECTRICITY);
            if ( nDamage > 0 )
            {
                // Apply damage.
                TrapDamage(oTarget, nDamage, DAMAGE_TYPE_ELECTRICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                    nDamage < nDamageMaster ? eHalf : eVis,
                                    oTarget);

                // Build a lightning stream connecting the targets.
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oTarget, 0.75);
                eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oTarget, BODY_NODE_CHEST);
            }

            // Decrement the count
            nSecondaryTargets--;
        }

        // Update the loop.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget);
    }
}


// Implements fire traps.
// nDice is the number of d6 to roll for damage.
// Radius is a RADIUS_SIZE_* constant.
void DoFireTrap(int nDice, float fRadius, int nDC)
{
    // Declare major variables
    location lTarget = GetLocation(GetEnteringObject());
    int nDamage, nOrigDamage;
    // Spiffy visuals. Less than 10 dice are the minor and average traps.
    effect eVis  = EffectVisualEffect(nDice <  10 ? VFX_IMP_FLAME_S  : VFX_IMP_FLAME_M);
    effect eHalf = EffectVisualEffect(nDice <  10 ? VFX_COM_HIT_FIRE : VFX_IMP_FLAME_S);
    effect eArea = fRadius <= RADIUS_SIZE_SMALL ?
                        EffectVisualEffect(VFX_IMP_PULSE_FIRE) :
                  (fRadius <= RADIUS_SIZE_LARGE  &&  nDice < 50 ? // Not that any standard traps have more than a medium radius...
                        EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE) :
                        EffectVisualEffect(VFX_FNF_FIREBALL));   // Fireball for huge and epic traps.

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eArea, lTarget);

    // Cycle through the objects in the affected area.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
    while ( oTarget != OBJECT_INVALID )
    {
        // Check PvP settings.
        if ( !GetIsReactionTypeFriendly(oTarget) )
        {
            // Allow a saving throw.
            nOrigDamage = d6(nDice);
            nDamage = TrapReflexAdjustedDamage(nOrigDamage, oTarget, nDC);
            if ( nDamage > 0 )
            {
                // Apply damage.
                TrapDamage(oTarget, nDamage, DAMAGE_TYPE_FIRE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                    nDamage < nOrigDamage ? eHalf : eVis,
                                    oTarget);
            }
        }

        // Update the loop.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
    }
}


// Implements frost traps.
// Duration is in rounds.
void DoFrostTrap(int nDamage, int nDuration, int nDC)
{
    // Declare major variables
    object oTarget = GetEnteringObject();
    effect eFreeze = ExtraordinaryEffect(EffectLinkEffects(
                        EffectParalyze(),
                        EffectVisualEffect(VFX_DUR_BLUR)));
    effect eVis = nDamage < 10 ? // Probably minor or average.
                    EffectVisualEffect(VFX_COM_HIT_FROST) :
                 (nDamage < 40 ? // Non-epic.
                    EffectVisualEffect(VFX_IMP_FROST_S) :
                    EffectVisualEffect(VFX_IMP_FROST_L));

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_IMP_PULSE_COLD),
                          GetLocation(oTarget));

    // Allow a saving throw.
    if ( !TrapSavingThrow(oTarget, nDC, SAVING_THROW_TYPE_COLD, SAVING_THROW_FORT) )
        // Frozen!
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTarget,
                            RoundsToSeconds(nDuration));

    // Damage regardless of the save.
    TrapDamage(oTarget, nDamage, DAMAGE_TYPE_COLD);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


// Implements gas traps.
// Duration is in rounds.
void DoGasTrap(int nDuration, string sOnEnterScript="****", string sHeartbeatScript="****", string sOnExitScript="****")
{
    object oCreator = GetTrapCreator(OBJECT_SELF);
    location lTarget = GetLocation(GetEnteringObject());
    float fDuration = RoundsToSeconds(nDuration);

    // Create the AoE object, crediting the trap creator if possible.
    if ( GetIsObjectValid(oCreator) )
        AssignCommand(oCreator, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
            EffectAreaOfEffect(AOE_PER_FOGACID, sOnEnterScript, sHeartbeatScript, sOnExitScript),
            lTarget, fDuration));
    else
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
            EffectAreaOfEffect(AOE_PER_FOGACID, sOnEnterScript, sHeartbeatScript, sOnExitScript),
            lTarget, fDuration);
}


// Implements holy traps.
// nUndeadDamage is the damage to inflict if the target is undead.
// nOtherDamage is the damage to inflict otherwise.
void DoHolyTrap(int nUndeadDamage, int nOtherDamage)
{
    // Declare major variables
    object oTarget = GetEnteringObject();
    effect eVis = nOtherDamage <= 12 ? // Minor or average, probably.
                    EffectVisualEffect(VFX_COM_HIT_DIVINE) :
                    EffectVisualEffect(VFX_IMP_SUNSTRIKE);

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_IMP_PULSE_HOLY),
                          GetLocation(oTarget));

    // Special visuals (and damage) for undead.
    if ( GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
    {
        // Spiffy... the first visuals are projectiles.
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY),
                            oTarget);
        // The rest happens after the projectiles hit.
        // (Assign to the target in case OBJECT_SELF will not exist by then.)
        AssignCommand(oTarget, DelayCommand(0.5,
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget)));
        TrapDamage(oTarget, nUndeadDamage, DAMAGE_TYPE_DIVINE, 0.5);
    }
    else
    {
        // Use standard visuals & apply damage.
        TrapDamage(oTarget, nOtherDamage, DAMAGE_TYPE_DIVINE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}


// Implements negative traps.
// eNegative will be made supernatural in this function.
void DoNegativeTrap(int nDamage, effect eNegative, int nDC)
{
    object oTarget = GetEnteringObject();

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE), // Looked better than "evil", I think.
                          GetLocation(oTarget));

    // Undead are healed by negative energy.
    if ( GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
    {
        // Apply healing.
        TrapHeal(oTarget, nDamage);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_HEALING_M), oTarget);
    }
    else
    {
        // Allow a saving throw.
        if ( !TrapSavingThrow(oTarget, nDC, SAVING_THROW_TYPE_TRAP, SAVING_THROW_FORT) )
        {
            effect eVis = GetEffectType(eNegative) == EFFECT_TYPE_NEGATIVELEVEL ?
                                EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE) :
                                EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

            // Apply the negative effect (permanently).
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eNegative), oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        else
            // The grease explosion could still use a bit of red.
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectVisualEffect(VFX_COM_HIT_NEGATIVE),
                                oTarget);

        // Damage regardless of the save.
        TrapDamage(oTarget, nDamage, DAMAGE_TYPE_NEGATIVE);
    }
}


// Implements sonic traps.
// nDice is the number of d4 to roll for damage. Duration is in rounds.
void DoSonicTrap(int nDice, int nDuration, int nDC)
{
    // Declare major variables
    location lTarget = GetLocation(GetEnteringObject());
    float fDuration = RoundsToSeconds(nDuration);
    effect eStun = ExtraordinaryEffect(EffectLinkEffects(
                        EffectStunned(),
                        EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED)));
    effect eVis2 = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis  = EffectVisualEffect(VFX_COM_HIT_SONIC);
    effect eArea = nDice < 4 ? // Minor and average.
                        EffectVisualEffect(VFX_IMP_PULSE_WIND) :
                        EffectVisualEffect(VFX_FNF_SOUND_BURST);

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eArea, lTarget);
    // Extra effect for epic traps.
    if ( nDice > 20 )
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE),
                              lTarget);

    // Cycle through the objects in the affected area.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget);
    while ( oTarget != OBJECT_INVALID )
    {
        // Check PvP settings.
        if ( !GetIsReactionTypeFriendly(oTarget) )
        {
            // Allow a save.
            if ( !TrapSavingThrow(oTarget, nDC, SAVING_THROW_TYPE_SONIC, SAVING_THROW_WILL) )
            {
                // Apply the stun effect.
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }

            // Damage regardless of the save.
            TrapDamage(oTarget, d4(nDice), DAMAGE_TYPE_SONIC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        // Update the loop.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget);
    }
}


// Implements spike traps.
void DoSpikeTrap(int nDamage, int nDC)
{
    object oTarget = GetEnteringObject();

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_IMP_SPIKE_TRAP),
                          GetLocation(oTarget));

    // Allow a saving throw.
    nDamage = TrapReflexAdjustedDamage(nDamage, oTarget, nDC);

    if (nDamage > 0)
    {
        // Being a little fancy here. Gore if this is major hit.
        // (I know, DR is not factored in. Deal with it.)
        effect eVis = nDamage < GetCurrentHitPoints(oTarget)  &&
                      nDamage < GetMaxHitPoints(oTarget) / 2 ?
                            EffectVisualEffect(VFX_COM_BLOOD_LRG_RED) :
                            EffectVisualEffect(TrapVFXGore(oTarget));

        // Apply damage.
        TrapDamage(oTarget, nDamage, DAMAGE_TYPE_PIERCING);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}


// Implements acid splash traps.
void DoSplashTrap(int nDamage, int nDC)
{
    object oTarget = GetEnteringObject();

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_IMP_ACID_L),
                          GetLocation(oTarget));

    // Allow a saving throw.
    nDamage = TrapReflexAdjustedDamage(nDamage, oTarget, nDC);
    if ( nDamage > 0 )
    {
        // Apply damage.
        TrapDamage(oTarget, nDamage, DAMAGE_TYPE_ACID);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_ACID_S), oTarget);
    }
}


// Implements tangle traps.
// Radius is a RADIUS_SIZE_* constant. Duration is in rounds.
void DoTangleTrap(int nDuration, float fRadius, int nDC)
{
    // Declare major variables
    location lTarget = GetLocation(GetEnteringObject());
    effect eSlow = ExtraordinaryEffect(EffectSlow());
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    float fDuration = RoundsToSeconds(nDuration);

    // Visual effect of the trap going off.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                          EffectVisualEffect(VFX_IMP_PULSE_NATURE),
                          lTarget);

    // Cycle through the objects in the radius.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
    while ( oTarget != OBJECT_INVALID )
    {
        // Check PvP settings.
        if ( !GetIsReactionTypeFriendly(oTarget) )
            // Allow a save.
            if ( !TrapSavingThrow(oTarget, nDC) )
            {
                // Apply the slow effect.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fDuration);
            }

        // Update the loop.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget);
    }
}


// Provides simulated feedback to oPlayer about a save rolled by oTarget.
// I have noted some StringRefs that could be used instead of string literals,
// but I do not know all of them. Better to use all English than mix languages.
// (Plus, I have introduced "ish" which is not going to have a StringRef.)
void SavingThrowFeedback(object oPlayer, object oTarget, int bSuccess, int nDC, int nSavingThrow, int nSaveType=SAVING_THROW_TYPE_NONE, int nEvasion=0)
{
    if ( !GetIsPC(oPlayer) )
        // No need to waste time building a string.
        return;
    if ( oPlayer == oTarget )
        // A message is already being sent. No need to double-up.
        return;

    // Get the target's saving throw, not counting "vs. X" modifiers.
    // ("vs. X" would add complexity with little increase in accuracy.)
    int nSave;
    switch ( nSavingThrow )
    {
        case SAVING_THROW_REFLEX : nSave = GetReflexSavingThrow(oTarget);    break;
        case SAVING_THROW_FORT   : nSave = GetFortitudeSavingThrow(oTarget); break;
        case SAVING_THROW_WILL   : nSave = GetWillSavingThrow(oTarget);      break;
    }

    // Create a success/failure message with save and DC info.
    string sEnding = ": " + (bSuccess ? "*success*" : "*failure*") +
                     " (d20 + " + IntToString(nSave) + "ish vs. DC: " + // "ish" because it lacks "vs. X" modifiers.
                     IntToString(nDC) + ")";

    // Convert the save subtype to a string.
    string sVersus = "";
    switch ( nSaveType )
    {
        // I entered all of these for completeness, but for efficiency, I will
        // comment out the ones not used by traps.
      //case SAVING_THROW_TYPE_MIND_SPELLS: sVersus = "vs. Mind-Affecting "; break;
      //case SAVING_THROW_TYPE_POISON     : sVersus = "vs. Poison ";         break;
      //case SAVING_THROW_TYPE_DISEASE    : sVersus = "vs. Disease ";        break;
      //case SAVING_THROW_TYPE_FEAR       : sVersus = "vs. Fear ";           break;
        case SAVING_THROW_TYPE_SONIC      : sVersus = "vs. Sonic ";          break;
        case SAVING_THROW_TYPE_ACID       : sVersus = "vs. Acid ";           break;
        case SAVING_THROW_TYPE_FIRE       : sVersus = "vs. Fire ";           break;
        case SAVING_THROW_TYPE_ELECTRICITY: sVersus = "vs. Electricity ";    break;
      //case SAVING_THROW_TYPE_POSITIVE   : sVersus = "vs. Positive ";       break;
        case SAVING_THROW_TYPE_NEGATIVE   : sVersus = "vs. Negative ";       break;
      //case SAVING_THROW_TYPE_DEATH      : sVersus = "vs. Death ";          break;
        case SAVING_THROW_TYPE_COLD       : sVersus = "vs. Cold ";           break;
        case SAVING_THROW_TYPE_DIVINE     : sVersus = "vs. Divine ";         break;
        case SAVING_THROW_TYPE_TRAP       : sVersus = "vs. Traps ";          break;
      //case SAVING_THROW_TYPE_SPELL      : sVersus = "vs. Spells ";         break;
      //case SAVING_THROW_TYPE_GOOD       : sVersus = "vs. Good ";           break;
      //case SAVING_THROW_TYPE_EVIL       : sVersus = "vs. Evil ";           break;
      //case SAVING_THROW_TYPE_LAW        : sVersus = "vs. Law ";            break;
      //case SAVING_THROW_TYPE_CHAOS      : sVersus = "vs. Chaos ";          break;
    }

    // Convert the save type to a string.
    string sType = "";
    switch ( nSavingThrow )
    {
        case SAVING_THROW_REFLEX : sType = "Reflex Save ";    break; // StringRef 519 + " "
        case SAVING_THROW_FORT   : sType = "Fortitude Save "; break; // StringRef 520 + " "
        case SAVING_THROW_WILL   : sType = "Will Save ";      break; // StringRef 745 + " "
    }
    switch ( nEvasion )
    {
        case 1: sType = "Evasion : " + sType;           break; // StringRef 1940 + " : "
        case 2: sType = "Improved Evasion : " + sType;  break; // StringRef 1946 + " : "
    }

    // Do we identify who made the save?
    string sName;
    if ( GetObjectSeen(oTarget, oPlayer)  ||  GetObjectHeard(oTarget, oPlayer) )
        sName = GetName(oTarget);
    else
        sName = "Someone"; // StringRef 8349

    // The colors are intended to resemble the usual saving throw messages.
    SendMessageToPC(oPlayer, StringToRGBString(sName, "646") +
                             StringToRGBString(" : " + sType + sVersus + sEnding, "367"));
}


// Handles damage in a trap script so that the trap creator gets credit for it.
// Use fDelay to delay the application of the damage.
// oCreator usually does not need to be supplied; internal use "mostly".
// oTrap does not need to be supplied; internal use only.
// (The internal use is to remember those objects when this function calls itself
// on a delay. The delay is assigned to the module so that it is not cancelled if
// either the trap or the trap creator cease to exist during the delay.)
void TrapDamage(object oTarget, int nDamage, int nType, float fDelay=0.0, object oCreator=OBJECT_INVALID, object oTrap=OBJECT_INVALID)
{
    // Get the trap creator, if not supplied.
    if ( oCreator == OBJECT_INVALID )
        oCreator = GetTrapCreator(OBJECT_SELF);

    // Wait for later?
    if ( fDelay > 0.0 )
    {
        // Prevent GetTrapCreator() from being called after the delay.
        if ( oCreator == OBJECT_INVALID )
            oCreator = OBJECT_SELF;
        else
            // Remember the trap, in case the creator ceases to exist.
            oTrap = OBJECT_SELF;
        // Assign the delay to the module, as the trap might cease to exist.
        AssignCommand(GetModule(), DelayCommand(fDelay,
            TrapDamage(oTarget, nDamage, nType, 0.0, oCreator, oTrap)));
    }
    else
    {
        // If the trap creator no longer exists, treat the trap as the creator.
        if ( !GetIsObjectValid(oCreator) )
            oCreator = oTrap;
        // Assign the damage, but only if the creator (still) exists.
        if ( GetIsObjectValid(oCreator) )
            AssignCommand(oCreator, ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                        EffectDamage(nDamage, nType), oTarget));
        else
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, nType), oTarget);
    }
}


// Handles healing in a trap script so that the trap creator gets credit for it.
void TrapHeal(object oTarget, int nHeal)
{
    object oCreator = GetTrapCreator(OBJECT_SELF);

    // Assign the damage, but only if the creator (still) exists.
    if ( GetIsObjectValid(oCreator) )
        AssignCommand(oCreator, ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                    EffectHeal(nHeal), oTarget));
    else
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), oTarget);
}


// Wrapper for GetReflexAdjustedDamage() that also gives the trap creator some feedback.
// This kind of assumes nDamage is at least 2.
int TrapReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_TRAP)
{
    // Adjust the damage for the saving throw.
    int nAdjustedDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType);

    // Deduce whether evasion applied and whether the save was the successful.
    int nEvasion = GetHasFeat(FEAT_IMPROVED_EVASION, oTarget) ? 2 :
                   GetHasFeat(FEAT_EVASION,          oTarget) ? 1 : 0;
    int bSuccess =  nAdjustedDamage == 0  ||
                    ( nAdjustedDamage < nDamage  &&  nEvasion < 2 ); // nEvasion < 2 means "does not have improved evasion"

    // Provide feedback to the trap creator.
    SavingThrowFeedback(GetTrapCreator(OBJECT_SELF), oTarget, bSuccess, nDC,
                        SAVING_THROW_REFLEX, nSaveType, nEvasion);

    // Done.
    return nAdjustedDamage;
}


// Replacement for  MySavingThrow() (in nw_i0_spells) that
// 1) does better handling of immunities, given the needs of traps; and
// 2) gives the trap creator some feedback.
// Returns TRUE if the save was successful, FALSE if failed.
int TrapSavingThrow(object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_TRAP, int nSavingThrow=SAVING_THROW_REFLEX)
{
    int nSuccess = 0;  // 0 == failed, 1 == success, 2 == immunity


    // Sanity checks to prevent wrapping around.
    nDC = nDC <   1 ?   1 :
          nDC > 255 ? 255 : nDC;

    // Do the save and get a visual effect for that save type.
    int nSaveVFX;
    switch ( nSavingThrow )
    {
        case SAVING_THROW_FORT:   nSuccess = FortitudeSave(oTarget, nDC, nSaveType);
                                  nSaveVFX = VFX_IMP_FORTITUDE_SAVING_THROW_USE;
                                  break;

        case SAVING_THROW_REFLEX: nSuccess = ReflexSave(oTarget, nDC, nSaveType);
                                  nSaveVFX = VFX_IMP_REFLEX_SAVE_THROW_USE;
                                  break;

        case SAVING_THROW_WILL:   nSuccess = WillSave(oTarget, nDC, nSaveType);
                                  nSaveVFX = VFX_IMP_WILL_SAVING_THROW_USE;
                                  break;
    }

    // Provide feedback to the trap creator.
    SavingThrowFeedback(GetTrapCreator(OBJECT_SELF), oTarget, nSuccess > 0, nDC,
                        nSavingThrow, nSaveType);

    // Apply an appropriate visual effect.
    switch ( nSuccess )
    {
        case 0: // Failed save.
            // Only add a visual if the save is versus death.
            // (Not needed for any traps currently, but might as well leave it
            // here since it would not be that obvious to a scripter that it was
            // missing.)
            if ( nSaveType == SAVING_THROW_TYPE_DEATH )
                ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                    EffectVisualEffect(VFX_IMP_DEATH),
                                    oTarget);
            break;

        case 1: // Successful save.
            // Use the save visual effect.
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectVisualEffect(nSaveVFX),
                                oTarget);
            break;

        case 2: // Immunity to the save type
            // Use a resistance visual effect.
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE),
                                oTarget);
            // The correct immunity message still needs to be displayed to oTarget.
            // The usual way to do this is to apply an effect of the type that
            // was saved against. If the save is vs. traps, this means claiming
            // that the save failed so that the trap applies an effect.
            // However, if the save is vs. something else, then the save should
            // be considered successful, as the save is for a secondary effect
            // and the thing saved versus is applied regardless of the save's
            // success.
            // ** This is the major change for traps. (The spell version **
            // ** always converts immunity to failure.)                  **
            if ( nSaveType == SAVING_THROW_TYPE_TRAP)
                nSuccess = 0;
            break;
    }

    // Done. Convert nSuccess to TRUE or FALSE.
    return nSuccess > 0;
}


// Returns an appropriate "chunk" visual effect number based upon oTarget's blood type.
int TrapVFXGore(object oTarget)
{
    string sBlood = Get2DAString("appearance", "BLOODCOLR", GetAppearanceType(oTarget));

    // What is the target's blood color?
    if ( sBlood == "R" )
        return VFX_COM_CHUNK_RED_SMALL;
    if ( sBlood == "G" )
        return VFX_COM_CHUNK_GREEN_SMALL;
    if ( sBlood == "Y" )
        return VFX_COM_CHUNK_YELLOW_SMALL;
    if ( sBlood == "W" )
        return VFX_COM_CHUNK_BONE_MEDIUM; // There is no small version for bones.

    // We are out of visual effects. Use a standby.
    return VFX_COM_BLOOD_SPARK_LARGE;
}

