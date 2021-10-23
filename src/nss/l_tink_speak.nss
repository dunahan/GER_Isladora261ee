int TCL(string sCommand) {
  return GetStringLength(sCommand);
}

// version
string TINK_VERSION = "Version GER-ISL-06/05/2020\n";

// various
string TINK_SPACERS = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n";

// commands that control Tink
string TINK_BASE_NAMES = "tink ",       TINK_BASE_PREFIX = "#!";
string TINK_BASE_START = "start";   int TBL = 5+2;                      // from base Names + Prefix
string TINK_BASE_GOHOM = "geh",         TINK_BASE_STOPS = "stop";
string TINK_BASE_HELPS = "hilfe",       TINK_BASE_FOLLW = "folge";

// commands that Tink understands
string TINK_CMD_CREITM = "item",        TINK_CMD_CREPLC = "place";
string TINK_CMD_CREMON = "spawn";
string TINK_CMD_GIVEGP = "give gp",     TINK_CMD_TAKEGP = "take gp";
string TINK_CMD_GIVELV = "give level",  TINK_CMD_TAKELV = "take level";
string TINK_CMD_GIVEXP = "give xp",     TINK_CMD_TAKEXP = "take xp";
string TINK_CMD_BRINGS = "bring",       TINK_CMD_GOTOPL = "goto";
string TINK_CMD_WHERES = "where",       TINK_CMD_MVTMAP = "map";
string TINK_CMD_MOVTWP = "wp";
string TINK_CMD_SETIMO = "immortal",    TINK_CMD_BOOTPC = "boot";
string TINK_CMD_FREEZE = "freeze",      TINK_CMD_HEALPC = "heal";
string TINK_CMD_FULHEA = "fullheal",    TINK_CMD_EXAMIN = "exa";
string TINK_CMD_GETHPS = "getps",       TINK_CMD_FEATIN = "feats";
string TINK_CMD_SKILLS = "skills",      TINK_CMD_EQUIPS = "equips";
string TINK_CMD_STHOUR = "hour",        TINK_CMD_CNGWEA = "weather";
string TINK_CMD_RSTART = "restart";

// Tinks speaks this
string TINK_SPEAK_NODM = "Du bist kein DM/Counci!";
string TINK_SPEAK_REDY = "Tinkerbell ist bereit.";
string TINK_SPEAK_IGNR = "Tinkerbell ignoriert Dich.";
string TINK_SPEAK_GOES = "Tinkerbell verschwindet.";
string TINK_SPEAK_FLW1 = "Tinkerbell folgt.";
string TINK_SPEAK_FLW2 = "Tinkerbell bleibt.";

// those show the base commands
string TINK_SPEAK_BASE = "Das sind die Standard-Kommandos:\n"+
                         TINK_BASE_NAMES+TINK_BASE_START+":  Tink wird zuhoeren.\n"+
                         TINK_BASE_NAMES+TINK_BASE_STOPS+":  Tink wird nicht mehr zuhoeren.\n"+
                         TINK_BASE_NAMES+TINK_BASE_GOHOM+":  Tink wird verschwinden.\n"+
                         TINK_BASE_NAMES+TINK_BASE_FOLLW+":  Tink wird folgen/stehen bleiben.\n" +
                         TINK_BASE_NAMES+TINK_BASE_HELPS+":  Zeige diese Liste.\n\n"+
                         "Weitere Kommandos: Der Befehl allein zeigt dessen Beschreibung.\n";
string TINK_SPEAK_CCOM = TINK_CMD_BRINGS+"  "+TINK_CMD_GOTOPL+"  "+TINK_CMD_WHERES+"\n"+
                         TINK_CMD_HEALPC+"  "+TINK_CMD_CNGWEA+"\n";

