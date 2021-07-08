#include "_tokenizer_inc"
#include "_area_inc"
#include "_debugisla"

#include "nw_i0_2q4luskan"
#include "nw_i0_plot"
#include "x2_inc_switches"
#include "x0_i0_position"

const string TELEDATAB = "TELE_DATA";

const float DELAYEDJUMP  =    10.0;
const float DELAYEDSAVE  =    60.0;
const float DELAYEDCHECK = 36000.0;
const float TELEDELAYDEL =    15.0;

const string ITEMFORPOSITIONS = "itm_questbuch";
const string TELEARRAY = "PSP";
const string TELECONWP = "TELE_CON";
const string TELECONTAG = "tele_container";

const string CITY001 = "OOC_Wanderer_PP_Strand_b";
const string CITY002 = "WP_Corazur";
const string CITY003 = "WP_LachendesDorf";

const string DWARF = "WP_Binge";    // RACIAL_TYPE_DWARF
const string ELF   = "TP_4_1";      // RACIAL_TYPE_ELF
const string GNOME = "";            // RACIAL_TYPE_GNOME
const string HALFL = "";            // RACIAL_TYPE_HALFLING
const string HLELF = "";            // RACIAL_TYPE_HALFELF
const string HLORC = "";            // RACIAL_TYPE_HALFORC
const string HUMAN = "";            // RACIAL_TYPE_HUMAN

const string DUERG = "";            // RACIAL_TYPE_DUERGAR
const int RACIAL_TYPE_DUERGAR = 30;
const string DROW  = "WP_Drow";     // RACIAL_TYPE_DROW
const int RACIAL_TYPE_DROW = 31;
const string SVIRF = "";            // RACIAL_TYPE_SVIRFNEBLIN
const int RACIAL_TYPE_SVIRFNEBLIN = 32;

const string CHAOTIC     = "";
const string LAWFUL      = "";
const string TRUENEUTRAL = "";

////////////////////////////////////////////////////////////////////////////////////
// Erfasst die passende Area zur ResRef
// sResRef = Die ResRef der zu suchenden Area
object GetAreaForTeleport(string sResRef);

////////////////////////////////////////////////////////////////////////////////////
// Verwandelt die aktuelle Position der Figur in einen String, der zuverlaessig
// abgespeichert werden kann.
// oPlayer = Figur, deren Position umgewandelt werden soll
string TeleportLocationToString(object oPlayer);

////////////////////////////////////////////////////////////////////////////////////
// Liesst aus einem vorher umgewandelten/abgespeicherten String die Position heraus
// und wandelt diese in eine weiterverarbeitbare Location um
// sLocation = Die in einem String umgewandelte Position, bestehend aus Area, X/Y/Z-
// Koordinate und Blickrichtung
location TeleportLocationFromString(string sLocation);

////////////////////////////////////////////////////////////////////////////////////
// WalkAround der Set-/Get-LocalLocation Funktion, da diese nicht zuverlässig ist
// oPlayer = der Spieler, dessen Position gespeichert werden soll
// sArray = ein Vorzeichen, um mehr als eine Position abspeichern zu können
// oItem = ein Item, auf dem die Position abgespeichert werden soll
//   ACHTUNG sArray, kurz halten dazu Case-Sensetiv!!!
void SetLocalLocationOverride(object oPlayer, string sArray, object oItem = OBJECT_INVALID);

////////////////////////////////////////////////////////////////////////////////////
// WalkAround der Set-/Get-LocalLocation Funktion, da diese nicht zuverlässig ist
// oPlayer = der Spieler, dessen gespeicherte Position geladen werden soll
// sArray = ein Vorzeichen, um eine bestimmte Position laden zu können
// oItem = ein Item, auf dem die Position abgespeichert werden soll
//   ACHTUNG sArray, kurz halten dazu Case-Sensetiv!!!
location GetLocalLocationOverride(object oPlayer, string sArray, object oItem = OBJECT_INVALID);

