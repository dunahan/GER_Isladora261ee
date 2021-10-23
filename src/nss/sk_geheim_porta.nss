void main()
{
    object oPC = GetEnteringObject();
    if (
    (GetIsPC(oPC)) &&
    (GetLocalInt(OBJECT_SELF, "iGesprochen") != 1))
    {
        AssignCommand(oPC, ClearAllActions());
        SetLocalInt(OBJECT_SELF, "iGesprochen", 1);
        AssignCommand(oPC, SpeakString("Das Fenster sieht etwas seltsam aus. . ."));
    }
}

