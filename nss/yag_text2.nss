int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "text") == 2)
    {
        SetLocalInt(OBJECT_SELF, "text", 0);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
