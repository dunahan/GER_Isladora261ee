// Henchmen Always Bleed to Death
// By Demetrious, OldManWhistler and IntrepidCW
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// Multi util objects script.

/*
This script manages a lot of items, placeables and NPCs that will make the use
of HABD easier for you. You can use the code as shown or modify to your own
needs.

Note that the script uses the TAG and the OBJECT_TYPE to know what code must
be executed.
So, if you want to change a NPC that does something by a Door, you could need to
change the object type or the tag in the code.
*/

#include "habd_include"
#include "_isla_inc"
#include "NW_I0_GENERIC"

//UTILS CONFIGURATION CONSTANTS ************************************************

//:: PORTAL
//
//Tag of the Waypoint where the portal transports PCs.
//const string PORTAL_DESTINYPOINT = "WP_Startgebiet";
  const string PORTAL_DESTINYPOINT = "";

//If TRUE, respawned guys are transported (AND RAISED) by the portal, if FALSE
//only alive guys are transported.
  const int PORTAL_TRANSPORT_RESPAWNED = TRUE;

//Penalties when being RAISED by the Portal, posible values are: "" no penalty
//"SPELL_RAISE_DEAD" as spell penalties, "SPELL_RESURRECTION" as spell penalties.
  const string PORTAL_PENALTY = "";


//:: NPC that RAISES GHOSTs
//
// Cost of the NPC service. It is take from the ghost money. If he has no money
// enough he is still raised.
  const int NPCRaiseGhost_Cost = 500;

//Spell used, it can be "SPELL_RAISE_DEAD" or "SPELL_RESURRECTION"
  const string NPCRaiseGhost_Spell = "SPELL_RESURRECTION";

// If FALSE, it will not raise corpse items carried by the PC Speaker.
  const int NPCRaiseGhost_CorpseItems = TRUE;


//:: BINDSTONE SYSTEM
//
// If TRUE, the location used by BindStones is the one of the nearest BindStone
// Waypoint. Otherwise is the actual location when the Binding is triggered.
  const int Always_Use_BindStoneWaypoints = FALSE;

// If TRUE, a message is displayed when bindstone is activated.
  const int Show_BindStone_Message = FALSE;


//:: DM NPC COMMAND LINE TOOL
//
// The Listen Pattern used by the NPC, it is just an Integer. Just make sure
// that, if you have more NPC Listeners in your module each one uses an unique
// Listern Pattern Integer. You can freely change it.
  const int DM_NPC_CommandLineTool_ListenPattern = 35400;

// Name of the Local Variable (Module) that stores the last command heard. Usefull
// to avoid executing the last correct command twice.
  const string DM_HABD_NPC_CLT_LastCommand_Var = "HABD_DM_NPC_CommandLineTool_LastCommand";





// ***********************************************************************
// FUNCTIONS
// ***********************************************************************


