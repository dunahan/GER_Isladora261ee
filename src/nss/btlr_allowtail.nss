int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "Tail") == 1)
    return TRUE;
  
  return FALSE;
}
