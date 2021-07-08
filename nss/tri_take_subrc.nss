void main()
{
  object exit = GetExitingObject();

  if (GetIsObjectValid(exit) == FALSE)
    return;

  if (GetIsDM(exit) == TRUE || GetIsDMPossessed(exit) == TRUE)
    return;

  if (GetSubRace(exit) != "" || GetSubRace(exit) == "-1")
  {
    SetSubRace(exit, "");
    WriteTimestampedLogEntry(GetName(exit) + " besass eine Subrasse!");
  }
}
