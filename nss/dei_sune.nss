//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_sune
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Sune als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Sune");
  SendServerMessageToPC(oRacePC, "Sune wurde als Gottheit eingestellt.");
}
