//#include "eds_include"

int StartingConditional()
{
    return GetLocalInt(GetPCSpeaker(), "DEATH_TIME_LEFT") > 0;
}
