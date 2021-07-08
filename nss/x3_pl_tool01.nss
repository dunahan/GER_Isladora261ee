#include "NW_I0_GENERIC"
#include "x0_inc_henai"

// Handles whether we're trying to start or in a conversation
int CheckConversation(object oTalker, int nAction);

// Handles command status stuff
int MakeUncommandable();

// Check if the creature is a minion directly or indirectly
int IsMinion(object oMinion, object oOriginalMaster);

// Regroups the party so no one misses any dialogue
void RegroupParty(object oOriginalMaster);

string HR_GetBaseItemName(object oItem);

void AttackAI(object oTarget, int nCommand, float fTracker, object oArea, object oOriginalMaster);

void SingleAttack(object oTarget, object oOriginalMaster);

void IndAttack(object oOriginalMaster, object oHench, object oTarget);

void TryToMoveToLocation(location lTarget, int nCommand, object oOriginalMaster, float fCloseEnough);

void SingleMoveToLocation(location lTarget, object oOriginalMaster, float fCloseEnough);

void IndMove(object oOriginalMaster, object oHench, location lTarget, float fCloseEnough);

void GroupAttack(object oTarget, object oOriginalMaster);

void GroupMoveToLocation(location lTarget, object oOriginalMaster, float fCloseEnough);

void TryToMoveToCreature(object oTarget, int nCommand, object oArea, object oOriginalMaster, float fCloseEnough);

void SingleMoveToCreature(object oTarget, object oArea, object oOriginalMaster, float fCloseEnough);

void GroupMoveToCreature(object oTarget, object oArea, object oOriginalMaster, float fCloseEnough);

void CheckLockStatus(object oTarget, object oOriginalMaster, int nCommand, object oArea);

void SingleUnlock(object oTarget, object oOriginalMaster, object oArea);

void GroupUnlock(object oTarget, object oOriginalMaster, object oArea);

void CheckDisarmStatus(object oTarget, object oOriginalMaster, int nCommand, int nDisarmActive, object oArea, int iControl);

void SingleDisarm(object oTarget, object oOriginalMaster, int iControl);

void GroupDisarm(object oTarget, object oOriginalMaster, int iControl);

void SetIndBusy(object oMinion);

void SetAllBusy(object oOriginalMaster);

void HenchWithCreatures(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough);

void HenchCheckToAttack(object oHench, object oMaster);

void HenchWithDoors(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough, int iStayAfterAction);

void NPC_Identify_Check(object oMaster, object oHench, object oTarget, object oPos);

void HenchWithItem(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough, int iStayAfterAction);

void HenchWithPLC(object oOriginalMaster, object oHench, object oTarget, float fCloseEnough, int iStayAfterAction, int iControl);

void HenchWithTRIG(object oOriginalMaster, object oHench, object oTarget, float fCloseEnough, int iControl);

void ft_CompanionCTRL(object oCaster, object oTarget, location lTarget);

/// - - - Speaking Strings, converted for easy translations - - - \\\
const string CCS_SPEAK_JUMPPARTY =      "JUMPING PARTY";
const string CCS_SPEAK_DEBUG1 =         "DEBUG 1";
const string CCS_SPEAK_DEBUG3 =         "DEBUG 3";
const string CCS_SPEAK_DEBUG4 =         "DEBUG 4";
const string CCS_SPEAK_DEBUG5 =         "DEBUG 5";
const string CCS_SPEAK_DEBUGATTACK =    "Debug Attack";

const string CCS_SPEAK_SENDINGHENCH =   "Sending ";
const string CCS_SPEAK_DEALWITHLOCK =   " to deal with the lock.";
const string CCS_SPEAK_CANTOPENLOCK =   " cannot deal with the lock.";
const string CCS_SPEAK_DEALWITHTRAP =   " to deal with the trap.";
const string CCS_SPEAK_CANTDEALTRAP =   " cannot deal with the trap.";
const string CCS_SPEAK_PICKUPTHEITM =   " to pick up the ";

const string CCS_SPEAK_NOTRAPNOLOCK =   "That door is not locked or trapped. Sending ";
const string CCS_SPEAK_OBJNOTRAPLOCK=   "That object is not locked or trapped. Interacting with it.";
const string CCS_SPEAK_OPENDOOR =       " to open it.";
const string CCS_SPEAK_CLOSEDOOR =      " to close it.";

const string CCS_SPEAK_CANTIDENTITM =   "Sorry, I cannot identify the ";
const string CCS_SPEAK_MAGICALPROPS =   " magical properties.";

const string CCS_SPEAK_ACTIVITYDONE =   "There you go, all done.";

const string CCS_SPEAK_ISCONVREGRUP =   "In a conversation, regrouping party.";

