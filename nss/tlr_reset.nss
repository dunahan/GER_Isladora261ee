//::///////////////////////////////////////////////
//::MIL TAILOR: reset
//::                 onconv mil_tailor
//:://////////////////////////////////////////////
/*
   read the blueprint of our clothes
   destroy clothes
   create the standard blueprint and put it on

*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:://////////////////////////////////////////////


void main()
{
    object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST);
    string sBP = GetResRef(oCloth);
    object oNew = CreateItemOnObject(sBP);

    DelayCommand(0.5, ActionEquipItem(oNew, INVENTORY_SLOT_CHEST));
    DestroyObject(oCloth, 0.8);

}
