/*

Chromatic Orb

Dialogue table description
**************************

Caster Level(s): Wizard/Sorcerer 1, Bard 1.
Innate Level: 1
School: Evocation
Descriptor(s):
Component(s): Verbal, Somatic
Range: long
Area of Effect/Target: one
Duration: instant
Additional Counter Spells: N/A
Save: Fortitude, special
Spell Resistance: yes

This spell causes a shimmering sphere to appear in the caster's hand. When thrown, the sphere heads unerringly to its target. The effect the orb has upon the target varies with the level of the mage who casts the spell. Each orb will do damage to the target against which there is no save, and an effect against which the target must save vs. spells at +4.

At first level, the sphere inflicts 1-4 damage and blinds the target for one round.
At second level, the sphere inflicts 1-4 damage and knocks the victim down.
At third level, the sphere deals 1-6 damage and slows the victim.
At fourth level, the sphere deals 1-6 damage and blinds the target for 1 turn.
At fifth level, the sphere deals 1-8 damage and stuns the target for 3 rounds.
At sixth level, the sphere deals 1-8 damage and causes weakness in the victim.
At seventh level, the sphere deals 1-10 damage and paralyzes the victim for 2 turns.
At tenth level, the sphere causes 1-12 damage and turns the victim to stone.
At twelfth level, the sphere will inflict 2-16 points of damage and instantly kill the victim.

**************************

The base save for this spell is DC-4. There are comments in the code on how to modify DC.

This spell is a port of the Baldur's Gate series spell. Some of the original effects have been
replaced - "burn" with "slow" effect, and "pain" with "knockdown". The knockdown effect is applied
for one round.

spells.2da line.
Note: Bioware has declared line 1500 as the starting line for custom spells, but well... Whatever suits
one's fancy.
nwn\2dasource.zip for .2da sources and safe2dalines.txt for reference.
***************************

576   Chromatic_Orb                      110565   is_chromorb       V        L       vs     0x3d        0x3A         bg_s1_chromorb     1      ****     ****    ****      ****     1          1        1000       hand       ****              vco_mehancold03   ****              sco_mehancold03   vs_chant_evoc_lm   vs_chant_evoc_lf   area       1000       ****             vca_outsonic     ****             sca_outsonic       1      vpr_ectocold01     homing         hand            ****               path              ****             1              ****           ****           ****           ****           ****           11         ****     1         110566       1                  0                   ****         1                ****        ****       ****       1

***************************

iprp_spells.2da line.
This is for the scroll and item "cast spell" properties.
***************************

552        Chromatic_orb                    110565  7           1           999      576          0           1         1            iss_chromorb

***************************

Icons (*.tga) are included in the archive...

    * * *

Author: Aenn Seidhe Priest
sidhepriest@yandex.ru
   ICQ# 38387129

Changes for Revision 2:
visual effects added, a tiny Maximise bug squashed, save switched to Will.

Anyone may modify this code as he/she pleases, but please do not insert any excessive spaces
or cameling letters (Bioware's horrid "GetMetaMagicFeat" is a classic example of how to hurt the flow of one's
understanding).

*/
#include "NW_I0_GENERIC"
#include "nw_i0_spells"

void main()
{
int Casterlevel=GetCasterLevel(OBJECT_SELF);
object Victim=GetSpellTargetObject();
int Metamagic=GetMetaMagicFeat();

//This can be tinkered with to adjust the projectile's speed.
float Delay=GetDistanceBetweenLocations(GetSpellTargetLocation(), GetLocation(Victim))/20;

//The projectile itself is defined in spells.2da.
//The effect below is the impact splash visual.
effect Missileslam=EffectVisualEffect(VFX_IMP_MAGBLUE);

effect Deathvisual=EffectVisualEffect(VFX_IMP_DEATH);

int Hurt;
int Duration;

effect Magic;

effect Visual;
effect Durable;

int DC=GetSpellSaveDC();
/*
The original DC was DC-6, but that was in 2nd. Ed., where Fortitude saves simply didn't exist,
but there was "one big" "save against spells". The way it worked in 2nd. Ed.: the character
(or creature) had one base save, which improved with levels (was reduced, so at a higher level
the creature succeeded in a save with a lower roll). Hence, there was no such thing as a
lev. 20 Half-orc Barbarian/Fighter with a Fort save of 18 or better. A negative (better than 20
in 3rd Ed.) save against spells (which mages were more competent with, by the way) a character
would acquire sometime around level 28 or so.
Note that a competent level 20 Cleric with Spellcraft 25 will get +5 to save on top of his
already good Fort save (primary for Cleric/Druid/Monk).
All of this means that for NWN, where mages already are quite weak, the effectiveness of this
spell is already lower than in Baldur's Gate series, where Chromatic Orb could kill even
mid-level enemies like Minotaurs (who, with their huge Fort bonuses, get an average of 28-34
saves in NWN). So you might want to switch the line below to "RealDC=DC".
*/
int RealDC=DC-4;

  if (Casterlevel==1)
  {
    Hurt=d4(1);
    Magic=EffectBlindness();
    Duration=1;

       Visual=EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
       Durable=EffectVisualEffect(VFX_DUR_BLIND);

    if (Metamagic==METAMAGIC_MAXIMIZE)
        {
         Hurt=4;
        }

  }

  else if (Casterlevel==2)
  {
    Hurt=d4(1);
    Magic=EffectKnockdown();
    Duration=1;

    Visual=EffectVisualEffect(VFX_IMP_SLOW);
    Durable=EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    if (Metamagic==METAMAGIC_MAXIMIZE)
        {
         Hurt=4;
        }

    }

else if (Casterlevel==3)
    {
    Hurt=d6(1);
    Magic=EffectSlow();
    Duration=5;

    Visual=EffectVisualEffect(VFX_IMP_SLOW);
    Durable=EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=6;
    }
    }

