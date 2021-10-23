int StartingConditional()
{
  if (GetLocalInt(OBJECT_SELF, "Pheno") == 1)
    return TRUE;
  
  return FALSE;
}
