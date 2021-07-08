//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_lolth
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Lolth als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Lolth");
  SendServerMessageToPC(oRacePC, "Lolth wurde als Gottheit eingestellt.");
}
