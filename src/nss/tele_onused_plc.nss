//::///////////////////////////////////////////////
//:: Teleportsystem: Lasse das Placeable sprechen
//:: tele_onused_plc
//:: (C): dunahan@schwerterkueste, 13.02.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Used
     Lässt das Placeable den Dialog sprechen


*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 13.02.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  ActionStartConversation(GetLastUsedBy(), "tele_dialogue");
}
