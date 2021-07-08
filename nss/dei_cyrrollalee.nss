//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_cyrrollalee
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Cyrrollalee die Herdhüterin als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Cyrrollalee die Herdhüterin");
  SendServerMessageToPC(oRacePC, "Cyrrollalee die Herdhüterin wurde als Gottheit eingestellt.");
}
