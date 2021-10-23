//::///////////////////////////////////////////////
//:: SL-Tool INCLUDE
//:: sltools_inc
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Die Bestimmende Include für SL Funktionen



*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.12.2010
//:://////////////////////////////////////////////
#include "x2_inc_itemprop"
#include "nw_i0_plot"
#include "nbde_inc"
#include "_debugisla"

//void main() { } // Alibimain zur Komplimierung

  // Tags der SL Werkzeuge (& ggf Gespräche)
  const string SL_EPS      = "itm_slgivesep";
  const string SL_GOLD     = "itm_slgivesgold";
  const string SL_BEAM     = "itm_slportchar";
  const string SL_PORTAL   = "itm_slportspawn";
  const string SL_COPYALL  = "itm_copyall";
  const string SL_DESTROY  = "itm_destroyall";
  const string SL_VISUAL   = "itm_slvisual";
  const string SL_FACTIONS = "itm_slfraktion";
  const string SL_ADDPRTY  = "itm_addproperty";
  const string SL_DESCRIPT = "itm_description";

  // Database der SL
  const string SLTOOLS_DB = "SLTOOLS_DB";

//Standard und Nutzerdefinierte Factions
//const int STANDARD_FACTION_HOSTILE  = 0;    Monster, Feindlich allem gegenüber
//const int STANDARD_FACTION_COMMONER = 1;    Bürger, Feindlich gegeüber Monstern
//const int STANDARD_FACTION_MERCHANT = 2;    Händler, Feindlich gegenüber Monstern
//const int STANDARD_FACTION_DEFENDER = 3;    Verteidiger, Feindlich gegenüber Monstern
  const int USER_FACTION_ANIMALS      = 4; // Absolut Neutral allem gegenüber, Feindlich zu Monstern
  const int USER_FACTION_TRUENEUTRAL  = 5; // Absolut Neutral allem gegenüber
  const int USER_FACTION_CNRANIMAL    = 6; // Absolut Neutral SC's gegenüber, Feindlich zu Monstern
  const int USER_FACTION_QUESTGIVER   = 7; // Absolut Neutral allem gegenüber, Freundlich zu SC

  // Deklariere die Nutzer/aktivierten Items
  object    oSpeaker = GetPCSpeaker();
  object  oSpeakTarg = GetSpellTargetObject();
  // Die Haut mit der bestimmenden Int erfassen
  object       oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oSpeaker);
  object oItemCaster = GetItemActivator();
  object oItemActive = GetItemActivated();
  object oItemTarget = GetItemActivatedTarget();

  // Finde die Ziele der Nutzer/aktivierten Items
  location  locOfSpeaker = GetLocation(oSpeaker);
  location  locSpeakTarg = GetLocation(oSpeakTarg);
  location locItemTarget = GetItemActivatedTargetLocation();
  location locItemCaster = GetLocation(oItemCaster);

  // Finde die Area des Ziels
  object oAreaItemTarget = GetAreaFromLocation(locItemTarget);
  object oAreaItemCaster = GetAreaFromLocation(locItemCaster);
  object  oAreaOfSpeaker = GetAreaFromLocation(locOfSpeaker);

  // Tag des aktivierten Items auslesen
  string sItem = GetTag(oItemTarget);

  // Benutzerdefinierte ID's generieren
  string sSpeakerID = GetName(oSpeaker)    + "_" + GetPCPlayerName(oSpeaker);
  string sSpekTarID = GetName(oSpeakTarg)  + "_" + GetPCPlayerName(oSpeakTarg);
  string sItmCastID = GetName(oItemCaster) + "_" + GetPCPlayerName(oItemCaster);
  string sItmCaTaID = GetName(oItemTarget) + "_" + GetPCPlayerName(oItemTarget);

  // Counci-Werzeugvariablen, nicht in DB, da auf Item gespeichert.
  int     nGivenEPS = GetLocalInt(OBJECT_SELF, GetName(oItemTarget));
  int    nGivenGold = GetLocalInt(OBJECT_SELF, GetName(oItemTarget));


//////////////////////////////////////////////////
// Prüfung ob SL Tool von Spieler / Sl nutzbar ist
//
//
int UseableDmTool(object oUser);
int UseableDmTool(object oUser)
{
  // Lese den Status aus, ob der Spieler Council ist
  string sAccountKey = GetPCPublicCDKey(oUser);
  int nIsCouncil = GetCampaignInt(SLTOOLS_DB, "CL_"+sAccountKey);

  if ( (GetIsDM(oUser) == FALSE) || (GetIsDMPossessed(oUser) == FALSE) )
  {
    if (nIsCouncil == TRUE) return TRUE;
    else                    return FALSE;
  }
  else
    return TRUE;
}


