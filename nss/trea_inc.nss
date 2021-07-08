#include "_tokenizer_inc"
#include "_isla_inc"
#include "trea_def_areas"

#include "x2_inc_switches"
#include "nw_i0_plot"

const string TREAROOM = "gebiet001d";           // Schatzraum-ResRef
const string TREAVCRN = "LootCRN";              // Name der Variable mit dem CR fuer normales
const string TREAVCRB = "LootCRB";              // Name der Variable mit dem CR fuer boss
const string TREACNAN = "Loot_Norm|";           // Kuerzel des CR fuer normales
const string TREACNAB = "Loot_Boss|";           // Kuerzel des CR fuer boss

void TreaCreateTable(object oContainer);
void TreaInitTables();
void TreaActualizeTable(object oContainer = OBJECT_SELF);
string TreaPrintTables();
string TreaLowestTables();
object TreaGetTreasureTable(object oMonster);
void TreaGetTreasure(object oTreasureTable, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0);
void IslaNscBooks(object oMonster = OBJECT_SELF);

void TreaCreateTable(object oContainer)
{
  string sTable = GetLocalString(oContainer, "TreasureTable");                  // Treasure-Variable auslesen
  string sTagTable = GetLocalString(oContainer, "TagTable");                    // Tag-Variable auslesen
  string sDescription = GetDescription(oContainer);                             // Beschreibung auslesen
  int nCount = 0;                                                               // Anzahl der Items = 0
  string sResRef; string sName; string sTag;

  object oTreasureItem = GetFirstItemInInventory(oContainer);                   // Erstes Item erfassen

  while (GetIsObjectValid(oTreasureItem) == TRUE)
  {
    sResRef = GetResRef(oTreasureItem);                                         // Lese ResRef aus
    sName = GetName(oTreasureItem);                                             // Lese Name aus
    sTag = GetTag(oTreasureItem);                                               // Lese Tag aus

    if (GetIsTokenInString(sName, sDescription)== FALSE )  sDescription = AddTokenToString(sName, sDescription);
    if (GetIsTokenInString(sResRef, sTable)== FALSE )      sTable = AddTokenToString(sResRef, sTable);
    if (GetIsTokenInString(sTag, sTagTable)== FALSE )      sTagTable = AddTokenToString(sTag, sTagTable);

    nCount ++;

    oTreasureItem = GetNextItemInInventory(oContainer);                         // Weiteres Item erfassen
  }

  SetDescription(oContainer, sDescription);                                     // In Beschreibung ablegen
  SetLocalString(oContainer, "TreasureTable", sTable);                          // In Treasure-Variable ablegen
  SetLocalString(oContainer, "TagTable", sTagTable);                            // In Tag-Variable ablegen

  SetLocalInt(oContainer, "Treasures", nCount);                                 // Anzahl der Items ablegen
  d("trea_inc, TreaCreateTable; Got "+ IntToString(nCount) +" Items in "+GetName(oContainer));
}