const string CCS_SPEAK_INDIVDATTACK = "INDIVIDUAL ATTACK";
const string CCS_SPEAK_INDIVUALMOVE = "INDIVIDUAL MOVE";
const string CCS_SPEAK_GROUPATTACKS = "GROUP ATTACKING";
const string CCS_SPEAK_GROUPMOVES = "GROUP MOVING";
const string CCS_SPEAK_CONTROLGROUP = "CONTROLING GROUP";
const string CCS_SPEAK_CONTROLINDIV = "CONTROLING INDIVIDUAL: ";
/// - - -                                                   - - - \\\


void main()
{
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    object oCaster = OBJECT_SELF;

    ft_CompanionCTRL(oCaster,oTarget,lTarget);
}


/// - - - Following function bodys - - - \\\
int CheckConversation(object oTalker, int nAction)
{
    //return (nAction == ACTION_WAIT || IsInConversation(oTalker));
    return (IsInConversation(oTalker));
}

int MakeUncommandable()
{
    int nCommand = GetLocalInt(OBJECT_SELF, "bmc_value");
    SetLocalInt(OBJECT_SELF, "bmc_active", 1);

    // This progresses our bmc_value so we know whether the order is current
    // The %10000 prevents it from potentially going out of bounds -- not sure how
    // NWN handles that so let's be safe
    nCommand = (++nCommand)%10000;

    SetLocalInt(OBJECT_SELF, "bmc_value", nCommand);

    return nCommand;
}

int IsMinion(object oMinion, object oOriginalMaster)
{
    return (GetMaster(oMinion) == oOriginalMaster || GetMaster(GetMaster(oMinion)) == oOriginalMaster || GetMaster(GetMaster(GetMaster(oMinion))) == oOriginalMaster);
}

