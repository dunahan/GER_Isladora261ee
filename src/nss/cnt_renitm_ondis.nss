void main()
{
  int nDisturbed = GetInventoryDisturbType(); object oItem;
  object oUser = GetLastDisturbed();

  if (nDisturbed == INVENTORY_DISTURB_TYPE_ADDED)
  {
    oItem = GetInventoryDisturbItem();          //SpeakString(GetName(oItem), TALKVOLUME_SHOUT);

    SetLocalObject(OBJECT_SELF, "Item", oItem); //SpeakString("Speichere Objekt", TALKVOLUME_SHOUT);
    SetCustomToken(60001, GetName(oItem));      //SpeakString(GetName(GetLocalObject(OBJECT_SELF, "Item")), TALKVOLUME_SHOUT);

    ActionStartConversation(oUser, "tlk_namechanger", TRUE, FALSE);
  }
}
