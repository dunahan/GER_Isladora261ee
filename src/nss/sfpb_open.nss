//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_open
//:://////////////////////////////////////////////
/*
    Written By Scarface
    Added more stuff by dunahan@schwerterkueste.de
*/
//////////////////////////////////////////////////
#include "sfpb_config"

void main()
{
    // Vars
    object oPC = GetLastOpenedBy(), oStorer, oItem;
    object oChest = OBJECT_SELF;
    location lLoc = GetLocation(oPC);
    string sID = SF_GetPlayerID(oPC), sAccount, sName;
    string sUserID = GetLocalString(oChest, "USER_ID");

    // End script if any of these conditions are met
    if (!GetIsPC(oPC) ||
         GetIsDMPossessed(oPC) ||
         GetIsPossessedFamiliar(oPC)) return;

    if (GetIsDM(oPC))                                                           // new WorkARound to get all contents of this specified box
    {
        if (SF_GetIsAdmin(oPC))                                                 // only the Admin of Server can access!
        {
            sUserID = GetLocalString(oChest, "DM_USER_ID");                     // only choosen useracc should be opened

            sName = GetTokenFromString(2, sUserID, "_");                        // get name
            sAccount = GetTokenFromString(1, sUserID, "_");                     // get key

            oStorer = RetrieveCampaignObject(DATABASE_NAME+"_"+sAccount, DATABASE_ITEM + sUserID, lLoc);

            // loop through the NPC storers inventory and copy the items
            // into the chest.
            oItem = GetFirstItemInInventory(oStorer);
            while (GetIsObjectValid(oItem))
            {
                // Copy the item into the chest
                CopyItem(oItem, oChest, TRUE);

                // Next item
                oItem = GetNextItemInInventory(oStorer);
            }

        // Destroy the NPC storer
        DestroyObject(oStorer);
        }

        return;
    }

    else
    {
        // If the chest is already in use then this must be a thief
        if (sUserID != "" && sUserID != sID)
            return;

        // Set the players ID as a local string onto the chest
        // for anti theft purposes
        SetLocalString(oChest, "USER_ID", sID);

        // Get the player's storer NPC from the database
        sAccount = GetTokenFromString(1, sID, "_");                             // Get Key
        oStorer = RetrieveCampaignObject(DATABASE_NAME+"_"+sAccount, DATABASE_ITEM + sID, lLoc);

        // loop through the NPC storers inventory and copy the items
        // into the chest.
        oItem = GetFirstItemInInventory(oStorer);
        while (GetIsObjectValid(oItem))
        {
            // Copy the item into the chest
            CopyItem(oItem, oChest, TRUE);

            // Destroy the original
            DestroyObject(oItem);

            // Next item
            oItem = GetNextItemInInventory(oStorer);
        }

    // Destroy the NPC storer
    DestroyObject(oStorer);
    }
}
