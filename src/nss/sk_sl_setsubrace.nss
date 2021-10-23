//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_setsubrace
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Subrace des Ziels in die DB
    zu speichern.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
/*#include "_sltools_inc"
#include "nbde_inc"
#include "isla_races"

void main()
{ // Hole dir die gegebene Subrace
  string sSubrace = GetSubRace(oSpeakTarg);

  if (sSubrace != "") { NBDE_SetCampaignString(SUBRACE_DB, "Subrace", sSubrace, oSpeakTarg);
                        NBDE_FlushCampaignDatabase(sDatabase);}

}



///////////////////////////////////////////////////
// Vergibt Klassenspezifische Fähigkeiten an
// eintretende Subrassen
//
void SetSubrace(object oEntering);
void SetSubrace(object oEntering)
{
  string sSubraceDB = NBDE_GetCampaignString(SUBRACE_DB, "Subrace", oEntering);

  if (sSubraceDB != "")
  {
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oEntering);
    int      nHD = GetHitDice(oEntering);
    int nLvl;

    switch (nHD) { case  0: case  1: case  2: case  3: case  4: nLvl =  1; break;
                   case  5: case  6: case  7: case  8: case  9: nLvl =  5; break;
                   case 10: case 11: case 12: case 13: case 14: nLvl = 10; break;
                   case 15: case 16: case 17: case 18: case 19: nLvl = 15; break;
                   case 20: case 21: case 22: case 23: case 24: nLvl = 20; break;
                   case 25: case 26: case 27: case 28: case 29: nLvl = 25; break;
                   case 30: case 31: case 32: case 33: case 34: nLvl = 30; break;
                   case 35: case 36: case 37: case 38: case 39: nLvl = 35; break;
                                                       case 40: nLvl = 40; break; }



    if ( (sSubraceDB == "Drow") && (nLvl == 5) ) { ItemPropertyBonusSpellResistance(0); }  // füge ZR +10 hinzu...

  /*void IPSafeAddItemProperty(
        object oItem,
        itemproperty nip,
        float fDuration = 0.0f,
        int nAddItemPropertyPolicy = X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,
        int bIgnoreDurationType = FALSE,
        int bIgnoreSubType = FALSE
    );

    IPSafeAddItemProperty(oHide, nItmProp,
  }
}*/


void main() { }
