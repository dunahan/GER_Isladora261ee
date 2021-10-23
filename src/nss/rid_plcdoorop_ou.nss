void main()
{
    string sTarget = GetTag(OBJECT_SELF);
    object oDoor = GetObjectByTag(sTarget);

    if (GetLocked(oDoor) == TRUE)
        ActionUnlockObject(oDoor);

    ActionOpenDoor(oDoor);
}
