//::///////////////////////////////////////////////
//:: Isladora Area Belohnung
//:: _area_onenter
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Spezielle Area Belohnung fuer Chars unter
    maximal Lvl 20
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "00_jk_pins"
#include "ll_include"
#include "spawn_functions"

//const float  SPAWN_HEARTBEAT_INTERVALL  = 12.0;
//const float  SPAWN_HEARTBEAT_FIRSTDELAY =  6.0;

const string AREA_MSG_NEWXP = "Du hast ein, Dir unbekanntes Gelände betreten";
const int AREA_XPS_MULTI = 19;

void main()
{
  object   oPC = GetEnteringObject();                                           // Der Spieler der die Area betritt
  object oItem = GetItemPossessedBy(oPC, sQuestbuch);                           // Das im Inv liegende Item fuer Speicherungen
  object oArea = OBJECT_SELF;

  Spawn_OnAreaEnter("spawn_sample_hb", SPAWN_HEARTBEAT_INTERVALL, SPAWN_HEARTBEAT_FIRSTDELAY);  // Spawn after 6 seconds and shedule next one in 300 seconds aka 5 min, first slow down process

  if (!GetIsPlayerCharacter(oPC))                                               // Handelt es sich um keinen SC
    return;                                                                     // bricht das Skript ab

  if (!GetIsAreaInterior(oArea))
  {
    int     nExp = GetLocalInt(oItem, "Area_Exp");                              // Sammle notwendige Daten, fest zu vergebende EP
    string sName = GetResRef(OBJECT_SELF);                                      // Lese die ResRef der Area aus
    int nVisited = GetCampaignInt(GetPCPublicCDKey(oPC), sName, oPC);           // Wurde die Area bereits besucht?
    int     nLvl = GetHitDice(oPC);                                             // Lese die Stufe des SC aus

    DebugMode("Area_EPs gefeuert. Speichert die Area mit ResRef "+sName+ "\n"+  // Debuggen
              "Es werden folgende Daten herangezogen:\n"+
              "Vorgegebene EP: "+IntToString(nExp)+"\n"+
              "Zufaellige EP aus: "+IntToString(AREA_XPS_MULTI+1)+"\n"+
              "Die Area wurde "+IntToString(nVisited)+" besucht.\n"+
              "Das Level des betretenden Chars ist: "+IntToString(nLvl));

    if ( nLvl <= 10 &&                                                          // Der Char hat noch nicht Stufe 10 ueberschritten
         !nVisited )                                                            // UND die Area wurde noch nicht betreten
    {
      DebugMode("Stufe 10 noch nicht ueberschritten UND Area wurde noch nicht besucht");
      if ( nExp == 0)                                                           // Es soll eine zufaellige Verteilung erfolgen
        nExp = Random(AREA_XPS_MULTI)+1;                                        // Standard 1-20 EP

      SetXPImproved(oPC, GetXP(oPC) + nExp);                                    // Addiere die XP oben auf
      SetCampaignInt(GetPCPublicCDKey(oPC), sName, TRUE, oPC);                  // Vermerke als betreten
      SendServerMessageToPC(oPC, AREA_MSG_NEWXP);                                     // Teile dies dem Spieler mit
    }
  }

  PersistentMapPins(oPC, 0, "map_pin_conv2");                                   // Lade die Mappins vom Item

  if (GetLocalInt(GetArea(oPC), "HiddenMaps"))                                  // Nebel des Krieges ;-)
    SetMapUnexplored(oPC, 1.0);

  ExecuteScript(GetLocalString(OBJECT_SELF, "OnTileMagic"), OBJECT_SELF);
  ExecuteScript(GetLocalString(OBJECT_SELF, "OnEnter"), OBJECT_SELF);
}
