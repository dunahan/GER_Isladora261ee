//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Open Shop
//:: _sk_oat_openshop
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim NSC unter, On Conversation einzufügen
    Öffnet das Gespräch des Händlers und die
    Auswahl für den SC. Läd zudem alle Daten
    für den Shop ein

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

#include "_sk_include"

void main()
{
  string sStore = GetTag(OBJECT_SELF);
  object oStore = GetObjectByTag(SK_PREFIX+sStore);


  DebugMode(GetName(oStore)+", Oeffnen Skript.");

  if (GetLocalInt(oStore, "Reload") == 0)
  {
    DebugMode(GetName(oStore)+" leert sein Inventar.");
    ClearShopFromItems(oStore);
  }

  DebugMode(GetName(oStore)+" laedt sein Inventar.");
  LoadShopItemsFromDB(oStore);


  int nAppraise  = GetLocalInt(oStore, "UseAppraise"  ); // Liest aus, ob der Shop die Fertigkeit "Schätzen" prüfen soll, oder nicht
  int nBonusUp   = GetLocalInt(oStore, "BonusMarkUp"  ); // Liest den aus, ob der Shop seine Preise um 100+x% erhöht, aus
  int nBonusDown = GetLocalInt(oStore, "BonusMarkDown"); // Liest den aus, ob der Shop seine Preise um 100-x% verringert, aus

  int nStoreGold = GetStoreGold(oStore);                 // Liest den Stand des Goldes aus

  if (nStoreGold <= 4999 && nStoreGold >= 4000)
  {
    nBonusUp   =   (nBonusUp   *  5) / 100;
    nBonusDown =  ((nBonusDown *  5) / 100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore, 1750);
  }

  if (nStoreGold <= 3999 && nStoreGold >= 3000)
  {
    nBonusUp = (nBonusUp *  7)/100;
    nBonusDown = ((nBonusDown * 7)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore, 1250);
  }

  if (nStoreGold <= 2999 && nStoreGold >= 2000)
  {
    nBonusUp = (nBonusUp * 18)/100;
    nBonusDown = ((nBonusDown * 18)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore, 1000);
  }

  if (nStoreGold <= 1999 && nStoreGold >= 1000)
  {
    nBonusUp = (nBonusUp * 25)/100;
    nBonusDown = ((nBonusDown * 25)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore,  750);
  }

  if (nStoreGold <=  999 && nStoreGold >=  500)
  {
    nBonusUp = (nBonusUp * 37)/100;
    nBonusDown = ((nBonusDown * 37)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore,  250);
  }

  if (nStoreGold <=  499 && nStoreGold >=  250)
  {
    nBonusUp = (nBonusUp * 45)/100;
    nBonusDown = ((nBonusDown * 45)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore, 100);
  }

  if (nStoreGold <=  249 && nStoreGold >=  100)
  {
    nBonusUp = (nBonusUp * 55)/100;
    nBonusDown = ((nBonusDown * 55)/100) + nBonusDown;
    SetStoreMaxBuyPrice(oStore,   10);
  }


  if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
  {
    if (nAppraise == 0)
    {
      OpenStore(oStore, GetPCSpeaker(), nBonusUp, nBonusDown);
      DebugMode("Händler "+GetName(oStore)+" nutzt kein Schätzen.");
    }
    else
    {
      gplotAppraiseOpenStore(oStore, GetPCSpeaker(), nBonusUp, nBonusDown);
      DebugMode("Händler "+GetName(oStore)+" nutzt das Schätzen.");
    }
  }

  else
    ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);

}

