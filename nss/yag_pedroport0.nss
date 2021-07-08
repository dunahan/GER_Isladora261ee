void main()
{
    object oPC = GetPCSpeaker();
    object oJumpTo=GetObjectByTag("eski_eldo_hinfahrt");
    AssignCommand(oPC,ActionJumpToObject(oJumpTo));
}
