void main()
{
  location locTarget = GetSpellTargetLocation();
  CreateObject(OBJECT_TYPE_PLACEABLE, "plc_chess_queenb", locTarget);
}
