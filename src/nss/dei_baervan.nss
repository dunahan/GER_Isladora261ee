//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_baervan
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Baervan Wildwanderer als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Baervan Wildwanderer");
  SendServerMessageToPC(oRacePC, "Baervan Wildwanderer wurde als Gottheit eingestellt.");
}
