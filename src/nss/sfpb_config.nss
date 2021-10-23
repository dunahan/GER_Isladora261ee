//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_config
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

#include "_tokenizer_inc"

/* WARNING!!!!! Please Read...

   If any changes are made to this script, you must
   use the "Build Module" option in toolset and check
   the "Scripts" box in order to compile (build) all
   scripts, failing to do so will result in any changes
   in thi sscript being overwritten back to its original
   state.....
*/

// Set this TRUE if you want the banking system to use
// the players CD Key, or FALSE to use the players
// account name.
// I recommend using the players CD Keys, it is a much
// secure option.
const int USE_CD_KEY = TRUE;

// Do you want players to be able to share items and gold
// between their own characters....
// If this is set TRUE, then players will be able to retrieve
// their items and gold with any of their own characters, if set
// FALSE, then they will only be able to retrieve items or gold
// that were saved on particular characters.
const int CHARACTER_SHARING = FALSE;

// Set the maximum amount of items allowed to be stored
// per player. I strongly recommend setting this no higher
// than 100. I cannot garuntee the system will function without
// any ill effects if you exceed this.
const int MAX_ITEMS = 100;

// For testing purposes, if testing this system in single player
// mode, make sure this is set TRUE. Please bare in mind that
// if testing this in single player mode or with a local vault
// server any items saved to the database will re-appear into the
// characters inventory because the character is not saved in the
// same way as a server vault.
const int SINGLE_PLAYER_MODE = FALSE;

////////////////////////////////////////////////////////////////////////////////
// DO NOT TOUCH ANY FUNCTIONS OR CONSANTS BELOW THIS LINE!!!!!!!
////////////////////////////////////////////////////////////////////////////////

const string DATABASE_GOLD = "SFPB_GOLD_";
const string DATABASE_ITEM = "SFPB_ITEM_";
const string DATABASE_NAME = "SFPB_DATA";
const string SFPATH = "D:/NWN1-Server/_ini/";
const string SFFILE = "SFPB_DATA.ini";


string SF_GetPlayerID(object oPC)
{
  string sID;
  if (USE_CD_KEY)
    sID = GetPCPublicCDKey(oPC, SINGLE_PLAYER_MODE);

  else
    sID = GetPCPlayerName(oPC); // Returns DXGUA37H only

  if (!CHARACTER_SHARING)
    sID += "_" + GetName(oPC);  // Returns DXGUA37H_Dunahan Jes !!!

  return GetSubString(sID, 0, 20);
}

int SF_GetIsAdmin(object oPC) {
  if (GetIsObjectValid(oPC) &&
      GetPCPublicCDKey(oPC) == "VDKTVEQQ" ||
      GetPCPublicCDKey(oPC) == "QYU3AJ7W" ||
      GetPCPublicCDKey(oPC) == "DXGUA37H"   )
    return TRUE;

  return FALSE;
}

/*
"VDKTVEQQ_Erzähler|VDKLCVPK_Yashia Nail|Q74J6DPV_Rodario Ale|QC4EDY6M_Chana|QC4L7DXT_Tarabas  La|QC4VMTG7_Riago Hinkl|QVMTDDK7_Nimron Elin|QGMFAM7J_Valen|
QC43H4FK_Faen  Er`li|QC4VMTG7_Mara Krown|QC43H4FK_Rebecca Blu|Q74LJM3N_Dandie Fyne|Q74NG9G3_Ravenna Fal|QVMXJRL4_Davarin|Q77GHE7A_Peron Dias|Q77GHE7A_Talia Sherz|
Q74NG9G3_Keyko Okawa|QC43H4FK_Sitares|QYAXUA3T_Skorbar Urd|QYAXUA3T_Fionna Morg|VDR9YQRY_Melina  Dal|QC4L7DXT_Runar|VDKLCVPK_Kelva Bendr|QVMTCMX6_Zellyord|
Q77GDMRU_Daria  aus|VDKTVEQQ_Salias Dana|Q77F7HDL_Anarion Her|QVMTCMX6_Reno Cedex|Q77F7HDL_ Anarion He|Q77F7HDL_Ingrim Gold|Q77F7HDL_ Ingrim Gol|QVMTRWQ9_Sarafeé Alb|
QVMTRWQ9_Camee Salur|QGMCAF7F_Lumi Leadót|QGMCAF7F_Farshad Dov|QVMTCMX6_Akachi|Q7RREKF3_Brann Morni|QC4PQ3UL_Antiriad Th|QC4LKG3N_Iouna Keiju|QC4PQ3UL_Kathandra M|
QVMTCMX6_Reno Cédex|Q74LXP3E_Tar Erialon|VDRWHATN_Nelly Abend|QGMWYY9E_Noah T' Ray|QGMWYY9E_Evelyn|VDKDCRAM_Sethara Dra|Q7KMUGCH_Diara Eisse|Q74LXP3E_Amlug  is T|
VDKDCRAM_Elyaria Laf|VDKDCRAM_Durila Fels|VDKDCRAM_Durila Funk|Q7KMUGCH_Keyko Okawa|VDKDCRAM_Faerfena Ba|QGMWYY9E_Caiden Vent|VDKTVEQQ_Gabriel";
*/