void TreaInitTables()
{
  string sCR, sTag; int i;
  if (GetLocalInt(GetModule(), "TreaInitCompl") == 1)  return;                  // Wurde bereits Initiert?
//if (GetLocalInt(GetModule(), AREA_LIST_COUNT) == 0)  InitializeAreaList();    // Wurde die Liste bereits angelegt?
  object oTreasureRoom = GetAreaByResRef(TREAROOM);                             // Hol den Schatzraum
  object oContainer = GetFirstObjectInArea(oTreasureRoom);                      // Schau nach dem ersten Kontainer

  // Ist der Kontainer okay und noch nicht gescannt
  while (GetIsObjectValid(oContainer)
      && GetLocalInt(oContainer, "Int") == 0)
  {
    // Darf der Kontainer auch genommen werden?
    if (GetStringLowerCase(GetStringLeft(GetTag(oContainer), 4)) == "loot")
    {
      // Setze den Kontainer als korrekt und speicher alles dazu
      d("trea_inc, TreaInitTables; Got "+ GetName(oContainer));
      TreaCreateTable(oContainer);
      sTag = GetTag(oContainer);

      // Verknuepfe den Kontainer mit der CR Range und danach auf die Karte
      if (GetLocalString(oContainer, TREAVCRB) != "")
      {
        sCR = GetTokenFromString(2, GetLocalString(oContainer, TREAVCRB));      // lese die CR-Range aus
        i = GetLocalInt(oTreasureRoom, TREACNAB+"NBR");                         // lese die Gesamtzahl Kontainer aus

        // gleich Loot_NormLootHigh|31_45
        SetLocalString(oTreasureRoom, TREACNAB+IntToString(i), sTag+"|"+sCR);   // 0 ist gleich Tag+CR des 1. Kontainer
        i++;                                                                    // 1 ist gleich Tag+CR des 2. Kontainer usw.
        d("trea_inc, TreaInitTables; Containers; "+IntToString(i));
        SetLocalInt(oTreasureRoom, TREACNAB+"NBR", i);

//      if (NWNX_ReadIntFromINI(TREACNAB, "NBR", 0, "D:/NWN1-Server/_ini/treasures.ini") <= 0)
//      {
//        NWNX_WriteStringToINI(TREACNAB, IntToString(i), sTag+"|"+sCR, "D:/NWN1-Server/_ini/treasures.ini");
//        NWNX_WriteIntToINI(TREACNAB, "NBR", i, "D:/NWN1-Server/_ini/treasures.ini");
//      }

        SetLocalInt(oContainer, "Int", 1);                                      // Speicher ab, dass der Kontainer gescannt wurde
      }
      else if (GetLocalString(oContainer, TREAVCRN) != "")
      {
        sCR = GetTokenFromString(2, GetLocalString(oContainer, TREAVCRN));      // lese die CR-Range aus
        i = GetLocalInt(oTreasureRoom, TREACNAN+"NBR");                         // lese die Gesamtzahl Kontainer aus

        // gleich Loot_NormLootHigh|31_45
        SetLocalString(oTreasureRoom, TREACNAN+IntToString(i), sTag+"|"+sCR);   // 0 ist gleich Tag+CR des 1. Kontainer
        i++;                                                                    // 1 ist gleich Tag+CR des 2. Kontainer usw.
        d("trea_inc, TreaInitTables; Containers; "+IntToString(i));
        SetLocalInt(oTreasureRoom, TREACNAN+"NBR", i);

//      if (NWNX_ReadIntFromINI(TREACNAN, "NBR", 0, "D:/NWN1-Server/_ini/treasures.ini") <= 0)
//      {
//        NWNX_WriteStringToINI(TREACNAN, IntToString(i), sTag+"|"+sCR, "D:/NWN1-Server/_ini/treasures.ini");
//        NWNX_WriteIntToINI(TREACNAN, "NBR", i, "D:/NWN1-Server/_ini/treasures.ini");
//      }

        SetLocalInt(oContainer, "Int", 1);                                      // Speicher ab, dass der Kontainer gescannt wurde
      }
    }

    // Scanne den naechsten Kontainer
    SetLocalInt(oContainer, "Int", 1);
    oContainer = GetNextObjectInArea(oTreasureRoom);
  }

  // Beende den Aufbau und setze ihn als Komplett
  SetLocalInt(GetModule(), "TreaInitCompl", 1);
}

