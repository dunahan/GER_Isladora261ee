void main()
{
object  oTarget = OBJECT_SELF;
effect  eEffect = EffectVisualEffect(GetLocalInt  (oTarget, "effect"));
float fDuration =                    GetLocalFloat(oTarget, "duration");
int       nTime =                    GetLocalInt  (oTarget, "time");
int     nActive =                    GetLocalInt  (oTarget, "active");

  if ( GetTimeHour() >= nTime && nActive == 0 )
  {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
    SetLocalInt(oTarget, "active", 1);
    DelayCommand(fDuration, DeleteLocalInt(oTarget, "active"));
  }
}
