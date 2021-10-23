//::///////////////////////////////////////////////
//:: nw_g0_convplac
//::
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cause a placeable object to start a
    conversation with the PC.

    Use this script as the OnUsed event
    of a Placeable object that is flagged as
    Useable, Has NO Inventory, and is NOT Static.
*/
//:://////////////////////////////////////////////
//:: Created By: Sydney Tang
//:: Created On: Aug 08, 2002
//:://////////////////////////////////////////////

void main()
{
/*if ( GetStringRight(GetTag(OBJECT_SELF), 3) == "itm" )
  // Aktion mit Gespraech aehnlich Tag des Items
  ActionStartConversation(GetLastUsedBy(), GetTag(OBJECT_SELF));
  else*/
  // Standardaktion
  ActionStartConversation(GetLastUsedBy(), "", TRUE, FALSE);
}
