#include "bbs_include"

int StartingConditional()
{
  object oSpeaker = GetPCSpeaker();
  string sAuthor = GetLocalString(oSpeaker, "PostAuthor");
  string sName = GetName(oSpeaker) + " (" + GetPCPlayerName(oSpeaker) + ")";

  int TotalItems;
  TotalItems = GetCampaignInt("DB_BBS",GetTag(OBJECT_SELF)+"#C");

  if(TotalItems == 0)
    return FALSE;

  else if(sName == sAuthor)
    return TRUE;

  else if(GetIsDM(oSpeaker) == TRUE || GetIsDMPossessed(oSpeaker) ==TRUE )
    return TRUE;

  else if(HasItem(oSpeaker,BBS_ADMIN_TAG))
    return TRUE;

  else
    return FALSE;
}
