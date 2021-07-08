void main()
{
    object oG1 = GetNearestObjectByTag("npc_vater"); //Kennzeichnungen der NPCs
    object oG2 = GetNearestObjectByTag("npc_elras");
    object oG3 = GetNearestObjectByTag("npc_vater");
    object oG4 = GetNearestObjectByTag("npc_justus");
    object oG5 = GetNearestObjectByTag("npc_elras");
    object oG6 = GetNearestObjectByTag("npc_vater");
    object oPC=GetEnteringObject();
    if (GetLocalInt(oPC,"npctalk1")==0) // Variable, damit nur einmal abgerufen wird
    {
        //hier die konversation einfuegen
        DelayCommand(2.0,AssignCommand(oG1,SpeakString("Justus... Elras... meine Zeit wird kommen und ihr sollt mein Vermaechtnis gemeinsam weitertragen.")));
        DelayCommand(15.0,AssignCommand(oG2,SpeakString("Sprich nicht so Vater du wirst noch viele Jahreslaeufe erleben an unserer Seite")));
        DelayCommand(32.0,AssignCommand(oG3,SpeakString("Ich werde jedem von euch etwas hinterlassen das euch Glueck und Reichtum bescheren soll")));
        DelayCommand(52.0,AssignCommand(oG4,SpeakString("Vater du hast uns das Leben gegeben und deine Weisheit. Dies ist das wahre Glueck und der wahre Reichtum")));
        DelayCommand(72.0,AssignCommand(oG5,SpeakString("Justus unterbrich Vater nicht!")));
        DelayCommand(92.0,AssignCommand(oG6,SpeakString("Elras dir ueberlasse ich einen Wuerfel, dessen Bedeutung noch weitreichend in der Geschichte von Bedeutung sein wird. Justus du sollst diesen Ring tragen und nie ablegen")));
        SetLocalInt(oPC,"npctalk1",1);
    }
}




