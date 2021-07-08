//::///////////////////////////////////////////////
//:: ISLADORA INCLUDE
//:: isla_inc
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    Die Bestimmende Include für ganz Isladora
    - Zwei Funktionen raus & Tokenizer als Inc verbunden


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 20.10.2009
//:: Modified On: 15.04.2013
//:://////////////////////////////////////////////
#include "nw_i0_2q4luskan"
#include "x2_inc_itemprop"
#include "nw_i0_plot"
#include "x3_inc_string"
#include "x2_inc_toollib"
#include "x3_inc_horse"
#include "x0_i0_position"

#include "tele_inc"
#include "eds_include"
#include "colors_inc"
#include "_debugisla"

                             //!!!WICHTIG!!//
//!!Nach Veränderung jeder Include IMMER ein Modul-Build ausführen!!

//void main() { } // Alibimain zur Komplimierung

const string sQuestbuch = "itm_questbuch";

// Vorab Deklerationen

////////////////////////////// Isladora SL System///////////////////////////////
// Isla-DM's
const string DUNGEON01 = "dunahan";      const string DUNGEON02 = "Draghetto";
const string DUNGEON03 = "Dretch";       const string DUNGEON04 = "isla_admin";
const string DUNGEON05 = "Hamsterbacke"; const string DUNGEON06 = "Antoss";

// Isladora PW Datenbank für RP-EP und weiteres
const string ISLADORA_DB = "SLTOOLS_DB";
const string DATABASE = "PlayerDB";                                             // Das Kürzel für die Spieler-Database

// Temporärer Behälter für verschiedene Funktionen
const string TEMP_CON = "plc_hwtruhe";

// Delays für AFK-Checks usw
const float fDelayRsCht = 7200.0;  //595 Sekunden bis zum Reset des Check-Status
const float fDelayCheck =  900.0;  //600 Sekunden bis zur Wiederholung des Checks

////////////////////////////ENDE DER KONFIG////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Den Namen des Items auslesen
//
string GetObjectName(string sItem);
string GetObjectName(string sItem)
{
  // 1++ Wichtiges erfassen,
  // 1.1 vorab notwendige Variablen deklarieren
  string sName;

  // 1.2 Erfasse das Objekt mit genau diesem Tag
  object oItem = GetObjectByTag(sItem), oContainer, oCreate;

  // 1.3 Prüf ab, ob das Objekt schon im Modul existiert
  if (GetIsObjectValid(oItem) == TRUE)
  {
    // 1.3.1 Dann gib diesen Namen aus
    sName = GetName(oItem, TRUE);
    return sName;
  }

  // 1.4 Es existiert nicht
  else if (GetIsObjectValid(oItem) == FALSE)
  {
    // 1.4.1 Suche einen temporären Behälter
    oContainer = GetObjectByTag(TEMP_CON);

    // 1.4.2 Erschaffe darin dieses Objekt, identifiziert
    oCreate = CreateItemOnObject(sItem, oContainer);
    SetIdentified(oCreate, TRUE);

    // 1.4.3 Lese dessen Namen aus und gib ihn als Ergebnis aus
    sName = GetName(oCreate, TRUE);
    return sName;
  }

  // 1.5 Irgendwas ist falsch gelaufen, so gib einen Fehler aus
  else
  {
    return "ERROR";
  }
}


