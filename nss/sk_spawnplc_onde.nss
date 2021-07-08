#include "nw_i0_2q4luskan"
#include "_isla_inc"

void main()
{

object        oPC = GetLastKiller   ();

  while (GetIsObjectValid(GetMaster(oPC)))
  { oPC = GetMaster(oPC); }

  if (GetIsPC(oPC) == TRUE)
  {
    string sMyResREF = GetResRef(OBJECT_SELF);
    object     oArea = GetArea(OBJECT_SELF);
    location  lMyLoC = GetLocalLocation(oArea, "sPLCSpawn");
    float     sDelay;
    int       myTyp  = GetObjectType(OBJECT_SELF);

    if (GetLocalString(OBJECT_SELF, "NewResRef") != "")
    { sMyResREF = GetLocalString(OBJECT_SELF, "NewResRef"); }
    else
    { sMyResREF = GetResRef(OBJECT_SELF); }

    if (GetLocalFloat(OBJECT_SELF, "Delay") == 0.0)
    { sDelay = 600.0; }
    else
    { sDelay = GetLocalFloat(OBJECT_SELF, "Delay"); }

    int nChance = d10();
    if ( (nChance >= 6) && (nChance <= 8) ) // bei einer 6-8 auf 1W10 erschaffe Item
    { CreateObject(OBJECT_TYPE_ITEM, GetLocalString(OBJECT_SELF, "item"), lMyLoC); }

    AssignCommand(oArea, DelayCommand(sDelay, CreateObjectVoid(myTyp, sMyResREF, lMyLoC))); //erschaffe zerstoertes Placeable wieder

    ExecuteScript(GetLocalString(OBJECT_SELF, "Script"), OBJECT_SELF);
  }
}