////////////////////////////////////////////////////////////////////////////////////
// Löscht die gespeicherten Daten des Set-/Get-LocalLocation WalkArounds
// oPlayer = der Spieler, dessen gespeicherte Position geladen werden soll
// sArray = ein Vorzeichen, um eine bestimmte Position laden zu können
// oItem = ein Item, auf dem die Position abgespeichert werden soll
//   ACHTUNG sArray, kurz halten dazu Case-Sensetiv!!!
int DeleteLocalLocationOverride(string sArray, object oItem = OBJECT_SELF);

////////////////////////////////////////////////////////////////////////////////////
// Sollte die Heimposition des Spielers erfassen
// noch im Erprobungsmodus! Gibt bei Fehler die aktuelle Position des Objekts aus!
location GetHomeLocation(object oPlayer);

////////////////////////////////////////////////////////////////////////////////////
// Fuehrt eine verspaete Speicherung der aktuellen Position aus. Nutzbar fuer ein
// kuenstliches Heartbeat.
// oPlayer = Figur deren Position gespeichert werden soll
// oItem = Item auf dem sie gespeichert werden soll
void DelayedSavePosition(object oPlayer, object oItem);

////////////////////////////////////////////////////////////////////////////////////
// Fuehrt einen verspaeten Teleport zur jeweiligen Position aus
// oPlayer = Figur die Teleportiert werden soll
// locJumpTo = Position zu der gesprungen werden soll
void DelayedJumpToLocation(object oPlayer, location locJumpTo, float fDelay = 10.0);

////////////////////////////////////////////////////////////////////////////////////
// Fuehrt einen verspaeten Teleport zum jeweiligen Objekt aus
// oPlayer = Figur die Teleportiert werden soll
// oObject = Objekt zu dem gesprungen werden soll
void DelayedJumpToObject(object oPlayer, object oObject, float fDelay = 10.0);

// Funktionen folgend

object GetAreaForTeleport(string sResRef)
{
  object oArea = GetFirstArea();          // Erfasse die erste Area im Modul

  while (GetIsObjectValid(oArea) == TRUE) // Ist diese Existent
  {
    if (GetResRef(oArea) == sResRef)      // Vergleiche die ResRef mit der Gesuchten
      return oArea;                       // UND stimmt diese, gib die Area wieder

    oArea = GetNextArea();                // Ansonsten untersuche die naechste Area
  }

  return OBJECT_INVALID;                  // Wurde kein Objekt gefunden, Melde UNBEKANNT
}

string TeleportLocationToString(object oPlayer)
{
  // 1.1 Erfasse die Area in der der Spieler sich befindet
  object oArea = GetArea( oPlayer );

  // 1.2.1 Erfasse die Position in der Area, an der sich der Spieler befindet
  location locTarget = GetLocation( oPlayer );               // dazu lese die aktuelle Position des Ziels aus
  vector vecLocation = GetPositionFromLocation( locTarget ); // und lese die Koordinaten aus der Position
  // 1.2.2 Nun wandle die Position in entsprechende Koordinaten um
  float fX = ( vecLocation.x ); float fY = ( vecLocation.y ); float fZ = ( vecLocation.z );

  // 1.3 Schlussendlich, erfasse die Blickrichtung der Spielfigur
  float fOrientation = GetFacing( oPlayer );

  // 2++
  // 2.1
  string sArea = GetResRef(oArea);
  string sfX = FloatToString(fX, 3, 2);
  string sfY = FloatToString(fY, 3, 2);
  string sfZ = FloatToString(fZ, 3, 2);
  string sOrientation = FloatToString(fZ, 3, 2);

  string sResult = "";
         sResult = AddTokenToString(sArea, sResult, "_");
         sResult = AddTokenToString(sfX, sResult, "_");
         sResult = AddTokenToString(sfY, sResult, "_");
         sResult = AddTokenToString(sfZ, sResult, "_");
         sResult = AddTokenToString(sOrientation, sResult, "_");    DebugMode("tele_inc, TeleportLocationToString - Aktuelle Location: "+sResult);

  return sResult;
}

