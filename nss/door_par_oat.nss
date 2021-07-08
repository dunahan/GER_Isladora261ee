// Kommt in das Gespraech in einen Zweig des SC's unter OnActionTaken
// rein (zweiter Reiter)

#include "door_inc"

void main()
{
  object oDoor = OBJECT_SELF;                        // Erfasse die Tuer
  object oEnter = GetPCSpeaker();                    // Erfasse den Sprecher

  string sSaid;                                      // Lege eine notwendige temporaere Variable an
  string sLosung = GetLocalString(oDoor, "losung");  // Erfasse die Losung

  if (GetIsListening(oDoor) == TRUE)                 // Hoert die Tuer zu?
  {
    if (GetListenPatternNumber() == 67000)           // Wenn die Tuer etwas hoerte
    {
      sSaid = GetMatchedSubstring(0);                // Erfasse das gehoehrte
      sSaid = GetStringLowerCase(sSaid);             // und verwandle es in Kleinbuchstaben

      if (TestStringAgainstPattern(sLosung, sSaid) == TRUE) // Stimmt das Gehoerte mit der Losung ueberein
      {
        SendServerMessageToPC(oEnter, "Ihr hört ein lautes Knarren und die Türe öffnet sich.");
        AssignCommand(oDoor, ActionUnlockObject(oDoor));
        AssignCommand(oDoor, ActionOpenDoor(oDoor));      // Oeffne die Tuer
      }
    }
  }
}
