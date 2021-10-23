// hook_ok_to_level
#include "cnr_hook_helper"
#include "cnr_recipe_utils"

int CnrGetTradeskillLevelsEarned(object oPC)
{
  int nLevelsEarned = 0;
  int nCount = CnrGetTradeskillCount();
  int nIndex;
  for (nIndex=1; nIndex<=nCount; nIndex++)
  {
    int nXP = CnrGetTradeskillXPByIndex(oPC, nIndex);
    int nLevel = CnrDetermineTradeskillLevel(nXP);
    nLevelsEarned += nLevel;
  }
  return nLevelsEarned;
}

int CnrGetTradeskillLevelsMastered(object oPC)
{
  int nLevelsMastered = 0;
  int nCount = CnrGetTradeskillCount();
  int nIndex;
  for (nIndex=1; nIndex<=nCount; nIndex++)
  {
    int nXP = CnrGetTradeskillXPByIndex(oPC, nIndex);
    int nLevel = CnrDetermineTradeskillLevel(nXP);
    if (nLevel >= 20)
    {
      nLevelsMastered++;
    }
  }
  return nLevelsMastered;
}

void main()
{
  // inputs
  int nTradeskillType = CnrHookHelperGetTradeskillType(OBJECT_SELF);
  int nNextLevel = CnrHookHelperGetNextLevel(OBJECT_SELF);

  // outputs
  //CnrHookHelperSetLevelUpDenied(OBJECT_SELF, TRUE);
  //CnrHookHelperSetLevelUpDeniedText(OBJECT_SELF, "\nYou cannot level becuse you stink too bad!");

  /*
  ////////////////////////////////////////////////////////////////
  // This example will deny the PC from leveling if they haven't
  // gained enough adventuring levels. This allows 4 trade levels
  // for each adventuring level acheived.
  ////////////////////////////////////////////////////////////////
  int nTotalLevelsAllowed = GetHitDice(OBJECT_SELF) * 4;
  int nTotalLevelsEarned = CnrGetTradeskillLevelsEarned(OBJECT_SELF) + 1;
  if (nTotalLevelsEarned > nTotalLevelsAllowed)
  {
    CnrHookHelperSetLevelUpDenied(OBJECT_SELF, TRUE);
    string sDeniedText = "\nYou must earn another adventuring level before ";
    sDeniedText += "you will be able to increase your ";
    sDeniedText += CnrGetTradeskillNameByType(nTradeskillType) + " skills.";
    CnrHookHelperSetLevelUpDeniedText(OBJECT_SELF, sDeniedText);
  }
  */


  ////////////////////////////////////////////////////////////////
  // This example will prevent the PC from leveling more than 40
  // times across all tradeskills.
  ////////////////////////////////////////////////////////////////

  // Lese die Schmelzen-EP aus
  int nSmtXP = CnrGetTradeskillXPByIndex(OBJECT_SELF, CNR_TRADESKILL_SMELTING);
  // Bilde daraus die Stufe
  int nSmLvl = CnrDetermineTradeskillLevel(nSmtXP);

  // Lese die Nahrung-EP aus
  int nFodXP = CnrGetTradeskillXPByIndex(OBJECT_SELF, CNR_TRADESKILL_FOOD_CRAFTING);
  // Bilde daraus die Stufe
  int nFdLvl = CnrDetermineTradeskillLevel(nSmtXP);

  // Lese alle HW-Stufen aus
  int nTotalLevelsEarned = CnrGetTradeskillLevelsEarned(OBJECT_SELF) + 1;
  // Reduziere die Gesamtlvl um die Schmelzenlvl und Nahrungslvl
      nTotalLevelsEarned = nTotalLevelsEarned - nSmLvl - nFdLvl;

  if (nTotalLevelsEarned > 40)
  {
    CnrHookHelperSetLevelUpDenied(OBJECT_SELF, TRUE);
    string sDeniedText = "Du hast die maximale Stufe im Handwerk erreicht.";
    CnrHookHelperSetLevelUpDeniedText(OBJECT_SELF, sDeniedText);
  }
}
