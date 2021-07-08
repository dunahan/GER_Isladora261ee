//::///////////////////////////////////////////////
//:: RP EP fuer Gesrochenes
//:: mod_player_chat
//:: Copyright (c) 2013 Dunahan.
//:://////////////////////////////////////////////
/*
    Player Chat Script
    Version 1.4
    * Ordnung ver�ndert und weiter verbessert
    * Lesbarkeit ver�ndert und weiter verbessert
    * Gold-Belohnung eingef�gt
    * Flexibilit�t bei der Vergabe der EP vergr�ssert
    * DebugModus f�r Sprecher eingef�gt
    * Zusammenhang mit AFK-Skript hergestellt
    * Chatfarben umgesetzt
    * Speicherung der Daten in eine Ini-Datei. Langsames Ersetzen aller DB gg. Ini-Files

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 25.10.2010
//:: Modified On: 07.05.2016
//:://////////////////////////////////////////////
#include "colors_inc"
#include "ll_include"
#include "_debugisla"
#include "_tokenizer_inc"

  // 1++  Grundlagen erfassen
  // 1.1 Standardeinstellungen definieren

  /* nEnable definiert ob das System generell an ist.
     1 aktiviert, 0 deaktiviert. */
  const int nEnable        =       1;

  /* Hier kann man ein Skript vorgeben, welches ausgef�hrt wird, wenn es sich beim Sprecher um einen DM handelt.
     "" bedeutet kein Skript ausf�hren und die Funktion wird �bergangen */
  const string DM_SCRIPT   = "";

  /* nSaveToDB definiert ob das System die gesammelten EP auch persistent Speichern soll.
     1 aktiviert, 0 deaktiviert. */
  const int nSaveToDB      =       1;

  /* Hier wird die Datenbank definiert in die das System die EP persistent speichern soll*/
  const string RP_EP       = "RP_EP_";  // Vorangehendes Zeichen des Systems
  const string RP_DATABASE = "RP_EP";   // Name der Datenbank
  const string PC_DATABASE = "PlayerDB";// Name der Spielerdatenbank

  /* die folgenden Delays definieren mit welcher Zeitverschiebung das System die EP vergeben soll. */
  const float fDelayDB     =    10.0;   //   10 Sekunden bis EP Vergabe durch die Datenbankspeicherung
  const float fDelayNonDB  =   900.0;   //  900 Sekunden bis EP Vergabe durch normales System, ohne persistente Speicherung
  const float fDelayResCht =  1800.0;   // 1800 Sekunden bis das Chat-System die Aktiv-Flagge l�scht

  /* nToGive definiert ab welcher gesammelter EP-Anzahl das System aussch�ttet soll. */
  const int nToGive        =      25;

  /* nPerDay definiert die H�chstgrenze der ausgesch�tteten EP-Anzahl des Systems die der SC maximal erhalten kann. */
  const int nPerDay        =   60000;

  /* nEXPAmount definiert die pro Zeichen vergebenen EP's des Systems.
     F�r jeden gez�hlten Buchstaben werden im Standardfalle 1 EP berechnet. */
  const int nEXPAmount     =       1;

  /* nEXPFactor definiert ob das System die zu vergebenen EP noch weiter beeinflussen soll.
     F�r jeden gez�hlten Buchstaben werden (Anzahl Buchstaben durch EP-Faktor mal die zu vergebenen EP) berechnet.
     Dh bei 100 Buchstaben, einem Faktor von 50 und einem EP Wert von 1 entspricht das nachher 50 EP, die der SC erh�lt. */
  const int nEXPFactor     =      25;

  /* nNeededPlayers gibt an, wieviele Spieler notwendig sind um EP zu bekommen.
     0 = kein weiterer Spieler notwendig um EP zu bekommen,
     1 = mindestens einen Spieler zus�tzlich zum Sprecher. */
  const int nNeededPlayers =       1;

  /* nEXPBonus definiert den Bonus pro weiteren anwesenden SC den das System vergeben soll.
     Hierbei rechnet das System den Bonus f�r Anwesende PC nach (Anzahl Buchstaben durch Bonus-Faktor mal Anzahl der gez�hlten SC's).
     Dh bei 50 Buchstaben, einem Faktor von 20 und 2 anwesenden SC entspricht das nachher 5 EP, die der SC zus�tzlich erh�lt. */
  const int nEXPBonus      =       5;

  /* nGoldFactor definiert die Prozentzahl an Gold-Bonus den das System vergeben soll.
     Bonus fr Gold berechnen, dh (Anzahl der auszuschenkenden EP durch Gold-Faktor)
     Dh bei 50 EP und einem Faktor von 20 entspricht das nachher 5 GP, die der SC ebenfalls als Bonus erh�lt. */
  const int nGoldFactor    =      35;

  string ColorChatting(object oPC, string sChat);

