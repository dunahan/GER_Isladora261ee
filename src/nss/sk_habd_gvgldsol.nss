//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_gvgldsol
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Dem Spieler Gold nehmen, einen Seelenstein geben
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 04.05.2011
//:://////////////////////////////////////////////

void main()
{
  object oRespawn = GetPCSpeaker();
  int nLvl = GetHitDice(oRespawn);
  int nCost = nLvl * 1000;

  TakeGoldFromCreature(nCost, oRespawn, TRUE);

  string ItmToGive = GetLocalString(OBJECT_SELF, "Item");

  CreateItemOnObject(ItmToGive, oRespawn);
}
