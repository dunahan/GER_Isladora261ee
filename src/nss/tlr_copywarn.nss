//::///////////////////////////////////////////////
//:: Tailoring - Copy warning
//:: tlr_copywarn.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Added for copying clothes without costs
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 9, 2004
//-- dunahan: changed for no costs OR if it isnt possible
//-- to copy, buy it then
//:://////////////////////////////////////////////

int StartingConditional()
{
    int BaseCost = 0; //-- change to raise prices
    float BaseMultiplyer = 2.0; //-- milamber's default

    object oPC = GetPCSpeaker();

    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);

    int iCost = BaseCost + FloatToInt((IntToFloat(GetGoldPieceValue(oNPCItem)) * BaseMultiplyer));
    int iAC = GetItemACValue(oNPCItem);

    string sOut = "- - Aktuelle RK: " + IntToString(iAC) + " - -\n";
          sOut += "(Beachte: Kopieren ist nur möglich, wenn die Rüstungsklasse deiner Kleidung die der Schneiderpuppe entspricht.\n";
          sOut += "Kosten zum Kaufen des Kleidungsstücks: " + IntToString(iCost) + " Gold.)\n";
          sOut += "\nMöchtest Du fortfahren?";

    SetCustomToken(9876, sOut);
    //-- this is called to check if the pc has the money to buy
    SetLocalInt(OBJECT_SELF, "CURRENTPRICE", iCost);

    return TRUE;
}
