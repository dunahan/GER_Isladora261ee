//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Sets The Custom Tokens
//:: _sk_otaw_settokn
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Text Appears When einfügen
    Liest verschiedenste Variablen, welche auf dem
    Shop abgelegt wurden aus und setzt sie als Text-
    Token ein

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

#include "_sk_include"

int StartingConditional()
{
  string sStore = GetTag(OBJECT_SELF);
  object oStore = GetObjectByTag(SK_PREFIX+sStore);

  if ( GetIsObjectValid(oStore) == TRUE )
  {
    SetCustomToken(70000, GetLocalString(OBJECT_SELF, "Welcome"));
    SetCustomToken(70001, GetLocalString(OBJECT_SELF, "OpenShop"));
    SetCustomToken(70002, GetLocalString(OBJECT_SELF, "ByeBye"));

    int nBonusUp   = GetLocalInt(oStore, "BonusUp");
    int nBonusDown = GetLocalInt(oStore, "BonusDown");

    // Optionen1 fuer SL aus NSC lesen
    SetCustomToken(70003, IntToString( nBonusUp ));
    // Optionen2 fuer SL aus NSC lesen
    SetCustomToken(70004, IntToString( nBonusDown ));

    // Abfrage Gold im Laden
    int nStoreGold = GetStoreGold(oStore);
    if ( nStoreGold == -1 )
      SetCustomToken(70010, "uneingeschränkt");
    else
      SetCustomToken(70010, IntToString(nStoreGold) );

    // Abfrage Maximales Gold
    int nMaxGold = GetStoreMaxBuyPrice(oStore);
    if ( nMaxGold == -1 )
      SetCustomToken(70020, "uneingeschränkt");
    else
      SetCustomToken(70020, IntToString(nMaxGold) );

    // Abfrage Identifizieren
    int nIdentify = GetStoreIdentifyCost(oStore);
    if ( nIdentify <= 0 )
      SetCustomToken(70030, "kann nicht identifizieren." );
    else
      SetCustomToken(70030, IntToString(nIdentify) );

    // Gegenstand beeinfussen, Gegenstand erfassen
    object oTarget = GetLocalObject(oStore, "Target");
    if (GetIsObjectValid(oTarget) == TRUE)
      SetCustomToken(70040, GetName(oTarget) );
    else
      SetCustomToken(70040, "Momentan nichts ausgewählt." );

    // Unbegrenzte/begrenzte Verfügbarkeit
    if (GetInfiniteFlag(oTarget) == TRUE )  // Ist dieser Gegenstand unendlich vorhanden?
      SetCustomToken(70050, "ist unendlich." );
    else
      SetCustomToken(70050, "ist nicht unendlich." );

    // Stackgröße beeinflussen
    int nStack = GetItemStackSize(oTarget);
    if (nStack <= 0)
      SetCustomToken(70060, "hat momentan keine Größe." );
    else
      SetCustomToken(70060, IntToString(nStack) );

    // Schaetzen nutzen?
    int nAppraise = GetLocalInt(oStore, "UseAppraise");
    if ( nIdentify <= 0 )
      SetCustomToken(70070, "nutzt kein -Schätzen-." );
    else
      SetCustomToken(70070, "nutzt -Schätzen-." );

//---------------------------------------------------------------------------------------
      // Heiler auslesen...
      SetCustomToken(70080, GetLocalString(OBJECT_SELF, "50") );
      SetCustomToken(70081, GetLocalString(OBJECT_SELF, "51") );
      SetCustomToken(70082, GetLocalString(OBJECT_SELF, "52") );
      SetCustomToken(70083, GetLocalString(OBJECT_SELF, "53") );
      SetCustomToken(70084, GetLocalString(OBJECT_SELF, "54") );
      SetCustomToken(70085, GetLocalString(OBJECT_SELF, "55") );
  }
  return TRUE;  // Immer einen Wert zurueckgeben.
}

