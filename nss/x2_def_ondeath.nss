//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "nw_i0_2q4luskan"

void main()
{
  object   oPC     = GetLastKiller();

  if (GetStringRight(GetTag(OBJECT_SELF), 5) == "_boss")
  {
    // For BossMonsters, if they are defeated, they respawn in 10 minutes
    // While a Henchman kills the Monster, reflect the script on the PC
    while (GetIsObjectValid(GetMaster(oPC)))
    { oPC     = GetMaster(oPC); }

      if (GetIsPC(oPC) == TRUE)
      {
        string sMyResREF = GetResRef(OBJECT_SELF);
        object     oArea = GetArea(OBJECT_SELF);
        location  lMyLoC = GetLocalLocation(oArea, "sSpawn");
        float     sDelay;
        int       myTyp  = GetObjectType(OBJECT_SELF);

        if (GetLocalString(OBJECT_SELF, "NewResRef") != "")
        { sMyResREF = GetLocalString(OBJECT_SELF, "NewResRef"); }

        else
        { sMyResREF = GetResRef(OBJECT_SELF); }

        if (GetLocalFloat(OBJECT_SELF, "Delay") == 0.0)
        { sDelay = 7200.0; }

        else
        { sDelay = GetLocalFloat(OBJECT_SELF, "Delay"); }

        AssignCommand(oArea,DelayCommand(sDelay, CreateObjectVoid(myTyp, sMyResREF, lMyLoC)));

        // LOG OUTPUT
        WriteTimestampedLogEntry("Erzeuge: " + sMyResREF + " in " + GetName(oArea) );
      }
  }

  if (GetTag(OBJECT_SELF) == "cre_vermag_a")
  {
    // For BossMonsters, if they are defeated, they respawn in 10 minutes
    // While a Henchman kills the Monster, reflect the script on the PC
    while (GetIsObjectValid(GetMaster(oPC)))
    { oPC     = GetMaster(oPC); }

      if (GetIsPC(oPC) == TRUE)
      {
        string sMyResREF = GetResRef(OBJECT_SELF);
        object     oArea = GetArea(OBJECT_SELF);
        location  lMyLoC = GetLocalLocation(oArea, "sSpawn");
        float     sDelay;
        int       myTyp  = GetObjectType(OBJECT_SELF);

        if (GetLocalString(OBJECT_SELF, "NewResRef") != "")
        { sMyResREF = GetLocalString(OBJECT_SELF, "NewResRef"); }

        else
        { sMyResREF = GetResRef(OBJECT_SELF); }

        if (GetLocalFloat(OBJECT_SELF, "Delay") == 0.0)
        { sDelay = 7200.0; }

        else
        { sDelay = GetLocalFloat(OBJECT_SELF, "Delay"); }

        AssignCommand(oArea,DelayCommand(sDelay, CreateObjectVoid(myTyp, sMyResREF, lMyLoC)));

        // LOG OUTPUT
        WriteTimestampedLogEntry("Erzeuge: " + sMyResREF + " in " + GetName(oArea) );
      }
    CreateObjectVoid(OBJECT_TYPE_CREATURE, "cre_vermag_unde", GetLocation(OBJECT_SELF));
  }

  if (GetTag(OBJECT_SELF) == "nsc_untotpirat_a")
  {
    // For BossMonsters, if they are defeated, they respawn in 10 minutes
    // While a Henchman kills the Monster, reflect the script on the PC
    while (GetIsObjectValid(GetMaster(oPC)))
    { oPC     = GetMaster(oPC); }

      if (GetIsPC(oPC) == TRUE)
      {
        string sMyResREF = GetResRef(OBJECT_SELF);
        object     oArea = GetArea(OBJECT_SELF);
        location  lMyLoC = GetLocalLocation(oArea, "sSpawn");
        float     sDelay;
        int       myTyp  = GetObjectType(OBJECT_SELF);

        if (GetLocalString(OBJECT_SELF, "NewResRef") != "")
        { sMyResREF = GetLocalString(OBJECT_SELF, "NewResRef"); }

        else
        { sMyResREF = GetResRef(OBJECT_SELF); }

        if (GetLocalFloat(OBJECT_SELF, "Delay") == 0.0)
        { sDelay = 7200.0; }

        else
        { sDelay = GetLocalFloat(OBJECT_SELF, "Delay"); }

        AssignCommand(oArea,DelayCommand(sDelay, CreateObjectVoid(myTyp, sMyResREF, lMyLoC)));

        // LOG OUTPUT
        // WriteTimestampedLogEntry("Erzeuge: " + sMyResREF + " in " + GetName(oArea) );
      }
    CreateObjectVoid(OBJECT_TYPE_CREATURE, "cre_untotpirat_e", GetLocation(OBJECT_SELF));
  }
  ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
