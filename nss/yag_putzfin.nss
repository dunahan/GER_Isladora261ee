void main()
{
    ActionWait(5.0);
    SetLocalInt(OBJECT_SELF, "text", 1);
    TakeGoldFromCreature(3,GetPCSpeaker(),TRUE);
    ActionStartConversation(OBJECT_SELF, "", FALSE, TRUE);
}
