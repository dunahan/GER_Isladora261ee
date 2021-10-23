void main()
{
  object oPC = GetLastUsedBy();
  string sCount = IntToString(GetLocalInt(OBJECT_SELF, "nCount"));
  object oTarget = GetObjectByTag("areain" + sCount);

  // Jump to the object with the same sequential reference counter
  AssignCommand(oPC,JumpToObject(oTarget));
}
