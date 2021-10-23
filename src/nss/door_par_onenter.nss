// Kommt in einen Ausloser bei OnEnter rein

#include "door_inc"

void main()
{
  object oEnter = GetEnteringObject();         // Erfasse das betrende Objekt
  string sTag   = GetTag(OBJECT_SELF);         // Lese den Tag des Auslosers aus
  object oDoor  = GetObjectByTag("Door_"+sTag);// Erfasse die Tur

  if (GetLocked(oDoor) == FALSE)               // Tur ist nicht abgeschlossen,
    return;                                    // somit brich das Skript ab

  string sParole = Parole(sTag);               // Bilde die Parole, siehe Include-File door_par_inc
  string sLosung = Losung(sTag);               // Bilde die Losung

  SetLocalString(oDoor, "parole", sParole);    // Speichere diese auf der Tur ab
  SetLocalString(oDoor, "losung", sLosung);    // Speichere diese auf der Tur ab

  AssignCommand(oEnter, ClearAllActions(TRUE)); // Beende alle Handlungen des betretenden Objekts und
  AssignCommand(oDoor, ActionStartConversation(oEnter, "door_par_tlkfile", FALSE, TRUE)); // starte das Gesprach
}
