#include "_isla_inc"

void main()
{
    object oPC = GetPCSpeaker();
    // Specify the dice
    int nDice = d20(1);
    // Modifier
    int nMod  = GetFortitudeSavingThrow(oPC);
    // Summary
    int nSum  = nDice + nMod;

    string sDice = IntToString(nDice);
    string sMod  = IntToString(nMod);
    string sSum  = IntToString(nSum);
    // Roll the dice
    SendServerMessageToPC(oPC, "Du hast eine " + sDice + " gewürfelt.\n"+
                               "Du hast einen Bonus/Malus von " + sMod + ".\n"+
                               "Das ergibt dann " + sSum + ".");
    DelayCommand(1.0, ActionSpeakString(ColorString( "// " + GetName(oPC) + " hat eine " + sSum +
                                                     " auf *Zähigkeit* gewürfelt." , 255, 215, 0)));
}
