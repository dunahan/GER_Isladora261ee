int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(), "MAPPIN") == 2) return TRUE;
    else                                            return FALSE;
}
