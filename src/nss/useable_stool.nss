void main()
{
  location locAim = GetItemActivatedTargetLocation();
  object oTarget = GetItemActivatedTarget();
  string sTarget = GetTag(oTarget);
  string sNewTag = "Stool" + GetStringLeft(GetName(GetItemActivator()), 4);
  object oStool; object oDestroy;

  if (GetIsObjectValid(oTarget)==FALSE) // das Ziel ist nicht der Stuhl!
  { oStool = CreateObject(OBJECT_TYPE_PLACEABLE, "useable_stool", locAim, FALSE, sNewTag); }
  else // ansonsten ist es der Stuhl und darf zerstoert werden.
  { oDestroy = GetObjectByTag(sNewTag); DestroyObject(oDestroy, 1.0); }
}
