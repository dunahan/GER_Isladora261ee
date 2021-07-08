void main()
{
  int nInt1 = GetLocalInt(GetPCSpeaker(), "Int1");
  string sOption = GetLocalString(OBJECT_SELF, "Option");

  SetLocalInt(OBJECT_SELF, "Opt"+sOption+"Gold", nInt1);
}
