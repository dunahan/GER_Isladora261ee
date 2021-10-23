#include "_area_inc"

void main()
{
  // 1++ Deklariere notwendige Variablen
  object oTarget = GetExitingObject();

  if( GetLocalInt(oTarget, "DamageOk") == 1)
  {
    DeleteLocalInt(oTarget, "DamageOk");
  }
}
