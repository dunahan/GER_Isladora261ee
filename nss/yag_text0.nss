int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "text") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
