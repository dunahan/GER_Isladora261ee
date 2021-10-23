//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_marthammor
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Marthammor Duin als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Marthammor Duin");
  SendServerMessageToPC(oRacePC, "Marthammor Duin wurde als Gottheit eingestellt.");
}
