//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_dlgpageup
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Questitem Seite wechseln +1
    Einzusetzen bei onActionTaken
    - Aktualisieren des Headers */
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:: Last Modified On: 15.04.2013
//:://////////////////////////////////////////////
#include "qsa_include"

void main()
{
  // 1++ Deklariere die wichtigsten Variablen, Objekte usw
  object oPC  = GetPCSpeaker();    // der Ansprecher

  // 1.1 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 2++ Initiiere das Questtoken
  // 2.1 Lies die erste Seite des Questtokens aus
  int nPage = GetLocalInt(oBook, "nPage"), nPageNow;

  // 2.2.1 Aktuelle Seite gleich oder kleiner Null, auf Erste Seite setzen
  if ( (nPage <= 0) || (nPage >= QUESTBOOK_PAGES) )     SetLocalInt(oBook, "nPage", 1);

  // 2.2.2 Aktuelle Seite groesser Null, Seite + Eins
  else if ( (nPage >  0) || (nPage <= QUESTBOOK_PAGES) ) {
    nPage += 1;
    SetLocalInt(oBook, "nPage", nPage);
  }
}
