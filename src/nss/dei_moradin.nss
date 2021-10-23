//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_moradin
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Moradin als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Moradin");
  SendServerMessageToPC(oRacePC, "Moradin wurde als Gottheit eingestellt.");
}
