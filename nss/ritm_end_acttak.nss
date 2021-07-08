

void main()
{
  object oBox  = OBJECT_SELF;                                                   //SpeakString("Box "+GetName(oBox));
  object oItem = GetLocalObject(oBox, "Item");                                  //SpeakString("Item "+GetName(oItem));

  SetLocked(oBox, FALSE);                                                       //SpeakString("Offen");
  DeleteLocalObject(oBox, "Item");
}