void TreaActualizeTable(object oContainer = OBJECT_SELF)
{
  string sTable = GetLocalString(oContainer, "TreasureTable");                  // Treasure-Variable auslesen
  string sTagTable = GetLocalString(oContainer, "TagTable");                    // Tag-Variable auslesen
  string sDescription = GetDescription(oContainer);                             // Beschreibung auslesen
  int nCount =  GetLocalInt(oContainer, "Treasures");                           // Anzahl der Items auslesen
  string sResRef; string sName; string sTag;

  int    nType = GetInventoryDisturbType();                                     // Art des Bewegens erfassen
  object oItem = GetInventoryDisturbItem();                                     // Item erfassen, das bewegt wurde
  object oUser = GetLastDisturbed();

  switch (nType)
  {
    case INVENTORY_DISTURB_TYPE_ADDED:                                          // Etwas wurde rein gelegt, addiere es zur Tabelle
      sResRef = GetResRef(oItem);                                               // Lese ResRef aus
      sName = GetName(oItem);                                                   // Lese Name aus
      sTag = GetTag(oItem);                                                     // Lese Tag aus

      // Schau nach ob Item in der Tabelle ist. Wenn Ja, blocken
      if (GetIsTokenInString(sName, sDescription)== TRUE )
      {
        AssignCommand(oUser, ClearAllActions(TRUE));                            // brich alle Handlungen ab
        SetLocalInt(oContainer, "Stop", 1);                                     // unterbinde jeden Abgabevermerk
        ActionGiveItem(oItem, oUser);                                           // gib das Item zurueck und beende!
        return;
      }

      // Schau nach ob Item in der Tabelle ist. Wenn NEIN, addieren
      if (GetIsTokenInString(sName, sDescription)== FALSE )
        sDescription = AddTokenToString(sName, sDescription);

      // Schau nach ob Item in der Beschreibung ist. Wenn NEIN, addieren
      if (GetIsTokenInString(sResRef, sTable)== FALSE )
      {
        sTable = AddTokenToString(sResRef, sTable);
        nCount ++;
      }

      // Schau nach ob Item in der Tag-Tabelle ist. Wenn NEIN, addieren
      if (GetIsTokenInString(sTag, sTagTable)== FALSE )
        sTagTable = AddTokenToString(sTag, sTagTable);

      SetDescription(oContainer, sDescription);                                 // In Beschreibung ablegen
      SetLocalString(oContainer, "TreasureTable", sTable);                      // In Treasure-Variable ablegen
      SetLocalString(oContainer, "TagTable", sTagTable);                        // In Treasure-Variable ablegen
      SetLocalInt(oContainer, "Treasures", nCount);                             // Anzahl der Items ablegen

    break;

    // Etwas wurde entfernt, nimm es aus der Tabelle
    case INVENTORY_DISTURB_TYPE_REMOVED:
      sResRef = GetResRef(oItem);                                               // Lese ResRef aus
      sName = GetName(oItem);                                                   // Lese Name aus

      // Schau, ob das Item zweimal eingelegt wurde, dann brich ab
      if (GetLocalInt(oContainer, "Stop") == 1)                                 // loesche den Vermerk
      {
        DelayCommand(6.0, DeleteLocalInt(oContainer, "Stop"));
        return;
      }

      // Schau nach ob Item in der Tabelle ist. Wenn JA, nehmen
      if (GetIsTokenInString(sName, sDescription)== TRUE )
        sDescription = DeleteTokenFromString(sName, sDescription);

      // Schau nach ob Item in der Beschreibung ist. Wenn JA, nehmen
      if (GetIsTokenInString(sResRef, sTable)== TRUE )
      {
        sTable = DeleteTokenFromString(sResRef, sTable);
        nCount --;
      }

      // Schau nach ob Item in der Tag-Tabelle ist. Wenn Ja, nehmen
      if (GetIsTokenInString(sTag, sTagTable)== TRUE )
        sTagTable = DeleteTokenFromString(sTag, sTagTable);

      SetDescription(oContainer, sDescription);                                 // In Beschreibung ablegen
      SetLocalString(oContainer, "TreasureTable", sTable);                      // In Treasure-Variable ablegen
      SetLocalString(oContainer, "TagTable", sTagTable);                        // In Treasure-Variable ablegen
      SetLocalInt(oContainer, "Treasures", nCount);                             // Anzahl der Items ablegen

    break;
  }
}

string TreaPrintTables()
{
  int i; string sPrint = "$$$";

  {
    object oArea = GetAreaByResRef(TREAROOM);
    int a = GetLocalInt(oArea, TREACNAN+"NBR");
    int b = GetLocalInt(oArea, TREACNAB+"NBR");
    sPrint = "";

    for (i=0; i <= a; i++)
      sPrint = AddTokenToString(sPrint, GetLocalString(oArea, TREACNAN+IntToString(i)), "$");

    for (i=0; i <= b; i++)
      sPrint = AddTokenToString(sPrint, GetLocalString(oArea, TREACNAB+IntToString(i)), "$");
  }

  sPrint = GetStringLeft(sPrint, GetStringLength(sPrint)-1);
  d("trea_inc - PrintTable; is "+sPrint);
  return sPrint;
}

