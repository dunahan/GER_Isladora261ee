//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_balance
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
#include "sfpb_config"

void main()
{
    // Vars
    object oPC = GetLastSpeaker();
    string sID = SF_GetPlayerID(oPC);
    // int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID); // switched to const string
    int nBanked = GetCampaignInt(DATABASE_NAME, DATABASE_GOLD + sID);  // will be turned off, due newer database sys
    //int nBanked = SF_GetBankedGoldFromDB(sID); // switched on, for new database sys

    // Set custom token for the account balance
    SetCustomToken(1000, IntToString(nBanked));
}