// Executes commands of the HABD DM NPC Listener Command Tool, based on strings.
// oUser is the Character using the conversation or allowing the action.
int UtilsHABDDM_NPCCommandLineTool(object oUser, string sPrefix, string sCommand);
int UtilsHABDDM_NPCCommandLineTool(object oUser, string sPrefix, string sCommand)
{
    if( GetIsDM(oUser)==FALSE && GetIsDMPossessed(oUser)==FALSE ){
        SendServerMessageToPC(oUser, "Fehler. Nur SL's koennen Kommandos geben.");
        return FALSE;
    }


    if(sPrefix != "HABD"){
        SendServerMessageToPC(oUser, "Fehler. Prefix muss HABD sein!");
        return FALSE;
    }

    //Extract instruction and parameters from string
    string sInstruction = HABDStrTokWSS(sCommand,1);
    string sParam1 = HABDStrTokWSS(sCommand,2);
    string sParam2 = HABDStrTokWSS(sCommand,3);
    string sParam3 = HABDStrTokWSS(sCommand,4);
    string sParam4 = HABDStrTokWSS(sCommand,5);
    string sParam5 = HABDStrTokWSS(sCommand,6);

    SendServerMessageToPC(oUser, "Kommandozeilen Werkzeug: Erklaerung '"+sInstruction+"'. "
                            +"Parameter1 '"+sParam1+"'. "+"Parameter2 '"+sParam2+"'. "
                            +"Parameter3 '"+sParam3+"'. "+"Parameter4 '"+sParam4+"'. "
                            +"Parameter5 '"+sParam5+"'."
                            );

    //Now, the List of Valid Commands
    if (sInstruction == ""){
        SendServerMessageToPC(oUser, "Fehler. Kommando nicht bekannt.");
        return FALSE;
    }
    else
    if (sInstruction =="GetPCDBString"){
        //this command displays the DataBase string for the Player Character
        //whose Player Name (parameter1) and Character Name (parameter2) are
        //specified.
        if(sParam1==""){
            SendServerMessageToPC(oUser, "Fehler. Parameter1 (Player Name) fehlt.");
            return FALSE;
        }
        if(sParam2==""){
            SendServerMessageToPC(oUser, "Fehler. Parameter2 (PC Name) fehlt.");
            return FALSE;
        }

        string sData = HABDLoadStringFromDB(sParam1, sParam2);

        // Load stats
        string iDCount = HABDStrTok(sData, 1);
        string iBCount = HABDStrTok(sData, 2);
        string iXCount = HABDStrTok(sData, 3);
        string iGCount = HABDStrTok(sData, 4);

        // Load PC state
        string iHP = HABDStrTok(sData, 5);
        string iState = HABDStrTok(sData, 6);
        string iRespawn = HABDStrTok(sData, 7);
        string iRaise = HABDStrTok(sData, 8);
        string sBindStoneAreaTag = HABDStrTok(sData, 9);

        // variables that allow PCs to be raised when logged out
        string iCorpseRaise = HABDStrTok(sData, 10);
        string iCorpseSpell = HABDStrTok(sData, 11);
        string iCorpseNPCGP = HABDStrTok(sData, 12);

        //custom variable
        string shabdcustomvar = HABDStrTok(sData, 13);

        string sMsg = "";
        sMsg = "DataBaseString fuer Spieler '"+sParam1+"' PC Name '"+sParam2+"' :"+sData+" . \n"
                +"DeathsCount: "+iDCount+"; BleedingCount: "+iBCount+"; XPLostCount: "+iXCount+"; GPLostCount: "+iGCount+" . \n"
                +"HitPoints: "+iHP+"; Status: "+iState+"( "+HABDGetStateName(StringToInt(iState))+" ) ; RespawnTimer: "+iRespawn+"; RaiseTimer: "+iRaise+"; BindStoneAreaTag: "+sBindStoneAreaTag+" . \n"
                +"RaisedWhenLogOut: "+iCorpseRaise+"; RaiseSpellUsedWhenLogOut: "+iCorpseSpell+"; GPDebtToNPCRaiserWhenLogOut: "+iCorpseNPCGP+"; CustomVariable: "
                +shabdcustomvar+" . \n";

        SendServerMessageToPC(oUser, sMsg);
        return TRUE;

    }

    //if no command executed at all
    SendServerMessageToPC(oUser, "Fehler. Kommando nicht bekannt, oder korrekt.");
    return FALSE;
}