string TINK_SPEAK_DMCM = TINK_CMD_CREITM+"  "+TINK_CMD_CREPLC+"  "+TINK_CMD_CREMON+"\n"+
                         TINK_CMD_GIVEGP+"  "+TINK_CMD_TAKEGP+"\n"+
                         TINK_CMD_GIVELV+"  "+TINK_CMD_TAKELV+"\n"+
                         TINK_CMD_GIVEXP+"  "+TINK_CMD_TAKEXP+"\n"+
                         TINK_CMD_BRINGS+"  "+TINK_CMD_GOTOPL+"  "+TINK_CMD_WHERES+"\n"+
                         TINK_CMD_MVTMAP+"  "+TINK_CMD_MOVTWP+"\n"+
                         TINK_CMD_BOOTPC+"  "+TINK_CMD_FREEZE+"\n"+
                         TINK_CMD_HEALPC+"  "+TINK_CMD_FULHEA+"  "+TINK_CMD_SETIMO+"\n"+
                         TINK_CMD_EXAMIN+"  "+TINK_CMD_GETHPS+"\n"+
                         TINK_CMD_FEATIN+"  "+TINK_CMD_SKILLS+"\n"+
                         TINK_CMD_EQUIPS+"  "+TINK_CMD_STHOUR+"  "+TINK_CMD_CNGWEA+"\n";

// Create funcs following
string TINK_CMD_BASNT0 = "DM:  ";
string TINK_CMD_BASER0 = "Kein Kommando erkannt.";
string TINK_CMD_CREER1 = TINK_CMD_BASNT0+"[";
string TINK_CMD_CREER2 = "] ist keine gueltige ResRef.\n";
string TINK_CMD_CREER3 = TINK_CMD_BASNT0+"Fehler bei Objekt erschaffen.";

string TINK_CMD_ITMSY1 = "Kommando:  item <ResRef> <Menge>";
string TINK_CMD_ITMSY2 = "\nBeispiel:  item nw_wamar001 99\n" +
                         "Ergebnis:  99 identifizierte Pfeile werden im Inv erschaffen.\n" +
                         "Bemerk.1:  <Menge> muss im Format 01 bis 99 sein.\n" +
                         "Bemerk.2:  Es koennen nur Items bis zur max. Stackgroesse erschaffen werden.";

string TINK_CMD_MONSY1 = "Kommando:  spawn <ResRef> <Menge>";
string TINK_CMD_MONSY2 = "\nBeispiel:  spawn nw_chicken 03\n" +
                         "Ergebnis:  Spawnt 3 Huehnchen bei Dir.\n" +
                         "Bemerkung:  <Menge> muss im Format 01 bis 99 sein.\n";

string TINK_CMD_PLCSY1 = "Kommando:  place <ResRef>";
string TINK_CMD_PLCSY2 = "\nBeispiel:  place plc_butterflies\n" +
                         "Ergebnis:  Erschafft das Placeable Schmetterlinge an Deiner Position.\n";

// Give to Player funcs following
string TINK_CMD_GIVER1 = TINK_CMD_BASNT0+"Fehler, es gibt kein Spieler mit dem Namen [";
string TINK_CMD_GIVER2 = "].";
string TINK_CMD_GIVER3 = TINK_CMD_BASNT0+"Fehler, dieser Befehl kann nur mit Spielern genutzt werden.";
string TINK_CMD_GIVER4 = TINK_CMD_BASNT0+"Fehler, die Menge an Gold/EP/Stufen fehlt.";

string TINK_CMD_BASNT1 = TINK_CMD_BASNT0+"Gab ";
string TINK_CMD_BASNT2 = TINK_CMD_BASNT0+"Nahm ";
string TINK_CMD_BASNT3 = ".  Der Spieler hat nun ";
string TINK_CMD_BASNT4 = " Gold.";
string TINK_CMD_BASNT5 = " EP.";

string TINK_CMD_GGOSY1 = "Kommando:  give gp <Menge> <Spieler>";
string TINK_CMD_GGOSY2 = "\nBeispiel:  give gp 100 bob\n" +
                         "Ergebnis:  Gibt 100 gold an bob";
