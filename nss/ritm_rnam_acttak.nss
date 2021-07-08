#include "colors_inc"

void main()
{
  object oBox  = OBJECT_SELF;                                                   //SpeakString("Box "+GetName(oBox));
  object oItem = GetLocalObject(oBox, "Item");                                  //SpeakString("Item "+GetName(oItem));
  string sSaid; string sColor; int nEnd; int nStart;

  SetLocked(OBJECT_SELF, TRUE);                                                 //SpeakString("Abgeschlossen");

  if (GetIsListening(OBJECT_SELF) == TRUE)
  {
    if (GetListenPatternNumber() == 60001)
    {
      sSaid = GetMatchedSubstring(0);                                           //SpeakString(sSaid);

      if (!GetIsDM(GetPCChatSpeaker()))
        sSaid = UndoColoring(sSaid);

      SetName(oItem, sSaid);
      SetLocked(oBox, FALSE);
    }
  }
}
