void main()
{
  object oDoor;
  string sDoor = GetLocalString(OBJECT_SELF, "sDoor");
  float fDelay = GetLocalFloat (OBJECT_SELF, "fDelay");
  float fReset = GetLocalFloat (OBJECT_SELF, "fReset");
  int  nActive = GetLocalInt   (OBJECT_SELF, "active");

  if (nActive == FALSE )
  { oDoor = GetNearestObjectByTag(sDoor); ActionWait(fDelay); ActionCloseDoor(oDoor);
    SetLocalInt(OBJECT_SELF, "active", 1);
  }
  else
  { DelayCommand(fReset, DeleteLocalInt(OBJECT_SELF, "active")); }
}
