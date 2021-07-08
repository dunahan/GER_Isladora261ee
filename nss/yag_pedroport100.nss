void main()
{
    object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 20)
    {
        TakeGoldFromCreature(20, oPC, TRUE);
        object oJumpTo=GetObjectByTag("eski_eldo_hinfahrt");
        AssignCommand(oPC,ActionJumpToObject(oJumpTo));
    }
    else
    {
        SpeakString("Pah, hast nichtmal genug Gold dabei, Landratte");
    }
}
