#include "x0_i0_spells"
#include "x2_inc_switches"

void DoStomp(int nSmashPower);

//The user of this script will occasionally fly to a weaker target and attack.
void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();
    ClearCreatureOverrideAIScriptTarget();

    if(!GetIsInCombat()) return;

    if(!GetIsObjectValid(oIntruder))
    {
        oIntruder = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    }

    if(!GetIsObjectValid(oIntruder) || GetDistanceToObject(oIntruder) >= 25.0)
    {
        return;
    }

    if(GetLocalInt(OBJECT_SELF, "UsedFlyby")) return;

    //You can choose to decrease the amount a creature flies by.
    if(d6() <= GetLocalInt(OBJECT_SELF, "FlybyInfrequency")) return;

    //Don't interrupt actions with flyby attacks
    if(GetCurrentAction() == ACTION_CASTSPELL ||
       GetCurrentAction() == ACTION_ITEMCASTSPELL ||
       GetCurrentAction() == ACTION_HEAL)
    {
        return;
    }

    int n = 1;
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                        OBJECT_SELF, n, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    int nEnemyScore;
    object oEnemyWorst;
    int nEnemyScoreWorst;
    while(GetIsObjectValid(oEnemy))
    {
        //The tougher the enemy, the higher the score.
        nEnemyScore = (GetCurrentHitPoints(oEnemy) / 4) + GetAC(oEnemy) +
                            GetLevelByClass(CLASS_TYPE_BARBARIAN) +
                            GetLevelByClass(CLASS_TYPE_BLACKGUARD) +
                            GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION) +
                            GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER) +
                            GetLevelByClass(CLASS_TYPE_FIGHTER) +
                            GetLevelByClass(CLASS_TYPE_MONK) +
                            GetLevelByClass(CLASS_TYPE_PALADIN) +
                            GetLevelByClass(CLASS_TYPE_RANGER) +
                            GetLevelByClass(CLASS_TYPE_WEAPON_MASTER) -
                            (GetLevelByClass(CLASS_TYPE_CLERIC) / 2) -
                            (GetLevelByClass(CLASS_TYPE_DRUID) / 2) -
                            GetLevelByClass(CLASS_TYPE_SORCERER) -
                            GetLevelByClass(CLASS_TYPE_WIZARD);
        if(!GetIsObjectValid(oEnemyWorst) || nEnemyScore <= nEnemyScoreWorst)
        {
            nEnemyScoreWorst = nEnemyScore;
            oEnemyWorst = oEnemy;
        }

        n++;
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                        OBJECT_SELF, n, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }

    if(!GetIsObjectValid(oEnemy) || GetIsDead(oEnemy) ||
       GetDistanceToObject(oEnemy) >= 25.0 || GetDistanceToObject(oEnemy) <= 3.0)
    {
        oEnemy = oIntruder;
    }

    //Flyby to oEnemy.
    ClearAllActions();
    float fDelay = IntToFloat(6 + d6()) / 2;
    effect eFlyby = EffectDisappearAppear(GetLocation(oEnemy));
    effect eCantHitMe = EffectConcealment(100, MISS_CHANCE_TYPE_VS_MELEE);
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFlyby, OBJECT_SELF, fDelay));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCantHitMe, OBJECT_SELF, fDelay));

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

    //Take no other actions this turn.
    SetCreatureOverrideAIScriptFinished();

    //Disable for a short duration.
    SetLocalInt(OBJECT_SELF, "UsedFlyby", TRUE);
    DelayCommand(IntToFloat(12 + d6(4)), SetLocalInt(OBJECT_SELF, "UsedFlyby", FALSE));
}

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
