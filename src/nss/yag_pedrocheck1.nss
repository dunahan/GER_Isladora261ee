int StartingConditional()
{
    int iResult;

    object oPedro = OBJECT_SELF;

    if (GetLocalInt(oPedro, "dice") == 1)
    {
        iResult=TRUE;
    }
    else
    {
        iResult=FALSE;
    }
    return iResult;
}
