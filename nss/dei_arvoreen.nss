//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_arvoreen
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Arvoreen der Verteidiger als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Arvoreen der Verteidiger");
  SendServerMessageToPC(oRacePC, "Arvoreen der Verteidiger wurde als Gottheit eingestellt.");
}
