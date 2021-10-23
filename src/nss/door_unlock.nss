// Place this on Unlock event of the door.
/* Name: door_unlock
   Created by Pattycake1 aka Nightwing
   For the Dawn of Nordock Server
*/
#include "ll_include"

void main()
{
  object oUnlocker = GetLastUnlocked();
  string sTag = "bHAS_XP_FOR_" + GetTag(OBJECT_SELF);

  if(!GetLocalInt(oUnlocker, sTag))
  {
    object oPC=GetLastUnlocked();
    int iMultiplier = 20/5;
    int iXPawarddc = GetLockUnlockDC(OBJECT_SELF) * iMultiplier;
    int iXPaward = (iXPawarddc - ((GetHitDice(oPC)-1) * iMultiplier))*2;
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));
    SetLocalInt(oUnlocker, sTag, TRUE);
    //optional. 600.0 is 10 minutes before it could be done again
    DelayCommand(600.0, DeleteLocalInt(oUnlocker, sTag));
  }
}