void RegroupParty(object oOriginalMaster)
{
    int iNoRegroup = GetLocalInt(oOriginalMaster, "NoRegrouping");
    if (iNoRegroup) return;
    FloatingTextStringOnCreature(CCS_SPEAK_JUMPPARTY, oOriginalMaster, FALSE);

    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);

    while (GetIsObjectValid(oMinion))
    {
        // Regroup the party for a nice chat
        if (IsMinion(oMinion,oOriginalMaster))
        {
            SetLocalInt(oMinion, "bmc_active", 0);

            if (!CheckConversation(oMinion, GetCurrentAction(oMinion)))
            {
                AssignCommand(oMinion, ClearAllActions(TRUE));
                AssignCommand(oMinion, JumpToObject(oOriginalMaster));
            }
        }
        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

string HR_GetBaseItemName(object oItem)
{
    string sItem;
    int iBaseTy = GetBaseItemType(oItem);
    string sBaseType = Get2DAString("baseitems", "Name", iBaseTy);
    int iBaseTlk = StringToInt(sBaseType);
    string sTlk_Item = GetStringByStrRef(iBaseTlk, GENDER_MALE);
    sItem = sTlk_Item;

    return sItem;
}

void AttackAI(object oTarget, int nCommand, float fTracker, object oArea, object oOriginalMaster)
{
    // Has our command value changed?
    if (nCommand != GetLocalInt(OBJECT_SELF, "bmc_value") || !GetLocalInt(OBJECT_SELF, "bmc_active"))
        return;

    int nAction = GetCurrentAction();
    if  (CheckConversation(OBJECT_SELF, nAction) || IsInConversation(oOriginalMaster))
    {
        FloatingTextStringOnCreature(CCS_SPEAK_DEBUG1, oOriginalMaster, FALSE);
        DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        RegroupParty(oOriginalMaster);
        return;
    }

    if (GetIsDead(oTarget) || !GetIsEnemy(oTarget) || GetArea(oTarget) != oArea || GetIsDead(OBJECT_SELF) ||
       (GetMaster() != oOriginalMaster && GetMaster(GetMaster()) != oOriginalMaster && GetMaster(GetMaster(GetMaster())) != oOriginalMaster))
    {
        DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    if (nAction == ACTION_ATTACKOBJECT)
    {
        if (fTracker >= 4.0)
        {
            DetermineCombatRound(oTarget);

            if (GetCurrentAction() != ACTION_INVALID)
                DelayCommand(0.5, AttackAI(oTarget, nCommand, 0.0, oArea,oOriginalMaster));

            else
            {
                ActionAttack(oTarget);
                DelayCommand(0.5, AttackAI(oTarget, nCommand, fTracker + 0.5, oArea,oOriginalMaster));
            }
        }

        else if (fTracker >= 2.0)
            DelayCommand(0.5, AttackAI(oTarget, nCommand, fTracker + 0.5, oArea,oOriginalMaster));

        else
            DelayCommand(0.5, AttackAI(oTarget, nCommand, 0.0, oArea,oOriginalMaster));

    }

    else if (nAction == ACTION_INVALID)
    {
        if (fTracker >= 1.5)
        {
            ActionAttack(oTarget);
            DelayCommand(0.5, AttackAI(oTarget, nCommand, fTracker + 0.5, oArea,oOriginalMaster));
        }
        else
        {
            DetermineCombatRound(oTarget);
            DelayCommand(0.5, AttackAI(oTarget, nCommand, fTracker + 0.5, oArea,oOriginalMaster));
        }
    }

    else if (nAction == ACTION_FOLLOW)
    {
            ClearAllActions();
            DetermineCombatRound(oTarget);
            DelayCommand(0.5, AttackAI(oTarget, nCommand, fTracker + 0.5, oArea,oOriginalMaster));
    }

    else
        DelayCommand(0.5, AttackAI(oTarget, nCommand, 0.0, oArea,oOriginalMaster));
}

void SingleAttack(object oTarget, object oOriginalMaster)
{
    int nCommand = MakeUncommandable();

    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);

    // Aielund specific, cancel peaceful follow mode
    //if (GetLocalInt(OBJECT_SELF,"DoNotAttack"))
    //{
    //    SetLocalInt(OBJECT_SELF,"DoNotAttack",FALSE);
    //    SpeakString(sHenchPeacefulModeCancel);
    //}

    SetLocalObject(OBJECT_SELF, "bmc_attacktarget", oTarget);
    DetermineCombatRound(oTarget);
    DelayCommand(0.5, AttackAI(oTarget, nCommand, 0.0, GetArea(OBJECT_SELF),oOriginalMaster));
}

void IndAttack(object oOriginalMaster, object oHench, object oTarget)
{
    SendMessageToPC(oOriginalMaster, CCS_SPEAK_INDIVDATTACK);

    if(GetIsObjectValid(oHench))
        AssignCommand(oHench, SingleAttack(oTarget, oOriginalMaster));
}

void TryToMoveToLocation(location lTarget, int nCommand, object oOriginalMaster, float fCloseEnough)
{
    // Has our command value changed?
    if (nCommand != GetLocalInt(OBJECT_SELF, "bmc_value") || !GetLocalInt(OBJECT_SELF, "bmc_active"))
        return;

    float fDist = GetDistanceBetweenLocations(lTarget, GetLocation(OBJECT_SELF));
    int nAction = GetCurrentAction();
    string sAction =IntToString(nAction);
    //FloatingTextStringOnCreature(sAction, oOriginalMaster, FALSE);
    //65535 standard / Invalid
    //36 Wait
    if  (CheckConversation(OBJECT_SELF, nAction) || IsInConversation(oOriginalMaster))
    {
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        RegroupParty(oOriginalMaster);
        return;
    }

    // Are we in another area or dead or fired?
    if (fDist < 0.0  || GetIsDead(OBJECT_SELF) || (GetMaster() != oOriginalMaster && GetMaster(GetMaster()) != oOriginalMaster && GetMaster(GetMaster(GetMaster())) != oOriginalMaster))
    {
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    // Only give the move command if we're too far away and not moving
    if (fDist > fCloseEnough && nAction != ACTION_MOVETOPOINT)
    {
        ClearAllActions();
        ActionMoveToLocation(lTarget, TRUE);
    }

    int iOverrideMove = GetLocalInt(OBJECT_SELF, "Temp_override_m");

    // Call again until we're there, bmc_value changes, or we time out
    if (!iOverrideMove)
        DelayCommand(0.5, TryToMoveToLocation(lTarget, nCommand, oOriginalMaster, fCloseEnough));
}

void SingleMoveToLocation(location lTarget, object oOriginalMaster, float fCloseEnough)
{
    int nCommand = MakeUncommandable();

    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");
    SetLocalInt(OBJECT_SELF, "Temp_override_m", 0);

    TryToMoveToLocation(lTarget, nCommand, oOriginalMaster, fCloseEnough);
}

void IndMove(object oOriginalMaster, object oHench, location lTarget, float fCloseEnough)
{
    SendMessageToPC(oOriginalMaster, CCS_SPEAK_INDIVUALMOVE);
    if(GetIsObjectValid(oHench))
        AssignCommand(oHench, SingleMoveToLocation(lTarget, oOriginalMaster, fCloseEnough));
}

void GroupAttack(object oTarget, object oOriginalMaster)
{
    SendMessageToPC(oOriginalMaster, CCS_SPEAK_GROUPATTACKS);
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);
    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master (or master's master for minion summons or
        // even master's master's master) is the PC, issue orders to attack
        if (IsMinion(oMinion, oOriginalMaster))
            AssignCommand(oMinion, SingleAttack(oTarget,oOriginalMaster));

        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}


void GroupMoveToLocation(location lTarget, object oOriginalMaster, float fCloseEnough)
{
    SendMessageToPC(oOriginalMaster, CCS_SPEAK_GROUPMOVES);
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);
    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master (or master's master for minion summons or
        // even master's master's master) is the PC, issue orders to move to the location
        if (IsMinion(oMinion, oOriginalMaster))
            AssignCommand(oMinion, SingleMoveToLocation(lTarget, oOriginalMaster, fCloseEnough));

        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

void TryToMoveToCreature(object oTarget, int nCommand, object oArea, object oOriginalMaster, float fCloseEnough)
{
    // Has our command value changed?
    if (nCommand != GetLocalInt(OBJECT_SELF, "bmc_value") || !GetLocalInt(OBJECT_SELF, "bmc_active"))
        return;

    int nAction = GetCurrentAction();
    if  (CheckConversation(OBJECT_SELF, nAction) || IsInConversation(oOriginalMaster))
    {
        FloatingTextStringOnCreature(CCS_SPEAK_DEBUG3, oOriginalMaster, FALSE);
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        RegroupParty(oOriginalMaster);
        return;
    }

    // Are we in another area or dead or fired?
    if (GetArea(OBJECT_SELF) != oArea || GetIsDead(OBJECT_SELF) ||
       (GetMaster() != oOriginalMaster && GetMaster(GetMaster()) != oOriginalMaster && GetMaster(GetMaster(GetMaster())) != oOriginalMaster))
    {
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    float fDist = GetDistanceBetween(oTarget, OBJECT_SELF);

    // Only give the command if we're too far away and not moving
    if (fDist > fCloseEnough && GetCurrentAction() != ACTION_MOVETOPOINT)
    {
        ClearAllActions();
        ActionMoveToObject(oTarget, TRUE);
    }

    // Call again until bmc_value changes or something else cancels us out
    DelayCommand(0.5, TryToMoveToCreature(oTarget, nCommand, oArea,oOriginalMaster,fCloseEnough));
}

void SingleMoveToCreature(object oTarget, object oArea, object oOriginalMaster, float fCloseEnough)
{
    int nCommand = MakeUncommandable();

    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");

    TryToMoveToCreature(oTarget, nCommand, GetArea(OBJECT_SELF), oOriginalMaster, fCloseEnough);
}

void GroupMoveToCreature(object oTarget, object oArea, object oOriginalMaster, float fCloseEnough)
{
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);
    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master (or master's master for minion summons or
        // even master's master's master) is the PC, issue orders to follow the creature
        if (IsMinion(oMinion,oOriginalMaster))
            AssignCommand(oMinion, SingleMoveToCreature(oTarget, oArea, oOriginalMaster, fCloseEnough));

        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

void CheckLockStatus(object oTarget, object oOriginalMaster, int nCommand, object oArea)
{
    // Has our command value changed?
    if (nCommand != GetLocalInt(OBJECT_SELF, "bmc_value") || !GetLocalInt(OBJECT_SELF, "bmc_active"))
        return;

    int nAction = GetCurrentAction();
    if  (CheckConversation(OBJECT_SELF, nAction) || IsInConversation(oOriginalMaster))
    {
        FloatingTextStringOnCreature(CCS_SPEAK_DEBUG4, oOriginalMaster, FALSE);
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        RegroupParty(oOriginalMaster);
        return;
    }

    // Are we in another area or dead or fired?
    if (GetArea(OBJECT_SELF) != oArea || GetIsDead(OBJECT_SELF) ||
      (GetMaster() != oOriginalMaster && GetMaster(GetMaster()) != oOriginalMaster && GetMaster(GetMaster(GetMaster())) != oOriginalMaster))
    {
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    if (GetLocked(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        if (GetCurrentAction() == ACTION_INVALID)
        {
            ClearAllActions();
            bkAttemptToOpenLock(oTarget);
        }
        DelayCommand(0.5, CheckLockStatus(oTarget, oOriginalMaster, nCommand, oArea));
    }
    else
    {
        ResetHenchmenState();
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
    }
}

void SingleUnlock(object oTarget, object oOriginalMaster, object oArea)
{
    int nCommand = MakeUncommandable();

    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");

    if (!bkAttemptToOpenLock(oTarget))
    {
        FloatingTextStringOnCreature(GetName(OBJECT_SELF) + CCS_SPEAK_CANTOPENLOCK, GetMaster(), FALSE);
        ResetHenchmenState();
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    DelayCommand(0.5, CheckLockStatus(oTarget, oOriginalMaster,nCommand, GetArea(OBJECT_SELF)));
}

void GroupUnlock(object oTarget, object oOriginalMaster, object oArea)
{
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);
    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master is the PC, issue orders to unlock (NOT including summons of minions)
        if (GetMaster(oMinion) == oOriginalMaster)
        {
            int iUL_Rank =GetSkillRank(SKILL_OPEN_LOCK,oMinion,TRUE);
            if(GetAssociateState(NW_ASC_RETRY_OPEN_LOCKS, oMinion) || iUL_Rank >= 1)
            {
                FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH  + GetName(oMinion) + CCS_SPEAK_DEALWITHLOCK, oOriginalMaster, FALSE);
                AssignCommand(oMinion, SingleUnlock(oTarget, oOriginalMaster, oArea));
            }
        }
        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

void CheckDisarmStatus(object oTarget, object oOriginalMaster, int nCommand, int nDisarmActive, object oArea, int iControl)
{
   int Trap_OFF = GetLocalInt(OBJECT_SELF, "Hen_TrapOff");

    // Has our command value changed?
    if (nCommand != GetLocalInt(OBJECT_SELF, "bmc_value") || !GetLocalInt(OBJECT_SELF, "bmc_active"))
        return;

    int nAction = GetCurrentAction();
    if  (CheckConversation(OBJECT_SELF, nAction) || IsInConversation(oOriginalMaster))
    {
        //FloatingTextStringOnCreature(CCS_SPEAK_DEBUG5, oOriginalMaster, FALSE);
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        RegroupParty(oOriginalMaster);
        return;
    }

    // Are we in another area or dead or fired?
    if (GetArea(OBJECT_SELF) != oArea || GetIsDead(OBJECT_SELF) ||
       (GetMaster() != oOriginalMaster && GetMaster(GetMaster()) != oOriginalMaster && GetMaster(GetMaster(GetMaster())) != oOriginalMaster))
    {
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
        return;
    }

    if (GetTrapDetectedBy(oTarget, OBJECT_SELF))
    {
        if (GetDistanceToObject(oTarget) > 15.0 || !bkGetIsInLineOfSight(oTarget))
            ActionMoveToObject(oTarget, TRUE);

        else
        {
            if (!nDisarmActive)
            {
                ClearAllActions();
                if (!bkAttemptToDisarmTrap(oTarget, TRUE) && !Trap_OFF && !iControl)
                {
                    FloatingTextStringOnCreature(GetName(OBJECT_SELF) + CCS_SPEAK_CANTDEALTRAP, GetMaster(), FALSE);
                    ResetHenchmenState();
                    SetLocalInt(OBJECT_SELF, "bmc_active", 0);
                    return;
                }
                nDisarmActive = 1;
            }
            else if (nAction == ACTION_INVALID && nDisarmActive)
            {
                if (iControl && Trap_OFF)
                    SetAssociateState(NW_ASC_DISARM_TRAPS, TRUE, OBJECT_SELF);

                ClearAllActions();
                bkAttemptToDisarmTrap(oTarget, TRUE);

                if (Trap_OFF && iControl)
                    SetAssociateState(NW_ASC_DISARM_TRAPS, FALSE, OBJECT_SELF);
            }
        }
        DelayCommand(0.1, CheckDisarmStatus(oTarget, oOriginalMaster, nCommand, nDisarmActive, oArea, iControl));
    }
    else
    {
        ResetHenchmenState();
        SetLocalInt(OBJECT_SELF, "bmc_active", 0);
    }
}

void SingleDisarm(object oTarget, object oOriginalMaster, int iControl)
{
    int nCommand = MakeUncommandable();

    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DeleteLocalObject(OBJECT_SELF, "bmc_attacktarget");

    CheckDisarmStatus(oTarget, oOriginalMaster, nCommand, 0, GetArea(OBJECT_SELF), iControl);
}

void GroupDisarm(object oTarget, object oOriginalMaster, int iControl)
{
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);

    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master is the PC, issue orders to disarm (NOT including summons of minions)
        if (GetMaster(oMinion) == oOriginalMaster)
        {
           int iDD_Rank = GetSkillRank(SKILL_DISABLE_TRAP, oMinion, TRUE);
           if(GetAssociateState(NW_ASC_DISARM_TRAPS, oMinion) || iDD_Rank >= 1)
           {
                FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oMinion) + CCS_SPEAK_DEALWITHTRAP, oOriginalMaster, FALSE);
                AssignCommand(oMinion, SingleDisarm(oTarget, oOriginalMaster, 1));
            }
        }
        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

void SetIndBusy(object oMinion)
{
    SetAssociateState(NW_ASC_IS_BUSY, TRUE, oMinion);
}

void SetAllBusy(object oOriginalMaster)
{
    // Going to loop through members of the party
    object oMinion = GetFirstFactionMember(oOriginalMaster, FALSE);

    while (GetIsObjectValid(oMinion))
    {
        // If the party member's master is the PC, issue orders to disarm (NOT including summons of minions)

        if (GetMaster(oMinion) == oOriginalMaster)
             SetAssociateState(NW_ASC_IS_BUSY, TRUE, oMinion);

        oMinion = GetNextFactionMember(oOriginalMaster, FALSE);
    }
}

void HenchWithCreatures(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough)
{
    object oArea = GetArea(oTarget);
    // Attack enemies
    if (GetIsEnemy(oTarget, oOriginalMaster) && !iControl)
        GroupAttack(oTarget, oOriginalMaster);

    else if (GetIsEnemy(oTarget, oOriginalMaster) && iControl)
        IndAttack(oOriginalMaster, oHench, oTarget);

    // Move to friendly/neutral targets
    else
        GroupMoveToCreature(oTarget, oArea, oOriginalMaster, fCloseEnough);
}

void HenchCheckToAttack(object oHench, object oMaster)
{
    FloatingTextStringOnCreature(CCS_SPEAK_DEBUGATTACK, oMaster, FALSE);
    object oN_Enemy = GetNearestEnemy(oHench);
    float fEnemy = GetDistanceBetween(oHench, oN_Enemy);

    if (fEnemy <= 8.0)
        AssignCommand(oHench, IndAttack(oMaster, oHench, oN_Enemy));
}

void HenchWithDoors(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough, int iStayAfterAction)
{
    object oArea = GetArea(oTarget);
    location loc_Door = GetLocation(oTarget);
    float f_Door_D = GetDistanceBetween(oHench, oTarget);
    // Disarm trapped doors
    if (GetTrapDetectedBy(oTarget, oOriginalMaster) && !iControl)
    {
        GroupDisarm(oTarget, oOriginalMaster, iControl);
        return;
    }
    if (GetTrapDetectedBy(oTarget, oOriginalMaster) && iControl)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_CANTDEALTRAP, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleDisarm(oTarget, oOriginalMaster, iControl));
        return;
    }
    // Open locked doors
    if (GetLocked(oTarget) && !iControl)
    {
        GroupUnlock(oTarget, oOriginalMaster, oArea);
        return;
    }
    if(GetLocked(oTarget) && iControl)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_DEALWITHLOCK, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleUnlock(oTarget, oOriginalMaster, oArea));
        return;
    }
    else if(iControl && GetIsOpen(oTarget) == FALSE)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_NOTRAPNOLOCK + GetName(oHench) + CCS_SPEAK_OPENDOOR, oOriginalMaster, FALSE);
        //float fDistance =GetDistanceBetween(oHench,oTarget);
        //fDistance = fDistance/2;
        //string sDistance = FloatToString(fDistance,2,1);
        //FloatingTextStringOnCreature(sDistance, oMaster, FALSE);
        AssignCommand(oHench, SingleMoveToLocation(GetLocation(oHench), oOriginalMaster, fCloseEnough));
        AssignCommand(oHench, ActionMoveToObject(oTarget, TRUE, 1.0));
        AssignCommand(oHench, ActionOpenDoor(oTarget));
        //if you want them to attack any close after opening the door.
        //DelayCommand(fDistance,AssignCommand(oHench,HenchCheckToAttack(oHench,oMaster)));
        // if you want them to stay at the door.
        if (iStayAfterAction)
            AssignCommand(oHench, SetLocalInt(oHench, "Temp_override_m", 1));

        AssignCommand(oHench, ActionDoCommand(SetCommandable(TRUE)));
        AssignCommand(oHench, SetCommandable(FALSE));

        return;
    }
    else if(iControl && GetIsOpen(oTarget) == TRUE)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_NOTRAPNOLOCK + GetName(oHench) + CCS_SPEAK_CLOSEDOOR, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleMoveToLocation(GetLocation(oHench), oOriginalMaster, fCloseEnough));
        AssignCommand(oHench, ActionMoveToObject(oTarget, TRUE, 1.0));
        AssignCommand(oHench, ActionCloseDoor(oTarget));
        AssignCommand(oHench, ActionDoCommand(SetCommandable(TRUE)));
        AssignCommand(oHench, SetCommandable(FALSE));
        return;
    }
}

