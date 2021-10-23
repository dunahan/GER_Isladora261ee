void main()
{

object     oNews = GetObjectByTag("plc_aktuelleshinweise");
object       oPC = GetEnteringObject();

  if (GetLocalInt(oNews, "restart") == 0)
  {
    if (GetIsPC(oPC) && GetLocalInt(oNews, "active") == 1)
    {
      effect eActive = EffectVisualEffect(VFX_DUR_PARALYZED);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eActive, oNews);
      SetLocalInt(oNews, "restart", 1);
    }
  }
}
