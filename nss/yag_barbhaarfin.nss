void main()
{
    ActionWait(10.0);
    SetLocalInt(OBJECT_SELF, "text", 2);
    TakeGoldFromCreature(10,GetPCSpeaker(),TRUE);
    ActionStartConversation(OBJECT_SELF, "", FALSE, TRUE);
}
