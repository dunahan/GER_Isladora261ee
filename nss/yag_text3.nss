int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "text") == 3)
    {
        SetLocalInt(OBJECT_SELF, "text", 0);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
