int StartingConditional()
{
    int iResult;

    object oPedro = OBJECT_SELF;

    if (GetLocalInt(oPedro, "dice") == 2)
    {
        iResult=TRUE;
    }
    else
    {
        iResult=FALSE;
    }
    return iResult;
}