string TreaLowestTables()
{
  string s, sResult, l = TreaPrintTables();
  //Loot_BossLootUnique|46_99$Loot_BossLootHigh|31_45$Loot_BossLootMid|15_30$Loot_BossLootLow|01_15$
  //Loot_TreasureTableHigh|35_99$Loot_TreasureTableMid|21_34$Loot_TreasureTable|01_20
  int t = GetTokenCount(l, "$");                          //7

  d("trea_inc - LowTable; start loop with "+IntToString(t));
  d("trea_inc - LowTable; on "+l);
  int i;
  for (i=1; i<=t; i++)
  {
    s = GetTokenFromString(i, l, "$");
    d("trea_inc - LowTable; Working on "+s);

    if (FindSubString(s, "01") >= 0)
    {
      sResult = AddTokenToString(sResult, s, ":");        //Loot_BossLootLow|01_15:Loot_TreasureTable|01_20
      //break;                                            // when only one value needed
    }                                                     // but beware if there exists another one!!!
  }

  sResult = GetStringLeft(sResult, GetStringLength(sResult)-1);
  d("trea_inc - LowTable; is "+sResult);
  return sResult;
}

object TreaGetTreasureTable(object oMonster)
{
    string sMonster = GetTag(oMonster), sCR, sRange, sTable;                    d("trea_inc, TreaGetTable; Tag "+sMonster);
    float fCR = GetChallengeRating(oMonster);                                   d("trea_inc, TreaGetTable; floatCR "+FloatToString(fCR,3,2));
    if (fCR <= 1.0)   fCR = 1.0;                                                //so its everytime a cr of 1!
    int nCR = FloatToInt(fCR), i, c, nMin, nMax;                                d("trea_inc, TreaGetTable; intCR "+IntToString(nCR));

    object oTreasureRoom = GetAreaByResRef(TREAROOM), oResult, oTable;          d("trea_inc, TreaGetTable; Room "+GetName(oTreasureRoom));
    int b = FindSubString(GetStringLowerCase(sMonster), "_boss");

    if (GetObjectType(oMonster) == OBJECT_TYPE_CREATURE && b >= 0)
    {
      c = GetLocalInt(oTreasureRoom, TREACNAB+"NBR");
      d("trea_inc, TreaGetTable; # Boss Con "+IntToString(c));

      //sRange = GetLocalString(oTreasureRoom, TREACNAB+IntToString(i));          // Loot_BossLootUnique|46_99

      //nMin = StringToInt(GetTokenFromString(1, GetTokenFromString(2, sRange), "_"));  // 46
      //nMax = StringToInt(GetTokenFromString(2, GetTokenFromString(2, sRange), "_"));  // 99

      d("trea_inc, TreaGetTable; Boss CR-Range "+IntToString(nMin)+"/"+IntToString(nMax));
    }
    else if (GetObjectType(oMonster) == OBJECT_TYPE_CREATURE && b < 0)
    {
      c = GetLocalInt(oTreasureRoom, TREACNAN+"NBR");
      d("trea_inc, TreaGetTable; # Norm Con "+IntToString(c));
      d("trea_inc, TreaGetTable; Norm CR-Range "+IntToString(nMin)+"/"+IntToString(nMax));
    }

    else if (GetObjectType(oMonster) == OBJECT_TYPE_PLACEABLE && b < 0)
    {
      d("trea_inc, TreaGetTable; Found Placeable!");

      c = GetLocalInt(oTreasureRoom, TREACNAN+"NBR");
      d("trea_inc, TreaGetTable; Use # Norm Con "+IntToString(c));
      nCR = GetLocalInt(oMonster, "LootBoxCR");

      d("trea_inc, TreaGetTable; Placeable CR "+IntToString(nCR)+" and "+IntToString(nMin)+"/"+IntToString(nMax));
    }

