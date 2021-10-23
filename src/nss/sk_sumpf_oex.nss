// Sample code for applying a 50% movement speed decrease
// penalty to a target

void main()
{
  object oPC = GetExitingObject();

  if (!GetIsPC(oPC)) return;

  //Remove Slow from the PC
  effect eLoop = GetFirstEffect(oPC);

  while (GetIsEffectValid(eLoop))
  {
    if (GetEffectType(eLoop) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
      RemoveEffect(oPC, eLoop); DeleteLocalInt(oPC, "Swamped");

  eLoop = GetNextEffect(oPC);
  }
}

