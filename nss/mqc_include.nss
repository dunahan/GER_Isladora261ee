//void main() { }

#include "nw_i0_plot"

// DebugModus
const int MQC_DEBUG = TRUE;

// const string MEHL_BELxxxx = "";  // <= kopieren um neue Questitems zu deklarieren
// Questbelohnungen, Questname_ (zb. MEHL_) + Belohnung (BEL) + Anfangsbuchstaben des NSC-Namens (zb ANTOn)
const string MEHL_BELANTO = "it_gulasch";
const string MEHL_BELESME = "cnrrationen_food";
const string MEHL_BELJOHA = "it_gansbraten";
const string MEHL_BELMEIK = "it_kaese";
const string MEHL_BELRUDI = "cnrblkberrypie";
const string MEHL_BELMERA = "mqc_weintraube";
const string MEHL_BELESRE = "cnrcornbread";
const string MEHL_BELSONS = "cnrcornbread";


// Notwendige Questitems um sie zu erfuellen... Aehnlich oben aufgebaut
const string MEHL_BELMUEL = "cnrCornFlour";


// Questnamen zur Speicherung der Daten, wieder siehe oben ;-)
const string UNBEKANNT = "UB_";
const string MEHLQUEST = "MQ_";

void mqc_Debug(string sFunction, string sMessage)
{
  if (MQC_DEBUG)
    WriteTimestampedLogEntry(sFunction + "; "+ sMessage);
}

string mqc_UniquePC(object oPC)
{
  string sFunction = "mqc_UniquePC";

  string name = GetName(oPC, TRUE);      mqc_Debug(sFunction, "Name: "+name);
  string spieler = GetPCPlayerName(oPC); mqc_Debug(sFunction, "Spieler: "+spieler);
  string sMessage = "Kobinierte Abfrage ergibt: ", ergebnis;

  int leer = FindSubString(name, " ");          // Wenn fuehrend ein Leerzeichen bevorsteht
  if (leer == 0)
    ergebnis = GetSubString(name, leer, 4);     // Starte nach dem ersten Leerzeichen

  else                                          // Ansonsten nimm das den normalen Namen
    ergebnis = GetStringLeft(name, 4);

  ergebnis = ergebnis + GetStringLeft(spieler, 3);  // Fuege diese Namen alle zusammen

  mqc_Debug(sFunction, sMessage + ergebnis);

  return ergebnis;
}


string mqc_Belohnung(object oQuestgeber = OBJECT_SELF)
{
  string sFunction = "mqc_Belohnung";
  string sResult, sMessage = "Ergebnis der Abfrage: ";
  string sResRef = GetResRef(oQuestgeber);

       if (sResRef == "mqc_gehilfemera")  sResult = MEHL_BELMERA;
  else if (sResRef == "mqc_esrenia")      sResult = MEHL_BELESRE;
  else if (sResRef == "mqc_gehilfeanton") sResult = MEHL_BELANTO;
  else if (sResRef == "mqc_esmeralda")    sResult = MEHL_BELESME;
  else if (sResRef == "mqc_gehilfemeike") sResult = MEHL_BELMEIK;
  else if (sResRef == "mqc_gehilfejohan") sResult = MEHL_BELJOHA;
  else if (sResRef == "mqc_ruddimohnfel") sResult = MEHL_BELRUDI;

  else if (sResRef == "")                 sResult = MEHL_BELSONS;
  if (sResult == "")                      sResult = MEHL_BELSONS;

  mqc_Debug(sFunction, sMessage + sResult);

  return sResult;
}

string mqc_Notwendig(object oQuestgeber = OBJECT_SELF)
{
  string sFunction = "mqc_Notwendig";
  string sResult, sMessage = "Ergebnis der Abfrage: ";
  string sResRef = GetResRef(oQuestgeber);

       if (sResRef == "mqc_gehilfemera")  sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_esrenia")      sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_gehilfeanton") sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_esmeralda")    sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_gehilfemeike") sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_gehilfejohan") sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_ruddimohnfel") sResult = MEHL_BELMUEL;
  else if (sResRef == "mqc_mjohanna")     sResult = MEHL_BELMUEL;

  else
    sResult = "";

  mqc_Debug(sFunction, sMessage + sResult);

  return sResult;
}

string mqc_Questname(object oQuestgeber = OBJECT_SELF)
{
  string sFunction = "mqc_Questname";
  string sResult, sMessage = "Ergebnis der Abfrage: ";
  string sResRef = GetResRef(oQuestgeber);

       if (sResRef == "mqc_gehilfemera")  sResult = MEHLQUEST;
  else if (sResRef == "mqc_esrenia")      sResult = MEHLQUEST;
  else if (sResRef == "mqc_gehilfeanton") sResult = MEHLQUEST;
  else if (sResRef == "mqc_esmeralda")    sResult = MEHLQUEST;
  else if (sResRef == "mqc_gehilfemeike") sResult = MEHLQUEST;
  else if (sResRef == "mqc_gehilfejohan") sResult = MEHLQUEST;
  else if (sResRef == "mqc_ruddimohnfel") sResult = MEHLQUEST;
  else if (sResRef == "mqc_mjohanna")     sResult = MEHLQUEST;
  else if (sResRef == "mqc_mbert")        sResult = MEHLQUEST;

  else if (sResRef == "")                 sResult = UNBEKANNT;
  if (sResult == "")                      sResult = UNBEKANNT;

  mqc_Debug(sFunction, sMessage + sResult);

  return sResult;
}

void mqc_AnzahlItemsNehmen(object oTarget, string sItem, int nNumItems)
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