    for (i = 0; i <= c; i++)
    {
      if (b >= 0)
        sRange = GetLocalString(oTreasureRoom, TREACNAB+IntToString(i));          // Loot_BossLootUnique|46_99
      else
        sRange = GetLocalString(oTreasureRoom, TREACNAN+IntToString(i));          // Loot_BossLootUnique|46_99

      nMin = StringToInt(GetTokenFromString(1, GetTokenFromString(2, sRange), "_"));  // 21
      nMax = StringToInt(GetTokenFromString(2, GetTokenFromString(2, sRange), "_"));  // 34

      if (nCR >= nMin && nCR <= nMax)
      {
        if (b >= 0)
        {
          sTable = GetTokenFromString(1, sRange);                                   // Loot_BossLootUnique
          oTable = GetObjectByTag(sTable);

          if (GetIsObjectValid(oTable) == TRUE)
          {
            d("trea_inc, TreaGetTable; "+GetName(oTable) +" is Valid "+ IntToString(GetIsObjectValid(oTable)));
            return oTable;
          }
          else
            return OBJECT_INVALID;
        }
        else
        {
          sTable = GetTokenFromString(1, sRange);                                   // Loot_BossLootUnique
          oTable = GetObjectByTag(sTable);

          if (GetIsObjectValid(oTable) == TRUE)
          {
            d("trea_inc, TreaGetTable "+GetName(oTable) +" is Valid "+ IntToString(GetIsObjectValid(oTable)));
            return oTable;
          }

          else
            return OBJECT_INVALID;
        }
      }
    }
  return OBJECT_INVALID;
}

void TreaGetTreasure(object oTreasureTable, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0)
{
  string sTreasureTable, sLowestTables, sTable, sTagTable, sResRef, sTag, a, b, c;
  int nCount, nRandom, nLowestBoss, nLowestNorm, nLowestMax;
  object oTreasure;
  d("trea_inc, TreaGetTreasure; Treasuretable is "+GetName(oTreasureTable));

  if (!GetIsObjectValid(oTreasureTable))                                        // table not available
  {
    d("trea_inc, TreaGetTreasure; No table for "+GetName(oCreateIn)+" found, so reaching out for lowest table!");
    //oTreasureTable = GetObjectByTag("Loot_TreasureTable");

    sLowestTables = TreaLowestTables();                                         // get the lowest tables
    d("trea_inc, TreaGetTreasure; split from: "+sLowestTables);
    nLowestMax = GetTokenCount(sLowestTables, ":");                             // return sum of tokens
    d("trea_inc, TreaGetTreasure; counted: "+IntToString(nLowestMax));

    a = GetTokenFromString(1, sLowestTables, ":");
    d("trea_inc, TreaGetTreasure; split to a: "+a);
    b = GetTokenFromString(2, sLowestTables, ":");
    d("trea_inc, TreaGetTreasure; split to b: "+b);

    if (FindSubString(GetStringLowerCase(GetTag(oCreateIn)), "_boss") >= 0)     // found a boss monster
    {
      d("trea_inc, TreaGetTreasure; Found a boss monster!");
      if (FindSubString(GetStringLowerCase(a), "boss") >= 0)
      {
        sTreasureTable = GetTokenFromString(1, a);
        d("trea_inc, TreaGetTreasure; Found a boss table!\n"+sTreasureTable);
      }
      else
      {
        sTreasureTable = GetTokenFromString(1, b);
        d("trea_inc, TreaGetTreasure; Found b boss table!\n"+sTreasureTable);
      }
    }

    oTreasureTable = GetObjectByTag(sTreasureTable);                            // get the lowest table?
    d("trea_inc, TreaGetTreasure; Thats me: "+GetName(oTreasureTable));
  }

  else if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oCreateIn)<=10 //)
  &&  GetLocalInt(oCreateIn, "GotIt") <= 0)
  {
    d("trea_inc, TreaGetTreasure; No commoner!");
    if (nChance==0)
    {
      d("trea_inc, TreaGetTreasure; Create Gold");
      CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF, d8(1) + (Random(2)+1));  // Maximal 10 GM
    }

    if (d100() <= nChance)
    {
      sTable    = GetLocalString(oTreasureTable, "TreasureTable");                // Treasure-Variable auslesen
      sTagTable = GetLocalString(oTreasureTable, "TagTable");                     // Tag-Variable auslesen
      nCount    = GetLocalInt(oTreasureTable, "Treasures");                       // Anzahl der Items auslesen
      d("trea_inc, TreaGetTreasure; Table is "+sTable+" and tags is "+sTagTable+" also is nbr "+IntToString(nCount));

      nRandom   = Random(nCount)+1;                                               // Bei 100 Items wird eine Zahl zwischen 1-100 ausgesucht, usw.
      d("trea_inc, TreaGetTreasure; RandomNbr is "+IntToString(nRandom));

      sResRef   = GetTokenFromString(nRandom+nBonus, sTable);                     // Suche die ResRef aus der Tabelle heraus
      sTag      = GetTokenFromString(nRandom+nBonus, sTagTable);                  // Suche den Tag aus der Tabelle heraus
      d("trea_inc, TreaGetTreasure; RandomNbr is "+IntToString(nRandom+nBonus)+" witch is "+sResRef+" / "+sTag);

      oTreasure = CreateItemOnObject(sResRef, oCreateIn);                         // Erschaffe das Item mit der ResRef

      if (GetIsObjectValid(oTreasure)==FALSE)                                     // Ansonsten erschaffe es mit dem Tag (Original-Items)
      {
        d("trea_inc, TreaGetTreasure; No ResRef, create with tag!");
        oTreasure = CreateItemOnObject(sTag, oCreateIn);
      }
    }
    string sTreasureName = GetName(oTreasure);
    if (sTreasureName == "")
    {
      if (sResRef != "")
        sTreasureName = GetObjectName(sResRef);
      else
        sTreasureName = GetObjectName(sTag);
    }
    SetIdentified( oTreasure, TRUE );
    d("trea_inc, TreaGetTreasure; "+GetName(oCreateIn)+" got: "+GetName(oTreasure)+" from: "+GetName(oTreasureTable) );
  }
}

