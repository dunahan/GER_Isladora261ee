//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_auril
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Auril als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Auril");
  SendServerMessageToPC(oRacePC, "Auril wurde als Gottheit eingestellt.");
}
