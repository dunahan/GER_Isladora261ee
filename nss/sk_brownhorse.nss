//::///////////////////////////////////////////////
//:: FileName sk_brownhorse
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23.10.2009 11:18:35
//:://////////////////////////////////////////////
void main()
{
  // Dem Sprecher die Gegenstände geben
  object oHorseToken = CreateItemOnObject("summonmyhorse");
  SetLocalString(oHorseToken, "HorseResRef", "cre_scbraun");
  ActionGiveItem(oHorseToken, GetPCSpeaker());

  // Dem Spieler Gold wegnehmen
  TakeGoldFromCreature(1200, GetPCSpeaker(), TRUE);
}
