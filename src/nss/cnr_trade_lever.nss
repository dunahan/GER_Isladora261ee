#include "cnr_recipe_utils"
void main()
{
  int nTrade = 0;
  string   sTradeName =  GetTag(OBJECT_SELF);
  if      (sTradeName == "Smelting")   { nTrade = CNR_TRADESKILL_SMELTING; }
  else if (sTradeName == "Weapon")     { nTrade = CNR_TRADESKILL_WEAPON_CRAFTING; }
  else if (sTradeName == "Armor")      { nTrade = CNR_TRADESKILL_ARMOR_CRAFTING; }
  else if (sTradeName == "Alchemy")    { nTrade = CNR_TRADESKILL_ALCHEMY; }
  else if (sTradeName == "Writing")    { nTrade = CNR_TRADESKILL_SCRIBING; }
  else if (sTradeName == "Thinkering") { nTrade = CNR_TRADESKILL_TINKERING; }
  else if (sTradeName == "Carpening")  { nTrade = CNR_TRADESKILL_WOOD_CRAFTING; }
  else if (sTradeName == "Enchanting") { nTrade = CNR_TRADESKILL_ENCHANTING; }
  else if (sTradeName == "Gemworks")   { nTrade = CNR_TRADESKILL_GEM_CRAFTING; }
  else if (sTradeName == "Tailor")     { nTrade = CNR_TRADESKILL_TAILORING; }
  else if (sTradeName == "Food")       { nTrade = CNR_TRADESKILL_FOOD_CRAFTING; }
  else if (sTradeName == "Herbs")      { nTrade = CNR_TRADESKILL_HERBS; }

  if (nTrade > 0)
  {
    object oUser = GetLastUsedBy();
    int nXP = CnrGetTradeskillXPByType(oUser, nTrade);
    int nLevel = CnrDetermineTradeskillLevel(nXP);
    int nNextLevelXP = 0;
    if (nLevel != 20)
    {
      nLevel = nLevel + 1;
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
      nNextLevelXP = GetLocalInt(GetModule(), "CnrTradeXPLevel" + IntToString(nLevel));
    }
    else
    {
      PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
      nLevel = 1;
    }
    CnrSetTradeskillXPByType(oUser, nTrade, nNextLevelXP);
    FloatingTextStringOnCreature("Deine " + sTradeName + " Fertigkeit ist jetzt Stufe " + IntToString(nLevel), oUser, FALSE);
  }
}
