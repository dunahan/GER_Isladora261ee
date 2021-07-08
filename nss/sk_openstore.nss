//::///////////////////////////////////////////////
//:: FileName open_store
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Oowyn
//:: Created On: 9/02/2003
//::
//:: Place this script in the Action Taken tab of
//:: a conversation node.
//:: Paint a merchant near the NPC that called the
//:: conversation with tag of 'Store_<tag>' where
//:: <tag> is the NPC's tag.
//:://////////////////////////////////////////////
#include "_isla_inc"

void main()
{
  string sStore = GetTag(OBJECT_SELF);
  object oStore = GetObjectByTag("Store_"+sStore);

  int nBonusUp   = GetLocalInt(oStore, "BonusUp");
  int nBonusDown = GetLocalInt(oStore, "BonusDown");
  int nStoreGold = GetStoreGold(oStore);

  if (nStoreGold <= 4999 && nStoreGold >= 4000) { nBonusUp = (nBonusUp *  5)/100;
                                                  nBonusDown = ((nBonusDown * 5)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore, 1750); }
  if (nStoreGold <= 3999 && nStoreGold >= 3000) { nBonusUp = (nBonusUp *  7)/100;
                                                  nBonusDown = ((nBonusDown * 7)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore, 1250); }
  if (nStoreGold <= 2999 && nStoreGold >= 2000) { nBonusUp = (nBonusUp * 18)/100;
                                                  nBonusDown = ((nBonusDown * 18)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore, 1000); }
  if (nStoreGold <= 1999 && nStoreGold >= 1000) { nBonusUp = (nBonusUp * 25)/100;
                                                  nBonusDown = ((nBonusDown * 25)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore,  750); }
  if (nStoreGold <=  999 && nStoreGold >=  500) { nBonusUp = (nBonusUp * 37)/100;
                                                  nBonusDown = ((nBonusDown * 37)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore,  250); }
  if (nStoreGold <=  499 && nStoreGold >=  250) { nBonusUp = (nBonusUp * 45)/100;
                                                  nBonusDown = ((nBonusDown * 45)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore, 100); }
  if (nStoreGold <=  249 && nStoreGold >=  100) { nBonusUp = (nBonusUp * 55)/100;
                                                  nBonusDown = ((nBonusDown * 55)/100) + nBonusDown;
                                                  SetStoreMaxBuyPrice(oStore,   10); }

  if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
      gplotAppraiseOpenStore(oStore, GetPCSpeaker(), nBonusUp, nBonusDown);
  else
      ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);

}
