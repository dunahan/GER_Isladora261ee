#include "_debugisla"

void main()
{
    object oEnter = GetEnteringObject();
    int nHitDice = GetHitDice(oEnter);
    int nMinLvl = GetLocalInt(OBJECT_SELF, "MinLevel");
    string sStringToSpeak = GetLocalString(OBJECT_SELF, "Warning");

    if (nHitDice <= nMinLvl)
    {
      if (GetLocalInt(oEnter, GetTag(OBJECT_SELF)+"_Warn") == 1)   return; // if the were warned before!

      AssignCommand(oEnter, ClearAllActions(TRUE));    // stop from moving!

      ActionSpeakString(sStringToSpeak);
      SendServerMessageToPC(oEnter, sStringToSpeak);

      SetLocalInt(oEnter, GetTag(OBJECT_SELF)+"_Warn", 1);
    }
}

