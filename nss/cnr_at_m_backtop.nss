/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_at_m_backtop
//
//  Desc:  Changes to the merchant's hello convo
//
//  Author: David Bobeck 23Dec02
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"
void main()
{
  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "sCnrMenuType", "TOP");

  DelayCommand(0.2, AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "cnr_c_merchant", TRUE)));
}
