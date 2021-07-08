//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_gaerdal
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Gaerdal Eisenhand als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Gaerdal Eisenhand");
  SendServerMessageToPC(oRacePC, "Gaerdal Eisenhand wurde als Gottheit eingestellt.");
}
