//::///////////////////////////////////////////////
//:: Teleportsystem: Holt die Teleportkiste her
//:: tele_container
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Skript durch Item-Aktivierung ausgefuehrt
     Stellt die Kontainer Kreatur wieder her
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  if (GetUserDefinedItemEventNumber() == X2_ITEM_EVENT_ACTIVATE)
    wrap_RetrieveCampaignObjects(TELEDATAB, "TELECON", GetItemActivatedTargetLocation());

}
