//Created by 420 for the CEP
//Check for a valid cloak in conversation
//Based on script tlr_color0.nss by Stacy L. Ropella
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "Cloak_Buy") == 0
       && GetLocalInt(OBJECT_SELF, "Cloak_Copy") == 0)
       return FALSE;

    else
        return TRUE;
}
