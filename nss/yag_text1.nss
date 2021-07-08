int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "text") == 1)
    {
        SetLocalInt(OBJECT_SELF, "text", 0);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
