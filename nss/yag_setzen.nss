void main()
{
    object oPC = GetPCSpeaker();
    object oChair = GetNearestObjectByTag("sitzen", OBJECT_SELF, 1);

    if (!GetIsObjectValid(GetSittingCreature(oChair)))
    {
        AssignCommand(oPC, ActionSit(oChair));
    }
}
