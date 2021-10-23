//::///////////////////////////////////////////////
//:: Tailoring - Decrease Item
//:: tlr_decreaseitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:: Modified By: The Amethyst Dragon
//:: Modified On: March 4, 2015 (for CEP 2.61 compatibility)
//:://////////////////////////////////////////////
#include "_debugisla"

// Get a Cached 2DA string.  If its not cached read it from the 2DA file and cache it.
string GetCachedACBonus(string sFile, int iRow);

// Get the Cached Upper limit for a 2DA file.  If not cached, determine the Limit and cache it.
int GetCachedLimit(string sFile);

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    DebugMode("s2DAFile: " + s2DAFile);

    int iNewApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify) - 1;

    string s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
    DebugMode("s2DA_ACBonus: " + s2DA_ACBonus);

    while (s2DA_ACBonus == "SKIP" || s2DA_ACBonus == "FAIL")
    {
        if (s2DA_ACBonus == "FAIL")
            iNewApp = GetCachedLimit(s2DAFile);
        else
            iNewApp--;

        s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
        DebugMode("s2DA_ACBonus: " + s2DA_ACBonus);
    }

    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify, iNewApp, TRUE);

    DestroyObject(oItem);
    SendServerMessageToPC(oPC, "Neues Aussehen: " + IntToString(iNewApp));

    AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST));
}

string GetCachedACBonus(string sFile, int iRow)
{
    // This function modified for 2da change introduced with CEP 2.61.
    string sACBonus = GetLocalString(GetModule(), sFile + IntToString(iRow));
    if (sACBonus == "")
    {
        sACBonus = Get2DAString(sFile, "ACBONUS", iRow);
        if (sACBonus == "" || Get2DAString(sFile, "HASMODEL", iRow) == "")
        {
            sACBonus = "SKIP";
            string sCost = Get2DAString(sFile, "COSTMODIFIER", iRow);
            if (sCost == "")
                sACBonus = "FAIL";
        }
        SetLocalString(GetModule(), sFile + IntToString(iRow), sACBonus);
    }
    return sACBonus;
}

int GetCachedLimit(string sFile)
{
    int iLimit = GetLocalInt(GetModule(), sFile + "Limit");
    if (iLimit == 0)
    {
        int iCount = 0;
        while (Get2DAString(sFile, "COSTMODIFIER", iCount + 1) != "")
            iCount++;

        SetLocalInt(GetModule(), sFile + "Limit", iCount);
        iLimit = iCount;
    }
    return iLimit;
}
