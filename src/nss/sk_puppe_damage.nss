void RespawnObject(string sResRef, int iType, location lLoc)
{
    CreateObject(iType, sResRef, lLoc);
}
#include "ll_include"

void main()
{
  object oPC = GetLastAttacker();
  if (!GetIsPC(oPC)) return;

  int PLAYER_XP_CAP = GetLocalInt(OBJECT_SELF, "LvlCab");                       // Cap

  if ((GetXP(oPC) >= 0) && (GetXP(oPC) <= PLAYER_XP_CAP))                       // Check des Cap
  {
      int nReward = d100(2);
      //GiveXPToCreature(GetLastDamager(), nReward);                            // Erfahrung geben
      SetXPImproved(GetLastDamager(), GetXP(oPC)+nReward);                      // Erfahrung geben
  }
  else
    SpeakString("Unterfordert, hier gibt es nichts mehr zu lernen.");           // Nachricht

  string sResRef = GetResRef(OBJECT_SELF);
  int      iType = GetObjectType(OBJECT_SELF);
  location  lLoc = GetLocation(OBJECT_SELF);
  float   fDelay = 0.0;

  AssignCommand(GetModule(), DelayCommand(fDelay, RespawnObject(sResRef, iType, lLoc))); // Respawn - gegen das Ausnutzen
}

