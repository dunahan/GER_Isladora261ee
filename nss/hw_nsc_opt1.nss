//::///////////////////////////////////////////////
//:: HW Tools
//:: hw_nsc_opt1
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
{ object oPC = GetPCSpeaker();                              int nOpt1XP      = GetLocalInt(OBJECT_SELF, "Opt1XP");
  int nOpt1TakeGold= GetLocalInt(OBJECT_SELF, "Opt1Gold");  int nOpt1Slot    = GetLocalInt(OBJECT_SELF, "Opt1Slot");
  int nOpt1FstProp = GetLocalInt(OBJECT_SELF, "Opt1Int1");  int nOpt1SndProp = GetLocalInt(OBJECT_SELF, "Opt1Int2");
  int nOpt1TrdProp = GetLocalInt(OBJECT_SELF, "Opt1Int3");  int nOpt1FthProp = GetLocalInt(OBJECT_SELF, "Opt1Int4");

  object oRPTaler  = GetItemPossessedBy(oPC, "RPTaler");
  object oOpt1Item = GetItemInSlot(nOpt1Slot, oPC);

    if (   (GetGold(oPC) >= nOpt1TakeGold)
        && (GetItemStackSize(oRPTaler) >= nOpt1XP)
        && (GetIsObjectValid(oOpt1Item) == TRUE)
       )
    {
      //AddHWSProp(oOpt1Item, nOpt1FstProp, nOpt1SndProp, nOpt1TrdProp, nOpt1FthProp);
      //TakeGoldFromCreature(nOpt1TakeGold, oPC, TRUE);
      //DercrementStackSize(oPC, "RPTaler", nOpt1XP);
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