location TeleportLocationFromString(string sLocation)
{
  location locResult;

  int nTokens = GetTokenCount(sLocation, "_");

  string sArea = GetTokenFromString(1, sLocation, "_");
  object oArea = GetAreaForTeleport(sArea);

  string sfX = GetTokenFromString(2, sLocation, "_");
  float fX = StringToFloat(sfX);
  string sfY = GetTokenFromString(3, sLocation, "_");
  float fY = StringToFloat(sfY);
  string sfZ = GetTokenFromString(4, sLocation, "_");
  float fZ = StringToFloat(sfZ);
  string sOrientation = GetTokenFromString(5, sLocation, "_");
  float fOrientation = StringToFloat(sOrientation);

  vector vResult = Vector(fX, fY, fZ);

  locResult = Location(oArea, vResult, fOrientation);

  return locResult;
}

void SetLocalLocationOverride(object oPlayer, string sArray, object oItem = OBJECT_INVALID)
{
  // 1++ Grundlagen sammeln/definieren
  // 1.1 Prüfe ab, ob Spieler existent, ansonsten breche ab!
  if ( GetIsObjectValid( oPlayer ) == FALSE )
    return;

  // 1.2 Erfasse die Area in der der Spieler sich befindet
  object oArea = GetArea( oPlayer ); string sArea = GetResRef( oArea ), sDebug;

  // 1.3.1 Erfasse die Position in der Area, an der sich der Spieler befindet
  location locTarget = GetLocation( oPlayer );               // dazu lese die aktuelle Position des Ziels aus

   // 1.3.2 Nun wandle die Position in entsprechende Koordinaten um
  vector vecLocation = GetPositionFromLocation( locTarget ); // und lese die Koordinaten aus der Position
  float fX = ( vecLocation.x ); float fY = ( vecLocation.y ); float fZ = ( vecLocation.z );

  // 1.4 Schlussendlich, erfasse die Blickrichtung der Spielfigur
  float fOrientation = GetFacing( oPlayer );

  sDebug = GetName(oPlayer)+"\n"+
           sArray+"\n"+
           GetName(oArea)+"\n"+
           sArea+"\n"+
           FloatToString(fX,3,2)+"|"+FloatToString(fY,3,2)+"|"+FloatToString(fZ,3,2)+"\n"+
           FloatToString(fOrientation,3,2)+"\n";
  DebugMode("tele_inc, SetLocalLocationOverride - Aktuelle Daten: "+sDebug);

  // 2++ Abspeichern der gesammelten und berechneten Ergebnisse, lokal auf die Figur ODER
  //     im Falle eines angegebenem Items

  // 2.1 Prüfe vorab ab, ob das Item existiert. Wenn ja, dann verwende es als Speicher!
  if ( GetIsObjectValid( oItem ) == TRUE )
  {  oPlayer = oItem;  }

  // 2.2 Speichern der Area als LocalObject auf dem Spieler/Item
  SetLocalString( oPlayer, sArray+"_Area", sArea );

  // 2.3 Speichern der Position im Einzelnen als LocalFloat auf dem Spieler/Item
  SetLocalFloat ( oPlayer, sArray+"_VecX", fX );
  SetLocalFloat ( oPlayer, sArray+"_VecY", fY );
  SetLocalFloat ( oPlayer, sArray+"_VecZ", fZ );

  // 2.4 Speichern der Blickrichtung als LocalFloat auf dem Spieler/Item
  SetLocalFloat ( oPlayer, sArray+"_Ornt", fOrientation );
}