void IslaNscBooks(object oMonster = OBJECT_SELF)
{
  d("trea_inc, IslaBooks Rep: "+IntToString(GetStandardFactionReputation(STANDARD_FACTION_COMMONER, OBJECT_SELF)));
  if (GetStringLeft(GetResRef(oMonster), 3) == "mob")                           // Pruefe auf ResRef mob
    return;                                                                     // Feind bekommt kein Buch!

  string sNSC_File = "CREATUREDB";                                              // DB mit allen Daten
  string sName = GetName(oMonster);                                             // Name des NSC
  string sSection = GetResRef(oMonster);                                        // ResRef des NSC

  if (HasItem(oMonster, "nw_it_book028") == FALSE)                              // Kein Buch im Inv?
    CreateItemOnObject("nw_it_book028", oMonster);                              // Erschaffe eins!

  object oBook = GetItemPossessedBy(oMonster, "NW_IT_BOOK028");                 // Buch im Inventar
  SetIdentified(oBook, TRUE);
  SetDroppableFlag(oBook, FALSE);

  string sDesc = GetDescription(oMonster);                                      // Lese die Beschreibung auf dem NSC aus
  string sAllg = GetCampaignString(sNSC_File, sSection);                        // Lese die Daten des NSC's aus

  if (sAllg == "")  SetCampaignString(sNSC_File, sSection, sName);

  string sBook = sDesc + "\n < - - - - >\n";
         sBook = sBook + sAllg;
         sBook = sBook + "\n < - - - - >\n";

  SetDescription(oBook, sBook, TRUE);

  SetName(oBook, sName);
}

void DeleteUnwantedItemsByChance(string sItemTag, object oCreature = OBJECT_SELF)
{
  object oItem = GetItemPossessedBy(oCreature, sItemTag);
  if (GetIsObjectValid(oItem))
  {
    int nChance = Random(100)+1;                                            // random chance from 1-100
    if (nChance >= 76)
    {
      //DebugMode(GetName(oCreature)+" hatte "+GetName(oItem)+", wird entfernt. Chance war: "+IntToString(nChance));
      DestroyObject(oItem);
    }
  }
}
