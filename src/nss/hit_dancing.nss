//::///////////////////////////////////////////////
//:: On hitting a Dancing Light
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    // Attacker now has a chance to realise that the Light is not real.
    object oFighter = GetLastDamager();
    int myInt = GetAbilityScore(oFighter, ABILITY_INTELLIGENCE);
    int myRand = Random(myInt);
    //SendMessageToPC(GetFirstPC(), IntToString(myRand));
    if (myRand > 6)
    {
        SetIsTemporaryFriend(oFighter);
        SetIsTemporaryFriend(OBJECT_SELF, oFighter);
    }
}