//////////////////////////////////////////////////
// Setzen der Council Flagge
//
//
void SetCouncil(object oUser);
void SetCouncil(object oUser)
{
  string sAccountKey = GetPCPublicCDKey(oUser);
  int nIsCouncil = GetCampaignInt(SLTOOLS_DB, "CL_"+sAccountKey);

  if ( (nIsCouncil == FALSE) )                                                  // Setze den Spieler als Council ein
  {
    SetCampaignInt(SLTOOLS_DB, "CL_"+sAccountKey, TRUE);
    CreateItemOnObject("itm_council", oUser);
  }
  else
  {
    SetCampaignInt(SLTOOLS_DB, "CL_"+sAccountKey, FALSE);
    DestroyObject(GetObjectByTag("itm_council"));
  }
}


//////////////////////////////////////////////////
// Lade alle Daten aus der Datenbank für den SL
//
//
void LoadSlDBVariables(object oUser);
void LoadSlDBVariables(object oUser)
{
  string sAccountKey = GetPCPublicCDKey(oUser);

  // Gespeicherte Variablen des Werkzeuges aus Datenbank
  // auslesen, wenn nicht vorhanden = Null
  int nInt1 = GetCampaignInt(SLTOOLS_DB, "INT1_"+sAccountKey);
              SetLocalInt(oUser, "Int1", nInt1);
  int nInt2 = GetCampaignInt(SLTOOLS_DB, "INT2_"+sAccountKey);
              SetLocalInt(oUser, "Int2", nInt2);
  int nInt3 = GetCampaignInt(SLTOOLS_DB, "INT3_"+sAccountKey);
              SetLocalInt(oUser, "Int3", nInt3);
  int nInt4 = GetCampaignInt(SLTOOLS_DB, "INT4_"+sAccountKey);
              SetLocalInt(oUser, "Int4", nInt4);

  string sString1 = GetCampaignString(SLTOOLS_DB, "STRING1_"+sAccountKey);
  SetLocalString(oUser, "String1", sString1);

  float fFloat1 = GetCampaignFloat(SLTOOLS_DB, "FLOAT1_"+sAccountKey);
  SetLocalFloat(oUser, "Float1", fFloat1);

  FloatingTextStringOnCreature("Variablen wurden aus Datenbank geladen.", oUser, FALSE);
}

//////////////////////////////////////////////////
// Speicher alle Daten in die Datenbank für den SL
//
//
void SaveSlDBVariables(object oUser);
void SaveSlDBVariables(object oUser)
{
  string sAccountKey = GetPCPublicCDKey(oUser);

  int nInt1 = GetLocalInt(oUser, "Int1");
              SetCampaignInt(SLTOOLS_DB, "INT1_"+sAccountKey, nInt1);
  int nInt2 = GetLocalInt(oUser, "Int2");
              SetCampaignInt(SLTOOLS_DB, "INT2_"+sAccountKey, nInt2);
  int nInt3 = GetLocalInt(oUser, "Int3");
              SetCampaignInt(SLTOOLS_DB, "INT3_"+sAccountKey, nInt3);
  int nInt4 = GetLocalInt(oUser, "Int4");
              SetCampaignInt(SLTOOLS_DB, "INT4_"+sAccountKey, nInt4);

  string sString1 = GetLocalString(oUser, "String1");
  SetCampaignString(SLTOOLS_DB, "STRING1_"+sAccountKey, sString1);

  float fFloat1 = GetLocalFloat(oUser, "Float1");
  SetCampaignFloat(SLTOOLS_DB, "FLOAT1_"+sAccountKey, fFloat1);

  FloatingTextStringOnCreature("Variablen in Datenbank gespeichert.", oUser, FALSE);
}


//////////////////////////////////////////////////
// Prüfung ob Ziel eine Slashing Weapon ist
//
//
int GetIsSlashing(object oItem);
int GetIsSlashing(object oItem)
{
  int nBaseType = GetBaseItemType(oItem);
  if ( (nBaseType >=  1) && (nBaseType <=  3) || (nBaseType >= 12) && (nBaseType <= 13) ||
       (nBaseType == 18) || (nBaseType == 33) || (nBaseType == 38) ||
       (nBaseType >= 40) && (nBaseType <= 42) || (nBaseType == 53) || (nBaseType == 60) ||
       (nBaseType == 63) || (nBaseType ==108) || (nBaseType ==111) )
  { return TRUE; }
  else { return FALSE; }
}

