//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_w_fail
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
#include "sfpb_config"

int StartingConditional()
{
    // Vars
    object oPC = GetLastSpeaker();
    string sID = SF_GetPlayerID(oPC);
    int nGold = StringToInt(GetLocalString(OBJECT_SELF, "GOLD"));
    // int nBanked = GetCampaignInt(GetName(GetModule()), "SFPB_GOLD_" + sID); // switched to const string!
    int nBanked = GetCampaignInt(DATABASE_NAME, "SFPB_GOLD_" + sID);  // turn off, due new database sys
    //int nBanked = SF_GetBankedGoldFromDB(sID); // switch to new database

    // Check if the player has enough to withdraw
    return (nBanked < nGold);
}