// ***********************************************************************
// MAIN ******************************************************************
// ***********************************************************************
// It is a Conditional, to allow more functionality when using with
// Conversations. Finally works as a Main, but sometimes returns a usefull value
//
int StartingConditional()
{

string sObjectTag = GetTag(OBJECT_SELF);


//**********************************************************************
// PORTAL that raises a RESPAWNED PC, and teleports him to a waypoint.
// ALIVE PCs are simply transported
/*
It is intended to be used in a conversation action, or with an OnUsed Event
Really you can use a portal, an NPC, a placeable... note that it doesnt fires
a conversation, you must put the conversation and use a script that fires the
conversation (not needed for NPCs, but needed for placeables). Scripts
X0_STARTCONV, nw_g0_convplac, nw_g0_convdoor, nw_startconv will be usefull.
This object is intended to be used in a sort of hell.
Note that you can introduce your own conditions to be raised... or access to the
portal.
*/

if (sObjectTag == "HABD_RaisePortal_UtilsObject")
{
    object oRespPoint = GetWaypointByTag(PORTAL_DESTINYPOINT);
    location lRespLoc = GetLocation( oRespPoint );
    object oMod = GetModule();

    object oPC=GetPCSpeaker();
        if (oPC == OBJECT_INVALID)
            oPC = GetLastUsedBy();

    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    int iState = HABDGetHABD_PLAYER_STATE(sID,oPC);

    location locDeadBody = HABDLoadPCLocationFromDB(GetPCPlayerName(oPC), GetName(oPC));

    if ( PORTAL_DESTINYPOINT == "" )
    {
      if( iState == HABD_STATE_PLAYER_ALIVE )
      {
        return TRUE;
        /*
        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Moving via portal.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Moviendote a traves del Portal.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Teleportiere via Portal.");

        AssignCommand (oPC, JumpToLocation (locDeadBody) );
        return TRUE;

        AssignCommand( oDeadClon, SetIsDestroyable(TRUE,FALSE,TRUE));
        DestroyObject( oDeadClon );
        */
      }

                //DEBUG: Not translated to spanish
      SendServerMessageToPC(oPC, "OCC: Destiny point is not configured. Possible Bug, alert DMs.");
      return FALSE;
    }


/*
    //if player is alive -e.g. Autoraise- simply transport him
    if( HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_PLAYER_ALIVE )
    {
        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Moving via portal.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Moviendote a traves del Portal.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Teleportiere via Portal.");

        AssignCommand (oPC, JumpToLocation (lRespLoc) );
        return TRUE;
    }
*/
    //player is a respawned ghost
    if( HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_RESPAWNED_GHOST )
    {
        //Raising is not allowed
        if (PORTAL_TRANSPORT_RESPAWNED == FALSE)
        {

            if(HABD_USERLANGUAGE==0)
              SendServerMessageToPC(oPC, "Server: You are still a ghost. Your body must be raised to let you use this portal.");

            else if(HABD_USERLANGUAGE==1)
              SendServerMessageToPC(oPC, "Server: Todavia eres un fantasma. Tu cuerpo debe ser resucitado para permitirte usar este portal.");

            else if(HABD_USERLANGUAGE==2)
              SendServerMessageToPC(oPC, "Server: Du bist weiterhin ein Geist. Deine Leiche muss wiederbelebt werden, damit Du dieses Portal nutzen kannst.");

           return FALSE;
        }

        //Else raise and move player
        else
        {
        // Respawn state has been removed. Restore the player to normal.
        SetCommandable(TRUE);
        SetPlotFlag(OBJECT_SELF, FALSE);
        // Set playerstate to alive.
        HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_ALIVE, sID, oPC);

        if(HABD_USERLANGUAGE==0)
          FloatingTextStringOnCreature("Server: You shake off the ghostly effects.", OBJECT_SELF, FALSE);

        else if(HABD_USERLANGUAGE==1)
          FloatingTextStringOnCreature("Server: Se eliminan los efectos de fanstasma.", OBJECT_SELF, FALSE);

        else if(HABD_USERLANGUAGE==2)
          FloatingTextStringOnCreature("Server: Du schüttelst die Effekte des Geistseins ab.", OBJECT_SELF, FALSE);

        // Restore the player's reputation with HOSTILE faction.
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
        DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while(GetIsEffectValid(eEffect))
        {
            // They are rezzed, remove sanctuary visual effects.
            if (GetEffectType(eEffect) == EFFECT_TYPE_CONCEALMENT)
            {
                RemoveEffect(OBJECT_SELF, eEffect);
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }
        HABDAssociateNotBusy();
        //Posible Penalties
        AssignCommand(OBJECT_SELF, ClearAllActions());
            if (PORTAL_PENALTY == "SPELL_RAISE_DEAD")
            {
                HABDApplyPenalty(oPC, HABD_RAISE_XP_LOSS, HABD_RAISE_GP_LOSS, HABD_EVENTRAISINGSIGNAL);
                AssignCommand(oPC, HABDUserDefinedRaise());
            }
            if (PORTAL_PENALTY == "SPELL_RESURRECTION")
            {
                HABDApplyPenalty(oPC, HABD_REZ_XP_LOSS, HABD_REZ_GP_LOSS, HABD_EVENTRESURRECTIONSIGNAL);
                AssignCommand(oPC, HABDUserDefinedResurrection());
            }
         //Move

         if(HABD_USERLANGUAGE==0)
           SendServerMessageToPC(oPC, "Server: Raised and Moving via portal.");

         else if(HABD_USERLANGUAGE==1)
           SendServerMessageToPC(oPC, "Server: Resucitado y moviendote a traves del portal.");

         else if(HABD_USERLANGUAGE==2)
           SendServerMessageToPC(oPC, "Server: Wiedererweckt. Teleportiere via Portal.");

         AssignCommand (oPC, JumpToLocation (lRespLoc) );
         return TRUE;
        }
        //end of else
    }
    //end of player is a respawned ghost

}
//
// /////////////////////////////////////////////////////////////////////////////


else


//**********************************************************************
// NPC that raises a GHOST carried by the speaking PC.
// It can also raise a corpse item in the PC inventory.
// Has sense if you use the uncomandable ghost feature.
/*
It is intended to be used in a conversation action, or with an OnUsed Event of
a placeable. Really you can use a portal, an NPC, a placeable... note that it
doesnt fires a conversation, you must put the conversation and use a script
that fires the conversation (not needed for NPCs, but needed for placeables).
Scripts X0_STARTCONV, nw_g0_convplac, nw_g0_convdoor, nw_startconv will be usefull.
This object is intended to be used as a Cleric that raises your death comrade.
Note that you can introduce your own conditions to be raised, gold cost, etc...
NOTE: It will raise the first ghost encountered of those carried by the PC.
NOTE: It will use a predefined spell  (raise or resurrection).
NOTE: It will take some money from the GHOST (if he has not enough money he is
    raised in any case)
*/
if (sObjectTag == "HABD_RaiseGhost_UtilsNPC")
{
    object oPC=GetPCSpeaker();
        if (oPC == OBJECT_INVALID)
            oPC = GetLastUsedBy();
    object oPCArea = GetArea(oPC);
    object oMod = GetModule();
    string sID = "";
    int iState = 0;

    //search the ghost in the Area
    object oGhost = GetFirstObjectInArea( oPCArea );
    int ifound = FALSE;
    while ( oGhost != OBJECT_INVALID && ifound == FALSE)
    {
        sID = GetPCPlayerName(oGhost)+GetName(oGhost);
        iState = HABDGetHABD_PLAYER_STATE(sID, oGhost);
        if (  iState == HABD_STATE_RESPAWNED_GHOST
            &&      GetLocalObject(oGhost, HABD_GHOST_AUTOFOLLOW) == oPC
            )
          ifound = TRUE;
        else
          oGhost = GetNextObjectInArea(oPCArea);
    }

    //make sure the ghost is near
    float fdistance = 0.0;
    if (ifound == TRUE)
        fdistance = GetDistanceBetween(OBJECT_SELF, oGhost);

    //search for corpses if no valid ghost is found
    int corpsefound = FALSE;
    object ocorpsei = OBJECT_INVALID;
    if (ifound == FALSE || fdistance>20.0f) //no valid or near ghost is found
    {
        if( NPCRaiseGhost_CorpseItems == TRUE ) //if Corpse items are allowed, search for them
        {
            ocorpsei = GetItemPossessedBy(oPC, HABD_CORPSEITEM_FEM_RESREF); //ladys first
            if (ocorpsei == OBJECT_INVALID)
                ocorpsei = GetItemPossessedBy(oPC, HABD_CORPSEITEM_MALE_RESREF);
            if (ocorpsei != OBJECT_INVALID)
                corpsefound = TRUE;
        }
        else  //Corpse items are not allowed
        {

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: HABD Raiser NPC is configured to not raise corpse items.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: HABD PNJ Resucitador esta configurado para no resucitar objetos cadaver.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Es können keinen Leichenobjekte erweckt werden.");
        }
    }

    //error
    if (  (ifound == FALSE || fdistance>20.0f) && corpsefound == FALSE)
        {
            if (ifound == FALSE)
            {

                if(HABD_USERLANGUAGE==0) SendServerMessageToPC(oPC, "Server: No Ghost following you has been found in the area.");

                else if(HABD_USERLANGUAGE==1) SendServerMessageToPC(oPC, "Server: No se ha encontrado ningun fanstasma siguiendote en el area.");

                else if(HABD_USERLANGUAGE==2) SendServerMessageToPC(oPC, "Server: Es wurde kein Geist in der Gegend gefunden, der Dir folgt.");

            }
            if (fdistance > 20.0f)
            {

                if(HABD_USERLANGUAGE==0) SendServerMessageToPC(oPC, "Server: Ghost is too far away from the Ghost Raiser.");

                else if(HABD_USERLANGUAGE==1) SendServerMessageToPC(oPC, "Server: El Fantasma esta muy lejos del Resucitador.");

                else if(HABD_USERLANGUAGE==2) SendServerMessageToPC(oPC, "Server: Der Geist ist zu weit entfernt um erweckt zu werden.");

            }
            if (corpsefound == FALSE)
            {

                if(HABD_USERLANGUAGE==0) SendServerMessageToPC(oPC, "Server: No corpse item has been found in your inventory.");

                else if(HABD_USERLANGUAGE==1) SendServerMessageToPC(oPC, "Server: No se ha encontrado ningun objeto cadaver en tu inventario.");

                else if(HABD_USERLANGUAGE==2) SendServerMessageToPC(oPC, "Server: Es wurde keine Leiche in Deinem Inventar gefunden.");

            }
            return FALSE;
        }

    //If we are trying to raise a corpse item, we must found who is the ghost
    //that owns the corpse.
    //Actually it only works if the PC is logged in
    int corpseownerfound = FALSE;
    if(corpsefound == TRUE && (ifound == FALSE || fdistance>20.0f) )
    {
        oGhost = GetFirstPC();
        while (oGhost!=OBJECT_INVALID && corpseownerfound == FALSE)
        {
            if(GetPCPlayerName(oGhost) == GetLocalString(ocorpsei, HABD_CORPSE_OWNER_PLAYERNAME)
                && GetName(oGhost) == GetLocalString(ocorpsei, HABD_CORPSE_OWNER_PCNAME) )
              { corpseownerfound == TRUE; }
              else oGhost = GetNextPC();
        }
    }

    //owner of the corpse is not logged in
    if(corpsefound == TRUE && (ifound == FALSE || fdistance>20.0f) && corpseownerfound == FALSE)
    {

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: A corpse item has been found, but his owner is not logged in, trying to raise him (he should be raised next time he logs-in).");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Se ha encontrado un objeto cadaver, pero su PJ no esta ahora mismo en el server, intentando resucitarle (deberia ser resucitado la proxima vez que entre en el server).");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Die Leiche wurde gefunden, aber der dazugehörige Spieler ist nicht eingeloggt. Er wird wiedererweckt, wenn er das nächste mal einloggt.");

    }

    //let's see the raise spell to be used
    int iNPCSpell = 0;
    if ( NPCRaiseGhost_Spell == "SPELL_RAISE_DEAD" )
            iNPCSpell = SPELL_RAISE_DEAD;
    else
        if ( NPCRaiseGhost_Spell == "SPELL_RESURRECTION" )
            iNPCSpell = SPELL_RESURRECTION;
        else
            {
                    //DEBUG: Not translated to Spanish
              SendServerMessageToPC(oPC, "OOC: Resurrection spell not configured in script. Possible bug, warn DMs.");
              return FALSE;
            }

    //raise ghost
    if (ifound == TRUE && fdistance<=20.0f)
    {
        HABDCureRespawnGhost(oGhost,iNPCSpell);
    }

    int icorpseraised = FALSE;
    //raise corpse item
    if (ocorpsei != OBJECT_INVALID)
    if (corpseownerfound == TRUE)
    {
        //the owner is logged in
        //cast the apropiate spell to raise.
            HABDCureRespawnGhost(oGhost,iNPCSpell);
            icorpseraised = TRUE;
    }
    else
    if (HABD_RAISE_LOGOUT_PLAYERS == TRUE)
    {
        //owner is logged out, we'll modify the database instead
        //note that it doesnt mark the PC as raised, instead we say that he
        //should be raised when he logs in next time.
        string sPlayerN = GetLocalString(ocorpsei, HABD_CORPSE_OWNER_PLAYERNAME);
        string sPCName = GetLocalString(ocorpsei, HABD_CORPSE_OWNER_PCNAME);
        sID = sPlayerN+sPCName;

        string sData = HABDLoadStringFromDB(sPlayerN, sPCName);

        int iDCount = StringToInt(HABDStrTok(sData, 1));
        int iBCount = StringToInt(HABDStrTok(sData, 2));
        int iXCount = StringToInt(HABDStrTok(sData, 3));
        int iGCount = StringToInt(HABDStrTok(sData, 4));
        int iHP = StringToInt(HABDStrTok(sData, 5));
        int iState = StringToInt(HABDStrTok(sData, 6));
        int iRespawn = StringToInt(HABDStrTok(sData, 7));
        int iRaise = StringToInt(HABDStrTok(sData, 8));
        string sBindStoneAreaTag = HABDStrTok(sData, 9);
        string shabdcustomvar = HABDStrTok(sData, 13);
        // variables that allow PCs to be raised when logged out
        int iCorpseRaise = TRUE;
        int iCorpseSpell = iNPCSpell;
        int iCorpseNPCGP = NPCRaiseGhost_Cost;

        sData = IntToString(iDCount)+","+IntToString(iBCount)+","+IntToString(iXCount)+","+IntToString(iGCount)+","+IntToString(iHP)+","+IntToString(iState)+","+IntToString(iRespawn)+","+IntToString(iRaise)+","+sBindStoneAreaTag+","+IntToString(iCorpseRaise)+","+IntToString(iCorpseSpell)+","+IntToString(iCorpseNPCGP)+","+shabdcustomvar+",0";
        icorpseraised = TRUE;

        //corpse is only created when you respawn.
        if (iState == HABD_STATE_RESPAWNED_GHOST)
        {
        HABDSaveStringToDB(sData, sPlayerN, sPCName);

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Owner of the corpse ( "+sPlayerN+sPCName+" ) was logged out, he has been marked as raised sucessfully.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: El PJ del cadaver ( "+sPlayerN+sPCName+" ) no estaba en el server, ha sido correctamente marcado como resucitado.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Der Besitzer der Leiche ( "+sPlayerN+sPCName+" ) ist nicht eingeloggt. Er wurde als erfolgreich Wiedererweckt markiert.");

        PrintString("HABD_DB: Player Character raised when Player was logged out: ");
        PrintString("HABD_DB: Storing "+sID+" iHP="+IntToString(iHP)+" iState="+IntToString(iState)+" iRespawnTimer="+IntToString(iRespawn)+" iRaiseTimer="+IntToString(iRaise));
        PrintString("HABD_DB: Storing "+sID+" Death="+IntToString(iDCount)+" Bleed="+IntToString(iBCount)+" XPLost="+IntToString(iXCount)+" GPLost="+IntToString(iGCount));
        PrintString("HABD_DB: Storing "+sID+" "+sData);
        }
        else
        {

            if(HABD_USERLANGUAGE==0)
              SendServerMessageToPC(oPC, "Server: The owner of the corpse is not a respawned ghost, he cannot be raised.");

            else if(HABD_USERLANGUAGE==1)
              SendServerMessageToPC(oPC, "Server: El PJ del cadaver no es un fantasma Respawnado, por tanto no puede ser resucitado.");

            else if(HABD_USERLANGUAGE==2)
              SendServerMessageToPC(oPC, "Server: Der Besitzer der Leiche ist kein Geist, er kann nicht wiedererweckt werden.");

        }
    }
    else
        {

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Actually it is not allowed to raise PCs that are not logged in.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Actualmente no se permite resucitar PJs que no estan jugando dentro del server.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Momentan ist es nicht erlaubt Spieler wieder zu erwecken, wenn diese nicht eingeloggt sind.");

        }

    //destroy found corpse
    if (ocorpsei != OBJECT_INVALID)
        if ( icorpseraised == TRUE )
        {
        DeleteLocalString(ocorpsei, HABD_CORPSE_OWNER_PLAYERNAME);
        DeleteLocalString(ocorpsei, HABD_CORPSE_OWNER_PCNAME);
        if (ocorpsei == GetLocalObject(oMod, HABD_PC_CORPSE_OBJECT_ID+sID))
            DeleteLocalObject(oMod, HABD_PC_CORPSE_OBJECT_ID+sID);
            else
                {
                if( GetLocalObject(oMod, HABD_PC_CORPSE_OBJECT_ID+sID) == OBJECT_INVALID )
                    SendServerMessageToPC(oPC, "OOC: It looks that the the corpse was not registed");
                    else         //DEBUG: Not Translated to spanish
                    SendServerMessageToPC(oPC, "OOC: HABD. It looks that there is another corpse item for this PC in the server!! Notify the Bug to DMs.");
                }
        DestroyObject(ocorpsei);
        }

    //take the money to be paid (from the ghost)
    //the money will not be taken if the player is logged out.
    AssignCommand(OBJECT_SELF,TakeGoldFromCreature(NPCRaiseGhost_Cost, oGhost, TRUE) );

    //Animations for the NPC
    if ( GetObjectType(OBJECT_SELF) == OBJECT_TYPE_CREATURE )
      AssignCommand( OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,1.5) );

    return TRUE;
}
//
// /////////////////////////////////////////////////////////////////////////////


