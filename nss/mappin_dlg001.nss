int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(), "MAPPIN") == 1) return TRUE;
    else                                            return FALSE;
}
