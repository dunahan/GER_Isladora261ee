

void main()
{
  int nDisturbed = GetInventoryDisturbType();
  object oUser = GetLastDisturbed();

  object oBox = OBJECT_SELF;                                                    //SpeakString("Box "+GetName(oBox));
  object oItem;

  switch (nDisturbed)
  {
    case INVENTORY_DISTURB_TYPE_ADDED:
      oItem = GetInventoryDisturbItem();                                        //SpeakString("Item "+GetName(oItem));

      SetLocalObject(oBox, "Item", oItem);                                      //SpeakString("Speichere Objekt");
      SetCustomToken(60001, GetName(oItem));                                    //SpeakString(GetName(GetLocalObject(OBJECT_SELF, "Item")));

      ActionStartConversation(oUser, "tlk_namechanger", TRUE, FALSE);
    break;

    case INVENTORY_DISTURB_TYPE_REMOVED:
      SpeakString("removed");
    break;

    case INVENTORY_DISTURB_TYPE_STOLEN:
      SpeakString("stolen");
    break;

    default:
      SpeakString("default");
    break;
  }
}
