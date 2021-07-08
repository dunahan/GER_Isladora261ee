int PLAYER_XP_CAP = 3000;    // Cap
int REWARD_XP     = d100(2);

/* GetLastSpell() returns the SPELL_* that was cast.
   GetLastSpellCaster() returns the object that cast the spell.
   GetLastSpellHarmful() returns TRUE if the spell was marked as hostile, FALSE otherwise.
   DetermineCombatRound(object, int) for standard combat actions.*/
#include "ll_include"

void main()
{
  int nAttacked = GetLocalInt(OBJECT_SELF, "nAttacked");
  object oPC = GetLastSpellCaster();

  if (!GetIsPC(oPC) ) return;
  if ( nAttacked == 1 ) { SpeakString("Du konntest keinen Schaden zufügen."); return; }

  if ((GetXP(oPC) >= 0) && (GetXP(oPC) <= PLAYER_XP_CAP))                       // Check des Cap
  {
    if (GetTotalDamageDealt() >= 5 && GetLastSpellHarmful() == TRUE)
    { //GiveXPToCreature(oPC, REWARD_XP);                                       // Erfahrung zuteilen
      SetXPImproved(oPC, GetXP(oPC)+REWARD_XP);                                 // Erfahrung zuteilen
      SpeakString( "Das war ein Volltreffer!.");
      SetLocalInt(OBJECT_SELF, "nAttacked", 1);
      DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "nAttacked"));
    }
  }
  else
    SpeakString( "Unterfordert, hier gibt es nichts mehr zu lernen.");          // Nachricht
}

