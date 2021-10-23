//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_callarduran
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Callarduran Schmalhand als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Callarduran Schmalhand");
  SendServerMessageToPC(oRacePC, "Callarduran Schmalhand wurde als Gottheit eingestellt.");
}
