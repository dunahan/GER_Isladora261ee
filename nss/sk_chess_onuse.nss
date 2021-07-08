void main()
{
  object oPC = GetLastUsedBy();
  string sTag = GetTag(OBJECT_SELF);

  DelayCommand( 9.0, ActionGiveItem(CreateItemOnObject(sTag), oPC));
  DelayCommand(11.0, DestroyObject(OBJECT_SELF));
}
