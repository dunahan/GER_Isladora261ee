//::///////////////////////////////////////////////
//:: HW Tools
//:: hw_nsc_opt2
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Item zum Eigenschaften hinzufügen
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 18.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"

void main()
{ object oPC = GetPCSpeaker();                              int nOpt2XP      = GetLocalInt(OBJECT_SELF, "Opt2XP");
  int nOpt2TakeGold= GetLocalInt(OBJECT_SELF, "Opt2Gold");  int nOpt2Slot    = GetLocalInt(OBJECT_SELF, "Opt2Slot");
  int nOpt2FstProp = GetLocalInt(OBJECT_SELF, "Opt2Int1");  int nOpt2SndProp = GetLocalInt(OBJECT_SELF, "Opt2Int2");
  int nOpt2TrdProp = GetLocalInt(OBJECT_SELF, "Opt2Int3");  int nOpt2FthProp = GetLocalInt(OBJECT_SELF, "Opt2Int4");

  object oRPTaler  = GetItemPossessedBy(oPC, "RPTaler");
  object oOpt2Item = GetItemInSlot(nOpt2Slot, oPC);

    if (   (GetGold(oPC) >= nOpt2TakeGold)
        && (GetItemStackSize(oRPTaler) >= nOpt2XP)
        && (GetIsObjectValid(oOpt2Item) == TRUE)
       )
    {
      //AddHWSProp(oOpt2Item, nOpt2FstProp, nOpt2SndProp, nOpt2TrdProp, nOpt2FthProp);
      //TakeGoldFromCreature(nOpt2TakeGold, oPC, TRUE);
      //DercrementStackSize(oPC, "RPTaler", nOpt2XP);
      SpeakString("Tut mir leid, aber ich kann das nicht machen.");
      return;
    }
    else
    {
      SpeakString("Tut mir leid, aber ich kann das nicht machen.");
      return;
    }

  if (GetLocalInt(OBJECT_SELF, "OnlyOnce") == 1)    SetLocalInt(OBJECT_SELF, "Active", 1);
}
