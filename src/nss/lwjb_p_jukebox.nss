 //::///////////////////////////////////////////////
//:: SL-Tools DM Tool 1 Instant Feat
//:: lwjb_p_jukebox
//:: Copyright (c) 2011 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools für Isladora
    Skript um das Jukebox-System zu
    starten

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"


void main()
{
//  if (GetResRef(GetItemActivated()) == )
  {
    CreateObject(OBJECT_TYPE_PLACEABLE, "lwjb_p_jukebox", locItemTarget, TRUE);
  }

//  else
  {

  }
}
