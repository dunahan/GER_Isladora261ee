//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: itm_questbuch
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    Ein Questsystem per Item.
    Aktivieren des Questtokens


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"

void main()
{
  // Suche den Aktivierer des Items
  object oActivator = GetItemActivator();
  string sActivated = GetTag(GetItemActivated());
  // Item-Gespräch aufrufen:
  ActionStartConversation(oActivator, "itm_questbuch", TRUE, FALSE);
}