string TINK_CMD_GGONT2 = " Gold an ";

string TINK_CMD_GLVSY1 = "Kommando:  give level <Spieler>";
string TINK_CMD_GLVSY2 = "\nBeispiel:  give level bob\n" +
                         "Ergebnis:  Gibt genug EP, damit bob die naechste Stufe erreicht.";
string TINK_CMD_GLVNT1 = "eine Stufe an ";
string TINK_CMD_GLVNT2 = ".  Der Spieler war ";
string TINK_CMD_GLVNT3 = " und ist nun ";
string TINK_CMD_GLVNT4 = ".";

string TINK_CMD_GXPSY1 = "Kommando:  give xp <Menge> <Spieler>";
string TINK_CMD_GXPSY2 = "\nBeispiel:  give xp 50 bob\n" +
                         "Ergebnis:  Gibt 50 EP an bob";
string TINK_CMD_GXPNT2 = " EP. Er bekam ";

// Take from Player funcs following
string TINK_CMD_TAKER1 = " hat kein Gold. Ihm kann kein negativer Goldwert gegeben werden.";
string TINK_CMD_TAKER2 = " ist bereits Stufe eins, es koennen keine weitere Stufen abgezogen werden!";
string TINK_CMD_TAKER3 = " hat bereits Null EP, es kann keine negative Anzahl an EP vergeben werden.";

string TINK_CMD_TGOSY1 = "Kommando:  take gp <Menge> <Spieler>";
string TINK_CMD_TGOSY2 = "\nBeispiel:  take gp 50 bob\n" +
                         "Ergebnis:  Nimmt 50 Gold von bob.  Kann nicht mehr nehmen, als der Spieler hat.";
string TINK_CMD_TGONT1 = " Gold von ";

string TINK_CMD_TLVSY1 = "Kommando:  take level <Spieler>";
string TINK_CMD_TLVSY2 = "\nBeispiel:  take level bob\n" +
                               "Ergebnis:  Nimmt genung EP von bob um ihn um eine Stufe zu reduzieren.";
string TINK_CMD_TLVNT1 = "* Verlor eine Stufe *";
string TINK_CMD_TLVNT2 = "eine Stufe von ";
string TINK_CMD_TLVNT3 = ".  Der Spieler war ";
string TINK_CMD_TLVNT4 = " und ist nun ";
string TINK_CMD_TLVNT5 = ".";

string TINK_CMD_TXPSY1 = "Kommando:  take xp <Menge> <Spieler>";
string TINK_CMD_TXPSY2 = "\nBeispiel:  take xp 50 bob\n" +
                         "Ergebnis:  Nimmt 50 XP von bob.  Kann nicht mehr EP nehmen als vorhanden.";
string TINK_CMD_TXPNT1 = " EP von ";

// Teleporting funcs following
string TINK_CMD_BRPSY1 = "Kommando:  bring <Spieler>";
string TINK_CMD_BRPSY2 = "\nBeispiel:  bring bob\n" +
                         "Ergebnis:  Bringt bob zu Dir.";
string TINK_CMD_BRPNT1 = "Du wirst an einem anderen Ort benoetigt.";
string TINK_CMD_BRPNT2 = "Ich werde an einem anderen Ort benoetigt.";
string TINK_CMD_BRPNT3 = ", Du wirst hier benoetigt.";

string TINK_CMD_GTPSY1 = "Kommando:  goto <Spieler>";
string TINK_CMD_GTPSY2 = "\nBeispiel:  goto bob\n" +
                         "Ergebnis:  Bringt Dich zu bob";

string TINK_CMD_GTMSY1 = "Kommando:  map <Tag der Karte/all/info>";
string TINK_CMD_GTMSY2 = "\nBeispiel 1:  map centertown\n" +
                         "Ergebnis:  Bringt dich zur Karte mit dem Tag centertown"+
                         "\nBeispiel 2:  map all\n" +
                         "Ergebnis:  Zeigt eine Liste mit allen Maps+Tags des Moduls."+
                         "\nBeispiel 3:  map info\n" +
                         "Ergebnis:  Zeigt Daten dieser Map und deckt sie auf.";
