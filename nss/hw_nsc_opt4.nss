//::///////////////////////////////////////////////
//:: HW Tools
//:: hw_nsc_opt4
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
{ object oPC = GetPCSpeaker();                              int nOpt4XP      = GetLocalInt(OBJECT_SELF, "Opt4XP");
  int nOpt4TakeGold= GetLocalInt(OBJECT_SELF, "Opt4Gold");  int nOpt4Slot    = GetLocalInt(OBJECT_SELF, "Opt4Slot");
  int nOpt4FstProp = GetLocalInt(OBJECT_SELF, "Opt4Int1");  int nOpt4SndProp = GetLocalInt(OBJECT_SELF, "Opt4Int2");
  int nOpt4TrdProp = GetLocalInt(OBJECT_SELF, "Opt4Int3");  int nOpt4FthProp = GetLocalInt(OBJECT_SELF, "Opt4Int4");

  object oRPTaler  = GetItemPossessedBy(oPC, "RPTaler");
  object oOpt4Item = GetItemInSlot(nOpt4Slot, oPC);

    if (   (GetGold(oPC) >= nOpt4TakeGold)
        && (GetItemStackSize(oRPTaler) >= nOpt4XP)
        && (GetIsObjectValid(oOpt4Item) == TRUE)
       )
    {
      //AddHWSProp(oOpt4Item, nOpt4FstProp, nOpt4SndProp, nOpt4TrdProp, nOpt4FthProp);
      //TakeGoldFromCreature(nOpt4TakeGold, oPC, TRUE);
      //DercrementStackSize(oPC, "RPTaler", nOpt4XP);
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
