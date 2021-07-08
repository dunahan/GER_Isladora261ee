//::///////////////////////////////////////////////
//:: Script für einen Gegenstand der eine festgelegte Kreatur erschafft.
//:: summonpet
//:: Copyright (c) 2012 Qowyn
//:://////////////////////////////////////////////
/*
    Parameter auf dem Gegenstand:

    - ResRef:
        Name des Templates
    - Area:
        Liste der ResRefs aller Gebiete in denen der Gegenstand benutzt werden
        darf, Doppelpunkt getrennt, leer wenn er überall benutzt werden darf.

*/
//:://////////////////////////////////////////////
//:: Created By: Qowyn
//:: Created On: 2013-01-05
//:://////////////////////////////////////////////
#include "x2_inc_switches"
#include "_debugisla"

void PrepareSpawn(object oPC, object oSpawn)
{
  AddHenchman(oPC, oSpawn);
  ClearAllActions(TRUE);
  ActionForceFollowObject(oPC, 1.0f);
}

void main()
{
  int nEvent = GetUserDefinedItemEventNumber();

  // Gegenstand wird benutzt
  if (nEvent == X2_ITEM_EVENT_ACTIVATE)
  {
    object oPC     = GetItemActivator();
    object oItem   = GetItemActivated();
    string sResRef = GetLocalString(oItem, "ResRef");
    string sArea   = GetLocalString(oItem, "Area");
    int bAreaEmpty = GetStringLength(sArea) == 0;
    int nTag = 0;
    object oSpawn;

    oSpawn = GetLocalObject(oPC, "Pet" + sResRef);
    // Überprüfen ob die Kreatur bereits gespawnt wurde UND sie selbst das Ziel ist
    if (GetIsObjectValid(oSpawn)
     && GetItemActivatedTarget() == oSpawn)
    {
      DeleteLocalObject(OBJECT_SELF, "SearchFor");
      DeleteLocalObject(oPC, "Pet" + sResRef);
      SetPlotFlag(oSpawn, FALSE);
      DestroyObject(oSpawn);
      return;
    }

    if (GetIsObjectValid(oSpawn) // Klick auf Anwender selbst, Ruf das Pet zu Dir
     && GetItemActivatedTarget() == oPC)
    {
      AssignCommand(oSpawn, ClearAllActions(TRUE));
      AssignCommand(oSpawn, ActionForceFollowObject(oPC, 1.0f));
      return;
    }

    if (GetIsObjectValid(oSpawn) == FALSE )
    {
      // Auf Gebietsbeschränkung prüfen
      if (!bAreaEmpty)
      { // Es ist eine Gebietsbeschränkung vorhanden
        int bPlayerInArea = TestStringAgainstPattern("**:"+GetResRef(GetArea(oPC))+":**", ":" + sArea + ":");

        // Befindet sich der Spieler in einem der Gebiete?
        if (!bPlayerInArea)
        { // Nein, ungültiger Ort
          SendServerMessageToPC(oPC, "Du kannst diesen Gegenstand hier nicht benutzen!");
          return;
        }
      }

      oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oPC));
      // Konnte die Kreatur gespawnt werden?
      if (GetIsObjectValid(oSpawn))
      { // Ja
        SetLocalObject(oPC, "Pet" + sResRef, oSpawn);
        SetLocalObject(OBJECT_SELF, "SearchFor", oPC);
        AssignCommand(oSpawn, PrepareSpawn(oPC, oSpawn));
      }

      else
      { // Nein, leeres oder falsche ResRef
        SendServerMessageToPC(oPC, "Fehler! Gegenstand defekt!");
        return;
      }
    }
  } // Gegenstand wurde benutzt
}
