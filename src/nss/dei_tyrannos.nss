//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_tyrannos
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Tyrannos als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Tyrannos");
  SendServerMessageToPC(oRacePC, "Tyrannos wurde als Gottheit eingestellt.");
}
