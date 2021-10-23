void main()
{
    object oPlayer=GetLastUsedBy();
    ClearAllActions();
    AssignCommand(OBJECT_SELF, ActionStartConversation(oPlayer, "", TRUE));
}