string TINK_CMD_GTMSY3 = "all";
string TINK_CMD_GTMSY4 = "info";

string TINK_CMD_GTMNT1 = TINK_CMD_BASNT0+"Aktuelle Map: ";
string TINK_CMD_GTMNT2 = "\nTag der Map: ";
string TINK_CMD_GTMNT3 = "\nEs werden Ausloeser und Ressourcen in die MiniMap geladen.\n";
string TINK_CMD_GTMNT0 = "Mehr kommt noch!\n";

string TINK_CMD_GTMER1 = TINK_CMD_BASNT0+"Fehler, es gibt keine Karte mit dem Tag [";
string TINK_CMD_GTMER2 = TINK_CMD_BASNT0+"Fehler, es gibt kein Objekt auf der Karte ";
string TINK_CMD_GTMER3 = " um dort hin zu springen.";

string TINK_CMD_GWPSY1 = "Kommando:  wp <Tag>";
string TINK_CMD_GWPSY2 = "\nBeispiel:  wp wp_main_recall_spot\n" +
                               "Ergebnis:  Bringt Dich zum ersten Wegpunkt mit dem Tag wp_main_recall_spot";
string TINK_CMD_GWPER1 = TINK_CMD_BASNT0+"Fehler, es gibt keinen Wegpunkt mit dem Tag [";

// How to kick an punish them!
string TINK_CMD_BTPSY1 = "Kommando:  boot <Spieler>";
string TINK_CMD_BTPSY2 = "\nBeispiel:  boot bob\n" +
                         "Ergebnis:  Wirft den Spieler aus dem aktuellen Spiel.";
string TINK_CMD_BTPNT1 = "Man keine DM's aus dem Spiel werfen.";
string TINK_CMD_BTPNT2 = "Sehr witzig... ";
string TINK_CMD_BTPNT3 = " wollte Dich gerade vom Server kicken.";
string TINK_CMD_BTPNT4 = " warf ";
string TINK_CMD_BTPNT5 = " aus dem Spiel.";
string TINK_CMD_BTPNT6 = " wurde aus dem Spiel geworfen.";
string TINK_CMD_BTPNT7 = "Du wirst aus dem Spiel geworfen.";

string TINK_CMD_FZPSY1 = "Kommando:  freeze <Spieler>";
string TINK_CMD_FZPSY2 = "\nBeispiel:  freeze bob\n" +
                               "Ergebnis:  Der Spieler kann sich nicht mehr bewegen.";
string TINK_CMD_FZPNT1 = "Du kannst dich nicht mehr bewegen.";
string TINK_CMD_FZPNT2 = " kann sich nicht mehr bewegen.";
string TINK_CMD_FZPNT3 = "Du kannst Dich wieder bewegen.";
string TINK_CMD_FZPNT4 = " kann sich nun wieder bewegen.";

// Collect Data from players funcs following
string TINK_CMD_EQUSY1 = "Kommando:  equips <Spieler>";
string TINK_CMD_EQUSY2 = "\nBeispiel:  equips bob\n" +
                         "Ergebnis:  Zeigt eine Liste aller Gegenstaende von bob.";

string TINK_CMD_EXASY1 = "Kommando:  exa <Spieler>";
string TINK_CMD_EXASY2 = "\nBeispiel:  exa bob\n" +
                         "Ergebnis:  Zeigt eine Liste verschiedenster Info's von bob.";

string TINK_CMD_FEASY1 = "Kommando:  feats <Spieler>";
string TINK_CMD_FEASY2 = "\nBeispiel:  feats bob\n" +
                         "Ergebnis:  Zeigt eine Liste mit bob's Talenten.";
string TINK_CMD_FEANT1 = " hat die folgenden Talente: ";

