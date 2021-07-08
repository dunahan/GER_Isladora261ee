//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_duerra
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Duerra aus der Tiefe als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Duerra aus der Tiefe");
  SendServerMessageToPC(oRacePC, "Duerra aus der Tiefe wurde als Gottheit eingestellt.");
}
