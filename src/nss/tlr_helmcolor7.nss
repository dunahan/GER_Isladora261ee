//::///////////////////////////////////////////////
//:: Tailoring - Dye Helm Color 7
//:: tlr_helmcolor7.nss
//:://////////////////////////////////////////////
/*
    Sets the color to 7.
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 7);

    ExecuteScript("tlr_dyehelm", OBJECT_SELF);
}