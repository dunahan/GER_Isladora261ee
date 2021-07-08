#include "NW_O2_CONINCLUDE"
#include "x2_inc_itemprop"
#include "_debugisla"

//Konfiguration
//Tags
const string CK_TRIGGER  = "ck_trig_raetsel";  // Der Tag des Auslösers
const string CK_PLATES   = "ck_platte_";       // Tag ohne Buchstabe, mit X anhängen.
const string CK_CHEST    = "ck_pcod";          // Tag der Truhe
const string CK_SCROLL   = "ck_iscroll";       // Tag der Schriftrolle
const string CK_MONSTER  = "crea_hund_beisse"; // ResRef des Tierchens
const string CK_SPWNMON  = "ck_beisser_0";     // Spawnbezeichner
const string CK_LOOTITEM = "ck_loot";          // Der besondere Loot!

//Lösungssätze
const string CK_STATUS_TRUE  = " ist richtig";
const string CK_STATUS_FALSE = " ist falsch";

//Vorab Deklerationen um das Lesen zu vereinfachen, die Details folgen nach

// 1.1 Um den Lösungsansatz für die Schriftrolle zu erhalten
string ck_get_description(string sRaetselwort);

// 1.2 Um den Schatz zufallsbedingt zu erschaffen und mit Eigenschaften zu versehen
void ck_create_loot(object oToCreateIn);

// 1.3 Um das Inventory zu leeren
void ck_del_inv(object oInvOwner);

string ck_random_raetselwort()
{
  int n = Random(8);

  switch (n) {
    case 0: return "vielleicht"; break;
    case 1: return "loch"; break;
    case 2: return "kaese"; break;
    case 3: return "tee"; break;
    case 4: return "fach"; break;
    case 5: return "fels"; break;
    case 6: return "heiss"; break;
    case 7: return "nacht"; break;
    case 8: return "feist"; break;
    default: return "Fehler"; break;
  }

  return "Fehler";
}

string ck_get_description(string sRaetselwort)
{
  // 1.1.1 Deklariere die Lösungsvariable. Vorab Warnung einfügen, falls etwas schief geht
  string sResult = "Fehler im System!";

  // 1.1.2 Folgend nun, prüfe ab ob das Rätselwort gegeben ist und erfasse die Lösung
  if (sRaetselwort == "vielleicht")
    sResult = "Mein Erstes ist nicht wenig, mein Zweites ist nicht schwer, gemeinsam lässts dich hoffen, doch hoffe nicht zu sehr!";
  if (sRaetselwort == "loch")
    sResult = "Es hat keine Farbe, trotzdem kann man es sehen. Es wiegt nichts, aber jeder Gegenstand wird damit leichter. Was ist das?";
  if (sRaetselwort == "kaese")
    sResult = "Wer kann ohne Nase riechen?";

  if (sRaetselwort == "tee")
    sResult = "Ich muss auf dem Weg zur Vollkommenheit dringend minutenlang gezogen werden. Was bin ich?";
  if (sRaetselwort == "fach")
    sResult = "Ich liege zwischen zwei Brettern und zweien, die mich umgeben. Was bin ich?";
  if (sRaetselwort == "fels")
    sResult = "Ich bin Beständig und stark, doch schwächt mich manch einfacher Tropfen. Was bin ich?";
  if (sRaetselwort == "heiss")
    sResult = "Manchmal bin ich ein Anzeichen von Gefahr und manchmal bin ich Lebensnotwendig. Was bin ich?";
  if (sRaetselwort == "nacht")
    sResult = "Ich bestehe nur wenige Stunden und dann braucht man Hilfe um seinen Weg zu finden. Was bin ich?";
  if (sRaetselwort == "feist")
    sResult = "Ich bin ein Begriff, vor dessen sich jeder unangenehmer gewichtiger Geselle fürchtet! Wie heisse ich?";

  /* Für weitere Rätsellösungen, diese entsprechend einfügen:
  if (Raetselwort == "loesung")
    sResult = "Raetselfrage";
  */

  // 1.1.3 Gebe die Lösung aus
  return sResult;
}


