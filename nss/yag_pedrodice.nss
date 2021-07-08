#include "_debugisla"

void main()
{
    object oPC = GetPCSpeaker();
    object oPedro = OBJECT_SELF;

    string sText;

    int iPC = d6(1);
    int iPedro = d6(1);

    sText = "Du hast eine "+IntToString(iPC)+" gewuerfelt, Pedro eine "+IntToString(iPedro);
    SendServerMessageToPC(oPC, sText);
    if (iPC > iPedro)
    {
        SetLocalInt(oPedro, "dice", 1);
    }
    else
    {
        SetLocalInt(oPedro, "dice", 2);
    }
}
