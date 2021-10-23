

int StartingConditional()
{                                                                               //SpeakString("ritm_true_txttru");
  object oBox  = OBJECT_SELF;                                                   //SpeakString("Box "+GetName(oBox));
  object oItem = GetLocalObject(oBox, "Item");                                  //SpeakString("Item "+GetName(oItem));

  int nPlot      = GetPlotFlag(oItem);
  int nStolen    = GetStolenFlag(oItem);
  int nDroppable = GetDroppableFlag(oItem);
  int nCursed    = GetItemCursedFlag(oItem);

       if (nPlot      == TRUE)  return FALSE;
  else if (nStolen    == TRUE)  return FALSE;
  else if (nDroppable == FALSE) return FALSE;
  else if (nCursed    == TRUE)  return FALSE;

  else                          return TRUE;
}
