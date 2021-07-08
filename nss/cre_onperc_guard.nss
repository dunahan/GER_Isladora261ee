void main()
{
  object oGesehen = GetLastPerceived();
  // Hier die Kennzeichnung des Gegenstandes auslesen
  string sObject = GetLocalString(OBJECT_SELF, "GuardRing");
  object oGegenstand = GetItemPossessedBy(oGesehen, sObject);

  // Wenn es kein Spieler ist, den die Wache sieht, reagiert sie nicht.
  if (GetIsPC(oGesehen))
  {
    if (oGegenstand != OBJECT_INVALID)
    {
      // Der Spieler hat den Gegenstand.
      ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
      ActionSpeakString("Seid gegrüßt, Freund.");
    }
    else
    {
      // Wenn der Spieler den Gegenstand nicht hat, kommt die Wache naeher.
      ActionSpeakString("Stoppt!");
      ActionMoveToObject(oGesehen);
    }
  }
}

