void main()
{
    string sResRef = GetTag(OBJECT_SELF);
    object oUser = GetLastUsedBy();

    object oCreation = CreateItemOnObject(sResRef, oUser);

    if (GetPlotFlag() == TRUE)
        SetPlotFlag(OBJECT_SELF, FALSE);

    DestroyObject(OBJECT_SELF);
}
