//::///////////////////////////////////////////////
//:: FileName sk_newsflags
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 01.01.2010 12:22:25
//:://////////////////////////////////////////////
#include "_isla_inc"

int StartingConditional()
{
  // Lokale Variablen sichten
  if( GetIsDM( GetPCSpeaker() ) == FALSE )
    return FALSE;
  return TRUE;
}