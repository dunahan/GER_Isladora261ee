//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: isla_races
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Die bestimmende Include


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////

// void main() { }      //Alibi Main

// IP Include
#include "x2_inc_itemprop"
#include "x3_inc_skin"
#include "_debugisla"

////////////////////////////////////////////////////////////////////////////////

const string ISLARACE_NORMAL = "x3_it_pchide";
const int LOAD_FACTOR = 5;

object oRacePC = GetPCSpeaker();

int   nRace = GetRacialType(oRacePC);
int    nAge = GetAge(oRacePC);
int  nLevel = GetHitDice(oRacePC);

string sRace;
string sSubRace = GetSubRace(oRacePC);
string sAge     = IntToString(nAge);
string sDeity   = GetDeity(oRacePC);

////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////

void LoadSubraceOnPC(object oPC, string subrace)
{
  object osubrace_hide = GetObjectByTag(subrace);
  object opcskin = SKIN_SupportGetSkin(oPC);

  if (GetIsObjectValid(opcskin) == FALSE) // Pruef ob Skin Existent, sonst Abbruch
  { DebugMode("LoadSubraceOnPC: Skin nicht vorhanden");
    return; }

  if (GetIsObjectValid(oPC) == FALSE) // Pruef ob Existent, sonst Abbruch
  { DebugMode("LoadSubraceOnPC: Charakter nicht gueltig");
    return; }

  if (subrace == "")                // Pruef ob Subrasse angegeben, sonst Abbruch
  { DebugMode("LoadSubraceOnPC: Subrasse nicht gueltig");
    return; }

  if (GetTag(opcskin) != ISLARACE_NORMAL) // Pruef ob die Skin die richtige ist, sonst Abbruch
  { DebugMode("LoadSubraceOnPC: Skin nicht gueltig");
    return; }

  if (GetIsObjectValid(osubrace_hide) == FALSE) // Pruef ob Rasse bekannt
  { DebugMode("LoadSubraceOnPC: Subrasse nicht vorhanden");
    return; }

  if (subrace == "Admin" && GetIsDM(oPC) )
  { IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "DungeonMaster" && GetIsDM(oPC) )
  { IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Aasimar")
  { // Ability bonus: charisma +2
    // Ability bonus: wisdom +2
    // Damage resistance: acid resist 5 / -
    // Damage resistance: cold resist 5 / -
    // Damage resistance: electrical resist 5 / -
    // Darkvision
    // Saving throw bonus: universal +2
    // Skill bonus: listen +2
    // Skill bonus: spot +2
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Drow")
  { // Ability bonus: charisma +2
    // Ability bonus: intelligence +2
    // Darkvision
    // Light sensitive.
    // Saving throw bonus: specific: will +2
    // Skill bonus: hide +2
    // Skill bonus: move silently +2
    // Spell resistance: 10 + 1 per level.
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    //CreateItemOnObject("key_drow", oPC, 1);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Duergar")
  { // Decreased ability score: charisma -2
    // Immunity: miscellaneous: paralysis
    // Immunity: miscellaneous: poison
    // Immunity: specific spell phantasmal killer
    // Immunity: specific spell weird
    // Light sensitive
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    //CreateItemOnObject("key_duergar", oPC, 1);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Erdgenasi")
  { // +2 Stärke
    // +2 Konstitution
    // -2 Weisheit
    // -2 Charisma
    // Dunkelsicht
    // +1 Rettungswurfbonus gegen Erdzauber und Erd-Effekte alle 5 Stufen
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Feuergenasi")
  { // +2 Intelligenz
    // -2 Charisma
    // Dunkelsicht
    // +1 Rettungswurfbonus gegen Feuerzauber und Feuer-Effekte alle 5 Stufen
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Luftgenasi")
  { // +2 Geschicklichkeit
    // +2 Intelligenz
    // -2 Weisheit
    // -2 Charisma
    // Dunkelsicht
    // breathless : Luft-Genasi atmen nicht und sind daher immun gegen Ersticken, Ertrinken, oder z.b. Giftgas.
    // +1 Rettungswurfbonus gegen Luftzauber und Luft-Effekte alle 5 Stufen
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Wassergenasi")
  { // +2 Konstitution
    // -2 Charisma
    // Dunkelsicht
    // Wasseratmung (unendlich lange, egal ob Salz- oder Süßwasser)
    // +1 Rettungswurfbonus gegen Wasserzauber und Wasser-Effekte alle 5 Stufen
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }


  if (subrace == "Goldzwerg")
  { // -2 Geschicklichkeit
    // +1 Angriffswurfbonus gegen Aberrationen (gegen die vielen seltsamen Kreaturen des Unterreichs)
    // Dunkelsicht
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Leichtfuss")
  { // Nothing now to add
    return;
  }

  if (subrace == "Steingnom")
  { // Nothing now to add
    return;
  }

  if (subrace == "Starkherz")
  { // Nothing now to add
    return;
  }

  if (subrace == "Svirfneblin")
  { // Ability bonus: dexterity +2
    // Ability bonus: wisdom +2
    // Bonus feat: dodge
    // Darkvision
    // Decreased ability score: charisma -4
    // Light sensitive.
    // Saving throw bonus: universal +2
    // Skill bonus: search +2
    // Spell resistance: 10 + 1 per level.
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    //CreateItemOnObject("key_svirfneblin", oPC, 1);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Tiefling")
  { // Ability bonus: dexterity +2
    // Ability bonus: intelligence +2
    // Decreased ability score: charisma -2
    // Damage resistance: acid resist 5 / -
    // Damage resistance: cold resist 5 / -
    // Damage resistance: electrical resist 5 / -
    // Darkvision
    // Saving throw bonus: universal +2
    // Skill bonus: bluff +2
    // Skill bonus: hide +2
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

  if (subrace == "Waldelf")
  { // Ability bonus: strength +2
    // Decreased ability score: charisma -2
    // Decreased ability score: intelligence -2
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode("LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }

/*  if (subrace == "Zwerg")
  { // Feat-Bonus: Umgang mit exotischen Waffen
    IPCopyItemProperties(osubrace_hide, opcskin, TRUE);
    DebugMode(oPC, "LoadSubraceOnPC: Skin wird beschrieben");
    return;
  }*/

  // Some other to go!
}

void SubraceOnClientEnter(object oPC = OBJECT_INVALID)
{
  if(!GetIsObjectValid(oPC))
  { oPC = GetEnteringObject(); }

  if(!GetIsPC(oPC))
  { DebugMode("SubraceOnClientEnter: Kein Spielercharakter");
    return; }

  string subrace = GetSubRace(oPC);

  if(subrace == "")
  { DebugMode("SubraceOnClientEnter: Subrasse nicht gueltig");
    return; }

  object oArea = GetArea(oPC);
  if(!GetIsObjectValid(oArea))
  {
    // Warte, das der Spieler entgueltig eingeloggt ist.
    DelayCommand(2.0*LOAD_FACTOR, SubraceOnClientEnter(oPC));
    return;
  }

  DelayCommand(1.0*LOAD_FACTOR, LoadSubraceOnPC(oPC, subrace));

}


