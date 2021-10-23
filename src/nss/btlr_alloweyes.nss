int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "Eyes") == 1)
    return TRUE;
  
  return FALSE;
}
