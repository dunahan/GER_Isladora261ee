void main()
{
    ActionWait(10.0);
    SetLocalInt(OBJECT_SELF, "text", 1);
    TakeGoldFromCreature(5,GetPCSpeaker(),TRUE);
    ActionStartConversation(OBJECT_SELF, "", FALSE, TRUE);
}