location GetLocalLocationOverride(object oPlayer, string sArray, object oItem = OBJECT_INVALID)
{
  // 1++ Grundlagen sammeln/definieren
  // 1.1 Prüfe vorab ab, ob das Item existiert. Wenn ja, dann verwende es als Speicher!
  if ( GetIsObjectValid( oItem ) == TRUE )
  {  oPlayer = oItem;  }

  // 1.2 Lese aus dem Spieler/Item die Area aus, die gespeichert wurde
  string sArea = GetLocalString      ( oPlayer, sArray+"_Area" ), sDebug;
  object oArea = GetAreaForTeleport  ( sArea );

  // 1.3.1 Lese aus dem Spieler/Item die Position aus, die gespeichert wurde
  float fX = GetLocalFloat           ( oPlayer, sArray+"_VecX" );
  float fY = GetLocalFloat           ( oPlayer, sArray+"_VecY" );
  float fZ = GetLocalFloat           ( oPlayer, sArray+"_VecZ" );

  // 1.3.2 Bilde daraus einen Vector, der spter fr die Erstellung benötigt wird
  vector vPosition = Vector( fX, fY, fZ );

  // 1.4 Lese aus Spielfigur/Item die Blickrichtung aus, die gespeichert wurde
  float fOrientation = GetLocalFloat ( oPlayer, sArray+"_Ornt" );

  sDebug = GetName(oPlayer)+"\n"+
           sArray+"\n"+
           GetName(oArea)+"\n"+
           sArea+"\n"+
           FloatToString(fX,3,2)+"|"+FloatToString(fY,3,2)+"|"+FloatToString(fZ,3,2)+"\n"+
           FloatToString(fOrientation,3,2)+"\n";
  DebugMode("tele_inc, GetLocalLocationOverride - Aktuelle Daten: "+sDebug);

  // 2++ Bilden der Position und Ausgabe
  // 2.1 Mit den nun vorhandenen Daten kann die Position erstellt werden
  location locResult = Location( oArea, vPosition, fOrientation );

  // 2.2 Gebe nun die erstellte Position als Ergebnis heraus
  return locResult;
}

int DeleteLocalLocationOverride(string sArray, object oItem = OBJECT_SELF)
{
  // 1++ Grundlagen sammeln/definieren
  // 1.1 Prüfe ab, ob Item existent, ansonsten breche ab!
  if ( GetIsObjectValid( oItem ) == FALSE )
    return FALSE;

  // 1.2 Loeschen der Area
  DeleteLocalString( oItem, sArray+"_Area" );

  // 1.3 Loeschen der Position
  DeleteLocalFloat ( oItem, sArray+"_VecX" );
  DeleteLocalFloat ( oItem, sArray+"_VecY" );
  DeleteLocalFloat ( oItem, sArray+"_VecZ" );

  // 1.4 Loeschen der Blickrichtung
  DeleteLocalFloat ( oItem, sArray+"_Ornt" );

  return TRUE;
}

void Tele_DestroyObject(object oObject = OBJECT_SELF)
{
  object oItem = GetFirstItemInInventory(oObject);

  while (GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);
    oItem = GetNextItemInInventory();
  }
  DestroyObject(oObject);
}

void wrap_StoreCampaignObjects(string sCampaignName, string sVarName, object oChest = OBJECT_SELF, object oPlayer = OBJECT_INVALID)
{
  object oWaypoint = GetObjectByTag(TELECONWP);
  object oStorer = CreateObject(OBJECT_TYPE_CREATURE, TELECONTAG, GetLocation(oWaypoint));
  object oCopy, oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
  {
    oCopy = CopyItem(oItem, oStorer, TRUE);
    oItem = GetNextItemInInventory(oChest);
  }

  StoreCampaignObject(sCampaignName, sVarName, oStorer, oPlayer);
  DelayCommand(TELEDELAYDEL-1.0, Tele_DestroyObject(oStorer));
  DelayCommand(TELEDELAYDEL, Tele_DestroyObject(oChest));
}

