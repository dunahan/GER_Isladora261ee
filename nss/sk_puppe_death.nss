#include "ll_include"

void main()
{
  object oPC = GetLastAttacker();
  if (!GetIsPC(oPC)) return;

  int PLAYER_XP_CAP = GetLocalInt(OBJECT_SELF, "LvlCab");                       // Cap

  if ((GetXP(oPC) >= 0) && (GetXP(oPC) <= PLAYER_XP_CAP))                       // Check des Cap
  {   int nReward = d100(2);
      //GiveXPToCreature(GetLastDamager(), nReward);  }                         // Erfahrung geben
      SetXPImproved(GetLastDamager(), GetXP(oPC)+nReward);  }                   // Erfahrung geben
  else
  { SpeakString( "Unterfordert, hier gibt es nichts mehr zu lernen."); }        // Nachricht
}

