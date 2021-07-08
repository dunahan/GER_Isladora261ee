//::///////////////////////////////////////////////
//:: Gas Trap
//:: NW_T1_GasStrC1.nss
//:://////////////////////////////////////////////
/*
    Creates a  5m poison radius gas cloud that
    lasts for 2 rounds and poisons all creatures
    entering the area with Black Lotus Extract
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 30, 2001
//:: Adapted from OnHeartbeat to OnEnter: The Krit
//:://////////////////////////////////////////////

void main()
{
    object oTarget = GetEnteringObject();
    effect ePoison = EffectPoison(POISON_BLACK_LOTUS_EXTRACT);

    if ( !GetIsReactionTypeFriendly(oTarget) )
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oTarget);
}