else


//**********************************************************************
// BINDSTONE
// Bindstone used with Respawning characters (optional feature)
/*
It is intended to be used with an OnEnter Event of a Trigger.
However it can be used in an OnUsed Placeable Event, in a Covnersation with
a NPC, etc..
The Bindstone will need also a waypoint ONLY if you want persistent bindstone
locations (persistent in the meaning of server reset). In this case the waypoint
should be in the same area as the blindstone, Tag of the waypoint must be always
the same as the BindStones, simply copy and paste the same waypoint one time and
aother and dont care to change the tag. If the area changes its Tag or Resref the
blindstones saved will be lost eventually.
*/
if (sObjectTag == HABD_BINDSTONE_TAG)
{
    object oPC=GetPCSpeaker();
        if (oPC == OBJECT_INVALID)
            oPC = GetLastUsedBy();
                if (oPC == OBJECT_INVALID)
                    oPC = GetEnteringObject();

    location lBindStoneLoc = GetLocation (oPC);

    if (Always_Use_BindStoneWaypoints == TRUE)
        {
        object oBindStoneWp = GetNearestObjectByTag (HABD_BINDSTONE_TAG, oPC);
        if ( oBindStoneWp != OBJECT_INVALID )
            lBindStoneLoc = GetLocation(oBindStoneWp);
        }

    SetLocalLocation(oPC, HABD_RESPAWNBS_LOCATION, lBindStoneLoc);
    if (HABD_BINDSTONE_PERSISTENT == TRUE)
        HABDBindstoneLocationToDB(lBindStoneLoc, oPC);

    if (Show_BindStone_Message == TRUE)

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: HABD Location Bindstone triggered.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: HABD Localizacion registrada (binded).");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Bindungsstein aktiviert.");

    return TRUE;
}
//
// /////////////////////////////////////////////////////////////////////////////


