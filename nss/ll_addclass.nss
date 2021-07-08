#include "ll_include"

void main()
{
    object oPC = GetPCSpeaker();
    int class = GetLocalInt(OBJECT_SELF, "ChosenClass") + 1;
    int numLL = GetXP(oPC)/LL_XP;

    if (numLL > 0)
    {
        int nClass;
        int nTh;
        for (nTh=1; nTh <= numLL; nTh++)
        {
            nClass = GetLocalInt(oPC,"LL_"+IntToString(nTh));
            if(nClass == 0)
            {
                SetLocalInt(oPC,"LL_"+IntToString(nTh),class);
                SetCampaignInt("LL",GetName(oPC)+"_"+IntToString(nTh),class);
                break;
            }
        }
    }

    LegendaryLevelsRecalculate(oPC);
//  LegendaryLevelsTempHP(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMONDRAGON),oPC);
}
