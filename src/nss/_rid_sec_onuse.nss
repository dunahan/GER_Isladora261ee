#include "_isla_inc"

void main()
{
  object oPC = GetLastUsedBy();
  object oTrigger = GetNearestObject(OBJECT_TYPE_TRIGGER);
  object oTarget = GetLocalObject(oTrigger, "Destination");

  if (!GetIsObjectValid(oTarget))
  {
    SendMessageToPC(oPC, "Falsche konfig");
    return;
  }

  DelayedJumpToObject(oPC, oTarget, GetLocalFloat(oTrigger, "s_delay"));
}

