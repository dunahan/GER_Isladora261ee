object oPlayer = GetLastSpeaker();
int imaxhp = GetMaxHitPoints(oPlayer);
int icurrenthp = GetCurrentHitPoints(oPlayer);
int iRandom = Random(6)+1;
int iCounter = GetLocalInt(OBJECT_SELF,"ZUNGE");
int iWunde = GetLocalInt(OBJECT_SELF,"Wunde");

void main()
{
        iCounter++;
        iWunde++;

        if (iCounter <=4)
    {
            switch(iRandom)

                                {
        default:

           break;

        case 1:
            ActionSpeakString("...Jaaa, so geht das aber nicht!...*kratzt mit einem seiner"+
            " schaurigen Gerätschaften den Dreck aus der Wunde*");
            break;

        case 2:
            ActionSpeakString("...Hier ein Stich und dort ein Stich...");
            break;

       case 3:
            ActionSpeakString("...Sag mal..wolltest mit einem Troll kuscheln?!...");
            break;

        case 4:
            ActionSpeakString("...*summt leise vor sich hin*...");
            break;

        case 5:
            ActionSpeakString("...Noch ein Stich!...");
            break;

        case 6:
           ActionSpeakString("...So..nur noch das hier festzurren und...");
            break;

                                }
        }

         if(iCounter <=4)   {
    DelayCommand(13.0, ExecuteScript("heil_gesund", OBJECT_SELF));
                            }

        if ( (icurrenthp == imaxhp)&&(iWunde == 4) )
                                    {
        ActionWait(15.0);

        ActionSpeakString ("*greift sich ein nahe liegendes Tuch und wischt die Haende ab*"+
                           " Das wars, nun bist du wieder zusammengeflickt. Bleib noch ein wenig"+
                           " sitzen bis alles wirkt und treib es das nächste Mal nicht zu wild!");
        AssignCommand(oPlayer,ClearAllActions());
//        SetLocalInt(OBJECT_SELF,"ZUNGE",iWunde=0);
                                    }
        if ((iWunde == 5) && (iCounter== 5))
        {
          SetLocalInt(OBJECT_SELF,"Wunde",iWunde=0);
          SetLocalInt(OBJECT_SELF,"ZUNGE",iCounter=0);
         }

         SetLocalInt(OBJECT_SELF,"Wunde",iWunde);
         SetLocalInt(OBJECT_SELF,"ZUNGE",iCounter);
}


/* object oPlayer = GetLastSpeaker();
int imaxhp = GetMaxHitPoints(oPlayer);
int icurrenthp = GetCurrentHitPoints(oPlayer);
int iRandom = Random(6)+1;
int iCounter = GetLocalInt(OBJECT_SELF,"ZUNGE");

void main()
{


        iCounter++;

        if (iCounter <=5)
    {

            switch(iRandom)

                                {

        default:

           break;

        case 1:
            ActionSpeakString("...Jaaa, so geht das aber nicht!...*kratzt mit einem seiner schaurigen Geraetschaften den Dreck aus der Wunde*");
            break;

        case 2:
            ActionSpeakString("...Hier ein Stich und dort ein Stich...");
            break;

       case 3:
            ActionSpeakString("...Sag mal..wolltest mit einem Troll kuscheln?!...");
            break;

        case 4:
            ActionSpeakString("...*summt leise vor sich hin*...");
            break;

        case 5:
            ActionSpeakString("...Noch ein Stich!...");
            break;

        case 6:
           ActionSpeakString("...So..nur noch das hier festzurren und...");
            break;

                                }
        }



        if ( (icurrenthp == imaxhp)&&(iCounter == 5) )
                                    {
        ActionWait(15.0);

        ActionSpeakString ("*greift sich ein nahe liegendes Tuch und wischt die Haende ab* Das wars, nun bist du wieder zusammengeflickt. Bleib noch ein wenig sitzen bis alles wirkt und treib es das naeste Mal nicht zu wild!");
        AssignCommand(oPlayer,ClearAllActions());
                                    }

         if(iCounter <=5)   {
    DelayCommand(15.0, ExecuteScript("heil_gesund", OBJECT_SELF));
                            }

         SetLocalInt(OBJECT_SELF,"ZUNGE",iCounter);
}*/
