#include "_debugisla"

int StartingConditional()
{
  string sStore = GetTag(OBJECT_SELF);
  DebugMode("Suche den Laden: "+sStore);
  object oStore = GetObjectByTag("Store_"+sStore);
  DebugMode("Laden: "+GetName(oStore) + " mit Bezeichnung: " + GetTag(oStore));

  if ( GetIsObjectValid(oStore) == TRUE )
  {
    int nBonusUp   = GetLocalInt(oStore, "BonusUp");
    int nBonusDown = GetLocalInt(oStore, "BonusDown");
    // Optionen1 fuer SL aus NSC lesen
    SetCustomToken(70003, IntToString( nBonusUp ));
    // Optionen2 fuer SL aus NSC lesen
    SetCustomToken(70004, IntToString( nBonusDown ));

    // Abfrage Gold im Laden
    int nStoreGold = GetStoreGold(oStore);
    if ( nStoreGold == -1 ) { SetCustomToken(70010, "uneingeschränkt"); }
    else { SetCustomToken(70010, IntToString(nStoreGold) ); }
    // Abfrage Maximales Gold
    int nMaxGold = GetStoreMaxBuyPrice(oStore);
    if ( nMaxGold == -1 ) { SetCustomToken(70020, "uneingeschränkt"); }
    else { SetCustomToken(70020, IntToString(nMaxGold) ); }
    // Abfrage Identifizieren
    int nIdentify = GetStoreIdentifyCost(oStore);
    if ( nIdentify == -1 ) { SetCustomToken(70030, "kann nicht identifizieren." ); }
    else { SetCustomToken(70030, IntToString(nIdentify) ); }
    // Gegenstand unbegrenzt
    object oTarget = GetLocalObject(oStore, "Target");
    SetCustomToken(70040, GetName(oTarget) );
    int nStack = GetItemStackSize(oTarget);
    SetCustomToken(70041, IntToString(nStack) );

  }
  return TRUE;  // Immer einen Wert zurueckgeben.
}
