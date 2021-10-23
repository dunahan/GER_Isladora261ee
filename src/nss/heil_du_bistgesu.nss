
    //Initialisierung der spaeteren Variablen
    object oPlayer = GetLastPerceived();
    object oNPC = OBJECT_SELF;
    int imaxhp = GetMaxHitPoints(oPlayer);
    int icurrenthp = GetCurrentHitPoints(oPlayer);
    int iWunde = 0; //GetLocalInt(OBJECT_SELF, "WUNDE");
    int iWunde2 = 0;
    const float HP_DIST = 2.0;// gibt die Entfernung aus, bis wohin er maximal reagiert
    float distance = GetDistanceBetween(oNPC, oPlayer); //berechnet die Distanz zwischen NPC und Spieler

void main()
{




    //prueft ob der Spieler wirklich da ist=>keine doppelte Chat ausgabe
    if( GetIsObjectValid(oPlayer) == FALSE ) {
        PrintString( "heil_du_bistgesu.nss::main() failsafe triggered. Aborting" );
        return;    }
    if( GetLastPerceptionSeen() == FALSE ||
        GetIsPC( oPlayer ) == FALSE ) return;


    //Sprachausgabe mit einer kleinen Abfrage nach Grad der Verletzung
       if(GetLastPerceptionSeen() && (icurrenthp == imaxhp) && (iWunde ==0)&& (distance > HP_DIST))
                                                {
           SpeakString( "*Als du den Vorhang beiseite schiebst, erblickt Andorn dich."+
                        " Er betrachtet dich lange, sehr lange und verschränkt dann die Arme"+
                        " vor der Brust. Seine Stirn legt sich in Falten*  Sag mal willst du"+
                        " mich auf den Arm nehmen? Dir fehlt überhaupt nichts! Raus uns meinem"+
                        " Behandlungsraum und nimm die Beine in die Hand!" );

                                                }

        if(icurrenthp < imaxhp && GetLastPerceptionSeen() && (iWunde2 == 0) && (distance > HP_DIST))     {
            SpeakString( "Oh das sieht nicht gut aus, los setzt dich auf den Tisch! *er ruft los*"+
                         " Pimpinelle hol mehr Verbände und vom Wurzelbrei!" );
               iWunde++;
               iWunde2++;
//               SpeakString("Anzahl der Wunde = "+IntToString(iWunde));
                                    }



}


