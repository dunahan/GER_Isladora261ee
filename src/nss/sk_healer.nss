void FakeRestore(object oTarget)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
    effect eBad = GetFirstEffect(oTarget);
    // Nach negativen Effekten suchen.
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
        GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
        GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
        GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
        GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
        GetEffectType(eBad) == EFFECT_TYPE_POISON ||
        GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
        GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
        {
            // Den negativen Effekt beseitigen, falls vorhanden.
            RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        // Alle Rassen, ausser Untote, komplett heilen.
        int nHeal = GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget);
        effect eHeal = EffectHeal(nHeal);
        if (nHeal > 0)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}


void main()
{
    // Den Spieler ermitteln, der den Dialog ausgeloest hat, inkl. Gefolge.
    object oPC = GetPCSpeaker();
    object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
    ActionPauseConversation();
    ActionCastFakeSpellAtObject(SPELL_GREATER_RESTORATION, OBJECT_SELF);
    ActionDoCommand(FakeRestore(oPC));
    if (GetIsObjectValid(oHenchman))
    {
        ActionDoCommand(FakeRestore(oHenchman));
        // Nach einem Trank - Wunden heilen - bei einem Gefolgsmann suchen,
        // ist keiner vorhanden, dann erzeugen.
        if (!GetIsObjectValid(GetItemPossessedBy(oHenchman,"NW_IT_MPOTION003")))
        {
            CreateItemOnObject("NW_IT_MPOTION003",oHenchman,3);
        }
    }
    if (GetIsObjectValid(oAnimal))
    {
        ActionDoCommand(FakeRestore(oAnimal));
    }
    if (GetIsObjectValid(oFamiliar))
    {
        ActionDoCommand(FakeRestore(oFamiliar));
    }
    if (GetIsObjectValid(oDominated))
    {
        ActionDoCommand(FakeRestore(oDominated));
    }
    if (GetIsObjectValid(oSummoned))
    {
        ActionDoCommand(FakeRestore(oSummoned));
    }
    ActionResumeConversation();
}

