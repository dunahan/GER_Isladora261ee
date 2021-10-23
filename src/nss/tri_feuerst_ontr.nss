void main()
{
  object oTarget = GetEnteringObject();

  if (GetLocalInt(oTarget, "DamageOk") > -1)
    SetLocalInt(oTarget, "DamageOk", -1);
}
