int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "Wings") == 1)
    return TRUE;
  
  return FALSE;
}
