
//::///////////////////////////////////////////////////
//:: X0_TRAPFTL_FARRW
//:: OnTriggered script for a projectile trap
//:: Spell fired: SPELL_FLAME_ARROW
//:: Spell caster level: on Trigger
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/17/2002
//::///////////////////////////////////////////////////

#include "x0_i0_projtrap"

void main()
{
  // Auslesen des CasterLevels
  int nCasterLevel = GetLocalInt(OBJECT_SELF, "CasterLevel");

  // Ausloesen der Falle
  TriggerProjectileTrap(SPELL_FLAME_ARROW, GetEnteringObject(), nCasterLevel);
}

