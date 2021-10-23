// Sample code for applying a 50% movement speed decrease
// penalty to a target

void main()
{
// This is the Object to apply the effect to.
object oTarget = GetEnteringObject();

  // Swamp the entering Object only when the Flag hasnt been set!
  if (GetLocalInt(oTarget, "Swamped") == 0 && !GetIsDM(oTarget) )
  { // Create the effect to apply
    effect eSlowDown = EffectMovementSpeedDecrease(50);

    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlowDown, oTarget);
    // Set a Integer, that determinates this creature is already slowed!
    SetLocalInt(oTarget, "Swamped", 1);
  }
}
