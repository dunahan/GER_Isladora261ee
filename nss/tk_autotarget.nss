//::///////////////////////////////////////////////
//:: tk_autotarget
//:://////////////////////////////////////////////
/*
    Causes the caller to use the appropriate combat
    feat or skill without needing to target a
    specific opponent.

    Uses GetSpellId() and tk_playertools.2da to
    determine which feat/skill.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: 2008-10-06
//:://////////////////////////////////////////////

/*************************************************
 * WHAT IT DOES:
 * ------------
 * Player tools that use this script will allow
 * players to use various targeted combat moves
 * on their current target without having to
 * click on the target.
 *
 * This version of the script expects to be used
 * in conjunction with tk_playertools.2da, which
 * allows flexible configuration of the player
 * tools. This script causes the Feat# and Skill#
 * columns to serve double duty -- not only do
 * these columns indicate when the tools are to be
 * given out, but they also indicate which feat or
 * skill the tool activates. (If these columns are
 * not filled in, the "all-in-one" variant is used.)
 *
 * PLAYER'S GUIDE:
 * --------------
 * 1) When targeted on a hostile creature, the
 *    associated combat move will be used on the
 *    target.
 * 2) When the "all-in-one" variant is self-targeted,
 *    the "active" feat/skill will cycle to the next
 *    available one.
 * 3) When targeted on anything else (e.g. the PC when
 *    not using the "all-in-one" variant, a party
 *    member, or an item in inventory) the associated
 *    combat move will be used on the PC's current
 *    combat target.
 * 4) When Animal Empathy is used via these player
 *    tools, the PC will automatically resume
 *    attacking the target if the skill fails (more
 *    accurately, if the target is hostile after
 *    the attempt).
 * 5) When Taunt is used via these player tools, it
 *    no longer sits in the action queue waiting
 *    for combat to end. Instead, the Taunt happens
 *    immediately, and if the target of the Taunt
 *    is still alive (and hostile) at the end of the
 *    Taunt, the PC will automatically resume
 *    attacking it.
 *
 * CAVEAT:
 * ------
 * There is no way to specify which Called Shot to
 * use; the game picks "Arm" or "Leg" seemingly at
 * random.
 *
 * ALL-IN-ONE VARIANT:
 * ------------------
 * The "all-in-one" variant allows a single player
 * tool to handle all the combat feats and skills.
 * This frees up some tools to handle other tasks,
 * without sacrificing much since very few PCs will
 * be able to make use of most -- let alone all --
 * of the combat feats.
 *
 * Each all-in-one variant (this can be assigned to
 * more than one tool) keeps track of which feat or
 * skill is "active" for each player. When targeted
 * on something other than the PC, this active combat
 * move is what is used. When targeted on the PC, the
 * active move cycles through the available options.
 * (It skips abilities that the PC does not have.)
 * The default "active" move is Taunt, since all
 * PCs can Taunt. However, when cycling through
 * abilities, Taunt is skipped unless the PC has at
 * least one rank in it (or unless there are no other
 * options available).
 *
 * The order in which the "all-in-one" variant cycles
 * through skills and feats is:
 *   Animal Empathy
 *   Called Shot
 *   Disarm
 *   Ki Damage
 *   Knockdown
 *   Quivering Palm
 *   Smite Evil
 *   Smite Good
 *   Stunning Fist
 *   Taunt
 * A character will use the improved version of a feat
 * if applicable.
 *
 * NOTE: If you want to change the list of skills/feats
 * for the "all-in-one" variant, all you need to do is
 * edit NextSupportedMove(). Just be sure to keep Taunt
 * in the list as this is the default when starting out.
 *
 * NOTE: Once a tool is used as an "all-in-one" variant
 * by a PC, it will not revert to a single-move
 * variant for that PC, even if the .2da is altered,
 * unless the corresponding skin variable is deleted.
 *************************************************
 * CONFIGURING:
 * -----------
 * 1) The framework for tk_playertools.2da needs to
 *    be installed.
 * 2) This script's name needs to be entered in the
 *    "Script" column for the desired row(s) of
 *    tk_playertools.2da.
 * 3) The index of the desired feat or skill needs
 *    to be entered in the "Skill1" or "Feat1"
 *    column of this row(s). For the "all-in-one"
 *    variant, these columns need to be left with
 *    the "no entry" code, namely ****.
 * 4) For feats with improved versions (i.e. disarm
 *    and knockdown), the index of the improved
 *    version needs to be entered in the "Feat2"
 *    column. For all other feats (including the
 *    "all-in-one" variant), this column needs to
 *    be left with the "no entry" code, namely ****.
 * 5) For the "all-in-one" variant, the "Everyone"
 *    column should be 1 and "AutoRemove" should be
 *    0. For the other tools, this should be reversed,
 *    with 0 in "Everyone" and 1 in "AutoRemove".
 *    Entering something descriptive (without spaces)
 *    in the "Label" column is a good idea.
 *
 * A sample tk_playertools.2da with this information
 * was included in this script's package. This sample
 * uses row 0 to demonstrate the "all-in-one" variant
 * even though row 0 is not actually used in the game.
 *
 * To make it easier for players to remember what the
 * various tools do, an override is available (from
 * the Vault entry where you got this) that allows
 * players to replace the player tool icons with the
 * icons from the various combat feats and skills.
 *************************************************/


