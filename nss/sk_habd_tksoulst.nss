//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_tksoulst
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Dem Spieler einen Seelenstein nehmen
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 04.05.2011
//:://////////////////////////////////////////////
#include "_isla_inc"

void main()
{
  object oRespawn = GetPCSpeaker();

  WriteTimestampedLogEntry("Ein Seelenstein wurde "+GetName(oRespawn)+" genommen");
  DercrementStackSize(oRespawn, "itm_soulstone", 1);
}
