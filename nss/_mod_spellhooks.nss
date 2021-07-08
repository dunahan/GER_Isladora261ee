#include "x2_inc_switches"
#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_craft"
#include "x2_inc_spellhook"

//#include "wdm_inc"
#include "oai_inc_weapstat"
#include "_debugisla"

int DetermineDuration()
{
    int nDuration = 1 + d4(1);
    int nSeconds = nDuration;
    int nDOverride = GetLocalInt(GetModule(),"TIMESTOP_DUR");
    if(nDOverride != 0) nSeconds = nDOverride;
    return nSeconds;
}

void TimeStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"TIMESTOP_DEL");
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "TIMESTOP_DELAY", 1);
    SendServerMessageToPC(oCaster, "Time Stop Recastable In " + IntToString(nDelay) + " seconds");
    DelayCommand(Delay1, SendServerMessageToPC(oCaster, "Time Stop Recastable In " + Message3 + " seconds"));
    DelayCommand(Delay2, SendServerMessageToPC(oCaster, "Time Stop Recastable In " + Message2 + " seconds"));
    DelayCommand(Delay3, SendServerMessageToPC(oCaster, "Time Stop Recastable In " + Message1 + " seconds"));
    DelayCommand(fDelay, SendServerMessageToPC(oCaster, "Time Stop Ready"));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "TIMESTOP_DELAY"));
}

void Timestop(object oCaster)
{
    object oArea = GetArea(oCaster);
    int nDuration = DetermineDuration();
    float fDuration = IntToFloat(nDuration);

    //Time Stop is AOE or Area Wide
    int nTSAOE = GetLocalInt(GetModule(),"TSAOE");

    if(nTSAOE == 0)
    {
      object oTarget = GetFirstObjectInArea(oArea);
      while (GetIsObjectValid(oTarget))
      {
        if(GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
          if(GetHasEffect(EFFECT_TYPE_CUTSCENE_PARALYZE,oTarget) == FALSE && oTarget != OBJECT_SELF)
          {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget,fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oTarget,fDuration);
          }
        }
        oTarget = GetNextObjectInArea(oArea);
      }
    }
    else
    {
      //Radius of the Time Stop Spell
      int nRadius = GetLocalInt(GetModule(),"TSRAD");
      float fRadius = IntToFloat(nRadius);

      location lSpell = GetSpellTargetLocation();
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP),OBJECT_SELF);

      //Freeze All Creatures
      object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
      while(oTarget != OBJECT_INVALID)
      {
        if(GetHasEffect(EFFECT_TYPE_CUTSCENE_PARALYZE,oTarget) == FALSE && oTarget != OBJECT_SELF)
        {
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget,fDuration);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oTarget,fDuration);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
      }
    }
}

void TimestopCheck(object oCaster, int nDuration)
{
    if (nDuration == 0) return;

    nDuration = nDuration - 1;
    float fDuration = IntToFloat(nDuration);
    object oArea = GetArea(oCaster);
    location lCaster = GetLocation(oCaster);

    effect eParalyze = EffectCutsceneParalyze();
    object oTarget = GetFirstObjectInArea(oArea);

    while (GetIsObjectValid(oTarget))
    {
      if(GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
      {
        if(GetIsDM(oTarget) == FALSE)
        {
          if(oTarget != oCaster)
          {
            effect eEffect = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eEffect))
            {
              if(GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE)
              {
                SetLocalInt(oTarget, "TIME_STOPPED", 1);
              }
              eEffect = GetNextEffect(oTarget);
            }

            if(GetLocalInt(oTarget, "TIME_STOPPED") == 0)
            {
              SendServerMessageToPC(oCaster, "Time Stopped");
              AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oTarget, fDuration));
            }

            DeleteLocalInt(oTarget, "TIME_STOPPED");
          }
        }
      }

     oTarget = GetNextObjectInArea(oArea);
   }

   DelayCommand(1.0, TimestopCheck(oCaster, nDuration));
}

void GSStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"GSANCTUARY_DEL");//In Rounds
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "GSANCTUARY_DELAY", 1);
    SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + IntToString(nDelay) + " seconds");
    DelayCommand(Delay1, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message3 + " seconds"));
    DelayCommand(Delay2, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message2 + " seconds"));
    DelayCommand(Delay3, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message1 + " seconds"));
    DelayCommand(fDelay, SendMessageToPC(oCaster,"Greater Sanctuary Ready"));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "GSANCTUARY_DELAY"));
}

int ORS_Attacks(int BAB)
{
  if(BAB%5){return BAB/5 + 1;}
  else {return BAB/5;}
}

// Spellhookscript starts

void main()
{
// returns the SPELL_* constant of the spell cast
int nSpellID = GetSpellId();
// gets the DC required to save against the effects of the spell
int nSpellDC = GetSpellSaveDC();
// gets the level the PC cast the spell as
int nCasterLevel = GetCasterLevel(OBJECT_SELF);
// gets the class the PC cast the spell as
int nClass = GetLastSpellCastClass();

// returns the targeted object of the spell, if valid
object oSpellTarget = GetSpellTargetObject();
// if an item cast the spell, this function gets that item
object oCastItem = GetSpellCastItem();
// get the caster
object oCaster = OBJECT_SELF;
// get the target
object oTarget = GetSpellTargetObject();

// returns the targeted location of the spell, if valid
location locSpellTarget = GetSpellTargetLocation();

float fDuration; int nDuration;

// Checks if DeadMagic Zone
object oMap = GetArea(oCaster);
int nCLEAR = GetLocalInt(oMap, "DeadMagic");

// Gets the Module
object oMod = GetModule();

// Check the spell.2da for usertype which define if the spell is a spell / spell feat etc..
string sSpellCheck = Get2DAString("spells", "UserType", nSpellID);

// Undeads
int IsUndead = FALSE;
if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) IsUndead = TRUE;

//: DEAD MAGIC ZONE
//:****************************************************************************/

if( nCLEAR == 1 &&  sSpellCheck == "1" )
{
  if ( !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster) )
  {
    SendMessageToPC(oCaster, "Dein Zauber verliert an Kraft bevor er sich voll entfalten kann.");
    SetModuleOverrideSpellScriptFinished();
    return;
  }
}


switch (nSpellID)
  {
//:****************************************************************************/
//: PHB HARM

    case SPELL_HARM:
    {
      //if(GetLocalInt(oMod,"PHBHARM") == 1)
      {
        object oCaster = OBJECT_SELF;
        int nCaster = GetHitDice(oCaster);
        object oTarget = GetSpellTargetObject();
        int nDamage, nHarm;
        int nMetaMagic = GetMetaMagicFeat();
        int nTouch = TouchAttackMelee(oTarget);
        effect eVis = EffectVisualEffect(246);
        effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
        effect eHeal, eDam;

        //PHB Max Value
        int nMV = 150;

        int nCHP = GetCurrentHitPoints(oTarget);
        int nMHP = GetMaxHitPoints(oTarget);

        //Determine Amount Cap At Max
        nHarm = 10 * nCaster;
        if(nHarm > nMV) nHarm = nMV;

        //Check for Metamagic Maximized
        if(nMetaMagic == METAMAGIC_MAXIMIZE) nHarm = nMV;

        //Check that the target is undead
        if(IsUndead)
        {
          //Heal Amount
          int nDiff = nMHP - nCHP;
          if(nDiff > nHarm) nHarm = nDiff;

          eHeal = EffectHeal(nHarm);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);

          //Fire cast spell at event for the specified target
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, FALSE));
        }

        else if (nTouch != FALSE)
        {
          if(!GetIsReactionTypeFriendly(oTarget))
          {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, TRUE));

            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
              //Harm Amount
              if(nCHP < nHarm) nHarm = nCHP - d4(1);

              eDam = EffectDamage(nHarm,DAMAGE_TYPE_NEGATIVE);
              DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
          }
        }
      }
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB HARM
//:****************************************************************************/

  case SPELL_IDENTIFY:
  {
    // Find out if the target is an item;
    object oTarget = GetSpellTargetObject();
    if ( GetObjectType(oTarget) == OBJECT_TYPE_ITEM )
    { // It is! Identify just this item
      SetIdentified(oTarget, TRUE);
      effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
      SetModuleOverrideSpellScriptFinished();
      // return; // we can exit the script now
    }

    else // old spell
    {
      //Declare major variables
      int nLevel = GetCasterLevel(OBJECT_SELF);
      int nBonus = 10 + nLevel;
      effect eLore = EffectSkillIncrease(SKILL_LORE, nBonus);
      effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
      effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
      effect eLink = EffectLinkEffects(eVis, eDur);
      eLink = EffectLinkEffects(eLink, eLore);

      int nMetaMagic = GetMetaMagicFeat();
      int nDuration = 2;

      //Meta-Magic checks
      if(nMetaMagic == METAMAGIC_EXTEND)
      { nDuration = 4; }

       //Make sure the spell has not already been applied
      if(!GetHasSpellEffect(SPELL_IDENTIFY, OBJECT_SELF) || !GetHasSpellEffect(SPELL_LEGEND_LORE, OBJECT_SELF)) //Use Legend Lore constant later
      {
        //Fire cast spell at event for the specified target
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_IDENTIFY, FALSE));

        //Apply linked and VFX effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

      }
    }
    SetModuleOverrideSpellScriptFinished();
    break;
  }