void NPC_Identify_Check(object oMaster, object oHench, object oTarget, object oPos)
{
    string sT_Name = HR_GetBaseItemName(oTarget);
    int nMyLore = GetSkillRank(SKILL_LORE, oHench);
    int nItemValue; // gold value of item
    string sMaxValue = Get2DAString("hr_skillvsitemco", "DeviceCostMax", nMyLore); // max value that the henchman can id
    int nMaxValue = StringToInt(sMaxValue);
    // * Handle overflow (November 2003 - BK)
    if (sMaxValue == "")
        nMaxValue = 120000000;

    SetIdentified(oTarget, TRUE); // setting TRUE to get the true value of the item
    nItemValue = GetGoldPieceValue(oTarget);
    string sItemValue = IntToString(nItemValue);
    SetIdentified(oTarget, FALSE); // back to FALSE
    string sResponseForMaster;

    if(nMaxValue < nItemValue)
    {
        //You could use local string for this responds
        //so each henchmen say something different.
        sResponseForMaster = GetLocalString(OBJECT_SELF, "CCS_RESPONSE_IDITM");
        if (sResponseForMaster == "")
            sResponseForMaster = CCS_SPEAK_CANTIDENTITM + sT_Name + CCS_SPEAK_MAGICALPROPS;

        FloatingTextStringOnCreature(sResponseForMaster, oHench, TRUE);
        return;
    }

    if(nMaxValue >= nItemValue && oPos !=oMaster)
    {
        //You could use local string for this responds
        //so each henchmen say something different.
        sResponseForMaster = GetLocalString(OBJECT_SELF, "CCS_RESPONSE_ACTDONE");
        if (sResponseForMaster == "")
            sResponseForMaster = CCS_SPEAK_ACTIVITYDONE;

        FloatingTextStringOnCreature(sResponseForMaster, oHench, TRUE);
        SetIdentified(oTarget, TRUE);
        //Have to refresh the inventory by calling this twice.
        OpenInventory(oPos,oMaster);
        OpenInventory(oPos,oMaster);
    }

    if(nMaxValue >= nItemValue && oPos ==oMaster)
    {
        //we cannot refresh pc inventory but we can refresh the item with
        //an examine call.
        //You could use local string for this responds
        //so each henchmen say something different.
        sResponseForMaster = GetLocalString(OBJECT_SELF, "CCS_RESPONSE_ACTDONE");
        if (sResponseForMaster == "")
            sResponseForMaster = CCS_SPEAK_ACTIVITYDONE;

        FloatingTextStringOnCreature(sResponseForMaster, oHench, TRUE);
        SetIdentified(oTarget, TRUE);
        AssignCommand(oMaster,ActionExamine(oTarget));
    }
}

