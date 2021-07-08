//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_brandobaris
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Brandobaris als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Brandobaris");
  SendServerMessageToPC(oRacePC, "Brandobaris wurde als Gottheit eingestellt.");
}