else if (Casterlevel==4)
    {
    Hurt=d6(1);
    Magic=EffectBlindness();
    Duration=10;

    Visual=EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    Durable=EffectVisualEffect(VFX_DUR_BLIND);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=6;
    }
    }

else if (Casterlevel==5)
    {
    Hurt=d8(1);
    Magic=EffectStunned();
    Duration=3;

    Visual=EffectVisualEffect(VFX_IMP_STUN);
    Durable=EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=8;
    }
    }

else if (Casterlevel==6)
    {
    Hurt=d8(1);
    Magic=EffectAbilityDecrease(ABILITY_STRENGTH, d6());
    Duration=20;

    Visual=EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    Durable=EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=8;
    Magic=EffectAbilityDecrease(ABILITY_STRENGTH, 6);
    }
    }

else if ((Casterlevel>=7)&&(Casterlevel<10))
    {
    Hurt=d10(1);
    Magic=EffectParalyze();
    Duration=30;

    Visual=EffectVisualEffect(VFX_IMP_STUN);
    Durable=EffectVisualEffect(VFX_DUR_PARALYZED);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=10;
    }
    }

else if ((Casterlevel>=10)&&(Casterlevel<12))
    {
    Hurt=d12(1);
    Magic=EffectPetrify();

    Visual=EffectVisualEffect(VFX_IMP_SILENCE);

     if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=12;
    }

  }

else if (Casterlevel>=12)
    {
    Hurt=d8(2);
    Magic=EffectDeath();
    //Umhu.

    Visual=EffectVisualEffect(VFX_IMP_DOMINATE_S);

    if (Metamagic==METAMAGIC_MAXIMIZE)
    {
     Hurt=16;
    }

    }

    //Empower check - done outside of level conditions
    if (Metamagic==METAMAGIC_EMPOWER)
    {
     //1.5 times
     Hurt=(Hurt*3)/2;
    }

effect Damage=EffectDamage(Hurt, DAMAGE_TYPE_MAGICAL);

DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Missileslam, Victim));


//Spell resistance check.
if (!MyResistSpell(OBJECT_SELF, Victim, Delay))
    {
DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Damage, Victim));


if (Casterlevel<7)
      {

if(!MySavingThrow(SAVING_THROW_WILL, Victim, RealDC, SAVING_THROW_TYPE_SPELL))
  {
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Visual, Victim));
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, Magic, Victim, RoundsToSeconds(Duration)));
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, Durable, Victim, RoundsToSeconds(Duration)));
  }
      }


else if ((Casterlevel>=7)&&(Casterlevel<=9))
    {
if(!MySavingThrow(SAVING_THROW_WILL, Victim, RealDC, SAVING_THROW_TYPE_SPELL))
  {
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Visual, Victim));
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, Magic, Victim, RoundsToSeconds(Duration)));
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, Durable, Victim, RoundsToSeconds(Duration)));
effect Holdvisual=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Holdvisual, Victim));
  }
    }


//Handling for higher-level instant effects

else if (Casterlevel>=10)
    {
if(!MySavingThrow(SAVING_THROW_WILL, Victim, RealDC, SAVING_THROW_TYPE_SPELL))
  {
   DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, Magic, Victim));
    DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Visual, Victim));
    //With nasty, pointy teeth...
    if(GetObjectType(Victim)==OBJECT_TYPE_CREATURE)
    {
    if (!GetRacialType(Victim)==RACIAL_TYPE_CONSTRUCT||RACIAL_TYPE_UNDEAD)
        {
    DelayCommand(Delay, ApplyEffectToObject(DURATION_TYPE_INSTANT, Deathvisual, Victim));
        }
    }
  }
//End of higher-level handler.
    }


//End of resistance check.
    }

//End of main.
}