void HenchWithItem(object oOriginalMaster, object oHench, object oTarget, int iControl, float fCloseEnough, int iStayAfterAction)
{
    object oPos =GetItemPossessor(oTarget);
    int iHenchOrMaster;
    int iMinPos = IsMinion(oPos,oOriginalMaster);
    if(iMinPos || oPos ==oOriginalMaster)iHenchOrMaster=TRUE;
    int iAssType =GetAssociateType(oHench);
    string sT_Name = HR_GetBaseItemName(oTarget);
    if(iControl && oPos == OBJECT_INVALID)
    {
        if(iAssType ==ASSOCIATE_TYPE_FAMILIAR ||  iAssType ==ASSOCIATE_TYPE_ANIMALCOMPANION || iAssType ==ASSOCIATE_TYPE_SUMMONED
        || iAssType ==ASSOCIATE_TYPE_DOMINATED)
        {
            //Will add bring object to master (fetching) with size related to weight of item later.
            AssignCommand(oHench, SingleMoveToLocation(GetLocation(oHench),oOriginalMaster,fCloseEnough));
            AssignCommand(oHench,ActionDoCommand(SetCommandable(TRUE)));
            AssignCommand(oHench, SetCommandable(FALSE));
            return;
        }

        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_PICKUPTHEITM + sT_Name, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleMoveToLocation(GetLocation(oHench),oOriginalMaster,fCloseEnough));
        AssignCommand(oHench,ActionMoveToObject(oTarget,TRUE,0.5));
        AssignCommand(oHench,ActionPickUpItem(oTarget));

        if(iStayAfterAction)AssignCommand(oHench,SetLocalInt(oHench,"Temp_override_m",1));

        AssignCommand(oHench,ActionDoCommand(SetCommandable(TRUE)));
        AssignCommand(oHench, SetCommandable(FALSE));
    }

    int iID =GetIdentified(oTarget);
    if(iControl && iHenchOrMaster && iID==FALSE)
    {
        NPC_Identify_Check(oOriginalMaster,oHench,oTarget,oPos);
    }
}

