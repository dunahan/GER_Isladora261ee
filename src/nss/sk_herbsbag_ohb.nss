void SendMessageToSpecialPC(string sMessage, string sPCName)
{
  object oPC = GetFirstPC();
  while (GetIsObjectValid(oPC))
  {
    if (GetPCPlayerName(oPC) == sPCName)
      SendMessageToPC(oPC, sMessage);

    oPC = GetNextPC();
  }
}

void main()
{
  if ( GetIsObjectValid( GetFirstItemInInventory() ) == FALSE  && GetLocalInt(OBJECT_SELF, "DestroyMe") == 0)
  {
    SetLocalInt(OBJECT_SELF, "DestroyMe", 1);
    DelayCommand(18.0 ,SetPlotFlag(OBJECT_SELF, FALSE));
    DestroyObject(OBJECT_SELF, 19.0);
    DelayCommand(20.0, DeleteLocalInt(OBJECT_SELF, "DestroyMe"));
  }
}