object wrap_RetrieveCampaignObjects(string sCampaignName, string sVarName, location locLocation, object oOwner = OBJECT_INVALID, object oPlayer = OBJECT_INVALID)
{
  object oWaypoint = GetObjectByTag(TELECONWP);
  object oStorer = RetrieveCampaignObject(sCampaignName, sVarName, GetLocation(oWaypoint), oOwner, oPlayer);
  object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, TELECONTAG, locLocation);
  object oCopy, oItem = GetFirstItemInInventory(oStorer);
  while (GetIsObjectValid(oItem))
  {
    oCopy = CopyItem(oItem, oChest, TRUE);
    oItem = GetNextItemInInventory(oStorer);
  }
  DelayCommand(TELEDELAYDEL, Tele_DestroyObject(oStorer));
  return oChest;
}

location GetHomeLocation(object oPlayer)
{
  object oChestPoint = GetWaypointByTag(TELECONWP);
  location locTarget = GetLocation(oChestPoint), locKeyA, locKeyB;
  location locPlayer = GetLocation(oPlayer);
  string sTag;
  object oKey, oChest = wrap_RetrieveCampaignObjects(TELEDATAB, "TELECON", locTarget);

  if (GetIsObjectValid(oChest))   oKey = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oKey))
  {
    sTag = GetTag(oKey);
    if ( GetIsObjectValid(GetItemPossessedBy(oPlayer, sTag)) )                  // besitzt der Spieler den Schluessel dann
    {
      locKeyA = GetLocalLocation(oKey, TELEARRAY+"_HOME");                      // lese die Daten aus
      locKeyB = GetLocalLocationOverride(oKey, TELEARRAY+"_HOME");              DebugMode(LocationToString(locKeyA)+"\n"+LocationToString(locKeyB));

      if ( GetIsObjectValid(GetAreaFromLocation(locKeyA)) )                     // ist diese loc korrekt dann
        return locKeyA;                                                         // gebe diese aus

      if ( GetIsObjectValid(GetAreaFromLocation(locKeyB)) )                     // ist jene korrekt
        return locKeyB;                                                         // dann gebe jene aus
    }

    oKey = GetNextItemInInventory(oChest);
  }
  return locPlayer;                                                             // im schlimmsten falle, gibts keine loc, aussser der des Players
}

void DelayedSavePosition(object oPlayer, object oItem)
{
  if (GetLocalInt(oPlayer, "Entered") == 1)
  {
    DelayCommand(DELAYEDSAVE-0.1, SendServerMessageToPC(oPlayer, "Deine Positon wurde gespeichert."));
    DelayCommand(DELAYEDSAVE, SetLocalLocationOverride(oPlayer, TELEARRAY, oItem));
  }

  SetLocalInt(oPlayer, "Entered", 1);
  DelayCommand(DELAYEDCHECK, DelayedSavePosition(oPlayer, oItem));
}

void wraploc(object oPlayer, location locJumpTo)
{
  AssignCommand(oPlayer, ClearAllActions(TRUE));
  AssignCommand(oPlayer, JumpToLocation(locJumpTo));

  // Hier sollten nun auch noch alle Anhängsel teleportiert werden, theoretisch
  object oHenchman; int nAssociateType, nTh = 1;
  for (nAssociateType = 1; nAssociateType <= 5; nAssociateType++)
  {
    oHenchman = GetAssociate(nAssociateType, oPlayer, nTh);

    if (GetIsObjectValid(oHenchman) == TRUE)
    {
      AssignCommand(oHenchman, ClearAllActions(TRUE)); // Beende alle Tätigkeiten und
      AssignCommand(oHenchman, JumpToObject(oPlayer)); // springe zum Ziel
    }
  }
}

