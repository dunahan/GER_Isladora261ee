//::///////////////////////////////////////////////
//:: FileName sk_greyhorse
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23.10.2009 11:17:58
//:://////////////////////////////////////////////
void main()
{
  // Dem Sprecher die Gegenstände geben
  object oHorseToken = CreateItemOnObject("summonmyhorse");
  SetLocalString(oHorseToken, "HorseResRef", "cre_scgrau");
  ActionGiveItem(oHorseToken, GetPCSpeaker());

  // Dem Spieler Gold wegnehmen
  TakeGoldFromCreature(1200, GetPCSpeaker(), TRUE);
}
