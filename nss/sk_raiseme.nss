void main()
{
//Get Nearst PC and see if within Distance of Undead PLC.
object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
if (GetIsObjectValid(oPC) == TRUE && GetDistanceToObject(oPC) < 6.0)
    {
    //Get the Tag of the Undead
    string sUndeadTag = GetLocalString       (OBJECT_SELF, "UndeadTag");
    //Get the closest ObjectUndead to Undead PLC.
    object oUndead    = GetNearestObjectByTag(sUndeadTag, OBJECT_SELF);

    //Raise the Undead
    ApplyEffectToObject(DURATION_TYPE_INSTANT , EffectResurrection(), oUndead);
    //Set the Plot Flag to NON-Plot
    SetPlotFlag(oUndead, FALSE);
    //Get the Number of HP to heal the Undead
    effect eHeal = EffectHeal(GetMaxHitPoints(oUndead));
    //Heal the Undead
    ApplyEffectToObject(DURATION_TYPE_INSTANT , eHeal, oUndead);
    //Change the Undead to HOSTILE
    ChangeToStandardFaction(oUndead, STANDARD_FACTION_HOSTILE);
    //Make the Undead attack who ever woke it up.
    AssignCommand(oUndead, ActionAttack(oPC));
    //Make the Undead Die for real.
    AssignCommand(oUndead, SetIsDestroyable(TRUE));
    //Set the Plot Flag of Undead PLC to False
    SetPlotFlag(OBJECT_SELF, FALSE);
    //Destroy the Undead PLC not needed anymore.
    DestroyObject(OBJECT_SELF);
    }
}
