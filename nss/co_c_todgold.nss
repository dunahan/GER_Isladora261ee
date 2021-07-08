int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nTode = GetLocalInt(oPC, "DEATH_COUNT");
    int nMult;
    if (nTode == 3) {
        nMult = 10;
    } else {
        nMult = 20;
    }
    int nGold = nMult * GetHitDice(oPC);
    return GetGold(oPC) >= nGold;
}
