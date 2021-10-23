#include "nw_i0_plot"

void main()
{
  // itm_feenstaub|key_eisbeer|key_zwerge

  object oPC = GetEnteringObject();

  int nRace = GetRacialType(oPC); string sTag;
  int nDruShi = GetLevelByClass(CLASS_TYPE_DRUID,oPC)+GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);

  if (nRace == RACIAL_TYPE_DWARF)
    if (!HasItem(oPC, "key_zwerge"))
      CreateItemOnObject("key_zwerge", oPC);

  if (nRace == RACIAL_TYPE_ELF)
    if (!HasItem(oPC, "itm_feenstaub"))
      CreateItemOnObject("itm_feenstaub", oPC);

  if (nDruShi >= 1)
  {
    if (!HasItem(oPC, "key_eisbeer"))
      CreateItemOnObject("key_eisbeer", oPC);

    if (!HasItem(oPC, "shifter_study"))
      CreateItemOnObject("it_shifter_study", oPC);
  }

  if (!HasItem(oPC, GetLocalString(OBJECT_SELF, "special")))
    CreateItemOnObject(GetLocalString(OBJECT_SELF, "special"), oPC);
}
