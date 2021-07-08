void main()
{
  SendMessageToAllDMs("AreaCleanerStopper in " + GetName(GetArea(OBJECT_SELF)) + " wird entfernt.");

  SetPlotFlag(OBJECT_SELF, FALSE);
  DestroyObject(OBJECT_SELF, 10.0);
}
