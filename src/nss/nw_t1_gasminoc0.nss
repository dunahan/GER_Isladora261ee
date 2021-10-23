//::///////////////////////////////////////////////
//:: Gas Trap
//:: NW_T1_GasMinC1.nss
//:://////////////////////////////////////////////
/*
    Creates a  5m poison radius gas cloud that
    lasts for 2 rounds and poisons all creatures
    entering the area with Giant Wasp Venom
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 30, 2001
//:: Adapted from OnHeartbeat to OnEnter: The Krit
//:://////////////////////////////////////////////

void main()
{
    object oTarget = GetEnteringObject();
    effect ePoison = EffectPoison(POISON_GIANT_WASP_POISON);

    if ( !GetIsReactionTypeFriendly(oTarget) )
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oTarget);
}