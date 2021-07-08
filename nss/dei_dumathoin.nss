//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_dumathoin
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Dumathoin als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Dumathoin");
  SendServerMessageToPC(oRacePC, "Dumathoin wurde als Gottheit eingestellt.");
}
