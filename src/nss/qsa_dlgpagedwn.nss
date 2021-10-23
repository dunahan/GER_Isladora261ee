//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_dlgpagedwn
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item, hier für das Item
    Questitem Seite wechseln -1
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

  // 2.2.1 Bei Seite kleiner 0, 0 sowie gleich 1 auf letzte Seite springen
  if ( (nPage <= 0) || (nPage == 1) )       SetLocalInt(oBook, "nPage", QUESTBOOK_PAGES);

  // 2.2.2 Bei Seite 1 und grösser sowie kleiner und gleich Gesamtzahl, - 1 Seite
  else if ( (nPage >  1) || (nPage <= QUESTBOOK_PAGES) ) {
    nPage = nPage - 1;
    SetLocalInt(oBook, "nPage", nPage);
  }
}
