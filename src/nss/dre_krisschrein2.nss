//::///////////////////////////////////////////////
//:: FileName dre_krisschrein2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 18.04.2013 22:30:03
//:://////////////////////////////////////////////
#include "nw_i0_plot"

int StartingConditional()
{

    // Sicherstellen, dass der SC-Sprecher diese Gegenstände in seinem Gepäck trägt
    if(!HasItem(GetPCSpeaker(), "it_que_blutflasche"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_feuerschale"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_knochenkiste"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "que_rum"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "cnrNuggetSilv"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "hw_resyarn"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "cnrGemMineral005"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "X2_IT_SPDVSCR509"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "cnrNuggetIron"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "cnrNuggetGold"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_wetzstein"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_altersaebel"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_enterhaken"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_hut"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_segeltuch"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_daemonenschaedel"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "it_que_schrot"))
        return FALSE;

     return TRUE;
}
