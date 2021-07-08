void main()
{
    object oNPC = OBJECT_SELF;
    // Sicherstellen, dass er gerade nichts anderes macht
    ClearAllActions();
    // Zufallszahl zwischen 1 und 6
    // Random(6) liefert eine Zahl zwischen 0 und 5
    int iZufall = Random(6) + 1;
    switch (iZufall)
    {
        case 1:
        {
            AssignCommand(oNPC, ActionSpeakString("Ù-chebin estel anim!"));
            break;
        }
        case 2:
        {
            AssignCommand(oNPC, ActionSpeakString("Avo drasto nín!"));
            break;
        }
        case 3:
        {
            AssignCommand(oNPC, ActionSpeakString("Im dae ne galad!"));
            break;
        }
        case 4:
        {
            AssignCommand(oNPC, ActionSpeakString("Im gorgoran cen!"));
            break;
        }
        case 5:
        {
            AssignCommand(oNPC, ActionSpeakString("Lastach huil nîn?"));
            break;
        }
        case 6:
        {
            AssignCommand(oNPC, ActionSpeakString("Mathach naeg nîn?"));
            break;
        }
    }
}