void main()
{
  // 1.2 Spieler und dessen Nachricht erfassen, bestimme dazu den Channel
  object oPC      = GetPCChatSpeaker();      // der Sprecher
  string sChat    = GetPCChatMessage();      // die Nachricht
  string sColored;                           // die Nachricht ggf. gefaerbt
  int nChatVolume = GetPCChatVolume();       // der Channel

  // 1.3 Bilde die ID des Spielers, suche den Modulspeicher
  string sID = GetStringLeft(GetName(oPC), 5)+"_"+GetStringLeft(GetPCPlayerName(oPC), 5);
  object oModule = GetModule();              // das Modul
  int nLocalRP = GetLocalInt(oModule, sID);  // Variable auf Modul zur ID auslesen

  // 1.4.2 Pr�fen, ob der Sprecher ein SL ist. Wenn ja, dann f�hre ein ggf. vorgegebenes Skript aus und beende dieses hier
  if ( GetIsDM ( oPC ) && FindSubString(sChat, "[RS]"))
  {
    // 1.4.2.1 Pr�fe ab, ob �berhaupt ein Skript abgelegt wurde, wenn ja f�hre es aus, ansonsten fahre normal fort
    if ( DM_SCRIPT != "" )
    {
      DebugMode("Es wird das Skript "+DM_SCRIPT+" ausgef�hrt, da ein DM sprach.");

      // 2.2.2.2 F�hre das vordefinierte Skript aus
      ExecuteScript( DM_SCRIPT, oPC );
    }

    SendServerMessageToPC(oPC, "Vordefiniertes Skript.");

    return;
  }

  if ( GetStringLeft ( sChat, 2 ) == "#!" )                                     // Ausnahme wg. Tinks Kommandos!
    return;

  if (GetTag(GetArea(oPC)) == "CR_Pfandleiher")                                 // Ausnahme wg. Bank. Keine EP/Farben usw!
    return;

  // 1.4.3 Markiert den Spieler als "Sprechend" womit dem AFK-System klar mitgeteilt
  // wird, das der Spieler aktiv am Serverleben teil nimmt. Nach 10 Min wird diese
  // Flagge wieder gelscht. Dies geschieht nur, wenn die Flagge nicht bereits
  // existiert. => AFK-Override-Skript!
  if ( GetLocalInt( oPC, "Chats" ) == 0 )
  {
    DebugMode("Der Spieler Chattete etwas, somit vermerke ihn als Aktiv am Spiel teilnehmend.");

    SetLocalInt( oPC, "Chats", 1 );
    DelayCommand( fDelayResCht, SetLocalInt( oPC, "Chats", 0 ) );
  }

  // 2++ Pr�fungen vor Ausf�hrung des Skripts
  // 2.1 Pr�f ob das Skript �berhaupt als Aktiv geschaltet ist. Wenn Nein, Abbruch!
  if ( nEnable != 1 )
  {
    DebugMode("RP-EP-Skript nicht aktiv geschaltet, keine Auswertung von gesprochenem m�glich.");

    sColored = ColorChatting(oPC, sChat);
    SetPCChatMessage(sColored);
    return;
  }

  // 2.2.1 Pr�fen, ob PC existiert. Fehlt dieser, Skript abbrechen.
  if ( !GetIsPC ( oPC ) )
    return;

  // 2.3 Pr�fen, ob die EP Grenze erreicht, ansonsten im Debug Ausgeben und Abbrechen
  if ( nLocalRP >= nPerDay )
  {
    DebugMode("Tagesgrenze an RP EP f�r " + GetName(oPC) + " erreicht.");

    sColored = ColorChatting(oPC, sChat);
    SetPCChatMessage(sColored);
    return;
  }

  // 2.4 Pr�fen, ob in einem OOC Raum, ansonsten im Debug Ausgeben und Abbrechen
  if ( GetLocalInt ( GetArea ( oPC ), "OCC_Area" ) == 1 )
  {
    DebugMode(GetName(oPC) + " befindet sich in einem OOC Gebiet, keine EP f�r geschriebenes.");

    sColored = ColorChatting(oPC, sChat);
    SetPCChatMessage(sColored);
    return;
  }

  // 2.5 Pr�fen,in welcher Lautst�rke gesprochen wurde und bei allem ausser Talk, Group & Whisper abbrechen
  if ( (nChatVolume == TALKVOLUME_SHOUT)        ||       // Rufen
       (nChatVolume == TALKVOLUME_SILENT_TALK)  ||       // Kreaturen
       (nChatVolume == TALKVOLUME_SILENT_SHOUT) ||       // DM Channel
       (nChatVolume == TALKVOLUME_TELL)            )     // Gr�n
  {
    DebugMode(GetName(oPC) + " sprach in einem nicht auswertbaren Channel.");

    return;
  }



  // 3++ Start des Hauptskriptes
  // 3.1 Durchz�hlen der anwesenden PC's und pr�fen ob diese zuh�ren k�nnen.
  int    nNumPCs = 0;                                  // Grundlage zur Anzahl der PC's;
  object oListen = GetFirstPC ( ) ;                    // Ersten PC erfassen;

  while (GetIsObjectValid (oListen)       == TRUE)     // Pr�fen ob dieser PC existent ist, dann
  {
    if ((GetDistanceBetween(oPC, oListen) <= 10.0) &&  // Kann der Andere ihn h�ren UND
        (GetIsPC(oListen))                           ) // wird dieser von einem Spieler kontrolliert
    {
      nNumPCs++;                                       // Ja, dann +1 f�r die Anzahl an Spielern
    }

    oListen = GetNextPC ( ) ;                          // Grundlegend n�chsten PC pr�fen
  }

  // Abschlie�end im DebugModus ausgeben wieviel Spieler vorhanden sind
  DebugMode("Es sind insgesamt " + IntToString (nNumPCs) + " SC in Reichweite.");

  // 3.2 Wenn nur ein PC anwesend, im Debug Ausgeben jedes Mal Abbrechen
  if ( nNumPCs <= nNeededPlayers )
  {
    DebugMode("Es sind keine weiteren Chars in Reichweite, keine EP f�r geschriebenes.");

    sColored = ColorChatting(oPC, sChat);
    SetPCChatMessage(sColored);
    return;
  }



  // 4++ Berechnungen f�r EP usw.
  // 4.1 Erfassen des Gesprochenen, alles auf kleine Schriftweise umsetzen um das
  //     verarbeiten einfacher zu machen. Alle Leerzeichen am Anfang ignorieren,
  //     da nicht notwendig.
  string sRPGChat = GetStringLowerCase ( sChat );

  while ( ( sRPGChat != "" ) &&                      // W�hrend der Chat nicht leer ist UND
          ( GetStringLeft ( sRPGChat, 1 ) == " " ) ) // das erste Zeichen ein Leerzeichen ist
  {
    sRPGChat = GetStringRight ( sRPGChat, GetStringLength ( sRPGChat ) -1 );  // das erste Zeichen nicht werten
  }

  // 4.2.1 Wenn die ersten zwei Zeichen "//", "((" oder Kommando Zeichen sind, vermerken und Abbrechen
  if ( GetStringLeft ( sRPGChat, 2 ) == "//" || GetStringLeft ( sRPGChat, 2 ) == "((")
  {
    DebugMode(GetName(oPC)+ " hat OOC Zeichen gesetzt, keine EP f�r geschriebenes.");

    sColored = ColorChatting(oPC, sRPGChat);
    SetPCChatMessage(sColored);
    return;
  }

  // 4.3 Z�hlen und Berechnen der Buchstaben
  // 4.3.1 Z�hlen der Buchstaben
  int nLetters = GetStringLength ( sChat );                              // Gesamte Anzahl an Buchstaben erfassen

  // 4.3.2 Nach Anzahl Leerzeichen suchen
  int nLocationOfSpace = FindSubString (sChat, " " );                    // Gibt die Stelle des ersten Leerzeichens
  int nAmountSpaces = 0;                                                 // Startanzahl der Leerzeichen
  while ( nLocationOfSpace >= 1 )
  {
    if  ( nLocationOfSpace >= 0 )                                        // Sicherheitsabfrage; Beginn auf 1 setzen
    {
      nAmountSpaces + 1;
    }

    nAmountSpaces    = nAmountSpaces + 1;                                // Anzahl der Leerzeichen + 1
    nLocationOfSpace = nLocationOfSpace + 1;                             // N�chstes Leerzeichen + 1 f�r Suche
    nLocationOfSpace = FindSubString (sChat, " ", nLocationOfSpace );    // Sucht weitere Leerzeichen
  }

  // 4.3.3 Auswerten der Buchstaben
  int nLetterAmount = nLetters - nAmountSpaces;
  int nOrgLetters   = nLetterAmount;

  DebugMode(GetName(oPC)+ " schrieb insg. " + IntToString(nLetterAmount) + " Buchstaben.");

  // 4.4 Berechnen des EP-Werts
  // 4.4.1.1 F�r jeden gez�hlten Buchstaben werden nun (Anzahl der Buchstaben mal dem Wert pro Buchstabe
  //         durch den Faktor und schlussendlich durch 100) EP berechnet,
      nLetterAmount = ( (nOrgLetters * nEXPAmount) * nEXPFactor ) / 100;

  DebugMode(GetName(oPC)+ " wird insg. " + IntToString(nLetterAmount) + " EP erhalten.");

  // 4.4.1.2 Bonus f�r Anwesende PC berechnen, dh (Anzahl der EP mal die um 100 erhoehten Faktor durch
  //         1000, wiederum mal die Anzahl an Spielern)
  int nBonus     = ( (nLetterAmount * (100+nEXPBonus)) / 1000 ) * nNumPCs;

  DebugMode(GetName(oPC)+ " wird insg. " + IntToString(nBonus) + " als Bonus EP erhalten.");

  // 4.4.2 Bonus f�r Gold berechnen, dh (Anzahl der auszuschenkenden EP durch Gold-Faktor)
  //       Bei  50 EP und einem Faktor von 20 entspricht das nachher 5 GP, die der SC ebenfalls als Bonus erh�lt.
  int nGoldBonus = ( nOrgLetters / nGoldFactor );

  // 4.4.2.1 Pr�f ab ob der Goldbonus unter bzw. auf 0 ausfallen w�rde, wenn Ja, dann vergib mindestens 1 GM
  if ( nGoldBonus <= 0 )
  {
      nGoldBonus = 1;
  }

  DebugMode(GetName(oPC)+ " wird insg. " + IntToString(nGoldBonus) + " GP erhalten.");

  // 4.4.3 Anzahl der zu vergebenden EPs
  int nAmountEps = nLetterAmount + nBonus;
  DebugMode("Folgende EP werden " + GetName(oPC) + " insg. gutgeschrieben: " + IntToString ( nAmountEps ) + "." );

  // 4.4.4 Abspeichern der EP auf dem RP-Speicher (immer, wg TagesEP)
  if (nLocalRP == 0)  // Speicherung wenn Lokal = 0
  {
    SetLocalInt(oModule, sID, nAmountEps);
  }
  if (nLocalRP >= 1)  // Speicherung wenn Lokal > 0
  {
    SetLocalInt(oModule, sID, (nLocalRP + nAmountEps) );
  }

  // 4.4.5 Abschlie�ende Vergabe der EP an den Sprecher, nach einer vorgegebener InGame Zeit bzw. Speicherung in DB
  //       Vorher notwendige Variablen deklarieren
  int nInDB; int nToSave;

  // 4.4.6 Wenn Datenbank aktiv, dann vergib �ber Datenbank, mit kurzer Verz�gerung (ca 10 Sekunden)
  if ( nSaveToDB  == 1 )
  {
    DebugMode("Datenbankoption/Persistenz aktiviert.");

    nInDB = GetCampaignInt(RP_DATABASE, RP_EP+sID, oPC);

    DebugMode(GetName(oPC) + " hat momentan insg. " + IntToString(nInDB) + " gespeichert.");

    // 4.4.6.1 Speicherung wenn in der DB keine EP vorhanden sind
    if ( (nInDB == 0) )
    {
      DebugMode("DB-Eintrag mit " + IntToString(nAmountEps) + " EP erstellt.");

      SetCampaignInt(RP_DATABASE, RP_EP+sID, nAmountEps+nInDB, oPC);

      // Vermerke im Debug
      DebugMode(GetName(oPC) + " bekommt insg. " + IntToString(nAmountEps) + " gespeichert.");
    }

    // 4.4.6.2 Speicherung wenn mehr als 0 und weniger als Vergabewert vorhanden
    else if ( (nInDB >= 0) && (nInDB < nToGive) )
    {
      nToSave = nInDB+nAmountEps;
      DebugMode("DB-Eintrag wird um  " + IntToString(nToSave) + " EP ergnzt.");

      SetCampaignInt(RP_DATABASE, RP_EP+sID, nToSave, oPC);

      // Vermerke im Debug
      DebugMode(GetName(oPC) + " bekommt insg. " + IntToString(nToSave) + " gespeichert.");
    }

    // 4.4.6.3 Speicherung wenn mehr als Vergabewert vorhanden
    else if ( (nInDB >= nToGive) )
    {
      DebugMode("DB-Eintrag wird geleert und die erreichten " + IntToString(nInDB+nAmountEps) + " EP vergeben.");

      SetCampaignInt(RP_DATABASE, RP_EP+sID, 0, oPC);

      //DelayCommand ( fDelayDB, GiveXPToCreature ( oPC, (nInDB+nAmountEps) ) );// Vergib EP wenn mehr als vorgegebene EP sind
      DelayCommand ( fDelayDB, SetXPImproved ( oPC, GetXP(oPC)+(nInDB+nAmountEps) ) );     // Vergib EP wenn mehr als vorgegebene EP sind

      // Vermerke im Debug
      DebugMode(GetName(oPC) + " hat insg. " + IntToString( GetCampaignInt(RP_DATABASE, RP_EP+sID) ) + " EP gespeichert." );
    }
  }

  // 4.4.7 Direkte Vergabe der EP ohne Speicherung, Verz�gerung aktiviert!
  else
  {
    DebugMode("Es werden insgesamt " + IntToString(nAmountEps) + " EP an " + GetName(oPC) + " vergeben.");

    //DelayCommand ( fDelayNonDB, GiveXPToCreature ( oPC, nAmountEps ) );
    DelayCommand ( fDelayNonDB, SetXPImproved ( oPC, GetXP(oPC)+nAmountEps ) );
  }

  // 4.5 Vergabe schlussendlich des Goldbetrages aus der berechneten Summe, um 25 Sek. verz�gert gg�. der EP-Vergabe
  DelayCommand ( 25 + fDelayNonDB, GiveGoldToCreature(oPC, nGoldBonus) );

  DebugMode("Es werden insg. " + IntToString(nGoldBonus) + " GP an " + GetName(oPC) + " vergeben." );

  sColored = ColorChatting(oPC, sChat);
  SetPCChatMessage(sColored);
}

