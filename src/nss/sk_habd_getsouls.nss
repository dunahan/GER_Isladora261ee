//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_getsouls
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Wer eines Seelensteins berechnen
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 04.05.2011
//:://////////////////////////////////////////////

int StartingConditional()
{
  object oRespawn = GetPCSpeaker();
  int nLvl = GetHitDice(oRespawn);
  int nCost = nLvl * 1000;

  SetCustomToken(55000, IntToString(nCost));

  return TRUE; //immer ein Wert zurueckgeben
}