void HenchWithPLC(object oOriginalMaster, object oHench, object oTarget, float fCloseEnough, int iStayAfterAction, int iControl)
{
    object oArea = GetArea(oTarget);

    if(GetTrapDetectedBy(oTarget, oOriginalMaster)&& !iControl)
    {
        GroupDisarm(oTarget,oOriginalMaster,iControl);
        return;
    }
    if (GetTrapDetectedBy(oTarget, oOriginalMaster)&& iControl)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_DEALWITHTRAP, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleDisarm(oTarget,oOriginalMaster,iControl));
        return;
    }
    if (GetLocked(oTarget)&& !iControl)
    {
        GroupUnlock(oTarget,oOriginalMaster,oArea);
     }
    else if(GetLocked(oTarget)&& iControl)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_DEALWITHLOCK, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleUnlock(oTarget,oOriginalMaster,oArea));
    }
    else if(iControl)
    {
       FloatingTextStringOnCreature(CCS_SPEAK_OBJNOTRAPLOCK, oOriginalMaster, FALSE);
       AssignCommand(oHench, SingleMoveToLocation(GetLocation(oHench),oOriginalMaster,fCloseEnough));
       AssignCommand(oHench,ActionMoveToObject(oTarget,TRUE,1.0));
       AssignCommand(oHench, ActionInteractObject(oTarget));
       // if you want them to stay.
       if(iStayAfterAction)AssignCommand(oHench,SetLocalInt(oHench,"Temp_override_m",1));
       AssignCommand(oHench,ActionDoCommand(SetCommandable(TRUE)));
       AssignCommand(oHench,SetCommandable(FALSE));
    }
}

