//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Is Speaker A DM
//:: _sk_otaw_isdm
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Text Appears When einf�gen
    Zeigt die Option(en) f�r SL an, wie sie den H�ndler
    bearbeiten k�nnen.

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

#include "_sk_include"

int StartingConditional()
{
  if ( GetIsDM(GetPCSpeaker()) == TRUE )
    return TRUE;

  return FALSE;
}

