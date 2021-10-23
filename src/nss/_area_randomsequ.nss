#include "_isla_inc"

void main()
{
  // 1++ Basis aufbauen
  // 1.1 Wichtige Variablen deklarieren, Daten sammeln
  string sTarget = GetLocalString(OBJECT_SELF, "Target");  // Lese den Tag des "Speichers" aus
  object  oLever = GetObjectByTag(sTarget);                // "Speicher" für das Wort über den ausgelesenen Tag erfassen
  int   nAlready = GetLocalInt(OBJECT_SELF, "Randomized"); // Wurde bereits einmal neu zusammen gewürfelt?
  string sString = GetLocalString(OBJECT_SELF, "String");  // Wird ein gewisser Speicherstring vorausgesetzt
  string sSequel, sRanSeq; int nModus;

  // 1.1.1 Sicherheitsabfrage zum Thema Speicherpunkt
  if (sString == "" )  sString = "Fehler im Skript _area_randomsequ!";

  // 2++ Eigentliches Skript ausführen
  // 2.1 Prüf ab, ist der "Speicher" existent
  if (GetIsObjectValid(oLever) == TRUE)
  {
    // 2.1 Prüf ab, wurde er bereits benutzt
    if (nAlready == 0)
    {
      // 2.1.1 Da nicht, fahre fort und lese weiter aus
      sSequel = GetLocalString(OBJECT_SELF, "Sequel"); // Erfasse die Wörter, die zu Verfügung stehen
      nModus  = GetLocalInt   (OBJECT_SELF, "Modus");  // Erfasse den Modus für die Funktion

      // 2.1.2 Würfle nun das Wort aus, welches genutzt werden soll
      sRanSeq = RandomSequel  (sSequel, nModus);

      // 2.1.3 Speichere es auf dem "Speicher" ab
      SetLocalString(oLever, sString, sRanSeq);

      // 2.1.4 Vermerke im Log, damit es jederzeit nachvollziehbar bleibt
      DebugMode(GetName(OBJECT_SELF) + " erhielt die Sequenz " + sRanSeq);

      // 2.1.5 Vermerke, dass das Wort ausgewürfelt wurde
      SetLocalInt(OBJECT_SELF, "Randomized", 1);
    }
  }

  // 2.2 Der Speicher fehlt, also kann da was nicht stimmen => Vermerke das im Log
  else
    DebugMode("Hebel im Gebiet "+ GetName(GetArea(OBJECT_SELF)) +" zum Auslöser "+ GetName(OBJECT_SELF) +" fehlt" );
}
