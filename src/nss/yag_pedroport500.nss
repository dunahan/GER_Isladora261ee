void main()
{
    object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 10)
    {
        TakeGoldFromCreature(10, oPC, TRUE);
        object oJumpTo=GetObjectByTag("eski_eldo_hinfahrt");
        AssignCommand(oPC,ActionJumpToObject(oJumpTo));
    }
    else
    {
        SpeakString("Pah, hast nichtmal genug Gold dabei, Landratte");
    }
}
