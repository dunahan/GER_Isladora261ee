const string TAG_CHILD = "nsc_lars";      const float TAGDIST = 1.5;    const string TAG_DADDY = "nsc_harald";
const string TAG_START = "nsc_emmelie";   const float HOMEDIS = 15.0;
const string TAG_HOME  = "TagGame";       const float HEARTBT = 6.0;
const string TAGLOCALO = "TagOrder";      const float ACTWAIT = 2.0;

object GetCreatureByTag(string sTag, int nNth=0)
{
    int i; object oCreature;
    for (i=0; i <= nNth; i++)
    {
        oCreature = GetObjectByTag(sTag, i);
        if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
            return oCreature;
    }

    return OBJECT_INVALID;
}

void main()
{
  object oTagChild, oHidePlace;                                                 // Definiere das Objekt nach dem nachher gesucht werden soll
  object oMe = OBJECT_SELF;
  string sObjectTag = GetTag(oMe);                                              // Lese den Tag des ausfuehrenden Objekts aus
  object oTagHome = GetWaypointByTag(TAG_HOME);                                 // Suche den Heimat-Waypoint
  object oDaddy = GetCreatureByTag(TAG_DADDY);

  if (sObjectTag == TAG_CHILD)                                                  // Ist dies Lars, so
    oTagChild = GetCreatureByTag(TAG_START);                                    // suche Emmelie
  else if (sObjectTag == TAG_START)                                             // Ist dies Emmelie, so
    oTagChild = GetCreatureByTag(TAG_CHILD);                                    // suche Lars

  if (GetIsObjectValid(oTagChild) == FALSE)                                     // Ist das andere Objekt nicht vorhanden
    return;                                                                     // beende das Skript hier

  AssignCommand(oMe, ActionWait(ACTWAIT));
  AssignCommand(oTagChild, ActionWait(ACTWAIT));

  if (Random(19)+1 > 10 && GetLocalInt(oTagHome, "HIDEGAME") == FALSE)
    SetLocalInt(oTagHome, "HIDEGAME", TRUE);                                    // Verstecki?!

  // Hier beginnt das eigentliche Spiel
  if (GetLocalInt(oMe, TAGLOCALO) == 0)                                         // Sollte diese Figur nicht mit fangen dran sein, dann
    ActionMoveAwayFromObject(oTagChild, TRUE);                                  // fliehe von anderem Kind

  else                                                                          // Ansonsten,
  {
    if (GetDistanceToObject(oTagChild) < TAGDIST)                               // Ist es nah genug, dann
    {
      AssignCommand(oMe, ClearAllActions());                                    // beende alle Aktionen
      AssignCommand(oMe, ActionSpeakString("Hab Dich! *lacht*"));               // Spreche den Sieg aus!

      AssignCommand(oTagChild, ClearAllActions());                              // beende alle Aktionen
      AssignCommand(oTagChild, ActionSpeakString("Menno... *lacht*"));          // Spreche Traurigkeit aus!

      DelayCommand(1.0, DeleteLocalInt(oMe, TAGLOCALO));                        // und markiere als fertig
      AssignCommand(oMe, ActionWait(ACTWAIT));                                  // Warte eine gewisse Zeit lang
      AssignCommand(oTagChild, ActionWait(ACTWAIT));                            // Warte eine gewisse Zeit lang
      AssignCommand(oMe, ActionSpeakString("Du bist dran!"));                   // Spreche den naechsten aus

      DelayCommand(1.0, SetLocalInt(oTagChild, TAGLOCALO, 1));                  // Markiere den anderen
      AssignCommand(oMe, ActionMoveAwayFromObject(oTagChild, TRUE));            // und fliehe von anderem Kind
    }

    else if (GetDistanceToObject(oTagChild) > HOMEDIS/2 &&                      // Verstecki-Spiel, suche ein entsprechendes Placeable mit der Kennung HideMe
             GetLocalInt(oTagHome, "HIDEGAME") == TRUE)
    {
        oHidePlace = GetNearestObjectByTag("HideMe");
        AssignCommand(oTagChild, ClearAllActions());
        AssignCommand(oTagChild, ActionSpeakString("*sucht etwas*"));
        AssignCommand(oTagChild, ActionMoveToObject(oHidePlace, TRUE));
        AssignCommand(oMe, ClearAllActions());
        AssignCommand(oMe, ActionSpeakString("*schaut sich um* Wo bist Du?"));
        AssignCommand(oMe, ActionWait(ACTWAIT));
        AssignCommand(oMe, ActionForceFollowObject(oTagChild));
    }

    else if (GetDistanceToObject(oTagChild) > GetLocalFloat(oMe, "dis"))
      SetLocalFloat(oMe, "dis", GetDistanceToObject(oTagChild));                // Speichere lokal ab, wie weit entfernt

    else if (GetDistanceToObject(oTagChild) == GetLocalFloat(oMe, "dis"))       // starte von neuem!
    {
      AssignCommand(oMe, ClearAllActions());                                    // Beende alle Aktionen
      AssignCommand(oMe, ActionSpeakString("Wo bist Du?"));
      AssignCommand(oTagChild, ClearAllActions());                              // Beende alle Aktionen
      AssignCommand(oTagChild, ActionSpeakString("Hier bin ich! *winkt*"));

      AssignCommand(oMe, ActionWait(ACTWAIT));
      AssignCommand(oMe, ActionMoveToObject(oTagHome, TRUE));
      AssignCommand(oTagChild, ActionWait(ACTWAIT));
      AssignCommand(oTagChild, ActionMoveToObject(oTagHome, TRUE));

      DeleteLocalFloat(oMe, "dis");
      DeleteLocalInt(oTagHome, "HIDEGAME");
    }

    else
    {
      AssignCommand(oMe, ClearAllActions());
      AssignCommand(oMe, ActionForceFollowObject(oTagChild));                   // fange/suche das andere Kind
    }
  }

  if (GetDistanceToObject(oTagHome) > HOMEDIS)                                  // Beide sind zu weit entfernt
  {
    AssignCommand(oDaddy, ClearAllActions());                                   // Beende alle Aktionen
    AssignCommand(oDaddy, ActionSpeakString("Kinder! Ich sehe euch nicht!"));

    AssignCommand(oMe, ClearAllActions());                                      // Beende alle Aktionen
    AssignCommand(oMe, ActionSpeakString("*kichert*"));
    AssignCommand(oTagChild, ClearAllActions());                                // Beende alle Aktionen
    AssignCommand(oTagChild, ActionSpeakString("*kichert*"));

    AssignCommand(oMe, ActionWait(ACTWAIT));
    AssignCommand(oMe, ActionMoveToObject(oTagHome, TRUE));                     // und wieder nach Hause zurueck kehren
    AssignCommand(oTagChild, ActionWait(ACTWAIT));
    AssignCommand(oTagChild, ActionMoveToObject(oTagHome, TRUE));               // und wieder nach Hause zurueck kehren
  }

  DelayCommand(HEARTBT, ExecuteScript("eski_tag_start", oMe));
}
