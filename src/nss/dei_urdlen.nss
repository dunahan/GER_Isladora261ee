//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_urdlen
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Urdlen als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Urdlen");
  SendServerMessageToPC(oRacePC, "Urdlen wurde als Gottheit eingestellt.");
}