int CountSubString(string sString, string sSubString)
{
  int i = FindSubString(sString, sSubString), c = 0;
  while (i != -1)
  {
    c++;
    i = FindSubString(sString, sSubString, i+1);
  }

  return c;
}

string ColorChatting(object oPC, string sChat)
{
  object oItem = GetItemPossessedBy(oPC, "itm_questbuch"); string sColor, sEmote;

  if (GetSubString(GetStringLowerCase(sChat), 0, 3) == "#>c")                   //player wants to change color via chat
  {
    if (GetSubString(GetStringLowerCase(sChat), 0, 5) == "#>c h")               //player needs help!
    {
      SendMessageToPC(oPC, ColorText("rot", "Mit #>c kannst Du die Chatfarbe deines Chars �ndern:t\n"+
                           "#>c c purpur => der n�chste Text wird Purpur dargestellt.\n"+
                           "#>c e rot => das n�chste Emote wird Rot dargestellt.\n"+
                           "#>c s => setzt alles auf Standardwerte (wei�er Text).\n"+
                           "#>c h => ruft diese Hilfe auf.\n"+
                           "#>c f => listet alle Farben auf."
                           ));
      return ColorString(sChat, 255, 255, 255);
    }

    else if (GetSubString(GetStringLowerCase(sChat), 0, 5) == "#>c s")          //player wants to reset all
    {
      SetLocalInt(oItem, "CHAT_ROT", 255);
      SetLocalInt(oItem, "CHAT_GRUEN", 255);
      SetLocalInt(oItem, "CHAT_BLAU", 255);
      SetLocalString(oItem, "CHAT_FARBE", "");
      return ColorString(sChat, 255, 255, 255);
    }

    else if (GetSubString(GetStringLowerCase(sChat), 0, 5) == "#>c f")          //player wants to know all the colors
    {
      SendMessageToPC(oPC, ColorText("purpur", "purpur")+", "+ColorText("rot", "rot")+", "+ColorText("pflaume", "pflaume")+", "+
                           ColorText("mandarine", "mandarine")+", "+ColorText("orange", "orange")+", "+ColorText("pfirsich", "pfirsich")+", "+
                           ColorText("bernstein", "bernstein")+", "+ColorText("gelb", "gelb")+", "+ColorText("zitrone", "zitrone")+", "+
                           ColorText("smaragd", "smaragd")+", "+ColorText("gr�n", "gr�n")+", "+ColorText("limette", "limette")+", "+
                           ColorText("mitternacht", "mitternacht")+", "+ColorText("marine", "marine")+", "+ColorText("blau", "blau")+", "+
                           ColorText("azur", "azur")+", "+ColorText("himmelblau", "himmelblau")+", "+ColorText("violett", "violett")+", "+
                           ColorText("lila", "lila")+", "+ColorText("lavendel", "lavendel")+", "+ColorText("schwarz", "schwarz")+", "+
                           ColorText("schiefer", "schiefer")+", "+ColorText("dunkelgrau", "dunkelgrau")+", "+ColorText("grau", "grau")+", "+
                           ColorText("hellgrau", "hellgrau")+", "+ColorText("wei�", "wei�")+", "+ColorText("t�rkis", "t�rkis")+", "+
                           ColorText("jade", "jade")+", "+ColorText("cyan", "cyan")+", "+ColorText("graublau", "graublau")+", "+
                           ColorText("wasser", "wasser")+", "+ColorText("silber", "silber")+", "+ColorText("rose", "rose")+", "+
                           ColorText("pink", "pink")+", "+ColorText("holz", "holz")+", "+ColorText("braun", "braun")+", "+
                           ColorText("br�une", "br�une")+", "+ColorText("fleisch", "fleisch")+", "+ColorText("elfenbein", "elfenbein")+", "+
                           ColorText("gold", "gold")+", "+ColorText("zufall", "zufall")
                           );
      return ColorString(sChat, 255, 255, 255);
    }

    else if (GetSubString(GetStringLowerCase(sChat), 0, 5) == "#>c c")          //player wants to change the color for chat
    {
      SetLocalInt(oItem, "CHAT_ROT", 255);
      SetLocalInt(oItem, "CHAT_GRUEN", 255);
      SetLocalInt(oItem, "CHAT_BLAU", 255);

      sColor = StringReplace(GetSubString(GetStringLowerCase(sChat), 6, 12), " ", "");
      SetLocalString(oItem, "CHAT_FARBE", sColor);
      return ColorText(GetLocalString(oItem, "CHAT_FARBE"), sChat);
    }

    else if (GetSubString(GetStringLowerCase(sChat), 0, 5) == "#>c e")          //player wants to change the color for emotes
    {
      SetLocalInt(oItem, "CHAT_ROT", 255);
      SetLocalInt(oItem, "CHAT_GRUEN", 255);
      SetLocalInt(oItem, "CHAT_BLAU", 255);

      sColor = StringReplace(GetSubString(GetStringLowerCase(sChat), 6, 12), " ", "");
      SetLocalString(oItem, "CHAT_FARBE_EMOTE", sColor);
      return ColorText(GetLocalString(oItem, "CHAT_FARBE_EMOTE"), sChat);
    }


    return sChat;
  }                      //GetSubString(sChat, 0, 1)

  else if (FindSubString(sChat, "*") > -1 && GetLocalString(oItem, "CHAT_FARBE_EMOTE") != "")  // found emote
  {
    string e = GetLocalString(oItem, "CHAT_FARBE_EMOTE"), t;
    string c = GetLocalString(oItem, "CHAT_FARBE");                             // *test* Anfang *test* Mitte und Schluss *test*
    string s = StringReplace(sChat, "*", "|*|");                                // *|test*| Anfang *|test*| Mitte und Schluss *|test*|
    int n;
    for (n=1;n<=GetTokenCount(s, "*");n++)
    {
      if (GetTokenFromString(n, s, "*") != "|")
      {
        string r = StringReplace(StringReplace(StringReplace(GetTokenFromString(n, s, "*"), "|", "*"), "* ", ""), " *", "");

        if (FindSubString(r, "*") > -1)
          t = t + " " + ColorText(e, r);

        else
          t = t + " " + ColorText(c, r);
      }
    }

    if (GetSubString(t, 0, 1) == " ")                                           //cutoff leading spaces
      t = GetSubString(t, 1, GetStringLength(t));

    return t;
  }

  else if (GetLocalString(oItem, "CHAT_FARBE") != "")
    return ColorText(GetLocalString(oItem, "CHAT_FARBE"), sChat);

  else if (GetLocalInt(oItem, "CHAT_ROT")+GetLocalInt(oItem, "CHAT_GRUEN")+GetLocalInt(oItem, "CHAT_BLAU") != 0)
    return ColorString(sChat, GetLocalInt(oItem, "CHAT_ROT"),
                              GetLocalInt(oItem, "CHAT_GRUEN"),
                              GetLocalInt(oItem, "CHAT_BLAU"));
  else
    return ColorString(sChat, 255, 255, 255);
}


