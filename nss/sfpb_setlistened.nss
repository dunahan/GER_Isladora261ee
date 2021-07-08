//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_listened
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

#include "colors_inc"

void main()
{
    int nMatch = GetListenPatternNumber();
    if (nMatch == 1)
    {
        string sSaid = UndoColoring(GetMatchedSubstring(0));
        SetLocalString(OBJECT_SELF, "GOLD", sSaid);
        SetLocalString(GetArea(OBJECT_SELF), "SFPB_GOLD", sSaid);
    }
}
