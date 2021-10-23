/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* File Name: i_dm_tink
*
* Purpose:  Spawn in DM listener, Tink.  No need to test for DM ids here.  Tink
*           will only respond to commands spoken by a DM id.
*
* Created By: Mistress
* Created On: 5-25-08
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#include "l_tink_funcs"

void main()
{
    object oDM = GetItemActivator();
    object oItem = GetItemActivated();

    GetMapList(oItem);

    object oTink = CreateObject(OBJECT_TYPE_CREATURE, "nd_dm_tink", GetLocation(oDM), TRUE);
    //DelayCommand(2.0f, AssignCommand(oTink, SpeakString("*Tink suddenly appears at the side of " + GetName(oDM) + ".*", TALKVOLUME_TALK)));

    // Set her up to follow
    SetLocalInt(oTink, "TINK_IS_FOLLOWING", TRUE);
    AssignCommand(oTink, ActionForceFollowObject(oDM, 0.75f));
} // END of void main

