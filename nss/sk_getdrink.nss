void main()
{
    object    oPC = GetLastUsedBy();
    CreateItemOnObject(GetLocalString(OBJECT_SELF, "sDrink"), oPC);
}
