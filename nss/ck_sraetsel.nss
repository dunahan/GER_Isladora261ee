/*Konfiguration
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
*/

#include "_ck_sraetsel_inc"

void main()
{
  // 1++ Vorab Deklerationen der Variablen
  // 1.1 Lese die ausgewürfelten Wörter aus, welche auf der Schatzkiste liegen
  object oChest = GetObjectByTag(CK_CHEST);

  // 1.1.1 Sicherheitsabfrage ob die Kiste existiert
  if (GetIsObjectValid(oChest) == FALSE)
  {
    WriteTimestampedLogEntry("ACHTUNG: Kiste fehlt für Skript");
    return;
  }

  // 1.1.2 Sicherheitsabfrage ob das Objekt mit dem Skript existiert
  if (GetIsObjectValid(OBJECT_SELF) == FALSE)
  {
    WriteTimestampedLogEntry("ACHTUNG: Objekt mit Skript fehlt");
    return;
  }

  // 1.1.3 Lese nun die Rätselwörter aus
  string sRiddleOne   = GetLocalString(oChest, "Raetsel001");   // Erstes Wort, das gesucht wird
  string sRiddleTwo   = GetLocalString(oChest, "Raetsel002");   // Zweites Wort, das gesucht wird
  string sRiddleThree = GetLocalString(oChest, "Raetsel003");   // Drittes Wort, das gesucht wird

  // 1.2 Entsprechend zum Lösungswort eine Lösungshilfe erstellen
  string sHintOne     = ck_get_description(sRiddleOne);         // Erster Lösungsansatz
  string sHintTwo     = ck_get_description(sRiddleTwo);         // Zweiter Lösungsansatz
  string sHintThree   = ck_get_description(sRiddleThree);       // Dritter Lösungsansatz

  // 1.3 Würfle auf 1-3 aus, was nachher bestimmt wo das Monster zufällig auftauchen wird
  string sDice = IntToString( d3() );


  // 2++ Ablauf des Skriptes
  // 2.1 Erfasse den Tag des Objektes, welches das Skript inne hat
  string sTag = GetTag(OBJECT_SELF);

  // 2.2 Deklariere weitere notwendige Variablen
  object oPC, oPlate;
  string sLetter, sRead;
  string ck_scrolldescript, ck_message;
  int nStatus;

  // 2.3 Prüf ab, ist es der Auslöser
       if (sTag == CK_TRIGGER)
  {
    // 2.3.1 Erfasse die betretende Figur
    oPC     = GetEnteringObject();

    // 2.3.2 Erfasse das naheliegenste Placeable
    oPlate  = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, GetLocation(oPC));

    // 2.3.3 Erfasse das letzte Zeichen des Tags dieses Placeables, damit den entsprechend berührten Buchstaben
    sLetter = GetStringRight(GetTag(oPlate), 1);

    // 2.3.4 Lege den Buchstaben auf das Lösungswort des Spielers ab, ggf. füge zusammen
    SetLocalString(oPC, "ck_raetselwort", GetLocalString(oPC, "ck_raetselwort") + sLetter);
  }


  // 2.4 Prüf ab, ist es die Kiste
  else if (sTag == CK_CHEST)
  {
    // 2.4.1 Erfasse die Figur, die sie als letzte öffnete
    oPC = GetLastOpenedBy();

    // 2.4.2 Prüf ab, wurde die Kiste von ihm das letzte mal geöffnet
    if (GetLocalInt(oPC, "ck_chest_is_open") == 1)
    {
      // 2.4.2.1 Melde, die Kiste wurde von ihm geschlossen
      SetLocalInt(oPC, "ck_chest_is_open", 0);

      // 2.4.2.2 Leere die Kiste
      ck_del_inv(oChest);
    }

    // 2.5.1 Die Kiste ist bisher nicht von ihm geöffnet gewesen
    else
    {
      // 2.5.2 Markiere den Spieler als Kistenöffner
      SetLocalInt(oPC, "ck_chest_is_open", 1);

      // 2.4.3.2 Lese das Lösungswort aus
      sRead = GetLocalString(oPC, "ck_raetselwort");

      // 2.5.3 Prüf ab, ist es bereits vorhanden, wenn Nein, vergib einen Extra Wert
      if (sRead == "")
        sRead = "Unbekannt";

      // 2.5.4 Lese den Lösungssatz zum ersten Rätselwort aus
      ck_scrolldescript = sHintOne;

      // 2.5.5 Vergebe den bisherigen Rätselstatus? Wieso, wird nirgends abgefragt!!!
      ck_message = "";

      // 2.5.6 Switch Anweisung nach Stand des Rätselnden
      int nStatus = GetLocalInt(oPC, "ck_status");
      switch (nStatus)
      {
        // 2.6.1 Der Spieler hat erfolgreich das erste Rätsel gelöst
        case 1:
          if (sRead == sRiddleOne)
          {
            SetLocalInt(oPC, "ck_status", 2);  // Setze den Status auf 2, Rätsel 2 beginnt
            ck_scrolldescript = sHintTwo;      // Setze die Beschreibung auf das Rätsel 2
            ck_message = CK_STATUS_TRUE;       // Gebe aus, das die Lösung zum Rätsel 1 korrekt war
            break;                             // Beende hier die Abfrage
          }

          // 2.6.1.1 Der Spieler hat falsch gelegen und suchte nach einem weiteren Rätsel
          else
          {
            // Erschaffe das Monster, das den Spieler bestrafen wird
            CreateObject(1, CK_MONSTER, GetLocation(GetObjectByTag(CK_SPWNMON+sDice)), 0);
            ck_message = CK_STATUS_FALSE;      // Gebe aus, das die Lösung falsch war
            break;                             // Beende hier die Abfrage
          }

        // 2.6.2 Der Spieler hat erfolgreich das zweite Rätsel gelöst
        case 2:
          if (sRead == sRiddleTwo)
          {
            SetLocalInt(oPC, "ck_status", 3);  // Setze den Status auf 3, Rätsel drei beginnt
            ck_scrolldescript = sHintThree;    // Setze die Beschreibung auf das Rätsel 3
            ck_message = CK_STATUS_TRUE;       // Gebe aus, das die Lösung zum Rätsel 2 korrekt war
            break;                             // Beende hier die Abfrage
          }

          // 2.6.2.1 Der Spieler hat falsch gelegen und suchte nach einem neuen Rätsel
          else
          {
            SetLocalInt(oPC, "ck_status", 2);  // Der Spieler fällt automatisch auf den Status 2 zurück
            ck_scrolldescript = sHintTwo;      // Setze die Beschreibung auf das Rätsel 2 zurück
            ck_message = CK_STATUS_FALSE;      // Gebe aus, das die Lösung falsch war

            // Erschaffe das Monster, das den Spieler bestrafen wird
            CreateObject(1, CK_MONSTER, GetLocation(GetObjectByTag(CK_SPWNMON+sDice)), 0);
            break;                             // Beende hier die Abfrage
          }

        // 2.6.3 Der Spieler hat erfolgreich das dritte Rätsel gelöst
        case 3:
          if (sRead == sRiddleThree)
          {
            ck_scrolldescript = sHintOne;      // Setze die Beschreibung auf das erste Rätsel zurück
            ck_message = "Gewonnen!";          // Vermerke, der Spieler hat gewonnen
            SetLocalInt(oPC, "ck_status", 0);  // Setze den Status des Spielers auf Rätsel 1
            ck_create_loot(oPC);               // Erschaffe nun die Belohnung
            break;                             // Beende hier die Abfrage
          }

          // 2.6.3.1 Der Spieler hat falsch gelegen und suchte nach der Belohnung
          else
          {
            // Erschaffe das Monster, das den Spieler bestrafen wird
            CreateObject(1, CK_MONSTER, GetLocation(GetObjectByTag(CK_SPWNMON+sDice)), 0);

            SetLocalInt(oPC, "ck_status", 3);  // Der Spieler fällt automatisch auf den Status 3 zurück
            ck_scrolldescript = sHintThree;    // Setze die Beschreibung auf das Rätsel 3 zurück
            ck_message = CK_STATUS_FALSE;      // Gebe aus, das die Lösung falsch war
            break;                             // Beende hier die Abfrage
          }

        // 2.6.4 Standard-Handlung, sollte etwas mal daneben gehen
        default:
        {
          // 2.6.4.1 Erschaffe die Schriftrolle und versehe sie mit dem entsprechenden Hinweis
          // CreateItemOnObject(CK_SCROLL, GetObjectByTag(CK_CHEST), 1, "ck_lootscroll"); // mom ausgegraut, ggf. wg. Doppel-Erschaffung?
          // SetDescription(GetObjectByTag("ck_lootscroll"), sHintOne ,TRUE);             // mom ausgegraut, ggf. wg. Doppel-Erschaffung?
          SetLocalInt(oPC, "ck_status", 1);  // Der Spieler wird in den Status 1 gesetzt

          WriteTimestampedLogEntry("Standart Sequenz des Skripts ck_sraetsel.");
          break;                             // Beende hier die Abfrage
        }
    }
    // 2.6.1 Der Spieler beendete ein Rätsel erfolgreich, so
    SetLocalString(oPC, "ck_raetselwort", ""); string sStatus = IntToString(nStatus);    // lösche das Rätselwort und wandle den Status um,
    CreateItemOnObject(CK_SCROLL, GetObjectByTag(CK_CHEST), 1, "ck_lootscroll"+sStatus); // erschaffe eine neue Rolle
    SetDescription(GetObjectByTag("ck_lootscroll"+sStatus), ck_scrolldescript ,TRUE);    // und setze deren Beschreibung entsprechend des Status'
    }
  }
}

