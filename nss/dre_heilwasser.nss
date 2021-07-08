  void main()
{
    object oUser;
    effect eHeal;
    effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_S);
    int nCurrentHitPoints, nMaxHitPoints, nVisualEffectId;
    oUser = GetLastUsedBy();
    nMaxHitPoints = GetMaxHitPoints(oUser); // max. HP
    nCurrentHitPoints = GetCurrentHitPoints(oUser); // akt. HP
    if ( nCurrentHitPoints < nMaxHitPoints )
    {
        eHeal = EffectHeal(nMaxHitPoints - nCurrentHitPoints);
        ApplyEffectToObject( DURATION_TYPE_INSTANT, eHeal, oUser );
        ApplyEffectToObject( DURATION_TYPE_INSTANT, eHealVis, oUser );
    }
}

