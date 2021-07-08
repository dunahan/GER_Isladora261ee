void main()
{
    string sSpecials = GetResRef(GetItemActivated());
    object oUser = GetItemActivator();
    string sItem = GetStringRight(sSpecials, 6);                                // isla_spec (102018)
    int nMonth = StringToInt(GetStringLeft(sItem, 2));
    int nYear = StringToInt(GetStringRight(sItem, 4));
    effect e; int n, t;
    // DURATION_TYPE_INSTANT, DURATION_TYPE_PERMANENT, DURATION_TYPE_TEMPORARY

    switch (nMonth) {
        case 10:
            e = EffectHeal(GetMaxHitPoints(oUser)-GetCurrentHitPoints(oUser));
            t = DURATION_TYPE_INSTANT;
        break;

        default: n = 0; break;
    }

    switch (nYear) {
        case 2018: n = 1; break;
        default: n = 0; break;
    }

    if (n == 0)
        return;
    else if (n == 1)
        ApplyEffectAtLocation(t, e, GetLocation(oUser));
    else if (n == 2)
        ApplyEffectToObject(t, e, oUser);
}