string TINK_CMD_PXGSY1 = "Kommando:  getps <Spieler>";
string TINK_CMD_PXGSY2 = "\nBeispiel:  getps bob\n" +
                         "Ergebnis:  Zeigt bob's EP und Gold.";
string TINK_CMD_PXGNT1 = " hat ";

string TINK_CMD_SKLSY1 = "Kommando:  skills <Spieler>";
string TINK_CMD_SKLSY2 = "\nBeispiel:  skills bob\n" +
                         "Ergebnis:  Zeigt eine Liste mit bob's Faehigkeiten.";
string TINK_CMD_SKLNT1 = " hat die folgenden Faehigkeiten:\n";

// Healing and others funcs following
string TINK_CMD_FHPSY1 = "Kommando:  fullheal <Spieler>";
string TINK_CMD_FHPSY2 = "\nBeispiel:  fullheal bob\n" +
                         "Ergebnis:  Wiederbelebt und heilt bob vollstaendig.";
string TINK_CMD_FHPNT1 = "Du wurdest wiederhergestellt und vollstaendig geheilt.";
string TINK_CMD_FHPNT2 = " wurde wiederhergestellt vollstaendig geheilt.";

string TINK_CMD_HLPSY1 = "Kommando:  heal <Spieler>";
string TINK_CMD_HLPSY2 = "\nBeispiel:  heal bob\n" +
                         "Ergebnis:  Heilt bob vollstaendig.";
string TINK_CMD_HLPNT1 = "Du wurdest vollstaendig geheilt.";
string TINK_CMD_HLPNT2 = " wurde vollstaendig geheilt.";

string TINK_CMD_IMOSY1 = "Kommando:  immortal <Spieler>";
string TINK_CMD_IMOSY2 = "\nBeispiel:  immortal bob\n" +
                         "Ergebnis:  Macht den Spieler bob unverwundbar.";
string TINK_CMD_IMONT1 = " ist nun unverwundbar.";
string TINK_CMD_IMONT2 = " ist wieder verwundbar.";

string TINK_CMD_WHRSY1 = "Kommando:  where <Spieler/all>";
string TINK_CMD_WHRSY2 = "\nBeispiel:  where bob\n" +
                         "Ergebnis:  Zeigt, wo sich bob befindet.\n" +
                         "Beispiel:  where all \n" +
                         "Ergebnis:  Zeigt, wo sich alle befinden.";
string TINK_CMD_WHRNT1 = "Zeige alle Spieler:  ";
string TINK_CMD_WHRNT2 = " befindet sich:  ";

string TINK_CMD_SHRSY1 = "Kommando:  hour <Menge>";
string TINK_CMD_SHRSY2 = "\nBeispiel:  hour 3\n" +
                         "Ergebnis:  Schreitet 3 Stunden in der Zeit vorwaerts. Man kann nur vorwaerts voran gehen";
string TINK_CMD_SHRSY3 = "\nEs ist gerade ";
string TINK_CMD_SHRSY4 = " Uhr.";
string TINK_CMD_SHRNT1 = TINK_CMD_BASNT0+"Fehler, man kann nur vorwaerts in der Zeit gehen.";
string TINK_CMD_SHRNT2 = "Es war gerade noch ";
string TINK_CMD_SHRNT3 = " Uhr.";
string TINK_CMD_SHRNT4 = " zur Stunde ";

string TINK_CMD_WEASY1 = "Kommando:  weather <here>";
string TINK_CMD_WEASY2 = "\nBeispiel:  weather here\n"+
                                 "Ergebnis:  Das Wetter in dieser Area wird klar.\nAktuell nur Klar und hier moegl.";
string TINK_CMD_WEASY3 = "here";
string TINK_CMD_WEANT1 = TINK_CMD_BASNT0+"Setze das Wetter in dieser Map auf Klar. ";
string TINK_CMD_WEANT2 = TINK_CMD_BASNT0+"Setze alle Maps auf Klar. Dies kann etwas dauern.";
