//::///////////////////////////////////////////////
//:: HW Tools
//:: hw_nsc_opt3
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
{ object oPC = GetPCSpeaker();                              int nOpt3XP      = GetLocalInt(OBJECT_SELF, "Opt3XP");
  int nOpt3TakeGold= GetLocalInt(OBJECT_SELF, "Opt3Gold");  int nOpt3Slot    = GetLocalInt(OBJECT_SELF, "Opt3Slot");
  int nOpt3FstProp = GetLocalInt(OBJECT_SELF, "Opt3Int1");  int nOpt3SndProp = GetLocalInt(OBJECT_SELF, "Opt3Int2");
  int nOpt3TrdProp = GetLocalInt(OBJECT_SELF, "Opt3Int3");  int nOpt3FthProp = GetLocalInt(OBJECT_SELF, "Opt3Int4");

  object oRPTaler  = GetItemPossessedBy(oPC, "RPTaler");
  object oOpt3Item = GetItemInSlot(nOpt3Slot, oPC);

    if (   (GetGold(oPC) >= nOpt3TakeGold)
        && (GetItemStackSize(oRPTaler) >= nOpt3XP)
        && (GetIsObjectValid(oOpt3Item) == TRUE)
       )
    {
      //AddHWSProp(oOpt3Item, nOpt3FstProp, nOpt3SndProp, nOpt3TrdProp, nOpt3FthProp);
      //TakeGoldFromCreature(nOpt3TakeGold, oPC, TRUE);
      //DercrementStackSize(oPC, "RPTaler", nOpt3XP);
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
