void main()
{
    object oG1 = GetNearestObjectByTag("Dummy1"); //Kennzeichnungen der NPCs
    object oG2 = GetNearestObjectByTag("Dummy2");
    object oG3 = GetNearestObjectByTag("Dummy1");
    object oG4 = GetNearestObjectByTag("Dummy2");
    object oPC=GetEnteringObject();
    if (GetLocalInt(oPC,"npctalk1")==0) // Variable, damit nur einmal abgerufen wird
    {
        //hier die konversation einfuegen
        DelayCommand(0.5,AssignCommand(oG1,SpeakString("Schönes Wetter heute")));
        DelayCommand(4.0,AssignCommand(oG2,SpeakString("Naja, es war schon mal besser")));
        DelayCommand(8.0,AssignCommand(oG3,SpeakString("Wieso? Die Sonne scheint doch!")));
        DelayCommand(12.0,AssignCommand(oG4,SpeakString("Das ist der Vollmond, du Blindfisch!")));
        SetLocalInt(oPC,"npctalk1",1);
    }
}

