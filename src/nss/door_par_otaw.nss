// Kommt in das Gespraech unter den ERSTEN Abschnitt der Tuer
// und in OnTextAppearsWhen (erster Reiter)

#include "door_inc"

int StartingConditional()
{
  string sParole = GetLocalString(OBJECT_SELF, "parole");  // Erfasse die Parole
  SetCustomToken(67000, sParole);                          // und lege sie ins Gespraech

  SetListening(OBJECT_SELF, TRUE);                         // Lasse die Tuer nun horchen
  SetListenPattern(OBJECT_SELF, "**", 67000);              // Setze alle Woerter als Relevant

  return TRUE;                                             // Gebe Wahr aus, damit der Gespraechsteil erscheint
}
