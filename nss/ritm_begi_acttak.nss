

void main()
{
  object oBox  = OBJECT_SELF;                                                   //SpeakString("Box "+GetName(oBox));
  object oItem = GetLocalObject(oBox, "Item");                                  //SpeakString("Item "+GetName(oItem));

  SetLocked(OBJECT_SELF, TRUE);                                                 //SpeakString("Abgeschlossen");

  SetListening(OBJECT_SELF, TRUE);                                              //SpeakString("Hoert nun zu");
  SetListenPattern(OBJECT_SELF, "**", 60001);                                   //SpeakString("Ohne Begrenzung");
}