// Use skin variables for potential persistency of
// the "all-in-one" selection.
#include "x3_inc_skin"


// The .2da to consult for feat, skill, etc. info.
const string PTOOL_CONFIG_FILE = "tk_playertools";

// Where to start the player tool spells.
// (One less than player tool 1; assumes player tools are sequential.)
const int SPELL_PLAYER_TOOL_BASE = 829;

// The local variables storing the "active" feat/skill for the "all-in-one" variant.
// The number of the tool is appended to this.
const string TK_AUTOTARGET_MOVE = "TK_AUTOTARGET_ActiveMove_";
// If positive, this variable holds a feat number.
// If negative, this variable + 1 is the negative of a skill number.
// If 0, this variable needs to be initialized.

// The local variable storing the current target in case other methods of
// identifying the current target fail.
const string TK_AUTOTARGET_TARGET = "TK_AUTOTARGET_LastTarget";


//------------------------------------------------------------------------------

// Calls ActionAttack() against oTarget if oTarget is (still) hostile.
// Intended to be added to the action queue.
void ActionAttackIfHostile(object oTarget);
void ActionAttackIfHostile(object oTarget)
{
    if ( GetIsEnemy(oTarget) )
        ActionAttack(oTarget);
}


// ---------------------------------------------------------------

// Returns the next (after nMove) feat/skill in the supported list.
// Skills are negative (and not offset by 1).
// bInitial is a flag indicating if this is being called before a certain
// loop starts. This allows unimproved feats to be skipped when the current
// move is the improved version.
int NextSupportedMove(int nMove, int bInitial = FALSE);
int NextSupportedMove(int nMove, int bInitial = FALSE)
{
    // A small hack to make this function simpler to update, yet process
    // improved feats as intended, while avoiding a potential infinite loop if
    // this function is updated poorly.
    int nCurrent = nMove;
    if ( bInitial )
        // Bump the improved feats down to the unimproved versions.
        switch ( nMove )
        {
            case FEAT_IMPROVED_DISARM:      nCurrent = FEAT_DISARM;     break;
            case FEAT_IMPROVED_KNOCKDOWN:   nCurrent = FEAT_KNOCKDOWN;  break;
        }

    // A simple switch to decide what is "next".
    // Edit this switch to add or remove moves, or to change their order.
    switch ( nCurrent )
    {
        case -SKILL_ANIMAL_EMPATHY:     return FEAT_CALLED_SHOT;
        case FEAT_CALLED_SHOT:          return FEAT_IMPROVED_DISARM;
        case FEAT_IMPROVED_DISARM:      return FEAT_DISARM;             // An improved feat should always go to the unimproved version.
        case FEAT_DISARM:               return FEAT_KI_DAMAGE;
        case FEAT_KI_DAMAGE:            return FEAT_IMPROVED_KNOCKDOWN;
        case FEAT_IMPROVED_KNOCKDOWN:   return FEAT_KNOCKDOWN;          // An improved feat should always go to the unimproved version.
        case FEAT_KNOCKDOWN:            return FEAT_QUIVERING_PALM;
        case FEAT_QUIVERING_PALM:       return FEAT_SMITE_EVIL;
        case FEAT_SMITE_EVIL:           return FEAT_SMITE_GOOD;
        case FEAT_SMITE_GOOD:           return FEAT_STUNNING_FIST;
        case FEAT_STUNNING_FIST:        return -SKILL_TAUNT;
        case -SKILL_TAUNT:              return -SKILL_ANIMAL_EMPATHY;
    }

    // Default: Return nMove since getting back to where you started
    // will end the loop that uses this function.
    // This is where an infinite loop could be generated if nCurrent was used
    // instead of nMove.
    return nMove;
}


