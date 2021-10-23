#include "NW_I0_GENERIC"
#include "X0_I0_SPELLS"
#include "X2_INC_SWITCHES"

void DoFlyby();

//This bit from bd_ai_flyby
void DoStomp(int nSmashPower);

void main()
{
    if(GetLocalInt(OBJECT_SELF, "AIRunning"))
    {
        SetCreatureOverrideAIScriptFinished();
        return;
    }

    if(GetLocalInt(OBJECT_SELF, "AIWait"))
    {
        SetCreatureOverrideAIScriptFinished();
        return;
    }

    if(!GetIsInCombat())
    {
        return;
    }

    object oIntruder = GetCreatureOverrideAIScriptTarget();
    //ClearCreatureOverrideAIScriptTarget();

    if(!GetIsObjectValid(oIntruder) || GetIsDead(oIntruder))
    {
        oIntruder = GetNearestSeenEnemy();
    }

    //OK, some general behaviour stuff first.
    if(GetCurrentHitPoints() < GetMaxHitPoints() / 3)
    {
        if(TalentHealingSelf(TRUE))
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
    }
    else if(GetCurrentHitPoints() < GetMaxHitPoints() * 2 / 3)
    {
        if(TalentHealingSelf())
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
    }

    //Be defensive.
    if(TalentPersistentAbilities())
    {
        SetCreatureOverrideAIScriptFinished();
        return;
    }

    if(d3() == 3)
    {
        if(TalentHeal())
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
        if(TalentCureCondition())
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
        if(TalentSummonAllies())
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
        if(d3() != 1)
        {
            if(TalentUseProtectionOnSelf())
            {
                SetCreatureOverrideAIScriptFinished();
                return;
            }
        }
        else
        {
            if(TalentUseProtectionOthers())
            {
                SetCreatureOverrideAIScriptFinished();
                return;
            }
        }

        if(d3() != 1)
        {
            if(TalentUseEnhancementOnSelf())
            {
                SetCreatureOverrideAIScriptFinished();
                return;
            }
        }
        else
        {
            if(TalentEnhanceOthers())
            {
                SetCreatureOverrideAIScriptFinished();
                return;
            }
        }

        if(TalentBuffSelf())
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
    }

    //Dragon Combat
    if(TalentDragonCombat(oIntruder))
    {
        if(d3() != 3 && !GetLocalInt(OBJECT_SELF, "UsedFlyby"))
        {
            SetLocalInt(OBJECT_SELF, "AIRunning", TRUE);
            DelayCommand(1.4, DoFlyby());
            DelayCommand(6.4, SetLocalInt(OBJECT_SELF, "AIRunning", FALSE));
            DelayCommand(6.6, DetermineCombatRound());
        }

        SetCreatureOverrideAIScriptFinished();
        return;
    }

    //Spell attack
    else if(d3() == 3)
    {
        if(TalentSpellAttack(oIntruder))
        {
            SetCreatureOverrideAIScriptFinished();
            return;
        }
    }

    //Don't fly by if we flew by recently
    //It's annoying and also looks weird if a dragon flies up, drops down, then
    //flies straight away again.
    if(GetLocalInt(OBJECT_SELF, "UsedFlyby")) return;

    //Don't interrupt actions with flyby attacks
    if(GetCurrentAction() == ACTION_CASTSPELL ||
       GetCurrentAction() == ACTION_ITEMCASTSPELL ||
       GetCurrentAction() == ACTION_HEAL)
    {
        return;
    }

    //Fly to a different location
    if(d4() == 4)
    {
        SetLocalInt(OBJECT_SELF, "AIRunning", TRUE);
        ClearAllActions();
        DelayCommand(0.8, DoFlyby());
        DelayCommand(5.8, SetLocalInt(OBJECT_SELF, "AIRunning", FALSE));
        DelayCommand(6.0, DetermineCombatRound());

        SetCreatureOverrideAIScriptFinished();
        return;
    }

    //Do flyby attack
    if(d6() == 6)
    {
        ExecuteScript("bd_ai_flyby", OBJECT_SELF);
    }
}

//This bit from bd_ai_flyby
void DoStomp(int nSmashPower)
{
    location lSelf = GetLocation(OBJECT_SELF);
    effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, lSelf);

    int nNotCreature;
    int nDamage1;
    int nDamage2;
    effect eDamage;
    effect eKD = EffectKnockdown();
    float fDelay;

    float fRadius = 2.5 + IntToFloat(nSmashPower) / 2;
    if(fRadius >= 5.0) fRadius = 5.0;
    object oStomped = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lSelf, FALSE,
                        OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE |
                        OBJECT_TYPE_DOOR);
    while(GetIsObjectValid(oStomped))
    {
        if(GetObjectType(oStomped) == OBJECT_TYPE_PLACEABLE ||
           GetObjectType(oStomped) == OBJECT_TYPE_DOOR)
        {
            nNotCreature = TRUE;
        }

        if(GetIsEnemy(oStomped) || nNotCreature)
        {
            fDelay = GetRandomDelay();

            if(spellsIsFlying(oStomped))
            {
                nDamage1 = d6(nSmashPower / 2);
                nDamage2 = GetReflexAdjustedDamage(nDamage1, oStomped, 13 +
                                    (nSmashPower / 2));
            }
            else
            {
                nDamage1 = d6(nSmashPower + nSmashPower * nNotCreature);
                nDamage2 = GetReflexAdjustedDamage(nDamage1, oStomped, 15 +
                                    nSmashPower);
            }

            eDamage = EffectDamage(nDamage2, DAMAGE_TYPE_BLUDGEONING);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage,
                                oStomped));

            if(nDamage1 == nDamage2)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                    eKD, oStomped, GetRandomDelay(3.5, 4.5)));
            }
        }

        oStomped = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lSelf, FALSE,
                        OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE |
                        OBJECT_TYPE_DOOR);
    }
}

void DoFlyby()
{
    //Disable for a short duration.
    SetLocalInt(OBJECT_SELF, "UsedFlyby", TRUE);
    DelayCommand(IntToFloat(8 + d6(3)), SetLocalInt(OBJECT_SELF, "UsedFlyby",
                        FALSE));

    string sTag = "WP_DragonCombat";
    int nNth = d2() + 1;

    //Always go to an outer waypoint on the first go.
    if(!GetLocalInt(OBJECT_SELF, "FirstFlyby"))
    {
        SetLocalInt(OBJECT_SELF, "FirstFlyby", TRUE);
    }
    else if(d2() == 2)
    {
        sTag = "WP_DragonCombat2";
        nNth = d4() + 1;
    }

    float fDelay = IntToFloat(6 + d4()) / 2;
    location lFlyTo = GetLocation(GetNearestObjectByTag(sTag, OBJECT_SELF, nNth));
    effect eFlyby = EffectDisappearAppear(lFlyTo);
    effect eCantHitMe = EffectConcealment(100, MISS_CHANCE_TYPE_VS_MELEE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFlyby, OBJECT_SELF, fDelay);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCantHitMe, OBJECT_SELF, fDelay);

    //We don't want to be killed while flying, as this means our corpse seems
    //to get "lost".
    SetImmortal(OBJECT_SELF, TRUE);
    DelayCommand(fDelay, SetImmortal(OBJECT_SELF, FALSE));

    //Do smash when landing (large flybiers only - eg dragons).
    int nSmashPower = GetLocalInt(OBJECT_SELF, "FlybyStompPower");
    if(nSmashPower)
    {
        DelayCommand(fDelay + 2.0, DoStomp(nSmashPower));
    }
}