void ck_create_loot(object oPlayer)
{
  // 1.2.1 Prüf ab, ob die Bezugsperson bereits das Item besitzt.
  if (GetIsObjectValid(GetItemPossessedBy(oPlayer, CK_LOOTITEM)) == TRUE)
  {
    // 1.2.1.1 Teile dem Spieler mit, dass er bereits den Schatz in Händen hält und somit keine Chance hat, einen weiteren zu erhalten
    SendServerMessageToPC(oPlayer, "Du besitzt bereits diesen Schatz, somit kannst Du keinen weiteren erhalten!");
    // 1.2.1.2 Brich die Funktion ab
    return;
  }

  // 1.2.2 Erfasse notwendige Variablen
  int nClassToUse = nDetermineClassToUse(oPlayer);     // Erfasse die Klasse des Chars, die genutzt werden soll
  object    oBox  = GetObjectByTag(CK_CHEST);          // Erfasse die "Schatzkiste"
  object    oLoot = CreateItemOnObject(CK_LOOTITEM, oBox, 1); // Erschaffe den "Schatz"

  // 1.2.3 Deklariere weitere notwendige Variablen
  itemproperty ip001, ip002, ip003;

  // 1.2.4 Bestimme die Eigenschaften, die vergeben werden sollen
  switch (nClassToUse) {

    case 0:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Barbar
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_MOBILITY);      // Mobilität
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 1:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Barde
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);  // +3 auf Charisma
             ip003 = ItemPropertySkillBonus(SKILL_PERFORM, 3);           // +3 auf Auftreten
    break;

    case 2:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Kleriker
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);  // +3 auf Weisheit
             ip003 = ItemPropertySkillBonus(SKILL_CONCENTRATION, 3);     // +3 auf Konzentration
    break;

    case 3:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Druide
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);  // +3 auf Weisheit
             ip003 = ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY, 3);    // +3 auf Tiere beeinflussen
    break;

    case 4:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Kämpfer
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_AMBIDEXTROUS);  // Beidhändigkeit
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 5:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Mönch
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_ALERTNESS);     // Wachsamkeit
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 6:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Paladin
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_COMBAT_CASTING);// Im Kampf zaubern
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 7:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Waldläufer
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);  // +3 auf Weisheit
             ip003 = ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY, 3);    // +3 auf Disziplin
    break;

    case 8:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Schurke
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);  // +3 auf Geschicklichkeit
             ip003 = ItemPropertySkillBonus(SKILL_DISABLE_TRAP, 3);      // +3 auf Falle entschaerfen
    break;

    case 9:  ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Hexenmeister
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);  // +3 auf Charisma
             ip003 = ItemPropertySkillBonus(SKILL_CONCENTRATION, 3);     // +3 auf Konzentration
    break;

    case 10: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Magier
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 3);  // +3 auf Intelligenz
             ip003 = ItemPropertySkillBonus(SKILL_SPELLCRAFT, 3);        // +3 auf Zauberkunst
    break;

    case 27: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Schattentänzer
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);  // +3 auf Geschicklichkeit
             ip003 = ItemPropertySkillBonus(SKILL_HIDE, 3);              // +3 auf Verstecken
    break;

    case 28: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Harfner
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);  // +3 auf Weisheit
             ip003 = ItemPropertySkillBonus(SKILL_SPOT, 3);              // +3 auf Entdecken
    break;

    case 29: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Arkaner Bogenschütze
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_POINTBLANK);    // Bonusfeat Point Blank Shot?
             ip003 = ItemPropertySkillBonus(SKILL_SPOT, 3);              // +3 auf Entdecken
    break;

    case 30: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Assassine
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);  // +3 auf Geschicklichkeit
             ip003 = ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 3);     // +3 auf Leise bewegen
    break;

    case 31: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Finsterer Streiter
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);  // +3 auf Charisma
             ip003 = ItemPropertySkillBonus(SKILL_TAUNT, 3);             // +3 auf Taunt?
    break;

    case 32: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Vorkämpfer der Götter
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);  // +3 auf Charisma
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 33: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Waffenmeister
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_AMBIDEXTROUS);  // Beidhaendigkeit
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 34: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Bleicher Meister
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 3);  // +3 auf Intelligenz
             ip003 = ItemPropertySkillBonus(SKILL_CONCENTRATION, 3);     // +3 auf Konzentration
    break;

    case 35: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Wahrer Wandler
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);  // +3 auf Weisheit
             ip003 = ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY, 3);    // +3 auf Tiere beeinflussen
    break;

    case 36: ip001 = ItemPropertyLimitUseByClass(nClassToUse);                 // Nur Zwergischer Verteidiger
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_EXOTIC);  // Waffen (Exotisch)
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);              // +3 auf Disziplin
    break;

    case 37: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Drachendisziplin
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 3);  // +3 auf Intelligenz
             ip003 = ItemPropertySkillBonus(SKILL_SPELLCRAFT, 3);        // +3 auf Zauberkunst
    break;

    case 39: ip001 = ItemPropertyLimitUseByClass(nClassToUse);                 // Nur Auge des Gruumsh
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_EXOTIC);  // Waffen (Exotisch)
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);              // +3 auf Disziplin
    break;

    case 40: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Shou Disziplin
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);  // +3 auf Geschicklichkeit
             ip003 = ItemPropertySkillBonus(SKILL_PARRY, 3);             // +3 auf Parieren
    break;

    case 41: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Ritter des Purpurdrachen
             ip002 = ItemPropertyBonusFeat(IP_CONST_FEAT_ALERTNESS);     // Wachsamkeit
             ip003 = ItemPropertySkillBonus(SKILL_DISCIPLINE, 3);        // +3 auf Disziplin
    break;

    case 42: ip001 = ItemPropertyLimitUseByClass(nClassToUse);           // Nur Nachtschatten
             ip002 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);  // +3 auf Geschicklichkeit
             ip003 = ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 3);     // +3 auf Leise bewegen
    break;
  }

  // 1.2.5 Wende die Eigenschaften auf das Item an
  IPSafeAddItemProperty(oLoot, ip001);   // Auf Item anwenden
  IPSafeAddItemProperty(oLoot, ip002);   // Auf Item anwenden
  IPSafeAddItemProperty(oLoot, ip003);   // Auf Item anwenden

}

void ck_del_inv (object oInvOwner)
{
  object oDel = GetFirstItemInInventory(oInvOwner);

  while (GetIsObjectValid(oDel))
  {
    DestroyObject(oDel);
    oDel = GetNextItemInInventory();
  }
}

//void main() { }
