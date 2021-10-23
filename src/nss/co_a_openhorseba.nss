#include "x3_inc_horse"

void main()
{
  object oHorse = OBJECT_SELF;
  object    oPC = GetPCSpeaker();
  if (GetLocalInt(GetModule(), "X3_HORSE_ENABLE_SADDLEBAGS") && GetLocalInt(oHorse, "bX3_HAS_SADDLEBAGS"))
  { // open saddle bags
    DelayCommand(0.1, OpenInventory(oHorse, oPC));
  } // open saddle bags
}
