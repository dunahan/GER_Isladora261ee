void main()
{
  // Der Gegenstand, wo der "letzte benutzte" Hebel gelagert wird
  // ist die Kennzeichnung des ersten Hebels, allen 4 Hebeln die
  // Kennzeichnung "LEVER_1" bis "LEVER_4" geben.
  string sLeverStatus = GetLocalString(OBJECT_SELF, "LeverTag");
  //SpeakString("Gesuchter Hebel: "+sLeverStatus, TALKVOLUME_SHOUT);

  object oLeverStatus = GetObjectByTag (sLeverStatus);
  if (GetIsObjectValid(oLeverStatus)==TRUE)   //SpeakString("Hebel gefunden!", TALKVOLUME_SHOUT);
  {
  // ========================================================
  string sLeverSequence = GetLocalString(oLeverStatus, "Sequel");
  //SpeakString("Aktuelle Sequenz: "+sLeverSequence, TALKVOLUME_SHOUT);
  // ========================================================

  // Wenn das Raetsel geloest ist oeffnet sich diese Tuer
  string sDoor = GetLocalString(oLeverStatus, "DoorTag");
  object oDoor = GetObjectByTag(sDoor);

  int iLeverCount = GetLocalInt (oLeverStatus, "LEVER_COUNT");
  int iThisLever = StringToInt (GetSubString (GetTag (OBJECT_SELF), 6, 1));
  int iNextLeverExpected = StringToInt (GetSubString (sLeverSequence, iLeverCount, 1));

  // Hebel-Animation abspielen
  ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
  ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

  if (iThisLever == iNextLeverExpected)
  {
    iLeverCount++;
    if (iLeverCount >= GetStringLength (sLeverSequence))
    {
      iLeverCount = 0;
      // Tuer oeffnen
      SetLocked (oDoor, FALSE);
      AssignCommand (oDoor, ActionOpenDoor(oDoor));
      SpeakString("Du hoerst in der Entfernung ein knirschen.");
    }
  }
  else
  {
    // Nicht die richtige Reihenfolge, Ruecksetzung
    SpeakString("Irgendetwas stimmt hier nicht.");
    iLeverCount = 0;
  }
  SetLocalInt (oLeverStatus, "LEVER_COUNT", iLeverCount);
  }
}
