//::///////////////////////////////////////////////
//:: Tailor - Buy Weapon
//:: tlr_buyshld.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
#include "_debugisla"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);

    //-- int iCost = GetGoldPieceValue(oItem) * 2;
    int iCost = GetLocalInt(OBJECT_SELF, "CURRENTPRICE");
/*
    if (GetGold(oPC) < iCost) {
        SendServerMessageToPC(oPC, "Das wird dich " + IntToString(iCost) + " gold kosten!");
        return;
    }
*/

    TakeGoldFromCreature(iCost, oPC, TRUE);

    object oPCCopy = CopyItem(oItem, oPC, TRUE);
    SetName(oPCCopy, GetName(oPC) +"'s Custom Shield");
}