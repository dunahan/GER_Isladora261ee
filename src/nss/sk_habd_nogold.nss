//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_nogold
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Der Spieler hat nicht genug Gold um Seelenstein zu kaufen
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

  if (GetGold(oRespawn) >= nCost) { return TRUE;  }
  else                            { return FALSE; }
}
