void main()
{
    ActionWait(15.0);
    SetLocalInt(OBJECT_SELF, "text", 3);
    TakeGoldFromCreature(20,GetPCSpeaker(),TRUE);
    ActionStartConversation(OBJECT_SELF, "", FALSE, TRUE);
}