// ---------------------------------------------------------------

// Determines if the caller has the indicated move (nMove).
// For feats (positive moves), this means having the feat.
// For skills (nonpositive moves), this means having a rank in the skill.
int GetHasMove(int nMove)
{
    if ( nMove > 0 )
        return GetHasFeat(nMove);
    else
        return GetSkillRank(-nMove, OBJECT_SELF, TRUE) > 0;
}


// ---------------------------------------------------------------

// Cycles "all-in-one" tool number nTool to the next (after nActive) available
// feat or skill.
void CycleMove(int nActive, int nTool);
void CycleMove(int nActive, int nTool)
{
    // Adjust for skills being offset by 1.
    if ( nActive < 0 )
        nActive++;

    // Cycle through available feats and skills, looking for one available.
    int nNext = NextSupportedMove(nActive, TRUE);
    while ( nNext != nActive  &&  !GetHasMove(nNext) )
        nNext = NextSupportedMove(nNext);

    // Get the name of the new move.
    string sMove = "";
    if ( nNext > 0 )
        sMove = GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", nNext)));
    else
        sMove = GetStringByStrRef(StringToInt(Get2DAString("skills", "Name", -nNext)));

    // Check for no additional available combat feats/skills.
    if ( nNext == nActive )
        FloatingTextStringOnCreature("Your only targeted combat technique is " + sMove + ".", OBJECT_SELF, FALSE);
    else
    {
        // Set the new move.
        if ( nNext > 0 )
            SetSkinInt(OBJECT_SELF, TK_AUTOTARGET_MOVE + IntToString(nTool), nNext);
        else
            // Skills need to be decreased by 1 so that skill 0 (animal empathy) registers.
            SetSkinInt(OBJECT_SELF, TK_AUTOTARGET_MOVE + IntToString(nTool), nNext - 1);
        // Inform the user.
        FloatingTextStringOnCreature("Targeted combat technique set to " + sMove + ".", OBJECT_SELF, FALSE);
    }
}


//------------------------------------------------------------------------------

// Returns the caller's current combat target.
// oMe should be set to OBJECT_SELF.
object GetCombatTarget(object oMe);
object GetCombatTarget(object oMe)
{
    // Start by checking the last attacked target.
    object oTarget = GetAttackTarget(oMe);

    // Sometimes we need the attempted target.
    if ( !GetIsObjectValid(oTarget) )
        oTarget = GetAttemptedAttackTarget();

    // Support for spellcasting in combat.
    if ( !GetIsObjectValid(oTarget) )
    {
        // Try to get a spell target.
        oTarget = GetAttemptedSpellTarget();
        if ( !GetIsObjectValid(oTarget) )
            oTarget = GetSpellTargetObject();
        // Make sure this is a hostile spell target.
        if ( !GetIsEnemy(oTarget) )
            oTarget = OBJECT_INVALID;
    }

    // If all else fails, use the stored target.
    if ( !GetIsObjectValid(oTarget) )
    {
        oTarget = GetLocalObject(oMe, TK_AUTOTARGET_TARGET);
        // Make sure the stored target is still valid.
        if ( !GetObjectSeen(oTarget, oMe)  &&  !GetObjectHeard(oTarget, oMe) )
            oTarget = OBJECT_INVALID;
        // Any other vital checks? I don't want to limit this more than
        // truly necessary.
    }

    return oTarget;
}


//------------------------------------------------------------------------------

