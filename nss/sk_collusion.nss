#include "_debugisla"

void main()
{
  int nCollusion = GetLocalInt(OBJECT_SELF, "Coll");

  if (nCollusion == 0 ) // Kollision aktivieren!
  { SendServerMessageToPC(OBJECT_SELF, "Kollisionsabfrage deaktiviert!");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), OBJECT_SELF); }
  else                  // Kollision deaktivieren!
  { SendServerMessageToPC(OBJECT_SELF, "Kollisionsabfrage aktiviert!");
    RemoveEffect(OBJECT_SELF, EffectCutsceneGhost() ); }
}
