//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{

  if (GetStringLeft(GetTag(OBJECT_SELF), 10) == "cre_kobold")
  {
    object oMaster = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    object oCompan = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if (GetDistanceToObject(oMaster) <= 5.0 || GetDistanceToObject(oCompan) <= 5.0)
    {
      ClearAllActions(); ActionMoveAwayFromObject(oMaster, TRUE, 10.0);
      ClearAllActions(); ActionMoveAwayFromObject(oCompan, TRUE, 20.0);
    }
  }

  if (GetStringRight(GetTag(OBJECT_SELF), 5) == "_boss")
  {
    /* if wounded and no longer in combat then rest and wander */
    if ((GetCurrentHitPoints() < GetMaxHitPoints()) && GetIsInCombat() == FALSE )
    { ClearAllActions(TRUE); ActionRest(); ActionRandomWalk(); }
  }

  ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