void DelayedJumpToLocation(object oPlayer, location locJumpTo, float fDelay = 10.0)
{
  if (GetIsObjectValid(GetAreaFromLocation(locJumpTo)) == TRUE)
  {
    DebugMode("DelayedJumpToLocation-Delay: "+FloatToString(fDelay));
    if (fDelay >= 0.0) {
      SendServerMessageToPC(oPlayer, "Du wirst in " +
                                     FloatToString(fDelay, 3, 0) +
                                     " Sekunden zu deinem Bestimmungsort gebracht.");
    }
    DelayCommand(fDelay, wraploc(oPlayer, locJumpTo));
  }

  else
    SendServerMessageToPC(oPlayer, "Du kannst leider nicht an diesen Ort gebracht werden.");
}

void wrapobj(object oPlayer, object oObject)
{
  AssignCommand(oPlayer, ClearAllActions(TRUE));
  AssignCommand(oPlayer, JumpToObject(oObject));

  // Hier sollten nun auch noch alle Anhängsel teleportiert werden, theoretisch
  object oHenchman; int nAssociateType, nTh = 1;
  for (nAssociateType = 1; nAssociateType <= 5; nAssociateType++)
  {
    oHenchman = GetAssociate(nAssociateType, oPlayer, nTh);

    if (GetIsObjectValid(oHenchman) == TRUE)
    {
      AssignCommand(oHenchman, ClearAllActions(TRUE)); // Beende alle Tätigkeiten und
      AssignCommand(oHenchman, JumpToObject(oPlayer)); // springe zum Ziel
    }
  }
}

void DelayedJumpToObject(object oPlayer, object oObject, float fDelay = 10.0)
{
  if (GetIsObjectValid(oObject) == TRUE)
  {
    DebugMode("DelayedJumpToObject-Delay: "+FloatToString(fDelay));
    if (fDelay > 0.1) {
      SendServerMessageToPC(oPlayer, "Du wirst in " +
                                     FloatToString(fDelay, 3, 0) +
                                     " Sekunden zu deinem Bestimmungsort gebracht.");
    }
    DelayCommand(fDelay, wrapobj(oPlayer, oObject));
  }

  else
    SendServerMessageToPC(oPlayer, "Du kannst leider nicht an diesen Ort gebracht werden.");
}

object GetRacialWaypoint(object oPlayer)
{
  int nRacialType = GetRacialType(oPlayer);
  object oResult; string sResult;

  switch (nRacialType)
  {
    case RACIAL_TYPE_DWARF: sResult = DWARF; break;
    case RACIAL_TYPE_ELF: sResult = ELF; break;
    case RACIAL_TYPE_GNOME: sResult = GNOME; break;
    case RACIAL_TYPE_HALFLING: sResult = HALFL; break;
    case RACIAL_TYPE_HALFELF: sResult = HLELF; break;
    case RACIAL_TYPE_HALFORC: sResult = HLORC; break;
    case RACIAL_TYPE_HUMAN: sResult = HUMAN; break;
  }

  return oResult = GetObjectByTag(sResult);
}

object GetSubRacialWaypoint(object oPlayer)
{
  string sSubrace = GetSubRace(oPlayer);
  object oResult; string sResult;

  if (sSubrace == "Duergar")     sResult = DUERG;
  if (sSubrace == "Drow")        sResult = DROW;
  if (sSubrace == "Svirfneblin") sResult = SVIRF;

  return oResult = GetObjectByTag(sResult);
}

object GetFactioalWaypoint(object oPlayer)
{
  int nLawChaos = GetAlignmentLawChaos(oPlayer);
  int nGoodEvil = GetAlignmentGoodEvil(oPlayer);
  object oResult; string sResult;

  if (nLawChaos == ALIGNMENT_CHAOTIC && nGoodEvil != ALIGNMENT_GOOD)
    sResult == CHAOTIC;
  if (nLawChaos != ALIGNMENT_CHAOTIC && nGoodEvil == ALIGNMENT_GOOD)
    sResult == LAWFUL;
  if (nLawChaos == ALIGNMENT_NEUTRAL && nGoodEvil == ALIGNMENT_NEUTRAL)
    sResult == TRUENEUTRAL;

  return oResult = GetObjectByTag(sResult);
}

