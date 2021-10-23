//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: NW_C2_DEFAULT4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "bbs_include"

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(nMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
  //     && GetIsFriend(oShouter)
    {
      if (oShouter == GetLocalObject(OBJECT_SELF, "Customer")) {
        string sSaid = GetMatchedSubstring(0);                                  bbs_debug_speak("bbs_scribe_conv: Heard string => "+sSaid);
        SetLocalString(OBJECT_SELF, "Stack", sSaid);                            bbs_debug_speak("bbs_scribe_conv: Saved string => "+GetLocalString(OBJECT_SELF, "Stack"));
      }
    }
}
