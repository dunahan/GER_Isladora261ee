/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: n_tink_spwn
*
* Purpose:  OnSpawn script for the DM listener
*
* Created By: Mistress
* Created On: 3-22-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
* Change Log:
* 3-22-07 Mistress
* - Added function header and formatting
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#include "l_tink_funcs"

void main()
{
    // Set Tink (OBJECT_SELF) to be listening
    SetListening(OBJECT_SELF, TRUE);

    // Tell her to listen for everything.  Her listening pattern is 3000.
    SetListenPattern(OBJECT_SELF, "**", 3000);
    
    SetLocalObject(OBJECT_SELF, "TINK_MY_DM", GetMyDM());
    FollowYourDM(OBJECT_SELF, 300.0);
}
