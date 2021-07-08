//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_conv
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
void main()
{
    BeginConversation();
    if (GetListenPatternNumber() == 1 &&
        GetLastSpeaker() == GetPCSpeaker())
    {
        string sGold = GetMatchedSubstring(0);
        object oLastSpeaker = GetLastSpeaker();
        object oPCSpeaker = GetPCSpeaker();
        
        if (sGold == "")
        {
            sGold = GetLocalString(GetArea(oPCSpeaker), "CHAT_"+GetName(oPCSpeaker));
            WriteTimestampedLogEntry(GetName(oPCSpeaker)+" "+sGold);

            if (sGold == "")
                sGold = GetLocalString(GetArea(oLastSpeaker), "CHAT_"+GetName(oLastSpeaker));
                WriteTimestampedLogEntry(GetName(oLastSpeaker)+" "+sGold);
        }
        
        SetLocalString(OBJECT_SELF, "GOLD", sGold);
        SetCustomToken(1000, sGold);
    }
}