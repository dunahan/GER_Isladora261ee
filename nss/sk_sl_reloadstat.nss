//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_reloadstat
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools für Isladora



*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"
#include "_isla_inc"

int StartingConditional()
{ string sUser = GetPCPlayerName(oSpeaker);

  // Wurde eine XP-Strafe gesetzt?
  object oItem = GetItemPossessedBy(oSpeakTarg, "itm_questbuch");
  int nRestricted = GetLocalInt(oItem, "Restricted");
  if (nRestricted == 1) { SetCustomToken(82060, "An"); SetCustomToken(82061, "Ausschalten"); }
  else                  { SetCustomToken(82060, "Aus"); SetCustomToken(82061, "Anschalten"); }

  // ECL auslesen
  int nECL = GetLocalInt(oItem, "ECL");
  switch (nECL)
  { case 0: SetCustomToken(82070, "kein ECL vergeben."); break;
    case 1: SetCustomToken(82070, "5% ECL vergeben.");   break;
    case 2: SetCustomToken(82070, "10% ECL vergeben.");  break;
    case 3: SetCustomToken(82070, "15% ECL vergeben.");  break; }

  // Aktivierung/Deaktivierung auslesen
  string sPlayerName = GetPCPlayerName(oSpeakTarg); string sPlayerCDKey = GetPCPublicCDKey(oSpeakTarg); // Lese Daten aus
  string sTemporList = AddTokenToString(sPlayerCDKey, sPlayerName, "_");  // Bilde den Namen daraus, zB dunahan_VDKTVEQQ

  if ( GetIsTokenInString(sTemporList, GetCampaignString("PlayerDB", "PlayerList")) )
       { SetCustomToken(82080, "ist der Spieler in der Liste."); }
  else { SetCustomToken(82080, "ist der Spieler nicht in der Liste."); }

  int nTokenNumber = GetLocalInt(oSpeaker, "PlayerToEdit");
  if (nTokenNumber <= 0) nTokenNumber = 1;
  SetCustomToken(82081, GetTokenFromString(nTokenNumber, GetCampaignString("PlayerDB", "PlayerList")));

  // Standardeinstellungen
  int nInt1       = GetLocalInt(oSpeaker, "Int1");       SetCustomToken(82001, IntToString(nInt1));
  int nInt2       = GetLocalInt(oSpeaker, "Int2");       SetCustomToken(82002, IntToString(nInt2));
  int nInt3       = GetLocalInt(oSpeaker, "Int3");       SetCustomToken(82003, IntToString(nInt3));
  int nInt4       = GetLocalInt(oSpeaker, "Int4");       SetCustomToken(82004, IntToString(nInt4));
  string sString1 = GetLocalString(oSpeaker, "String1"); SetCustomToken(82005, sString1);
  float fFloat1   = GetLocalFloat(oSpeaker, "Float1");   SetCustomToken(82006, FloatToString(fFloat1,1,1));

  // Stufe beeinflussen
  int    nFstClass = GetClassByPosition(1, oSpeakTarg); int nSndClass = GetClassByPosition(2, oSpeakTarg);   int nTrdClass = GetClassByPosition(3, oSpeakTarg);
  string sFstClass = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nFstClass))) + "(" + IntToString(nFstClass) + ")";
  string sSndClass = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nSndClass))) + "(" + IntToString(nSndClass) + ")";
  string sTrdClass = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nTrdClass))) + "(" + IntToString(nTrdClass) + ")";
  string sInt1     = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nInt1)));

  SetCustomToken(82023, sFstClass); SetCustomToken(82024, IntToString(GetLevelByPosition(1, oSpeakTarg))); // Klasse & Stufe 1
  SetCustomToken(82025, sSndClass); SetCustomToken(82026, IntToString(GetLevelByPosition(2, oSpeakTarg))); // Klasse & Stufe 2
  SetCustomToken(82027, sTrdClass); SetCustomToken(82028, IntToString(GetLevelByPosition(3, oSpeakTarg))); // Klasse & Stufe 3
  SetCustomToken(82029, sInt1); // Momentane Int umwandeln

  // KI beeinflussen
  int nAiLvl = GetAILevel(oSpeakTarg); string sAiLvl; string sIntAI;
  switch (nAiLvl) { case 0: sAiLvl = "Sehr niedrig (0)"; break; case 1: sAiLvl = "Niedrig (1)"; break; case 2: sAiLvl = "Normal (2)"; break; case 3: sAiLvl = "Hoch (3)"; break;  case 4: sAiLvl = "Sehr hoch (4)"; break; default: sAiLvl = "Standard (255)"; break; }
  switch (nInt1)  { case 0: sIntAI = "Sehr niedrig (0)"; break; case 1: sIntAI = "Niedrig (1)"; break; case 2: sIntAI = "Normal (2)"; break; case 3: sIntAI = "Hoch (3)"; break;  case 4: sIntAI = "Sehr hoch (4)"; break; default: sIntAI = "Standard (255)"; break; }
  SetCustomToken(82030, sAiLvl); SetCustomToken(82031, sIntAI);

  // Objekt speichern
  string sStored = GetLocalString(oSpeaker, "Stored");
  SetCustomToken(82040, sStored);

  // Fraktionen
  string sFaction;
  switch (nInt1)  { case 0: sFaction = "Feindlich (0)"; break; case 1: sFaction = "Bürgerlicher (1)"; break; case 2: sFaction = "Händler (2)"; break; case 3: sFaction = "Verteidiger (3)"; break; default: sFaction = "Unbekannt (255)"; break; } //case 4: sFaction = "Tiere (4)"; break; case 5: sFaction = "Absolut Neutral (5)"; break; case 6: sFaction = "CNR Tiere (6)"; break; case 7: sFaction = "Questgeber (7)"; break; }
  SetCustomToken(82050, sFaction);

  // Item verbessern
  int nItemProp = StringToInt(Get2DAString("ItemPropDef", "Name", nInt1));
  int nSubTypeO = StringToInt(Get2DAString(Get2DAString("ItemPropDef", "SubTypeResRef", nInt2), "Name", nInt2));
  int nSubTypeT = StringToInt(Get2DAString(Get2DAString("ItemPropDef", "SubTypeResRef", nInt3), "Name", nInt3));
  int nSubTypeF = StringToInt(Get2DAString(Get2DAString("ItemPropDef", "SubTypeResRef", nInt4), "Name", nInt4));
  string sTable = Get2DAString("itempropdef", "CostTableResRef", nInt1);
  itemproperty ipCost = IPGetItemPropertyByID(nInt1, nInt2, nInt3, nInt4);
  string sCostV = Get2DAString(sTable, "Name", GetItemPropertyCostTableValue(ipCost) );


  string sItemProp = GetStringByStrRef(nItemProp); string sSubTypeO = GetStringByStrRef(nSubTypeO);
  string sSubTypeT = GetStringByStrRef(nSubTypeT); string sSubTypeF = GetStringByStrRef(nSubTypeF);

  if (sItemProp!="Bad Strref")
  { SetCustomToken(82015, sItemProp + " (" + sCostV +" GM)" );  SetCustomToken(82016, sSubTypeO);  SetCustomToken(82017, sSubTypeT);  SetCustomToken(82018, sSubTypeF); }
  else { SetCustomToken(82015, "Unbekannt");  SetCustomToken(82016, "Unbekannt");  SetCustomToken(82017, "Unbekannt");  SetCustomToken(82018, "Unbekannt"); }


  string sVFX = Get2DAString("visualeffects", "Label", nInt1);
  SetCustomToken(82019, sVFX);

  object oArea = GetArea(oSpeaker);
  int nCLEAR = GetLocalInt(oArea, "DeadMagic");
  SetCustomToken(82025, GetName(oArea));
  switch (nCLEAR) { case 0:  SetCustomToken(82026, "nicht aktiv"); SetCustomToken(82027, "erschaffen"); break;
                    case 1:  SetCustomToken(82026, "aktiv");       SetCustomToken(82027, "zerstören");  break;
                    default: SetCustomToken(82026, "unbekannt");   SetCustomToken(82027, "unbekannt");  break; }


  return TRUE;
}
