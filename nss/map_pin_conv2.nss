#include "x2_inc_switches"
#include "00_jk_pins"

void main()
{
  if (GetUserDefinedItemEventNumber() == X2_ITEM_EVENT_ACTIVATE)
  {
    object oPC = GetItemActivator();
    if (GetItemActivatedTarget() == oPC)
    {
      SetLocalInt(oPC, "MAPPIN", 1);
      AssignCommand(oPC, ActionStartConversation(oPC, "map_pin_conv2", TRUE));
    }
    else
    {
      SetLocalInt(oPC, "MAPPIN", 2);
      vector vPos = GetPositionFromLocation(GetItemActivatedTargetLocation());
      SetLocalFloat(oPC, "MAPPIN_X", vPos.x);
      SetLocalFloat(oPC, "MAPPIN_Y", vPos.y);
      AssignCommand(oPC, ActionStartConversation(oPC, "map_pin_conv2", TRUE));
    }
  }
}
