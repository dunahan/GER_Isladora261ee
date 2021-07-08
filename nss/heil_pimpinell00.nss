void main()
{
    object oNPC = GetObjectByTag("RederPimpinelle");
    object oPC = GetLastPerceived();


    if (
    (GetIsPC(oPC)) &&
    (IsInConversation(oNPC) == FALSE) &&
    (GetObjectSeen(oPC,oNPC)) &&
    (GetLocalInt(OBJECT_SELF, "igesprochen_21") != 1))
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oNPC, ClearAllActions());
        AssignCommand(oNPC, ActionMoveToObject(oPC));
        AssignCommand(oNPC, ActionStartConversation(oPC));
        SetLocalInt(OBJECT_SELF, "igesprochen_21", 1);
    }
}
