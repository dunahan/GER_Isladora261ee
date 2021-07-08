int StartingConditional()
{
  int nActive = GetLocalInt(OBJECT_SELF, "Active");
  if (nActive == 0) return TRUE;
  else              return FALSE;
}
