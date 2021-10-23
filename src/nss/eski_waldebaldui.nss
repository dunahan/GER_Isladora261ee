void main()
{
  object oG1 = GetNearestObjectByTag("eski_balduin"); //Kennzeichnungen der NPCs
  object oG2 = GetNearestObjectByTag("eski_waldemar");
  object oG3 = GetNearestObjectByTag("eski_balduin");
  object oG4 = GetNearestObjectByTag("eski_waldemar");
  object oPC=GetEnteringObject();

  if (GetLocalInt(oPC,"npctalk1")==0) // Variable, damit nur einmal abgerufen wird
  {
    //hier die konversation
    DelayCommand(1.5,AssignCommand(oG1,SpeakString("Schönes Wetter heute")));
    DelayCommand(4.0,AssignCommand(oG2,SpeakString("Du spinnst doch es regnet junge Hunde!")));
    DelayCommand(8.0,AssignCommand(oG3,SpeakString("Wieso? Die Sonne scheint doch!")));
    DelayCommand(12.0,AssignCommand(oG4,SpeakString("Das ist der Vollmond, du blindes Huhn!")));

	SetLocalInt(oPC,"npctalk1",1);
  }
}

