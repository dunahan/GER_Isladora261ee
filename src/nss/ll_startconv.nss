#include "ll_include"

string GetClassName(int nClass)
{
    return GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nClass)));
}

int StartingConditional()
{
    SetLocalInt(OBJECT_SELF, "CanSetLvl", 0);
    object oPC = GetPCSpeaker();
    string sText = GetName(oPC)+"\n\n";
    int nAXP = GetXP(oPC), nXP = nAXP/LL_XP;
           sText+= "Du hast insg. "+IntToString(nAXP)+" Erfahrung und hast damit ";

    if (nXP < 1)
        sText+= "noch keine keine legendäre Stufe erreicht.\n";

    else if (GetHitDice(oPC) < 40)
        sText+= "noch nicht die 40igste Stufe erreicht.\n";

    else
    {
        int nClass;
        int nTh;
        for (nTh=1; nTh <= nXP; nTh++)
        {
            nClass = GetLocalInt(oPC,"LL_"+IntToString(nTh))-1;
            if(nClass > -1)
            {
                sText+= "\n"+IntToString(40+nTh)+". LL: "+GetClassName(nClass);
            }
            else
            {
                sText+= "\n"+IntToString(40+nTh)+". LL: Keine Klasse";
                SetLocalInt(OBJECT_SELF, "CanSetLvl", nTh);
            }
        }
    }

    SetCustomToken(300, sText);
    return TRUE;
}
