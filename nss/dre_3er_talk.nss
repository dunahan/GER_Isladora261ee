void main()
{
    object oG1 = GetNearestObjectByTag("cre_trollwachter_schmuddel"); //Kennzeichnungen der NPCs
    object oG2 = GetNearestObjectByTag("cre_trollwaechter_popel");
    object oG3 = GetNearestObjectByTag("cre_trollwachter_schmuddel");
    object oG4 = GetNearestObjectByTag("cre_trollwachter_borstel");
    object oPC=GetEnteringObject();
    if (GetLocalInt(oPC,"npctalk1")==0) // Variable, damit nur einmal abgerufen wird
    {
        //hier die konversation einfuegen
        DelayCommand(0.5,AssignCommand(oG1,SpeakString("Jungs da kommt Essen auf Beinen!")));
        DelayCommand(4.0,AssignCommand(oG2,SpeakString("Hoffentlich saftiger als die letzte Lieferung!")));
        DelayCommand(8.0,AssignCommand(oG3,SpeakString("Eher Frischfleisch ohne Madenbeilage...")));
        DelayCommand(12.0,AssignCommand(oG4,SpeakString("Gut abgehangen wäre mir lieber!")));
        SetLocalInt(oPC,"npctalk1",1);
    }
}

