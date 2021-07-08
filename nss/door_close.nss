

void main()
{
  float fDoor = GetLocalFloat(OBJECT_SELF, "fDoor");

  if ( fDoor == 0.0 )
    fDoor = 240.0;

  object oObjekt = GetNearestObject(OBJECT_TYPE_DOOR);
  if (GetIsOpen(OBJECT_SELF))
  {
    ActionWait(fDoor); // Die Zeit die die Tür offen stehen soll.
    ActionCloseDoor (OBJECT_SELF);
  }

  if (GetLockLockable(OBJECT_SELF) && !GetLocked(OBJECT_SELF))
    SetLocked(OBJECT_SELF, TRUE);
}