// Add a HW property
void AddHWSProp(object oItem, int nFstProp, int nSndProp, int nTrdProp, int nFthProp);
void AddHWSProp(object oItem, int nFstProp, int nSndProp, int nTrdProp, int nFthProp)
{
  itemproperty ipItemProp;                             // Anzuwendende Eigenschaft
  int   nSumOfProp = IPGetNumberOfItemProperties(oItem);

  // Bricht das Skript ab, wenn fuenf Eigenschaften bereits auf dem Gegenstand sind.
  if (nSumOfProp >= 5)
  {
    SendServerMessageToPC(OBJECT_SELF, "Der Gegenstand besitzt bereits fünf Eigenschaften.");
    return;
  }

  // Ansonsten weiter
  else
    SendServerMessageToPC(OBJECT_SELF, "Der Gegenstand besitzt momentan "+ IntToString(nSumOfProp) +" Eigenschaften.");

  switch (nFstProp)
  {
  // nXXXProp kann bei den meisten Eigenschaften 1-20 betragen, Ausnahmen sind eingetragen.
    case    0:  ipItemProp = ItemPropertyAbilityBonus             (nSndProp, nTrdProp); break;
    case    1:  ipItemProp = ItemPropertyACBonus                  (nSndProp);  break;
    case    2:  ipItemProp = ItemPropertyACBonusVsAlign           (nSndProp, nTrdProp); break;
    case    3:  ipItemProp = ItemPropertyACBonusVsDmgType         (nSndProp, nTrdProp); break;
    case    4:  ipItemProp = ItemPropertyACBonusVsRace            (nSndProp, nTrdProp); break;
    case    5:  ipItemProp = ItemPropertyACBonusVsSAlign          (nSndProp, nTrdProp); break;
    case    6:  ipItemProp = ItemPropertyEnhancementBonus         (nSndProp); break;
    case    7:  ipItemProp = ItemPropertyEnhancementBonusVsAlign  (nSndProp, nTrdProp); break;
    case    8:  ipItemProp = ItemPropertyEnhancementBonusVsRace   (nSndProp, nTrdProp); break;
    case    9:  ipItemProp = ItemPropertyEnhancementBonusVsSAlign (nSndProp, nTrdProp); break;
    case   10:  ipItemProp = ItemPropertyEnhancementPenalty       (nSndProp); break;
    case   11:  ipItemProp = ItemPropertyWeightReduction          (nSndProp); break;
    case   12:  ipItemProp = ItemPropertyBonusFeat                (nSndProp); break;
    case   13:  ipItemProp = ItemPropertyBonusLevelSpell          (nSndProp, nTrdProp); break;
    case   14:  ipItemProp = ItemPropertyCastSpell                (nSndProp, nTrdProp); break;
    case   15:  ipItemProp = ItemPropertyDamageBonus              (nSndProp, nTrdProp); break;
    case   16:  ipItemProp = ItemPropertyDamageBonusVsAlign       (nSndProp, nTrdProp, nFthProp); break;
    case   17:  ipItemProp = ItemPropertyDamageBonusVsRace        (nSndProp, nTrdProp, nFthProp); break;
    case   18:  ipItemProp = ItemPropertyDamageBonusVsSAlign      (nSndProp, nTrdProp, nFthProp); break;
    case   19:  ipItemProp = ItemPropertyDamageImmunity           (nSndProp, nTrdProp); break;
    case   20:  ipItemProp = ItemPropertyDamagePenalty            (nSndProp); break;
    case   21:  ipItemProp = ItemPropertyDamageReduction          (nSndProp, nTrdProp); break;
    case   22:  ipItemProp = ItemPropertyDamageResistance         (nSndProp, nTrdProp); break;
    case   23:  ipItemProp = ItemPropertyDamageVulnerability      (nSndProp, nTrdProp); break;
    case   24:  ipItemProp = ItemPropertyDarkvision               (); break;
    case   25:  ipItemProp = ItemPropertyDecreaseAbility          (nSndProp, nTrdProp); break;
    case   26:  ipItemProp = ItemPropertyDecreaseAC               (nSndProp, nTrdProp); break;
    case   27:  ipItemProp = ItemPropertyDecreaseSkill            (nSndProp, nTrdProp); break;
    case   28:  ipItemProp = ItemPropertyContainerReducedWeight   (nSndProp); break;
    case   29:  ipItemProp = ItemPropertyExtraMeleeDamageType     (nSndProp); break;
    case   30:  ipItemProp = ItemPropertyExtraRangeDamageType     (nSndProp); break;
    case   31:  ipItemProp = ItemPropertyHaste                    (); break;
    case   32:  ipItemProp = ItemPropertyHolyAvenger              (); break;
    case   33:  ipItemProp = ItemPropertyImmunityMisc             (nSndProp); break;
    case   34:  ipItemProp = ItemPropertyImprovedEvasion          (); break;
    case   35:  ipItemProp = ItemPropertyBonusSpellResistance     (nSndProp); break;
    case   36:  ipItemProp = ItemPropertyBonusSavingThrow         (nSndProp, nTrdProp); break;
    case   37:  ipItemProp = ItemPropertyBonusSavingThrowVsX      (nSndProp, nTrdProp); break;
    case   38:  ipItemProp = ItemPropertyKeen                     (); break;
    case   39:  ipItemProp = ItemPropertyLight                    (nSndProp, nTrdProp); break;
    case   40:  ipItemProp = ItemPropertyMaxRangeStrengthMod      (nSndProp); break;
    case   41:  ipItemProp = ItemPropertyNoDamage                 (); break;
    case   42:  ipItemProp = ItemPropertyOnHitProps               (nSndProp, nTrdProp); break;
    case   43:  ipItemProp = ItemPropertyReducedSavingThrow       (nSndProp, nTrdProp); break;
    case   44:  ipItemProp = ItemPropertyReducedSavingThrowVsX    (nSndProp, nTrdProp); break;
    case   45:  ipItemProp = ItemPropertyRegeneration             (nSndProp); break;
    case   46:  ipItemProp = ItemPropertySkillBonus               (nSndProp, nTrdProp); break;
    case   47:  ipItemProp = ItemPropertySpellImmunitySpecific    (nSndProp); break;
    case   48:  ipItemProp = ItemPropertySpellImmunitySchool      (nSndProp); break;
    case   49:  ipItemProp = ItemPropertyAttackBonus              (nSndProp); break;
    case   50:  ipItemProp = ItemPropertyAttackBonusVsAlign       (nSndProp, nTrdProp); break;
    case   51:  ipItemProp = ItemPropertyAttackBonusVsRace        (nSndProp, nTrdProp); break;
    case   52:  ipItemProp = ItemPropertyAttackBonusVsSAlign      (nSndProp, nTrdProp); break;
    case   53:  ipItemProp = ItemPropertyAttackPenalty            (nSndProp); break;
    case   54:  ipItemProp = ItemPropertyUnlimitedAmmo            (nSndProp); break;
    case   55:  ipItemProp = ItemPropertyLimitUseByAlign          (nSndProp); break;
    case   56:  ipItemProp = ItemPropertyLimitUseByClass          (nSndProp); break;
    case   57:  ipItemProp = ItemPropertyLimitUseByRace           (nSndProp); break;
    case   58:  ipItemProp = ItemPropertyLimitUseBySAlign         (nSndProp); break;
    case   59:  ipItemProp = ItemPropertyVampiricRegeneration     (nSndProp); break;
    case   60:  ipItemProp = ItemPropertyTrueSeeing               (); break;
    case   61:  ipItemProp = ItemPropertyTurnResistance           (nSndProp); break;
    case   62:  ipItemProp = ItemPropertyMassiveCritical          (nSndProp); break;
    case   63:  ipItemProp = ItemPropertyFreeAction               (); break;
    case   64:  ipItemProp = ItemPropertyImmunityToSpellLevel     (nSndProp); break;
    case   65:  ipItemProp = ItemPropertyWeightIncrease           (nSndProp); break;
    case   66:  ipItemProp = ItemPropertyOnHitCastSpell           (nSndProp, nTrdProp); break;
    case   67:  ipItemProp = ItemPropertyVisualEffect             (nSndProp); break;
    case   68:  ipItemProp = ItemPropertyArcaneSpellFailure       (nSndProp); break;
    case   69:  ipItemProp = ItemPropertyMaterial                 (nSndProp); break;
    case   70:  ipItemProp = ItemPropertyQuality                  (nSndProp); break;
    case   71:  ipItemProp = ItemPropertyAdditional               (nSndProp); break;
    default  :  SendServerMessageToPC(OBJECT_SELF, "Nicht anwendbar!"); break;
  }

 // Dieser Befehl erzeugt den Effekt auf dem Gegenstand, jedoch ersetzt er gleiche Effekte, egal welcher besser ist.
  IPSafeAddItemProperty(oItem, ipItemProp, 0.0f, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
}

/////////////////////////////////////////////////////////////////////////////
// Funktion um einen stillen Fertigkeitswurf durchzuführen
// Nichts wird dem Spieler mitgeteilt!
//
int GetIsSkillSuccessfulPrivate(object oTarget, int nSkill, int nDifficulty)
{
  // 1.1 Wurf für die Fertigkeit anwenden
  if(GetSkillRank(nSkill, oTarget) + d20() >= nDifficulty)
  {
    // 1.2.1 Da bestanden, teile Wahr mit
    return TRUE;
  }

  // 1.2.2 Nicht bestanden, teile Falsch mit
  return FALSE;
}


////////////////////////////////////////////////////////////////////////////////
// Entfernt alle Effekte, die ein Spieler auf sich selbst angewandt hat.
//
//
void RemovePlayerEffects(object oPlayer);
void RemovePlayerEffects(object oPlayer)
{
  // 1++ Erfasse notwendiges
  // 1.1 Erfasse den ersten Effekt des Spielers
  effect eCheck = GetFirstEffect(oPlayer);

  // 1.2.1 Während dieser existiert
  while ( GetIsEffectValid(eCheck) == TRUE )
  {
    // 1.2.1.1 Prüfe den Erschaffer des Effekts
    if ( GetEffectCreator(eCheck) == oPlayer )
    {
      // 1.2.1.2 Entferne den Effekt, wenn der Spieler selbst diesen
      //         auf sich angewandt hat
      RemoveEffect(oPlayer, eCheck);
    } // Ende If

  // 1.2.2 Scanne den nächsten Effekt
  eCheck = GetNextEffect(oPlayer);
  } // Ende While
} // Ende Void


////////////////////////////////////////////////////////////////////////////////
// Durchsucht den Behälter und liefert den Tag/die ResRef der jeweiligen
// Gegenstände
//
string SearchContainer(object oContainer, int nTag=1, int nNumItem=1);
string SearchContainer(object oContainer, int nTag=1, int nNumItem=1)
{
  // 1++ Notwendiges deklarieren/erfassen
  // 1.1 Variablen vorab deklarieren
  int nTag, nSlot; string sTag, sResRef;
  int nCount = 0;

  // 1.2 Ersten Gegenstand im Inventar erfassen
  object oItem = GetFirstItemInInventory ( oContainer );

  // 1.3 Scanne die Objektart
  // 1.3.1 Sollte es sich um eine Kreatur handeln
  if (GetObjectType(oContainer) == OBJECT_TYPE_CREATURE)
  {
    for (nSlot=INVENTORY_SLOT_HEAD; nSlot<=INVENTORY_SLOT_BOLTS; nSlot++)
    {
      oItem = GetItemInSlot(nSlot, oContainer);

      if (oItem != OBJECT_INVALID)
      {
        // Ist der Tag gesucht, gib diesen direkt aus und Fertig
        if      ( nTag == 1 )
        {
          sTag = GetTag ( oItem );
          nCount++;
          return sTag;
        }

        // Ansonsten gib die ResRef aus und Fertig
        else if ( nTag == 0 )
        {
          sResRef = GetResRef( oItem );
          nCount++;
          return sResRef;
        }

      } // Ende If (OBJECT_INVALID)
    } // Ende For
  } // Ende If (OBJECT_TYPE_CREATURE)

  // 1.4 Ansonsten handelt es sich um ein gültiges Inventar
  else
  {
    // 1.4.1 Während das Item existiert UND die Anzahl der gescannten Items
    //       nicht die Anzahl der zu durchsuchenden überschreitet
    while ( (oItem != OBJECT_INVALID) &&
            (nCount < nNumItem) )
    {
      // 1.4.1.1 Prüfe den Tag, ist der gesucht, gib diesen direkt aus und Fertig
      if      ( nTag == 1 )
      {
        sTag = GetTag ( oItem );
        nCount++;
        return sTag;
      }
      // 1.4.1.2 Ansonsten gib die ResRef aus und Fertig
      else if ( nTag == 0 )
      {
        sResRef = GetResRef( oItem );
        nCount++;
        return sResRef;
      }

      // 1.4.1.3 Ein Behälter wurde gefunden, so durchsuche diesen
      else if (GetHasInventory(oItem) == TRUE)
        SearchContainer( oItem, nTag, nNumItem );

      // 1.4.1.4 Scanne das nächste Item
      oItem = GetNextItemInInventory( oContainer );
    }
  }

  return "";
} // Ende String


void SetGlobalSeason()
{
  int nMonth = GetCalendarMonth();  // Erfasse den Monat des Moduls
  int nSeason;                      // Deklariere die Saison
  object oMod = GetModule();        // Erfasse das Modul

  switch (nMonth)
  {
    case 1:  case 2:  case 12:                 { nSeason = 1; break; }  // Winter
    case 3:  case 4:                           { nSeason = 2; break; }  // Frühling
    case 5:  case 6:  case 7:  case 8: case 9: { nSeason = 3; break; }  // Sommer
    case 10: case 11:                          { nSeason = 4; break; }  // Herbst
  }
  SetLocalInt(oMod, "SEASON" , nSeason);
}


////////////////////////////////////////////////////////////////////////////////
// Wetterfunktion von Isladora; Festlegen des Wetters anhand des Monats.
// Wiederholung des ganzen innerhalb von 6 InGame-Stunden
//
void SetGlobalWeather(int nDelay=8);
void SetGlobalWeather(int nDelay=8)
{
  // 1++ Festlegen der Saison
  SetGlobalSeason();

  // 1.1 Deklarieren notwendiger Variablen, Objekte usw.
  int nMin; int nMed; int nMax;
  int nWeather; int nSky;
  object oMod = GetModule();

  // 1.2 Zufallszahl generieren
  int nChance = d100();

  // 2++ Wechsle innerhalb der Saison das jeweilige Wetter bzw den Himmel.
  switch ( GetLocalInt(oMod, "SEASON") )
  {
    // 2.1 Saison: Winter
    case 1:
    { nMin = 5; nMed = 85; nMax = 100;

      if ( nChance <= nMin )
      {
        DebugMode("SetGlobalWeather - Winter: Regen, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_RAIN;
        nSky = SKYBOX_GRASS_STORM;
      }  //Regen Wetter

      if ( nChance >  nMin && nChance <= nMed )
      {
        DebugMode("SetGlobalWeather - Winter: Klar, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_CLEAR;
        nSky = SKYBOX_GRASS_CLEAR;
      }  //Klares Wetter

      if ( nChance >  nMin && nChance >  nMed && nChance <= nMax )
      {
        DebugMode("SetGlobalWeather - Winter: Schnee, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_SNOW;
        nSky = SKYBOX_ICY;
      }  //Schnee Wetter

      break; }

    // 2.2 Saison: Frühling
    case 2:
    { nMin =  5; nMed = 15; nMax = 100;

      if ( nChance <= nMin )
      {
        DebugMode("SetGlobalWeather - Frühling: Schnee, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_SNOW;
        nSky = SKYBOX_ICY;
      }  //Schnee Wetter

      if ( nChance >  nMin && nChance <= nMed )
      {
        DebugMode("SetGlobalWeather - Frühling: Regen, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_RAIN;
        nSky = SKYBOX_GRASS_STORM;
      }  //Regen Wetter

      if ( nChance >  nMin && nChance >  nMed && nChance <= nMax )
      {
        DebugMode("SetGlobalWeather - Frühling: Klar, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_CLEAR;
        nSky = SKYBOX_GRASS_CLEAR;
      }  //Klares Wetter

      break;
    }

    // 2.3 Saison: Sommer
    case 3:
    { nMin =  0; nMed = 7; nMax = 100;

      if ( nChance <= nMin )
      {
        DebugMode("SetGlobalWeather - Sommer: Schnee, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_SNOW;
        nSky = SKYBOX_ICY;
      }  //Schnee Wetter

      if ( nChance >  nMin && nChance <= nMed )
      {
        DebugMode("SetGlobalWeather - Sommer: Regen, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_RAIN;
        nSky = SKYBOX_GRASS_STORM;
      }  //Regen Wetter

      if ( nChance >  nMin && nChance >  nMed && nChance <= nMax )
      {
        DebugMode("SetGlobalWeather - Sommer: Klar, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_CLEAR;
        nSky = SKYBOX_GRASS_CLEAR;
      }  //Klares Wetter

      break;
    }

    // 2.4 Saison: Herbst
    case 4:
    { nMin = 5; nMed = 95; nMax = 100;

      if ( nChance <= nMin )
      {
        DebugMode("SetGlobalWeather - Herbst: Schnee, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_SNOW;
        nSky = SKYBOX_ICY;
      }  //Schnee Wetter

      if ( nChance >  nMin && nChance <= nMed )
      {
        DebugMode("SetGlobalWeather - Herbst: Klar, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_CLEAR;
        nSky = SKYBOX_GRASS_CLEAR;
      }  //Klares Wetter

      if ( nChance >  nMin && nChance >  nMed && nChance <= nMax )
      {
        DebugMode("SetGlobalWeather - Herbst: Regen, Zahl: "+IntToString(nChance));
        nWeather = WEATHER_RAIN;
        nSky = SKYBOX_GRASS_STORM;
      }  //Regen Wetter

      break;
    }
  }

  // 3++ Umsetzen des Wetters aufs Modul bzw. des Himmels auf die Area
  int nAll = GetAreaCount();  // Erfasse die Anzahl der Areas
  object oArea = GetFirstArea(); // Erfasse die erste Area

  // 3.1 Wenn diese Area exisitert UND
  //     die Anzahl der geänderten Area's die Gesamtzahl nicht ubersteigt
  while ( GetIsObjectValid(oArea) )
  {
    if (GetIsAreaAboveGround(oArea) == AREA_ABOVEGROUND  // Oberirdisch &&
     && GetIsAreaInterior(oArea)    == FALSE  )          // Draussen    !!
    {
      DebugMode("SetGlobalWeather - " + GetName(oArea) + " wird bearbeitet");

      SetWeather(oMod, nWeather);   // Setze das Wetter auf das vorher Definierte
      SetSkyBox(nSky, oArea);       // Setze den Himmel auf den vorher Definierten
    }
    oArea = GetNextArea(); // Erfasse die nächste Area
  }

  // 4++ Führe den Befehl nach 8 Stunden erneut aus.
  DelayCommand(HoursToSeconds(nDelay), SetGlobalWeather());
}


////////////////////////////////////////////////////////////////////////////////////
// Nimmt dem Spieler eine gewisse Anzahl an Items auch aus einem Stack heraus
// oTarget = Der Spieler mit dem Item,
// sItem = Tag des Items,  und    nNumItems = Anzahl die genommen werden soll
void DercrementStackSize(object oTarget, string sItem, int nNumItems);
void DercrementStackSize(object oTarget, string sItem, int nNumItems)
{
  int nCount = 0;     // Anzahl genommener Items auf Null
  int nNewStSize;     // Die neue Anzahl an Items im Stack

  // Erstes Item scannen
  object oItem = GetFirstItemInInventory(oTarget);

  // während das Item gültig und die Anzahl geprüfter Items kleiner als Anzahl an zu nehmender ist
  while ( (GetIsObjectValid(oItem) == TRUE) && (nCount < nNumItems) )
  { // Ist der Tag des Items gleich des gesuchten
    if (GetTag(oItem) == sItem)
    {
      int nStackSize = GetNumStackedItems(oItem);
      // Wenn gefundenes Item mehr als 2 Items und das Maximum 10 beinhaltet
      if ( (nStackSize >= 2) && (nStackSize <= 10) )
      {
        nNewStSize = nStackSize - nNumItems;   // nimm die vorbestimmte Anzahl
        SetItemStackSize(oItem, nNewStSize);   // und setze die StackSize des Items auf die neue Anzahl
      }
      // wird nur ein Item gefunden, zerstöre dieses
      else
        DestroyObject(oItem);
      // Anzahl genommener Items + 1
      nCount++;
    } // Ende If (GetTag(oItem) == sItem)
  // Nächstes Item scannen
  oItem = GetNextItemInInventory(oTarget);
  } // Ende While
  return;
} // Ende Void


////////////////////////////////////////////////////////////////////////////////////
// Verdeckt die Karte des Spielers sobald dieser die Map betritt.
// oPlayer = Spieler dessen Karte verdeckt werden soll, fDelay = Abstand in dem die
// Karte aktualisiert werden soll
//
void SetMapUnexplored(object oPlayer, float fDelay);
void SetMapUnexplored(object oPlayer, float fDelay)
{
  if(GetArea(oPlayer) == OBJECT_SELF)
  {
    ExploreAreaForPlayer(OBJECT_SELF, oPlayer, FALSE);
    DelayCommand(fDelay, SetMapUnexplored(oPlayer, fDelay));
  }
}


////////////////////////////////////////////////////////////////////////////////////
// Um eine Folge an Buchstaben oder Zahlen durcheinander zu bringen
// zb. liefert die Eingabe sSequel = 12 entweder 12 oder 21,
// oder die Eingabe sSequel = 123 entweder 231, 321, 213, 123 usw...
// Modus 0, Standard bedeutet alles durcheinander bringen, Modus 1 nur ein
// bestimmtes Wort usw. wählen.
string RandomSequel(string sSequel, int nModus=0)
{
  // 1++ Definiere Wichtiges
  // 1.1 und die die weitere Vorgehensweise
  string sResult;
  int ia, ib, ic, id;
  int nRandom;

  // 1.2 Lese die Länge der Sequenz, welche Verwürfelt werden soll, aus
  int nSequelLength = GetTokenCount(sSequel);                                         d("RandomSequel - Anzahl zu verwendeten Daten: "+IntToString(nSequelLength));

  if (nModus=0)                                                                       d("RandomSequel - Modus 0, Durcheinander bringen aktiv.");
  {
    // 2++ Folgend, durcheinander bringen der Sequenz
    // 2.1 Switch-Anweisung, anhand der Länge der Sequenz
    switch (nSequelLength)
    {

      // 2.1.1 Die Sequenz ist leer, oder hat keine Länge
      case 0: {
        sResult = "";                    // Gib Null bzw. Leer aus!
      break;  } // Ende case 0:


      // 2.1.2 Die Sequenz ist nur Einstellig, damit nur diese Stelle!
      case 1: {
        sResult = sSequel;               // Ergebnis = Sequenz!
      break;  } // Ende case 1:

      // 2.1.2 Die Sequenz ist zweistellig, damit sind zwei Möglichkeiten gegeben!
      case 2: {
        ia = d2(); ib = d2();              // Würfle auf 1W2
        while (ia == ib)                   // Wenn a gleich b,
          { ib = d2(); }                  // würfle b nochmals, bis es anders ist.

        sResult = GetTokenFromString(ia, sSequel) +
                  GetTokenFromString(ib, sSequel);
      break;  } // Ende case 2:

      // 2.1.3 Die Sequenz ist dreistellig, damit sind x Möglichkeiten gegeben!
      case 3: {
        ia = d3(); ib = d3(); ic = d3();
        while (ia == ib)
          { ib = d3(); }
        while (ia == ic | ib == ic)
          { ic = d3(); }

        sResult = GetTokenFromString(ia, sSequel) +
                  GetTokenFromString(ib, sSequel) +
                  GetTokenFromString(ic, sSequel);
      break;  } // Ende case 3:

      // 2.1.4 Die Sequenz ist vierstellig, damit sind x Möglichkeiten gegeben!
      case 4: {
        ia = d4(); ib = d4(); ic = d4(); id = d4();
        while (ib == ia)
          { ib = d4(); }
        while (ic == ia | ic == ib)
          { ic = d4(); }
        while (id == ia | id == ib | id == ic)
          { id = d4(); }

        sResult = GetTokenFromString(ia, sSequel) +
                  GetTokenFromString(ib, sSequel) +
                  GetTokenFromString(ic, sSequel) +
                  GetTokenFromString(id, sSequel);
      break;  } // Ende case 4:
    }  // Ende Switch-Anweisung

    DebugMode("RandomSequel - Modus 0, Ergebnis: "+ sResult);
  }

  if (nModus=1)
  {
    nRandom = Random(nSequelLength)+1;
    sResult = GetTokenFromString(nRandom, sSequel);

    DebugMode("RandomSequel - Modus 1, Ergebnis: " + sResult);
  }
  return sResult;
}


////////////////////////////////////////////////////////////////////////////////////
// Wertet aus, ob sich der Spieler entweder bewegte, oder sprach.
// Gibt dann TRUE für Aktiv oder FALSE für AFK aus.
// oPlayer = Spieler der geprüft werden soll
//
int CheckIsAFK(object oPlayer);
int CheckIsAFK(object oPlayer)
{
  // 1++ Grundlagen definieren
  // 1.1 Erfasse die abgelegte Variable "Chats", aus dem Chat-Skript
  //     Erhält die Figur, sofern sie etwas ber die Chatleiste von sich gab
  int nChats = GetLocalInt( oPlayer, "Chats" );

  // 1.2.1 Erfasse die Position, die bereits ber dieses Skript abgelegt wurde
  //       und die aktuelle Position
  location locSavPos = GetLocalLocationOverride( oPlayer, "CHAT" );
  location locActPos = GetLocation( oPlayer );

  // 1.2.2 Wandle die Positionen für später in verarbeitbare Werte um
  vector vSavPos = GetPositionFromLocation( locSavPos );
  vector vActPos = GetPositionFromLocation( locActPos );

  // 1.3 Variable als Meldungshinweis zur Abfrage, Aktiv bzw AFK
  int bNotAFK;   // Boolean Int


  // 2++ Grundlegene Prüfungen
  // 2.1.1 Prüf ab, ob die Variable "Chats" bereits genutzt/vergeben wurde
  //     spricht der Char ber die Chat-Leiste? Dann markiere als Aktiv!
  if ( nChats = 1 )
  {
    bNotAFK = TRUE;
    DebugMode("CheckIsAFK - " + GetName( oPlayer ) + " ist nicht AFK.");
  }

  // 2.1.2 da nicht, markiere als AFK
  else
  {
    bNotAFK = FALSE;
    DebugMode("CheckIsAFK - " +  GetName( oPlayer ) + " ist AFK." );
  }

  // 2.2.1 Prüf ab, ist die gespeicherte Position überhaupt gültig
  if ( GetIsObjectValid( GetAreaFromLocation( locSavPos ) ) == TRUE )
  {
    // 2.2.1.1 Prüf ab, ob die gespeicherte Position mit der aktuellen übereinstimmt
    //         hat sich der Char innerhalb der letzten 10 Min bewegt? Dann markiere als Aktiv
    if ( vActPos != vSavPos )                      // Vergleiche die Vektoren aus den Positionen
    {
      SetLocalLocationOverride( oPlayer, "CHAT" ); // Speichert die aktuelle Position ab
      bNotAFK = TRUE;
      DebugMode("CheckIsAFK - " +  GetName( oPlayer ) + " ist nicht AFK." );
    }

    // 2.2.1.2 da nicht, markiere als AFK
    else
    {
      bNotAFK = FALSE;
      DebugMode("CheckIsAFK - " +  GetName( oPlayer ) + " ist AFK." );
    }
  }

  // 2.2.2 da nicht, speichere eine neue Position, markiere als Aktiv und vermerke im Log!
  else
  {
    SetLocalLocationOverride( oPlayer, "CHAT" ); // Speichert die aktuelle Position ab
    bNotAFK = TRUE;
    DebugMode("CheckIsAFK - " +  GetName( oPlayer ) + " prodzierte ein Fehler im AFK-Skript." );
  }

  // 3++ Ergebnis-Ausgabe
  // 3.1 Gebe schlussendlich aus, in welchem Zustand sich der Char bis zu diesem Zeitpunkt befindet
  return bNotAFK;
}


////////////////////////////////////////////////////////////////////////////////////
// Wrapperfunktion für den AFK-Check
// Da die Funktion CheckIsAFK(object oPlayer) nur ausgibt ob ein Spieler Aktiv oder
// nicht ist und somit keine Prüfung/Wiederholung möglich ist, wurde diese Funktion
// angelegt
void AFKCheck(object oPlayer);
void AFKCheck(object oPlayer)
{
  // 1++ Datensammlungen, grundlegende Prüfungen der Funktion, bevor überhaupt etwas weiter gegeben wird
  // 1.1 Aufstellen der notwendigen Daten
  int bNotAFK  = CheckIsAFK ( oPlayer );                  // Checke vorab ob Aktiv
  int nChecked = GetLocalInt( oPlayer, "AFK_CHECKED");    // Lese aus, ob er bereits gecheckt wurde
  int nChats   = GetLocalInt( oPlayer, "Chats");          // Lese aus, ob er etwas getextet hatte

  // object oItem = GetItemByResRef("itm_questbuch", oPlayer);  // Erfasse ein Item, auf dem Daten im PC abgespeichert wurden
  object oItem = oPlayer;
  EDS_SetDelay (oItem, "ResetCheck", fDelayRsCht, FALSE, 1); // Setze das Delay des Resets
  EDS_SetDelay (oItem, "NextCheck", fDelayCheck, FALSE, 1);  // Setze das Delay zum nächsten Check

  // 1.2 Frage ab, ob dies ein SL ist, dann brich ab
  if ( GetIsDM( oPlayer ) == TRUE )
    return;

  // 1.3 Prüf, ob der Check bereits ausgeführt wurde, dann brich ab
  else if ( nChecked == 1 )
  {
    if ( EDS_CheckDelay (oItem, "ResetCheck", 1) == TRUE )
      AFKCheck( oPlayer );
    if ( EDS_CheckDelay (oItem, "NextCheck", 1) == TRUE )
      SetLocalInt( oPlayer, "AFK_CHECKED", 0 );

    //DelayCommand( fDelayCheck, AFKCheck( oPlayer ) );                      // Check in 10 min wiederholen
    //DelayCommand( fDelayRsCht, SetLocalInt( oPlayer, "AFK_CHECKED", 0 ) ); // Lösche die Variable 5 sek. vor dem nächsten Check
    DebugMode("AFKCheck - " + GetName( oPlayer ) + " ist nicht AFK." );

    return;
  }

  // 1.4 Prüf ab, befindet sich der Char in einer OOC-Area, dann brich ab
  else if ( GetLocalInt( GetArea( oPlayer ), "OCC_Area" ) == 1 )
  {
    if ( EDS_CheckDelay (oItem, "ResetCheck", 1) == TRUE )
      AFKCheck( oPlayer );
    if ( EDS_CheckDelay (oItem, "NextCheck", 1) == TRUE )
      SetLocalInt( oPlayer, "AFK_CHECKED", 0 );

    //DelayCommand( fDelayCheck, AFKCheck( oPlayer ) );                      // Check in 10 min wiederholen
    //DelayCommand( fDelayRsCht, SetLocalInt( oPlayer, "AFK_CHECKED", 0 ) ); // Lösche die Variable 5 sek. vor dem nächsten Check
    DebugMode("AFKCheck - " +  GetName( oPlayer ) + " ist in einem OOC." );

    return;
  }

  // 1.5 Prüf ab, ob die Variable Chats bereits genutzt o. vergeben wurde, dann brich ab
  else if ( nChats == 1 )
  {
    if ( EDS_CheckDelay (oItem, "ResetCheck", 1) == TRUE )
      AFKCheck( oPlayer );
    if ( EDS_CheckDelay (oItem, "NextCheck", 1) == TRUE )
      SetLocalInt( oPlayer, "AFK_CHECKED", 0 );

    //DelayCommand( fDelayCheck, AFKCheck( oPlayer ) );                      // Check in 10 min wiederholen
    //DelayCommand( fDelayRsCht, SetLocalInt( oPlayer, "AFK_CHECKED", 0 ) ); // Lösche die Variable 5 sek. vor dem nächsten Check
    DebugMode("AFKCheck - " +  GetName( oPlayer ) + " hat etwas gesprochen." );

    return;
  }

  // 1.6.1 Erfasse die Position, die bereits über dieses Skript abgelegt wurde
  //       und die aktuelle Position
  location locSavPos = GetLocalLocationOverride( oPlayer, "CHAT" );
  location locActPos = GetLocation( oPlayer );

  // 1.6.2 Wandle die Positionen für später in verarbeitbare Werte um
  vector vSavPos = GetPositionFromLocation( locSavPos );
  vector vActPos = GetPositionFromLocation( locActPos );

  // 1.6.3 Prüf ab, ob die gespeicherte Position mit der aktuellen übereinstimmt
  //       hat sich der Char innerhalb der letzten 10 Min bewegt? Dann markiere als Aktiv
  if ( vActPos != vSavPos || bNotAFK == TRUE )                             // Vergleiche die Vektoren aus den Positionen
  {
    SetLocalLocationOverride( oPlayer, "CHAT" );                           // Speichert die aktuelle Position ab

    if ( EDS_CheckDelay (oItem, "ResetCheck", 1) == TRUE )
      AFKCheck( oPlayer );
    if ( EDS_CheckDelay (oItem, "NextCheck", 1) == TRUE )
      SetLocalInt( oPlayer, "AFK_CHECKED", 0 );

    //DelayCommand( fDelayCheck, AFKCheck( oPlayer ) );                      // Check in 10 min wiederholen
    //DelayCommand( fDelayRsCht, SetLocalInt( oPlayer, "AFK_CHECKED", 0 ) ); // Lösche die Variable 5 sek. vor dem nächsten Check
    SetLocalInt ( oPlayer, "AFK_CHECKED", 1 );                             // Vermerken, das bereits gecheckt
    DebugMode("AFKCheck - " +  GetName( oPlayer ) + " ist nicht AFK." );

    return;  // Vorzeitiges Ende des Skripts, ohne das die letzte Abfrage noch durch getestet werden soll.
  }


  // 2++ Da der Char eindeutig nicht Aktiv ist, legt das Skript nun mit der eigentlichen Aktion los"
  // 2.1 Der Char ist nicht aktiv, fahre fort
  else
  {
    // 2.2.1 Erfasse, das Ziel zum AFK-Sprung
    object oWP_OOCRoom = GetWaypointByTag( "WP_AFK" );
    DebugMode("AFKCheck - " +  GetName( oPlayer ) + " ist AFK." );

    // 2.2.2 Fahre mit den folgenden Aktionen fort
    AssignCommand( oPlayer, ClearAllActions(TRUE) );                    // Beende alle Tätigkeiten und
    SetLocalLocationOverride( oPlayer, "CHAT" );                        // Speichert die aktuelle Position ab, danach
    AssignCommand( oPlayer, ActionJumpToObject( oWP_OOCRoom, FALSE ) ); // springe zum Ziel
    SetLocalInt ( oPlayer, "AFK_CHECKED", 1 );                          // Vermerken, das bereits gecheckt

    // 2.2.3 Vermerke für den nächsten Check
    if ( EDS_CheckDelay (oItem, "ResetCheck", 1) == TRUE )
      AFKCheck( oPlayer );
    if ( EDS_CheckDelay (oItem, "NextCheck", 1) == TRUE )
      SetLocalInt( oPlayer, "AFK_CHECKED", 0 );

    //DelayCommand( fDelayCheck, AFKCheck( oPlayer ) );                      // Check in 10 min wiederholen
    //DelayCommand( fDelayRsCht, SetLocalInt( oPlayer, "AFK_CHECKED", 0 ) ); // Lösche die Variable 5 sek. vor dem nächsten Check
    DebugMode("AFKCheck - " +  GetName( oPlayer ) + " wurde gebeamt." );
  }
}

void SleepMode()
{
  if(GetFirstPC() == OBJECT_INVALID)
  {
    object oPause = GetObjectByTag("_SLEEPMODE_");
      if(!GetIsObjectValid(oPause))
      {
        oPause = CreateObject(OBJECT_TYPE_CREATURE,"x2_djinn",GetStartingLocation(),FALSE,"_SLEEPMODE_");
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectCutsceneParalyze()),oPause);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectCutsceneGhost()),oPause);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY)),oPause);
      }
    //SetPersistentString(GetModule(),"KEEP_NWNXDB_ALIVE","1");
    PrintString("SleepMode - >> No player in game, server is now turning into the sleep mode. <<");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTimeStop(),oPause,14400.0);
    DelayCommand(0.1,SleepMode());
  }
}

void UnpauseModule()
{
  object oPause = GetObjectByTag("_SLEEPMODE_");
    if(GetIsObjectValid(oPause))
   {
     DestroyObject(oPause);
     PrintString("SleepMode - >> New player logged in, server is waking up from the sleep mode. <<");
   }
}

// Work around zum Kreaturen per Tag finden
object GetNearestCreatureByTag(string sTag, object oTarget=OBJECT_SELF, int nNth=1);
object GetNearestCreatureByTag(string sTag, object oTarget=OBJECT_SELF, int nNth=1)
{
  object oObject;

  oObject = GetNearestObjectByTag(sTag, oTarget, nNth);

  if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
    return oObject;

  else
    return OBJECT_INVALID;
}

object SearchForSpecificPlayer(string sPlayerName)
{
  object oPlayer = GetFirstPC();

  while (GetIsObjectValid(oPlayer))
  {
    if (GetStringLowerCase(GetPCPlayerName(oPlayer)) == GetStringLowerCase(sPlayerName))
    {
      return oPlayer;
    }

    oPlayer = GetNextPC();
  }

  return OBJECT_INVALID;
}

void SendPositionToDB(object oPlayer, float fHeartbeat = 600.0);
void SendPositionToDB(object oPlayer, float fHeartbeat = 600.0)
{
  int bStop = 0;
  if (GetIsObjectValid(oPlayer) == FALSE)
  {
    DebugMode("SendPositionToDB - Player isn't valid.");
    bStop = 1; // Pruefe ab, ob SC existent. Ansonsten brich ab!
  }

  if (bStop >= 1)
  {
    DebugMode("SendPositionToDB - Stopped playertrack_oncl due nothing to do!");
    return;
  }

//if (fHeartbeat <= 0.0) fHeartbeat = 60.0;                                     // Standard-Delay fuer erneuten Scan setzen

  object oArea = GetArea(oPlayer);                                              // Lese Gebiet aus
  if (GetIsObjectValid(oArea) == FALSE)
  {
    DelayCommand(fHeartbeat, SendPositionToDB(oPlayer));
    return;                                                                     // Pruefe ab, wenn das Gebeit nicht existiert, brich ab
  }

  location locPlayer = GetLocation(oPlayer);                                    // Lese Position aus
  vector vecPlayer = GetPositionFromLocation(locPlayer);                        // Lese die Vektoren aus
  float fX = (vecPlayer.x), fY = (vecPlayer.y), fZ = (vecPlayer.z);             // und verwandle sie in nuetzliche Zahlen

  string sX = FloatToString(fX,3,2), sY = FloatToString(fY,3,2), sZ = FloatToString(fZ,3,2);// Verwandle die Koordinaten in Text um
  string sAreaResRef = GetResRef(oArea);                                        // Lese die ResRef des Gebiets aus
  string sAreaName  = GetName(oArea);                                           // Lese den Namen des Gebiets aus
  string sPlayerName = GetName(oPlayer);                                        // Lese den Namen des Spielers aus
  string sAccount = GetPCPlayerName(oPlayer);                                   // Lese den Accountnamen aus
  string sAccountKey = GetPCPublicCDKey(oPlayer);                               // Lese den Key aus
  string sAreaTag = GetTag(oArea);

  DebugMode("SendPositionToDB - "+sPlayerName+"\n"+sAreaName+"\n"+sAreaResRef+"\n"+sX+"\n"+sY+"\n"+sZ+"\n");    // Druck der Daten ins Log
  string sDBVar = sAccountKey+"_"+GetSubString(sAccount, 1, 7);

  SetCampaignInt(DATABASE, sDBVar, TRUE, oPlayer);                              // Setze Tracking aktiv
  SetCampaignString(DATABASE, sDBVar, sPlayerName, oPlayer);                    // Speichere die gesammelten Daten in der DB
  SetCampaignString(DATABASE, sDBVar, sAreaName, oPlayer);
  SetCampaignString(DATABASE, sDBVar, sAreaResRef, oPlayer);
  SetCampaignString(DATABASE, sDBVar, sAreaTag, oPlayer);
  SetCampaignFloat(DATABASE, sDBVar, fX, oPlayer);
  SetCampaignFloat(DATABASE, sDBVar, fY, oPlayer);
  SetCampaignFloat(DATABASE, sDBVar, fZ, oPlayer);

  DelayCommand(fHeartbeat, SendPositionToDB(oPlayer));
}

void StopPlayerTracking(object oPlayer);
void StopPlayerTracking(object oPlayer)
{
  string sDBVar = GetPCPublicCDKey(oPlayer)+"_"+GetSubString(GetPCPlayerName(oPlayer), 1, 7);
  SetCampaignInt(DATABASE, sDBVar, FALSE, oPlayer);                              // Setze Tracking inaktiv
}