/*////////////////////////////////////////////////
// Lese den Angriffsbonus aus
//
//
int GetWeaponAttackBonus(object oWeapon);
int GetWeaponAttackBonus(object oWeapon)
{
  itemproperty ip = GetFirstItemProperty(oWeapon);
  int nFound = 0;
  while ( (nFound == 0) && (GetItemPropertyType(ip) == ITEM_PROPERTY_ATTACK_BONUS) )
  {
    nFound = GetItemPropertyCostTableValue(ip);

    ip = GetNextItemProperty(oWeapon);
  }
  return nFound;
}*/

/*////////////////////////////////////////////////
// Lese den Schadensbonus aus
// nDamageType ist die INT der jeweiligen Schadens-
// art.
int GetDamageBonus(object oWeapon, int nDamageType = DAMAGE_TYPE_MAGICAL);
int GetDamageBonus(object oWeapon, int nDamageType = DAMAGE_TYPE_MAGICAL)
{
    itemproperty ip = GetFirstItemProperty(oWeapon);
    int nFound = 0;
    while (nFound == 0 && GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertySubType(ip) == nDamageType)
        {
            nFound = GetItemPropertyCostTableValue(ip);
        }
        ip = GetNextItemProperty(oWeapon);
    }
    return nFound;
}*/

/*//////////////////////////////////////////////////////////////////
// Takes a nNumItems from sItem
//
void DercrementStackSize(object oTarget,string sItem,int nNumItems);
void DercrementStackSize(object oTarget,string sItem,int nNumItems)
{
  int nCount = 0;     // Anzahl genommener Items auf Null
  int nNewStSize;     // Die neue Anzahl an Items im Stack

  // Erstes Item scannen
  object oItem = GetFirstItemInInventory(oTarget);

  // während das Item gültig und die Anzahl geprüfter Items kleiner als Anzahl an zu nehmender ist
  while ( (GetIsObjectValid(oItem) == TRUE) && (nCount < nNumItems) )
  { // Ist der Tag des Items gleich des gesuchten
    if (GetTag(oItem) == sItem)
    {  int nStackSize = GetNumStackedItems(oItem);
      // Wenn gefundenes Item mehr als 2 Items und das Maximum 10 beinhaltet
      if ( (nStackSize >= 2) && (nStackSize <= 10) )
      { nNewStSize = nStackSize - nNumItems;   // nimm die vorbestimmte Anzahl
        SetItemStackSize(oItem, nNewStSize); } // und setze die StackSize des Items auf die neue Anzahl
      // wird nur ein Item gefunden, zerstöre dieses
      else
      { DestroyObject(oItem); }
      // Anzahl genommener Items + 1
      nCount++;
    } // Ende If (GetTag(oItem) == sItem)
  // Nächstes Item scannen
  oItem = GetNextItemInInventory(oTarget);
  } // Ende While
  return;
} // Ende Void*/

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Items erfassen
// sItemResRef = zu suchendes Item, oContainer = zu durchsuchendes Ziel
// oItem = liefert das gesuchte Item, meldet OBJECT_INVALID wenn nicht vorhanden
//
object ItemByResRef(string sItemResRef, object oContainer); // From CNR Adapted
object ItemByResRef(string sItemResRef, object oContainer)
{
object oItem = GetFirstItemInInventory(oContainer);
  while (oItem != OBJECT_INVALID)
  { // Ist es das richtige Item?
    if (GetResRef(oItem) == sItemResRef)
    { return oItem; }

    // Einen Behaelter gefunden?
    if (GetHasInventory(oItem) == TRUE)
    { oItem = ItemByResRef(sItemResRef, oItem); } // Suche darin

    oItem = GetNextItemInInventory(oContainer); } // Naechster Gegenstand

  if (GetObjectType(oContainer) == OBJECT_TYPE_CREATURE)
  { int nSlot;
    for (nSlot=INVENTORY_SLOT_HEAD; nSlot<=INVENTORY_SLOT_BOLTS; nSlot++)
    { oItem = GetItemInSlot(nSlot, oContainer);
        if (oItem != OBJECT_INVALID)
        { if (GetResRef(oItem) == sItemResRef) { return oItem; } }
    }
  }
  return OBJECT_INVALID;
}*/
