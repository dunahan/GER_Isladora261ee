/* Name: sk_disarm Place this script on the Disarm event of the trap.
   Created by: Pattycake1 aka Nightwing
   For the Dawn of Nordock Server
*/
#include "_isla_inc"
#include "ll_include"

void main()
{
    object oPC = GetLastDisarmed();

    int iMultiplier = 20/5;
    int iXPawarddc  = GetTrapDisarmDC(OBJECT_SELF) * iMultiplier;
    int iXPaward    = (iXPawarddc - ((GetHitDice(oPC)-1) * iMultiplier))*2;

    DebugMode("Trap disarmed");

    //GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));
}