else


//**********************************************************************
// PORTAL that raises a PERMADEATH PC, and teleports him to a waypoint.
// ALIVE PCs are simply transported.
// It is provided as a safety measure. The prefab is not supplied, but it
// as similar to the Raising Portal, only the Tag should be changed.
/*
It is intended to be used in a conversation action, or with an OnUsed Event
Really you can use a portal, an NPC, a placeable... note that it doesnt fires
a conversation, you must put the conversation and use a script that fires the
conversation (not needed for NPCs, but needed for placeables). Scripts
X0_STARTCONV, nw_g0_convplac, nw_g0_convdoor, nw_startconv will be usefull.
As a safety measure you can place the portal in a Non-accesible part of the area
... or into a DM exclusive use area.
Note that you can introduce your own conditions to be raised... or access to the
portal.
*/
if (sObjectTag == "HABD_PermaDeathPortal_UtilsObject")
{
    object oPC=GetPCSpeaker();
        if (oPC == OBJECT_INVALID)
            oPC = GetLastUsedBy();

    if ( PORTAL_DESTINYPOINT == "" )
    {
        //DEBUG: Not translated to spanish
        SendServerMessageToPC(oPC, "OCC: Destiny point is not configured. Posible Bug, alert DMs.");
        return FALSE;
    }

    object oRespPoint = GetWaypointByTag(PORTAL_DESTINYPOINT);
    location lRespLoc = GetLocation( oRespPoint );
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    //if player is alive -e.g. Autoraise- simply transport him
    if( HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_PLAYER_ALIVE )
    {
        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Moving via portal.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Moviendote a traves del Portal.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Teleportiere via Portal.");

        AssignCommand (oPC, JumpToLocation (lRespLoc) );
        return TRUE;
    }

    //player is Permadeath
    if( HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_PC_PERMADEATH )
    {
        //raise and move player
        {
        // Respawn state has been removed. Restore the player to normal.
        SetCommandable(TRUE);
        SetPlotFlag(OBJECT_SELF, FALSE);
        // Set playerstate to alive.
        HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_ALIVE, sID, oPC);

        if(HABD_USERLANGUAGE==0)
          FloatingTextStringOnCreature("Server: You are Raised from Permadeath.", OBJECT_SELF, FALSE);

        else if(HABD_USERLANGUAGE==1)
          FloatingTextStringOnCreature("Server: Eres resucitado de la Muerte Permanente (Permadeath).", OBJECT_SELF, FALSE);

        else if(HABD_USERLANGUAGE==2)
          FloatingTextStringOnCreature("Server: Du wurdest aus dem Totenreich wiedererweckt.", OBJECT_SELF, FALSE);

        // Restore the player's reputation with HOSTILE faction.
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
        DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while(GetIsEffectValid(eEffect))
        {
            // They are rezzed, remove sanctuary visual effects.
            if (GetEffectType(eEffect) == EFFECT_TYPE_CONCEALMENT)
            {
                RemoveEffect(OBJECT_SELF, eEffect);
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }
        HABDAssociateNotBusy();
        //Posible Penalties
        AssignCommand(OBJECT_SELF, ClearAllActions());
            if (PORTAL_PENALTY == "SPELL_RAISE_DEAD")
            {
                HABDApplyPenalty(oPC, HABD_RAISE_XP_LOSS, HABD_RAISE_GP_LOSS, HABD_EVENTRAISINGSIGNAL);
                AssignCommand(oPC, HABDUserDefinedRaise());
            }
            if (PORTAL_PENALTY == "SPELL_RESURRECTION")
            {
                HABDApplyPenalty(oPC, HABD_REZ_XP_LOSS, HABD_REZ_GP_LOSS, HABD_EVENTRESURRECTIONSIGNAL);
                AssignCommand(oPC, HABDUserDefinedResurrection());
            }
         //Move

         if(HABD_USERLANGUAGE==0)
           SendServerMessageToPC(oPC, "Server: Raised and Moving via portal.");

         else if(HABD_USERLANGUAGE==1)
           SendServerMessageToPC(oPC, "Server: Resucitado y moviendote a traves del portal.");

         else if(HABD_USERLANGUAGE==2)
           SendServerMessageToPC(oPC, "Server: Wiedererwecken und Teleportieren via Portal.");

         AssignCommand (oPC, JumpToLocation (lRespLoc) );
         return TRUE;
        }
        //end of else
    }
    //end of player is a respawned ghost

}
//
// /////////////////////////////////////////////////////////////////////////////


