 //::///////////////////////////////////////////////
//:: SL-Tools DM Tool 1 Instant Feat
//:: x3_dm_tool01
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools f�r Isladora
    Skript um das Gespr�ch f�r die SL zu
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
    AssignCommand(OBJECT_SELF, ClearAllActions());  // Alle Aktionen zur�cksetzen & Gespr�ch starten
    AssignCommand(OBJECT_SELF, ActionStartConversation(OBJECT_SELF, "isla_universal", TRUE, FALSE));
  }

//  else
  {

  }
}
