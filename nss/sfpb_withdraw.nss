//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_withdraw
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
#include "sfpb_config"

void main()
{
    // Vars
    object oPC = GetPCSpeaker();
    string sID = SF_GetPlayerID(oPC);
    int nWithdraw = StringToInt(GetLocalString(OBJECT_SELF, "GOLD"));
    // int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID); // switched to const string
    int nBanked = GetCampaignInt(DATABASE_NAME, DATABASE_GOLD + sID);  // will be turned off, due newer database sys
    // int nBanked = SF_GetBankedGoldFromDB(sID); // switch to new database

    // Give the amount required tot he player and store in the database
    GiveGoldToCreature(oPC, nWithdraw);
    int nTotal = nBanked - nWithdraw;
    // SetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID, nTotal); // switched to const string
    SetCampaignInt(DATABASE_NAME, DATABASE_GOLD + sID, nTotal);  // will be turned off, due newer database sys
    // SF_SetBankedGoldToDB(sID, nTotal);  // switch to new database

    // Set custom token
    SetCustomToken(1000, IntToString(nTotal));
}
