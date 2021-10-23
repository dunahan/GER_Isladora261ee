//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_urogalan
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Urogalan als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Urogalan");
  SendServerMessageToPC(oRacePC, "Urogalan wurde als Gottheit eingestellt.");
}
