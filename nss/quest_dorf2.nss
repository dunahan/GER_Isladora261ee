void main()
{
    object oG1 = GetNearestObjectByTag("npc_arenar"); //Kennzeichnungen der NPCs
    object oG2 = GetNearestObjectByTag("npc_schamane");
    object oG3 = GetNearestObjectByTag("npc_schamane");
    object oG4 = GetNearestObjectByTag("npc_arenar");
    object oG5 = GetNearestObjectByTag("npc_teufel");
    object oPC=GetEnteringObject();
    if (GetLocalInt(oPC,"npctalk1")==0) // Variable, damit nur einmal abgerufen wird
    {
        //hier die konversation einfuegen
        DelayCommand(2.0,AssignCommand(oG1,SpeakString("Mein Freund... hast du worum ich dich bat?")));
        DelayCommand(22.0,AssignCommand(oG2,SpeakString("*reicht einen kleinen Holzkasten an Arenar* Nach deinem Willen mein Freund")));
        DelayCommand(45.0,AssignCommand(oG3,SpeakString("Elras und Justus werden auf ewig deiner Gedenken und all jene die noch kommen werden, solange sie einander die Treue halten")));
        DelayCommand(70.0,AssignCommand(oG4,SpeakString("Soehne wie ein Vater sie sich nur wuenschen kann... kein Zweifel nagt an mir, dass sie je etwas entzweien koennte")));
        DelayCommand(95.0,AssignCommand(oG5,SpeakString("*unhoerbar fuer die Maenner setzt das haemische Lachen des Teufels ein*Kleine dumme Menschen ihr werdet es nie lernen zu meiner Freude")));
        SetLocalInt(oPC,"npctalk1",1);
    }
}




