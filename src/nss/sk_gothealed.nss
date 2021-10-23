int PLAYER_XP_CAP = 3000;    // Cap
int REWARD_XP     = d100(2);

/* GetLastSpell() returns the SPELL_* that was cast.
   GetLastSpellCaster() returns the object that cast the spell.
   GetLastSpellHarmful() returns TRUE if the spell was marked as hostile, FALSE otherwise.
   DetermineCombatRound(object, int) for standard combat actions.*/
#include "ll_include"

void main()
{
  int nHealed = GetLocalInt(OBJECT_SELF, "nHealed");
  object oPC = GetLastSpellCaster();

  if (!GetIsPC(oPC) ) return;
  if ( nHealed == 1 ) { SpeakString("Aua, mit tut immer noch alles weh..."); return; }

  if ((GetXP(oPC) >= 0) && (GetXP(oPC) <= PLAYER_XP_CAP))                       // Check des Cap
  {
    int nLastSpell = GetLastSpell();
    if ( (nLastSpell >= 31) && (nLastSpell <= 35) || (nLastSpell >= 79) && (nLastSpell <= 80) ||
         (nLastSpell == 506)  )
    { //GiveXPToCreature(oPC, REWARD_XP);                                       // Erfahrung zuteilen
      SetXPImproved(oPC, GetXP(oPC)+REWARD_XP);                                 // Erfahrung zuteilen
      SpeakString( "Vielen Dank, mir geht es schon besser.");
      SetLocalInt(OBJECT_SELF, "nHealed", 1);
      DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "nHealed"));
    }
  }
  else
    SpeakString( "Unterfordert, hier gibt es nichts mehr zu lernen.");          // Nachricht
}

