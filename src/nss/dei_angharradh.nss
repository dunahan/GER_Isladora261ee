//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_angharradh
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Angharradh als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Angharradh");
  SendServerMessageToPC(oRacePC, "Angharradh wurde als Gottheit eingestellt.");
}