//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_sheela
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Sheela Peryroyl als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Sheela Peryroyl");
  SendServerMessageToPC(oRacePC, "Sheela Peryroyl wurde als Gottheit eingestellt.");
}
