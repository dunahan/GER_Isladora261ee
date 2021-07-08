#include "nw_i0_plot"

const string RDD_ITEM = "rdd_fluegel";
const string BLM_ITEM = "blm_totearm";

void main()
{
  object oPC = GetPCLevellingUp();

  ExecuteScript("fky_chat_levelup", oPC);
  ExecuteScript("tk_playertools_a", oPC);

  int nRddLvls = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC);
  int nBlmLvls = GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC);

  if (nRddLvls >= 9)
  {
    if (HasItem(oPC, RDD_ITEM) == FALSE)
    {
      SetCreatureWingType(CREATURE_WING_TYPE_NONE, oPC);
    }
  }

  else if (nRddLvls >= 6)
  {
    if (HasItem(oPC, BLM_ITEM) == FALSE)
    {
      SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, CREATURE_MODEL_TYPE_SKIN, oPC);
      SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, CREATURE_MODEL_TYPE_SKIN, oPC);
      SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, CREATURE_MODEL_TYPE_SKIN, oPC);
    }
  }
}
