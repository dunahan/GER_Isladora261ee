//::///////////////////////////////////////////////
//:: FileName sk_gasthaus
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 26.01.2010 19:29:24
//:://////////////////////////////////////////////
void main()
{
    // Dem Sprecher die Gegenstände geben
    CreateItemOnObject("key_gasthaus", GetPCSpeaker(), 1);


    // Dem Spieler Gold wegnehmen
    TakeGoldFromCreature(GetLocalInt(OBJECT_SELF, "nGold"), GetPCSpeaker(), TRUE);
}
