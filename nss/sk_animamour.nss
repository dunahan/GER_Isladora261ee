// #include "NW_I0_2Q4LUSKAN"

void main()
{
    string   sResRef = GetResRef(OBJECT_SELF);
    location locAnim = GetLocation(OBJECT_SELF);
    // create a clone
    object oClon = CreateObject(OBJECT_TYPE_CREATURE, sResRef + "b", locAnim);
    DelayCommand(30.0, DestroyObject(oClon));
    // kill it
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), oClon);
    // set it to not attackable
    AssignCommand(oClon, SetIsDestroyable(FALSE,FALSE,FALSE));
    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oClon);
    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oClon);
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE,  100, oClon);
    SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oClon);

    // Create left Arm
    CreateObject(OBJECT_TYPE_CREATURE, sResRef + "c", locAnim);
    // Create right Arm
    CreateObject(OBJECT_TYPE_CREATURE, sResRef + "d", locAnim);
    // Create right Arm
    CreateObject(OBJECT_TYPE_CREATURE, sResRef + "e", locAnim);

    // Destroy Not visible objects from the clon, avoid problems.
    // Destroy Gold
    AssignCommand(OBJECT_SELF, TakeGoldFromCreature(GetGold(oClon), oClon, TRUE));

    // Destroy Backpack items
    object oItem = GetFirstItemInInventory(oClon);
        while (oItem != OBJECT_INVALID)
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory(oClon);
        }
        //Make clon equipped items undroppable
        int i;
        for (i=0; i<NUM_INVENTORY_SLOTS; i++)
        {
            oItem = GetItemInSlot(i, oClon);
            if (GetIsObjectValid(oItem) )
            {
                SetDroppableFlag (oItem, FALSE);
                SetItemCursedFlag(oItem, TRUE);
            }
        }
        return;

    // Destroy the monster itself
    DestroyObject(OBJECT_SELF);
}
