void main()
{
  string ToSpeak = GetDescription(OBJECT_SELF);
  FloatingTextStringOnCreature(ToSpeak, GetLastUsedBy(), FALSE);
}
