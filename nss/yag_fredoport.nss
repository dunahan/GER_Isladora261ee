void main()
{
    object oPC = GetPCSpeaker();
    object oJumpTo=GetObjectByTag("eski_eldo_rueckfahrt");
    AssignCommand(oPC,ActionJumpToObject(oJumpTo));
}
