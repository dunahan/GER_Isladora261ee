//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_sehanine
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Sehanine Mondbogen als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Sehanine Mondbogen");
  SendServerMessageToPC(oRacePC, "Sehanine Mondbogen wurde als Gottheit eingestellt.");
}
