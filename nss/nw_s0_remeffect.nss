//::///////////////////////////////////////////////
//:: Remove Effects
//:: Modified for use with the RLCore Denizens of Darkness
//:: NW_SO_RemEffect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes the place of
        Remove Disease
        Neutralize Poison
        Remove Paralysis
        Remove Curse
        Remove Blindness / Deafness
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
//#include "NW_I0_SPELLS"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nSpellID = GetSpellId();
    object oTarget = GetSpellTargetObject();
    int nEffect1;
    int nEffect2;
    int nEffect3;
    int bAreaOfEffect = FALSE;

    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Check for which removal spell is being cast.
    if(nSpellID == SPELL_REMOVE_BLINDNESS_AND_DEAFNESS)
    {
        nEffect1 = EFFECT_TYPE_BLINDNESS;
        nEffect2 = EFFECT_TYPE_DEAF;
        bAreaOfEffect = TRUE;
    }
    else if(nSpellID == SPELL_REMOVE_CURSE)
    {
        nEffect1 = EFFECT_TYPE_CURSE;
    }
    else if(nSpellID == SPELL_REMOVE_DISEASE || nSpellID == SPELLABILITY_REMOVE_DISEASE)
    {
        nEffect1 = EFFECT_TYPE_DISEASE;
        nEffect2 = EFFECT_TYPE_ABILITY_DECREASE;
    }
    else if(nSpellID == SPELL_NEUTRALIZE_POISON)
    {
        nEffect1 = EFFECT_TYPE_POISON;
        nEffect2 = EFFECT_TYPE_DISEASE;
        nEffect3 = EFFECT_TYPE_ABILITY_DECREASE;
    }


    // * March 2003. Remove blindness and deafness should be an area of effect spell
    if (bAreaOfEffect == TRUE)
    {
        effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
        effect eLink;

        spellsGenericAreaOfEffect(OBJECT_SELF, GetSpellTargetLocation(), SHAPE_SPHERE, RADIUS_SIZE_MEDIUM,
            SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, eImpact, eLink, eVis,
            DURATION_TYPE_INSTANT, 0.0,
            SPELL_TARGET_ALLALLIES, FALSE, TRUE, nEffect1, nEffect2);
        return;
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    //Remove effects
    RemoveSpecificEffect(nEffect1, oTarget);
    if(nEffect2 != 0)
    {
        RemoveSpecificEffect(nEffect2, oTarget);
    }
    if(nEffect3 != 0)
    {
        RemoveSpecificEffect(nEffect3, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    ///*************Added code for RLCore Curses*************************
    //DEBUG START
    //SendMessageToPC(oTarget,"DEBUG: Remove Curse has been applied");
    //DEBUG END

    object oItem = GetFirstItemInInventory(oTarget);
    string sItem = "RL_CURSE";
    string sItem2 = "RL_VIRUS";
    // check inventory for item

    if(nSpellID == SPELL_REMOVE_CURSE)
    {
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetStringLeft((GetTag(oItem)), 8) == sItem && GetTag(oItem) != "RL_CURSE_ODEM")
            {
                //DEBUG START
                //SendMessageToPC(oTarget,"DEBUG: Curse Should Be Removed");
                //DEBUG END
                SetItemCursedFlag(oItem, FALSE);
                SetPlotFlag(oItem, FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                DestroyObject(oItem);

                int IsLycan = GetLocalInt(oTarget,"nRL_IS_LYCAN");
                if (IsLycan)
                {
                    RemoveEffects(oTarget);
                }
                DeleteLocalInt(oTarget, "nRL_IS_LYCAN");
                DeleteLocalInt(oTarget, "nRL_HAS_BAD_SKIN");
                DeleteLocalInt(oTarget, "nRL_WAS_TODAY_A_LYCAN");
                DeleteLocalInt(oTarget, "nRL_CURSE_HOUR");

                //If the curse is lycanthropy
                if (GetStringLeft((GetTag(oItem)), 10) == "RL_CURSE_W")
                {
                    //check to see if the PC survives the curse being removed...
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH))
                    {
                        SendMessageToPC(oTarget,"You body is stong enough to repel the lycanthropy");
                    }
                    else
                    {
                        SendMessageToPC(oTarget,"The shock to your system as the curse is removed is to much!");
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                    }
                }
            }
            else
            if (GetTag(oItem) == "RL_CURSE_ODEM")
            {
                //int nModifier = 3;
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
                {
                    SendMessageToPC(oTarget,"Odem: 'What!?  No!!!'");
                    SetItemCursedFlag(oItem, FALSE);
                    SetPlotFlag(oItem, FALSE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DEATH),oTarget);
                    DestroyObject(oItem);
                    RemoveEffects(oTarget);
                    DeleteLocalInt(oTarget, "nRL_CURSE_BEGINS");
                    DeleteLocalInt(oTarget, "nRL_HAS_BAD_SKIN");
                }
                else
                {
                    SendMessageToPC(oTarget,"Odem: 'Haha! You will have to do better then that my little toy....'");
                }
            }
            oItem = GetNextItemInInventory(oTarget);
        }
    }

    if(nSpellID == SPELL_REMOVE_DISEASE)
    {
        int ViralStageA = GetLocalInt(oTarget,"nRL_VIRUS_STAGEA");
        int ViralStageB = GetLocalInt(oTarget,"nRL_VIRUS_STAGEB");
        int ViralStageC = GetLocalInt(oTarget,"nRL_VIRUS_STAGEC");

        while (!(oItem == OBJECT_INVALID))
        {
            if (GetStringLeft((GetTag(oItem)), 8) == sItem2)
            {
                if (ViralStageC)
                {
                    if (/*Will Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()-4, SAVING_THROW_TYPE_DEATH))
                    {
                        //DEBUG START
                        SendMessageToPC(oTarget,"The virus is purged from your system!");
                        //DEBUG END
                        SetItemCursedFlag(oItem, FALSE);
                        SetPlotFlag(oItem, FALSE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        DestroyObject(oItem);
                        RemoveEffects(oTarget);

                        DeleteLocalInt(oTarget, "nRL_HAS_BAD_SKIN");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEA");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEB");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEC");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_CARRIER");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_VIRAL");
                    }
                    else
                    {
                        SendMessageToPC(oTarget,"The spell has no effect!  The virus is still active in your body!");
                    }
                }
                else
                if ((ViralStageB) &&  (!ViralStageC))
                {
                    if (/*Will Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH))
                    {
                        //DEBUG START
                        SendMessageToPC(oTarget,"The virus is purged from your system!");
                        //DEBUG END
                        SetItemCursedFlag(oItem, FALSE);
                        SetPlotFlag(oItem, FALSE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        DestroyObject(oItem);
                        RemoveEffects(oTarget);

                        DeleteLocalInt(oTarget, "nRL_HAS_BAD_SKIN");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEA");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEB");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEC");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_CARRIER");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_VIRAL");
                    }
                    else
                    {
                        SendMessageToPC(oTarget,"The spell has no effect!  The virus is still active in your body!");
                    }
                }
                else
                if ((ViralStageA)  &&  (!ViralStageB))
                {
                    //if (/*Will Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()-4, SAVING_THROW_TYPE_DEATH))
                    //{
                        //DEBUG START
                        SendMessageToPC(oTarget,"The virus is purged from your system!");
                        //DEBUG END
                        SetItemCursedFlag(oItem, FALSE);
                        SetPlotFlag(oItem, FALSE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        DestroyObject(oItem);
                        RemoveEffects(oTarget);

                        DeleteLocalInt(oTarget, "nRL_HAS_BAD_SKIN");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEA");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEB");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STAGEC");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_CARRIER");
                        DeleteLocalInt(oTarget, "nRL_VIRUS_STATE_VIRAL");
                    //}
                    //else
                    //{
                    //    SendMessageToPC(oTarget,"The spell has no effect!  The virus is still active in your body!");
                    //}
                }
            }
            oItem = GetNextItemInInventory(oTarget);
        }
    }
///******************************************************************
}


