/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_alchemy_anim
//
//  Desc:  This script animates the PC when crafting
//         at the alchemy table.
//
//  Author: Gary Corcoran 21Mar03
//
/////////////////////////////////////////////////////////
void main()
{
  object oPC = GetLocalObject(OBJECT_SELF, "oCnrCraftingPC");

  if (GetIsPC(oPC))
  {
    // The animation delay should be set to the number of seconds it
    // takes to complete this animation.
    SetLocalFloat(oPC, "fCnrAnimationDelay", 7.0);
    int bSuccess = GetLocalInt(oPC, "bCnrCraftingResult");

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 1.0));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
    if (bSuccess)
    {
      AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
    }
    else
    {
      AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
    }
    PlaySound("al_mg_cauldron1");
  }
}

