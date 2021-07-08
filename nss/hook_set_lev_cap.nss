/////////////////////////////////////////////////////////////////////
//
// hook_set_lev_cap
//
// Use this script to define the trade level caps for the calling PC
//
/////////////////////////////////////////////////////////////////////
#include "cnr_recipe_utils"


void main()
{
  // Set the trade level caps for this PC
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_SMELTING,        20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_FOOD_CRAFTING,   20);

  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WEAPON_CRAFTING, 20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ARMOR_CRAFTING,  20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ALCHEMY,         20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_SCRIBING,        20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TINKERING,       20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING,   20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ENCHANTING,      20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_GEM_CRAFTING,    20);
  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TAILORING,       20);

  CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_HERBS,           20);

  int nPrimaryClassType = GetClassByPosition(1, OBJECT_SELF);
  int nRacialType = GetRacialType(OBJECT_SELF);
  /*
  if (nRacialType == RACIAL_TYPE_DWARF)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WEAPON_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ARMOR_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_GEM_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ENCHANTING, 20);
  }
  else if (nRacialType == RACIAL_TYPE_ELF)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TAILORING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ENCHANTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_HERBS, 20);
  }
  else if (nRacialType == RACIAL_TYPE_GNOME)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TINKERING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ENCHANTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_GEM_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ALCHEMY, 20);
  }
  else if (nRacialType == RACIAL_TYPE_HALFELF)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_HERBS, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WEAPON_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TAILORING, 20);
  }
  else if (nRacialType == RACIAL_TYPE_HALFORC)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_SMELTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WEAPON_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ARMOR_CRAFTING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING, 20);
  }
  else if (nRacialType == RACIAL_TYPE_HALFLING)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TINKERING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TAILORING, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ALCHEMY, 20);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING, 20);
  }
  else if (nRacialType == RACIAL_TYPE_HUMAN)
  {
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WEAPON_CRAFTING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ARMOR_CRAFTING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ALCHEMY,10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_SCRIBING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TINKERING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_WOOD_CRAFTING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_ENCHANTING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_GEM_CRAFTING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_TAILORING, 10);
    CnrSetTradeskillLevelCapByType(OBJECT_SELF, CNR_TRADESKILL_HERBS, 10);
  } */

}