else


//**********************************************************************
// ONOPEN and ONUSED of the DeathBag Placeable.
// It is configured by the habd_include. Basically, it wil ensure that the only
// players allowed to take the dropped items will be the PCs on the death PC
// team, or the death player only.
/*
    The script must be placed in the OnOpen Event of the deathbag placeable.
    (already comes with the prefab). What it does is to cancel actions of everyone
    who opens the deathbag and is not allowed to loot.
*/
if (sObjectTag == HABD_PLACEABLE_BAG)
{
    int OnOpen = TRUE;

    //maybe it does not have a container, and can only be used
    //note that when you use a container placeable you open it
    object oPC = GetLastOpenedBy();
    if ( oPC == OBJECT_INVALID )
        {
        oPC = GetLastUsedBy();
        OnOpen = FALSE;
        }

    if (oPC == OBJECT_INVALID ) return FALSE;

    //let's see who is the owner of the deathbag
    object oOwner = GetLocalObject(OBJECT_SELF, HABD_BAG_OWNER);
    string sName = GetLocalString(OBJECT_SELF, HABD_BAG_OWNER_NAME);

    string sdeadmsg;
        if(HABD_USERLANGUAGE==0)
            sdeadmsg = "Dead: ";
        else if(HABD_USERLANGUAGE==1)
            sdeadmsg = "Muerto: ";

    //ON OPEN EVENT
    if (OnOpen == TRUE)
    {
    if (oOwner == OBJECT_INVALID ) return FALSE;
        //says the name of the dead PC
        if ( HABD_BAG_SAYSNAMETOPLAYERS == TRUE || GetIsDM(oPC) || GetIsDMPossessed(oPC) )
        AssignCommand(OBJECT_SELF, SpeakString(sdeadmsg+sName, TALKVOLUME_TALK)  );
    // If set to 2, or PC is DM, or PC is the Death PC, allow looting
    if (HABD_DROP_ALLOWED_LOOTERS == 2 || GetIsDM(oPC) || GetIsDMPossessed(oPC)
        || oPC == oOwner )
        return TRUE;
    // If set to 1 and PC is in party.
    if (HABD_DROP_ALLOWED_LOOTERS == 1 && GetFactionEqual(oPC, oOwner))
        return TRUE;
    // Else Looting is not allowed
    if(HABD_USERLANGUAGE==0)
        SendServerMessageToPC(oPC, "HABD: You are not allowed to loot from this Death Bag.");
    else if(HABD_USERLANGUAGE==1)
        SendServerMessageToPC(oPC, "HABD: No se te permite robar de este Contenedor de Muerte.");
    AssignCommand (oPC,ClearAllActions(TRUE));
    AssignCommand (oPC,ActionMoveAwayFromObject(OBJECT_SELF,TRUE, 5.0f));
    AssignCommand (OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    DelayCommand ( 0.001, SetCommandable(FALSE, oPC) );
    DelayCommand ( 1.0, SetCommandable(TRUE, oPC) );
    DelayCommand ( 1.01, AssignCommand (oPC,ActionMoveAwayFromObject(OBJECT_SELF,TRUE, 5.0f)) );
    }
    else
    //ON USED EVENT
    {
        //says the name of the dead PC
        if ( HABD_BAG_SAYSNAMETOPLAYERS == TRUE || GetIsDM(oPC) || GetIsDMPossessed(oPC) )
        AssignCommand(OBJECT_SELF, SpeakString(sdeadmsg+sName, TALKVOLUME_TALK)  );
    }

    return FALSE;
}
//
// /////////////////////////////////////////////////////////////////////////////



else



//**********************************************************************
// COMMAND LINE TOOL FOR DMs (NPC Conversation / Chat Listener Based)
//
// Based on Sir Elric's Verbal Transitions
//
/*
    The script must be placed in the OnSpawn Event of the NPC and somewhere
    at the conversation (where command must be executed).
    NPC should be changed to a Custom Neutral faction.

    The NPC Listener uses the Listen Pattern defined in constant
    DM_NPC_CommandLineTool_ListenPattern in this script.
*/
if (sObjectTag == "HABD_UtilsNPCDMtool")
{
    object oTarget = OBJECT_SELF;
    object oModule = GetModule();

    //Setup Listener
    if (GetLocalInt(oTarget,"HABD_DMCommandLineToolNPCListenerSetup") == FALSE)
    {
        SetListening(oTarget, TRUE);
        SetListenPattern(oTarget, "HABD(**)", DM_NPC_CommandLineTool_ListenPattern);
        SetLocalInt(oTarget,"HABD_DMCommandLineToolNPCListenerSetup", TRUE);
        SpeakString("NPC Setup for Listening the DM commands");
        return FALSE;
    }


    //Listening
    else
    {

    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    string sSaid;
    string sInput;
    string sMsg;

    string sPrefix = HABDCleanWhiteSpacesLR(GetMatchedSubstring(0)); //Should be always HABD
    string sCommand = HABDCleanWhiteSpacesLR(GetMatchedSubstring(1)); //If player says HABDPot, sCommand is "Pot"

    sInput = GetMatchedSubstring(0) + GetMatchedSubstring(1);
    sSaid = sPrefix + sCommand;

    object oPC = GetPCSpeaker();

    //Error: Last command incorrect sintax. Command executed twice.
    if (sInput == "")
        {
      sMsg = "Error, Command:/> "+sSaid;
      SpeakString("Error: Empty String Listened. Listener not Setup, either not valid command entered or maybe NPC not properly configured");
      SendServerMessageToPC(oPC, sMsg);
        }
    else
    if ( GetLocalString(oModule, DM_HABD_NPC_CLT_LastCommand_Var) == sInput )
        {
      sMsg = "Error, Command:/> "+sInput;
      SpeakString("Error: The command listened by the HABD NPC DM Tool was exactly the same that was executed last, It is not allowed for security reasons. Either: ");
      SpeakString("a) The text you written was incorrect -must be 'HABDCommand Parameters', so the NPC ignored it and tried to execute the last valid command (the process was aborted to avoid surprises) \n  b) You written the same Command twice, it is not allowed in order to avoid errors. In order to execute the same command another time write something like 'HABDNull', then rewrite your command");
      SendServerMessageToPC(oPC, sMsg);
      //SetCustomToken(5010, "Error");
        }
    //No error
    else
     {
      //Save last valid text Input listened
      SetLocalString(oModule, DM_HABD_NPC_CLT_LastCommand_Var, sInput);

      //Process valid Text Input
      if (nMatch == DM_NPC_CommandLineTool_ListenPattern && GetIsObjectValid(oShouter))
        {
      sMsg = "HABD DM Tool used by "+GetName(oPC)+" Executes Command:/> "+sSaid;
      SpeakString(sMsg);
      SendMessageToAllDMs(sMsg);
      SendServerMessageToPC(oPC, sMsg);
      //SetCustomToken(5010, sSaid);
            UtilsHABDDM_NPCCommandLineTool(oPC, sPrefix, sCommand);
        }
      else
        {
      sMsg = "Error, Command:/> "+sSaid;
      SpeakString("Error: Listener not Setup, either not command entered or maybe NPC not properly configured");
      SendServerMessageToPC(oPC, sMsg);
      //SetCustomToken(5010, "Error");
        }
     }




    }
    //End of Listening


    return FALSE;
}
//
// /////////////////////////////////////////////////////////////////////////////






//End of Script
return FALSE;
}