//:****************************************************************************/
//: AREA SPECIFIC TIME STOP
/*
    case SPELL_TIME_STOP:
    {
      //Players Only
      if(!GetIsPC(OBJECT_SELF)) break;

      //if(GetLocalInt(oMod,"TIMESTOP") == 1)
      {
        if(GetLocalInt(OBJECT_SELF, "TIMESTOP_DELAY") == 1)
        {
          FloatingTextStringOnCreature("Timestop is not castable yet", OBJECT_SELF, FALSE);
          SetModuleOverrideSpellScriptFinished();
          break;
        }

        int nDelay = GetLocalInt(GetModule(),"TIMESTOP_DEL");
        float fDelay = IntToFloat(nDelay);
        if(nDelay > 0){ DelayCommand(1.0, TimeStopDelay(OBJECT_SELF)); }

        location lTarget = GetSpellTargetLocation();
        effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
        int nDuration = DetermineDuration();

        //Fire cast spell at event for the specified target
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
        Timestop(OBJECT_SELF);
        DelayCommand(1.0, TimestopCheck(OBJECT_SELF, nDuration));
      }
      SetModuleOverrideSpellScriptFinished();
      break;
    }
*/
//: AREA SPECIFIC TIME STOP
/*:****************************************************************************/


//: Greater Planar Binding
//:****************************************************************************/

    case 62:
    {
      //Declare major variables
      int nMetaMagic = GetMetaMagicFeat();
      int nCasterLevel = GetCasterLevel(OBJECT_SELF);
      int nDuration = GetCasterLevel(OBJECT_SELF)*2;
      effect eSummon;
      effect eGate;
      effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
      effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
      effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);

      effect eLink = EffectLinkEffects(eDur, EffectParalyze());
      eLink = EffectLinkEffects(eLink, eDur2);
      eLink = EffectLinkEffects(eLink, eDur3);

      object oTarget = GetSpellTargetObject();
      int nRacial = GetRacialType(oTarget);
      //Check for metamagic extend
      if (nMetaMagic == METAMAGIC_EXTEND)
      {
          nDuration = nDuration *2;   //Duration is +100%
      }
      //Check to see if a valid target has been chosen
      if (GetIsObjectValid(oTarget))
      {
          if(!GetIsReactionTypeFriendly(oTarget))
          {
              //Fire cast spell at event for the specified target
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_PLANAR_BINDING));
              //Check for racial type
              if(nRacial == RACIAL_TYPE_OUTSIDER)
              {
                  //Allow will save to negate hold effect
                  if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+5))
                  {
                      //Apply the hold effect
                      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                  }
              }
          }
      }
      else
      {
          //If the ground was clicked on summon an outsider based on alignment
          int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
          float fDelay = 3.0;
          switch (nAlign)
          {
              case ALIGNMENT_EVIL:
                  eSummon = EffectSummonCreature("NW_S_VROCK", VFX_FNF_SUMMON_GATE, 3.0);
                  //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
              break;
              case ALIGNMENT_GOOD:
                  eSummon = EffectSummonCreature("NW_S_CTRUMPET", VFX_FNF_SUMMON_CELESTIAL, 3.0);
                  //eGate = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
              break;
              case ALIGNMENT_NEUTRAL:
                  eSummon = EffectSummonCreature("NW_S_SLAADDETH", VFX_FNF_SUMMON_MONSTER_3, 1.0);
                  //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
                  fDelay = 1.0;
              break;
          }
          //Apply the VFX impact and summon effect
          ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
      }
      SetModuleOverrideSpellScriptFinished();
      break;
    }
