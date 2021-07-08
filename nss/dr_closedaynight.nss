void main()
{
  int nChoose = GetLocalInt(OBJECT_SELF, "DayNight");

       if (nChoose == 1)
  {
         if ( (GetIsNight()) && (!GetLocked(OBJECT_SELF)) )
    {
      SetLocked(OBJECT_SELF,FALSE); // Oeffnen
      ActionOpenDoor(OBJECT_SELF);  // Aufschliessen
    }
    else if ( (GetIsDay())   && ( GetLocked(OBJECT_SELF)) )
    {
      ActionCloseDoor(OBJECT_SELF); // Schliessen
      SetLocked(OBJECT_SELF,TRUE);  // Verschliessen
    }
  }

  else if (nChoose == 2)
  {
         if ( (GetIsNight()) && (!GetLocked(OBJECT_SELF)) )
    {
      ActionCloseDoor(OBJECT_SELF); // Schliessen
      SetLocked(OBJECT_SELF,TRUE);  // Verschliessen
    }
    else if ( (GetIsDay())   && ( GetLocked(OBJECT_SELF)) )
    {
      SetLocked(OBJECT_SELF,FALSE); // Oeffnen
      ActionOpenDoor(OBJECT_SELF);  // Aufschliessen
    }
  }
}

