#include "dotnetplugin_inc"


//////////////////////////////
///// PROTOTIPES /////////////
//////////////////////////////


//Effectively deletes the last saved char from the specified player.
//It will only delete the character vault if it is marked to deletion.
//PLEASE NOTE the BootPlayerForVaultDeletion() function should be called before this,
//  function, or it will not work.
//PLEASE NOTE the best local to put this function is on OnClientLeave module event.
void CheckAndDeleteLastServerVault();

//Starts the character deletion. It will boot the PC and mark some variables to effective
//  character deletion when the player is exiting.
//PLEASE NOTE you SHOULD implement DeleteLastServerVault() on OnClientLeave module event,
//  or it will not work
//Parameters:
//  oPlayerCaller: the player that is calling the method. Use this to check if the calling
//      player have rights to do it (you should implement your own rules)
// oDeleteFromPlayer: the player being his char deleted
void BootPlayerForVaultDeletion(object oPlayerCaller, object oDeleteFromPlayer);

//Returns the REAL current server date.
//Parameters:
//  Format: formats the return.
string GetDate(string Format="yyyy/MM/dd HH:mm:ss");

//Returns a GUID (Global Unique Identifer), string which you can
//  use as a PrimaryKey. A GUID is supposed to never repeat
string GetGuid();


//////////////////////////////
///// FUNCTIONS //////////////
//////////////////////////////

void CheckAndDeleteLastServerVault() {
    object oPC = GetExitingObject();
    string strPlayerCaller = GetLocalString(oPC, "DOTNET_DELETEVAULT_CALLING_PLAYER");
    if (strPlayerCaller != "") {
        string strDeleteFromPlayer = GetLocalString(oPC, "DOTNET_DELETEVAULT_DELETING_PLAYER");
        DotNetExecute("DeleteLastServerVault", strPlayerCaller, strDeleteFromPlayer, "utc");
    }
}

void BootPlayerForVaultDeletion(object oPlayerCaller, object oDeleteFromPlayer) {
    SetLocalString(oDeleteFromPlayer, "DOTNET_DELETEVAULT_CALLING_PLAYER", GetPCPlayerName(oPlayerCaller));
    SetLocalString(oDeleteFromPlayer, "DOTNET_DELETEVAULT_DELETING_PLAYER", GetPCPlayerName(oDeleteFromPlayer));
    DelayCommand(0.2, FloatingTextStringOnCreature("You will be booted for character deletion (" +  GetPCPlayerName(oDeleteFromPlayer) + ")", oDeleteFromPlayer));
    DelayCommand(2.5, BootPC(oDeleteFromPlayer));
}

string GetDate(string Format="yyyy/MM/dd HH:mm:ss") {
    return DotNetExecute("GetDate", "yyyy/MM/dd");
}

string GetGuid() {
    return DotNetExecute("GetGuid");
}

//void main() {}
