#include "_isla_inc"
#include "ll_include"

int iMulti = 20/5; float fDelay = 60.0f;
void main()
{
  if (GetLocalInt(OBJECT_SELF, "revealed"))
  {
  //SendMessageToPC(GetEnteringObject(), "Already revealed");
    return;
  }

  object oPC = GetEnteringObject();                                             // auslösende Kreatur
  object oWaypoint = GetLocalObject(OBJECT_SELF, "SpawnPoint");                 // gespeicherter Spawnpoint
  object oPlaceable;

  if (!GetIsObjectValid(oWaypoint) || !GetLocalInt(OBJECT_SELF, "hidden") || !GetIsPC(oPC))
  {
  //SendMessageToPC(GetEnteringObject(), "Waypoint Missing ("+IntToString(GetIsObjectValid(oWaypoint))+
  //                                     "), not hidden ("+IntToString(GetLocalInt(OBJECT_SELF, "hidden"))+
  //                                     ") or no PC ("+IntToString(GetIsPC(oPC))+")");
    return;
  }

  int nDiff = GetLocalInt(OBJECT_SELF, "s_diff");
  float fReset = GetLocalFloat(OBJECT_SELF, "s_reset");
  if (fReset == 0.0)  fReset = fDelay;

  int iXPawarddc = nDiff * iMulti;
  int iXPaward = (iXPawarddc - (GetHitDice(oPC)-1) * iMulti) * 2;

  int b = GetIsAbilitySuccessfulPrivate(oPC, ABILITY_INTELLIGENCE, nDiff);
      b+= GetIsSkillSuccessfulPrivate(oPC, SKILL_SPOT, nDiff);
      b+= GetIsSkillSuccessfulPrivate(oPC, SKILL_SEARCH, nDiff);

  if (b > 0)
  {
    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
    oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, GetTag(oWaypoint), GetLocation(oWaypoint));
    SetLocalInt(OBJECT_SELF, "hidden", FALSE);
    DelayCommand(fReset, SetLocalInt(OBJECT_SELF, "hidden", TRUE));
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));
  }

  DelayCommand(fReset, DestroyObject(oPlaceable));
}

