//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_corellon
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Corellon Larethian als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Corellon Larethian");
  SendServerMessageToPC(oRacePC, "Corellon Larethian. wurde als Gottheit eingestellt.");
}