// Causes the caller to use either feat nFeat or feat nImproved (if not 0) on
// oTarget if allowed. Priority is given to nImproved.
void UseTargetedFeat(object oTarget, int nFeat, int nImproved = 0);
void UseTargetedFeat(object oTarget, int nFeat, int nImproved = 0)
{
    // See if we can use the improved feat.
    if ( nImproved > 0  &&  GetHasFeat(nImproved) )
        ActionUseFeat(nImproved, oTarget);

    // Make sure we can use the feat.
    else if ( GetHasFeat(nFeat) )
        ActionUseFeat(nFeat, oTarget);

    else
        // Can't use a feat we don't have.
        FloatingTextStringOnCreature("You cannot use " +
            GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", nFeat))) + ".",
            OBJECT_SELF, FALSE);
}


//------------------------------------------------------------------------------

// Causes the caller to use skill nSkill on oTarget if allowed.
void UseTargetedSkill(object oTarget, int nSkill);
void UseTargetedSkill(object oTarget, int nSkill)
{
    // Make sure we can use the skill.
    if ( GetHasSkill(nSkill) )
    {
        // Taunting needs the action queue cleared to work.
        ClearAllActions();
        ActionUseSkill(nSkill, oTarget);
        // Resume the attack.
        ActionDoCommand(ActionAttackIfHostile(oTarget));
    }

    else
        // Can't use a skill we don't have.
        FloatingTextStringOnCreature("You cannot use " +
            GetStringByStrRef(StringToInt(Get2DAString("skills", "Name", nSkill))) + ".",
            OBJECT_SELF, FALSE);
}


//------------------------------------------------------------------------------
void main()
{
    object oMe     = OBJECT_SELF;   // Used for efficiency.
    object oTarget = GetSpellTargetObject();
    int nTool   = GetSpellId() - SPELL_PLAYER_TOOL_BASE;
    int nActive = GetSkinInt(oMe, TK_AUTOTARGET_MOVE + IntToString(nTool));

    // Targeting self with the all-in-one variant means cycle abilities.
    if ( oTarget == oMe  &&  nActive != 0 )
    {
        CycleMove(nActive, nTool);
        return;
    }

    // Targeting self, a non-hostile, or a non-creature means we use the current
    // attack target.
    if ( oTarget == oMe  ||  !GetIsEnemy(oTarget, oMe)  ||
         GetObjectType(oTarget) != OBJECT_TYPE_CREATURE )
        oTarget = GetCombatTarget(oMe);
    // Remember this target.
    SetLocalObject(oMe, TK_AUTOTARGET_TARGET, oTarget);

    // If not the "all-in-one" tool.
    if ( nActive == 0 )
        // Determine the feat to use.
        nActive = StringToInt(Get2DAString(PTOOL_CONFIG_FILE, "Feat1", nTool));
    // See if there is a feat to use.
    // NOTE: This test assumes feat 0 (alertness) will never be supported.
    if ( nActive > 0 )
    {
        // Make sure a target was found.
        if ( !GetIsObjectValid(oTarget) )
            FloatingTextStringOnCreature("No current target found for autotargeting.", oMe, FALSE);
        else
            // Use the feat.
            UseTargetedFeat(oTarget, nActive,
                StringToInt(Get2DAString(PTOOL_CONFIG_FILE, "Feat2", nTool)));
        // Done.
        return;
    }

    // If the "all-in-one" tool.
    if ( nActive != 0 )
        // Skills are stored as negatives for the "all-in-one" variant. Undo that.
        nActive = -nActive;
    else
    {
        // Determine the skill to use.
        string sSkill =  Get2DAString(PTOOL_CONFIG_FILE, "Skill1", nTool);
        if ( sSkill != "" )
            // Add 1 so that skill 0 (animal empathy) registers as found.
            nActive = StringToInt(sSkill) + 1;
    }
    // See if there is a skill to use.
    if ( nActive > 0 )
    {
        // Make sure a target was found.
        if ( !GetIsObjectValid(oTarget) )
            FloatingTextStringOnCreature("No current target found for autotargeting.", oMe, FALSE);
        else
            // Use the skill (decreased by 1 since that was added to make sure
            // skill 0 (animal empathy) would register as a skill to use).
            UseTargetedSkill(oTarget, nActive - 1);
        // Done.
        return;
    }

    // At this point no skill or feat was specified.
    // So this is an "all-in-one" variant that was not initialized.
    // Default to Taunt and try again.
    SetSkinInt(oMe, TK_AUTOTARGET_MOVE + IntToString(nTool), -SKILL_TAUNT - 1);
    ExecuteScript("tk_autotarget", oMe);
}