void HenchWithTRIG(object oOriginalMaster, object oHench, object oTarget, float fCloseEnough, int iControl)
{
    object oArea = GetArea(oTarget);
    if(GetTrapDetectedBy(oTarget, oOriginalMaster)&& !iControl)
    {
        GroupDisarm(oTarget,oOriginalMaster,iControl);
    }
    if (GetTrapDetectedBy(oTarget, oOriginalMaster)&& iControl)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_SENDINGHENCH + GetName(oHench) + CCS_SPEAK_DEALWITHTRAP, oOriginalMaster, FALSE);
        AssignCommand(oHench, SingleDisarm(oTarget,oOriginalMaster,iControl));
    }
}

void ft_CompanionCTRL(object oCaster, object oTarget, location lTarget)
{
    object oCur_Hench;
    float fCloseEnough = 1.5;
    int iAssType =GetAssociateType(oTarget);
    string sHighLighColor;
    //object oPer =GetPersistentItemOnPc(oCaster);

    //Are we highlighting a single companion or the whole group
    int iSingleCom = GetLocalInt(oCaster,"SingleCom");

    //if 1 will stay after action.
    int iStayAfterAction = 1;

    // This will need to be changed if an item is used instead of a player feat
   object oOriginalMaster = oCaster;

    //Not jumping on conversations.
    int iNoRegrouping = 1;
    SetLocalInt(oOriginalMaster,"NoRegrouping",iNoRegrouping);

    //1 if we controling the group / 0 for indiviual.
    int iSingleControl = GetLocalInt(oOriginalMaster,"SINGLE_C");

    // Find what we targeted
    object oTarget = GetSpellTargetObject();

    // If we have a valid target, use that location, otherwise get the location
    location lTarget = GetLocation(oTarget);
    if (oTarget == OBJECT_INVALID)
    {
        lTarget = GetSpellTargetLocation();
    }

    // If we're in a conversation, prevent new commands as it might
    // break the dialogue if minions move around.  Regroup party instead.
    if (IsInConversation(oOriginalMaster) && !iNoRegrouping)
    {
        FloatingTextStringOnCreature(CCS_SPEAK_ISCONVREGRUP, oOriginalMaster, FALSE);
        RegroupParty(oOriginalMaster);
        return;
    }

    if(oTarget == oOriginalMaster)
    {
        SetLocalInt(oOriginalMaster,"SINGLE_C",0);
        SendMessageToPC(oOriginalMaster, CCS_SPEAK_CONTROLGROUP);
        return;
    }

    int iType =GetObjectType(oTarget);
    int iIsMyMinion = IsMinion(oTarget,oOriginalMaster);

    if(iType == OBJECT_TYPE_CREATURE && iIsMyMinion && oTarget != oOriginalMaster)
    {
        SetLocalInt(oOriginalMaster,"SINGLE_C",1);
        SendMessageToPC(oOriginalMaster, CCS_SPEAK_CONTROLINDIV + GetName(oTarget));

        SetLocalObject(oOriginalMaster,"Cur_Hench",oTarget);
        return;
    }

    object oCur_H =GetLocalObject(oOriginalMaster,"Cur_Hench");

    // Targeted on object
    if (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            HenchWithCreatures(oOriginalMaster,oCur_H,oTarget,iSingleControl,fCloseEnough);
            return;
        }
        if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
        {
            HenchWithDoors(oOriginalMaster,oCur_H,oTarget,iSingleControl,fCloseEnough,iStayAfterAction);
            return;
        }
        if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            HenchWithItem(oOriginalMaster,oCur_H,oTarget,iSingleControl,fCloseEnough,iStayAfterAction);
            return;
        }
        if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
        {
            HenchWithPLC(oOriginalMaster,oCur_H,oTarget,fCloseEnough,iStayAfterAction,iSingleControl);
            return;
        }
        if (GetObjectType(oTarget) == OBJECT_TYPE_TRIGGER)
        {
            HenchWithTRIG(oOriginalMaster,oCur_H,oTarget,fCloseEnough,iSingleControl);
            return;
        }
    }
    else
    {
        // Move to location
        if(!iSingleControl)GroupMoveToLocation(lTarget,oOriginalMaster,fCloseEnough);
        if(iSingleControl)IndMove(oOriginalMaster,oCur_H,lTarget,fCloseEnough);
    }
}