//: Greater Planar Binding
//:****************************************************************************/


//: Lesser Planar Binding
//:****************************************************************************/
    case 96:
    {
      //Declare major variables
      int nMetaMagic = GetMetaMagicFeat();
      int nCasterLevel = GetCasterLevel(OBJECT_SELF);
      int nDuration = GetCasterLevel(OBJECT_SELF)*2;
      effect eSummon;
      effect eGate;
      effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
      effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
      effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
      effect eLink = EffectLinkEffects(eDur, EffectParalyze());
      eLink = EffectLinkEffects(eLink, eDur2);
      eLink = EffectLinkEffects(eLink, eDur3);

      object oTarget = GetSpellTargetObject();
      int nRacial = GetRacialType(oTarget);
      if(nDuration == 0)
      {
          nDuration = 1;
      }

      //Check for metamagic extend
      if (nMetaMagic == METAMAGIC_EXTEND)
      {
          nDuration = nDuration *2;   //Duration is +100%
      }
      //Check to see if the target is valid
      if (GetIsObjectValid(oTarget))
      {
          if(!GetIsReactionTypeFriendly(oTarget))
          {
              //Fire cast spell at event for the specified target
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_PLANAR_BINDING));
              //Check to make sure the target is an outsider
              if(nRacial == RACIAL_TYPE_OUTSIDER)
              {
                  //Make a will save
                  if(!WillSave(oTarget, GetSpellSaveDC()))
                  {
                      //Apply the linked effect
                      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                  }
              }
          }
      }
      else
      {
          //Get the alignment of the caster
          int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
          float fDelay = 3.0;
          switch (nAlign)
          {
              //Set the summon effect based on alignment
              case ALIGNMENT_EVIL:
                  {
                      eSummon = EffectSummonCreature("NW_S_IMP",VFX_FNF_SUMMON_GATE , fDelay);
                      //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                  }
              break;
              case ALIGNMENT_GOOD:
                  {
                      eSummon = EffectSummonCreature("NW_S_CLANTERN", 219 ,fDelay);
                      //eGate = EffectVisualEffect(219);
                  }
              break;
              case ALIGNMENT_NEUTRAL:
                  {
                      eSummon = EffectSummonCreature("NW_S_SLAADRED", VFX_FNF_SUMMON_MONSTER_3);
                      //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3, ,1.0);
                  }
              break;
          }
          //Apply the summon effect and the VFX impact
          //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetSpellTargetLocation());
          ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
      }
      SetModuleOverrideSpellScriptFinished();
      break;
    }
//: Lesser Planar Binding
//:****************************************************************************/

