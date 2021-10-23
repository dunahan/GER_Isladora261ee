void main()
{
    object oNPC = OBJECT_SELF;
    // Sicherstellen, dass er gerade nichts anderes macht
    ClearAllActions();
    // Zufallszahl zwischen 0 und 2
    // Random(3) liefert eine Zahl zwischen 0 und 3
    int iZufall = Random(3);
    switch (iZufall)
    {
        case 0:
        {
            ActionSpeakString(GetLocalString(oNPC, "random01"));
            DelayCommand(10.0, ActionRandomWalk());
            break;
        }
        case 1:
        {
            ActionSpeakString(GetLocalString(oNPC, "random02"));
            DelayCommand(10.0, ActionRandomWalk());
            break;
        }
        case 2:
        {
            ActionSpeakString(GetLocalString(oNPC, "random03"));
            DelayCommand(10.0, ActionRandomWalk());
            break;
        }
    }
}

