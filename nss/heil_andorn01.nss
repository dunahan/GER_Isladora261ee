void main()
{

  object oPlayer = GetLastUsedBy();;
  int iMaxHP = GetMaxHitPoints(oPlayer);
  int iCurrentHP = GetCurrentHitPoints(oPlayer);

//  int iRandom = Random(6)+1;

    //das Skript um zu sehen, wie gross die Differenz zwischen Aktuellen und Maximal HP ist um das dann zu heilen
  effect eVisual = EffectVisualEffect(VFX_IMP_HEALING_S);


   if(iCurrentHP < iMaxHP)
        {
        effect eHeal = EffectHeal(iMaxHP - iCurrentHP);



       ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
       }


}