//: Summon Monster I-IX
//:****************************************************************************/
    case 174: case 175: case 176: case 177: case 178:
    case 179: case 180: case 181: case 182:
      {
        // Declare major variables
        int nSpellID = GetSpellId();
        //int nDuration = GetCasterLevel(OBJECT_SELF);
        nDuration = 24;
        int nFNF_Effect;
        int nRoll = d4();
        string sSummon;

        if(nDuration == 1)
        {
            nDuration = 2;
        }

        // Make metamagic check for extend
        int nMetaMagic =  GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }

        // Actual Spellscript
        if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
        {
                if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_BOARDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_WOLFDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_SPIDDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2; sSummon = "NW_S_beardire";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2; sSummon = "NW_S_diretiger";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRHUGE";    break;
                    case 2: sSummon = "NW_S_WATERHUGE";  break;
                    case 3: sSummon = "NW_S_FIREHUGE";   break;
                    case 4: sSummon = "NW_S_EARTHHUGE";  break;
                }
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRGREAT";    break;
                    case 2: sSummon = "NW_S_WATERGREAT";  break;
                    case 3: sSummon = "NW_S_FIREGREAT";   break;
                    case 4: sSummon = "NW_SW_EARTHGREAT"; break;
                }
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRELDER";   break;
                    case 2: sSummon = "NW_S_WATERELDER"; break;
                    case 3: sSummon = "NW_S_FIREELDER";  break;
                    case 4: sSummon = "NW_S_EARTHELDER"; break;
                }
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRELDER";   break;
                    case 2: sSummon = "NW_S_WATERELDER"; break;
                    case 3: sSummon = "NW_S_FIREELDER";  break;
                    case 4: sSummon = "NW_S_EARTHELDER"; break;
                }
            }
        }
        else  //WITHOUT THE ANIMAL DOMAIN
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_badgerdire";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_BOARDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1; sSummon = "NW_S_WOLFDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2; sSummon = "NW_S_SPIDDIRE";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2; sSummon = "NW_S_beardire";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2; sSummon = "NW_S_diretiger";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRHUGE";   break;
                    case 2: sSummon = "NW_S_WATERHUGE"; break;
                    case 3: sSummon = "NW_S_FIREHUGE";  break;
                    case 4: sSummon = "NW_S_EARTHHUGE"; break;
                }
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRGREAT";   break;
                    case 2: sSummon = "NW_S_WATERGREAT"; break;
                    case 3: sSummon = "NW_S_FIREGREAT";  break;
                    case 4: sSummon = "NW_SW_EARTHGREAT";  break;
                }
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                switch (nRoll)
                {
                    case 1: sSummon = "NW_S_AIRELDER";   break;
                    case 2: sSummon = "NW_S_WATERELDER"; break;
                    case 3: sSummon = "NW_S_FIREELDER";  break;
                    case 4: sSummon = "NW_S_EARTHELDER"; break;
                }
            }
        }

        effect eSummon = EffectSummonCreature(sSummon, nFNF_Effect);

        // Apply the VFX impact and summon effect
        // ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));

        SetModuleOverrideSpellScriptFinished();
        break;
      }

//: Summon Monster I-IX
//:****************************************************************************/

//:  Animate Dead & Control Undead / Create Greater Undead & Create Undead
//:****************************************************************************/
/*
    case   2: case  28: case  29: case  30:
      {
        AdjustAlignment(oCaster, ALIGNMENT_EVIL, 5, FALSE);
        SetModuleOverrideSpellScriptFinished();
        break;
      }
*/
//: Summon Monster I-IX
//:****************************************************************************/

//:****************************************************************************/
//: FIND TRAP - Only FINDS the Traps now and Not DESTROY them too (EP Olson Fix)
    case SPELL_FIND_TRAPS:
    {
      effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
      int nCnt = 1;
      object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER |
             OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
      while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 30.0)
      {
        if(GetIsTrapped(oTrap))
        {
          SetTrapDetectedBy(oTrap, OBJECT_SELF);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
          //DelayCommand(2.0, SetTrapDisabled(oTrap));  // EPOlson: NOT disabled/destroyed
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
      }

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: FIND TRAP
//:****************************************************************************/

    }
}
