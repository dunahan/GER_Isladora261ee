/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_persist_inc
//
//  Desc:  These functions are collected together to
//         facilitate interfacing to a persistent database.
//
//  Author: David Bobeck 20Apr03
//
/////////////////////////////////////////////////////////

// Note: no include is required to use Bioware's database.
//#include "aps_include"

// included Knats BioWareDB Extension
#include "nbde_inc"

// CNR defined return codes for CnrSQLFetch()
int CNR_SQL_ERROR = 0;
int CNR_SQL_SUCCESS = 1;

// 0 for local variables, so database support
// 1 for BioWareDB
// 2 for MySQL
int CNR_DATA_TO_DBS = 1;

/////////////////////////////////////////////////////////
void CnrSetPersistentInt(object oHost, string sVarName, int nValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Integers in your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //SetLocalInt(oHost, sVarName, nValue);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    SetCampaignInt("cnr_misc", sVarName, nValue, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
    //SetPersistentInt(oHost, sVarName, nValue, 0, "cnr_misc");
}

////////////////////////////////////////////////////////
int CnrGetPersistentInt(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Integers from your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //return GetLocalInt(oHost, sVarName);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    return GetCampaignInt("cnr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
  //return GetPersistentInt(oHost, sVarName, "cnr_misc");
}

/////////////////////////////////////////////////////////
void CnrSetPersistentFloat(object oHost, string sVarName, float fValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Floats in your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //SetLocalFloat(oHost, sVarName, fValue);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    SetCampaignFloat("cnr_misc", sVarName, fValue, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
    //SetPersistentFloat(oHost, sVarName, fValue, 0, "cnr_misc");
}

/////////////////////////////////////////////////////////
float CnrGetPersistentFloat(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Floats from your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //return GetLocalFloat(oHost, sVarName);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    return GetCampaignFloat("cnr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
    //return GetPersistentFloat(oHost, sVarName, "cnr_misc");
}

/////////////////////////////////////////////////////////
void CnrSetPersistentString(object oHost, string sVarName, string sValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Strings in your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //SetLocalString(oHost, sVarName, sValue);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    SetCampaignString("cnr_misc", sVarName, sValue, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
    //SetPersistentString(oHost, sVarName, sValue, 0, "cnr_misc");
}

/////////////////////////////////////////////////////////
string CnrGetPersistentString(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Strings from your Database

  // uncomment the following line for NO database support
  //if (CNR_DATA_TO_DBS == 0)
    //return GetLocalString(oHost, sVarName);

  // uncomment the following line for Bioware database support
  //if (CNR_DATA_TO_DBS == 1)
    return GetCampaignString("cnr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //if (CNR_DATA_TO_DBS == 2)
    //return GetPersistentString(oHost, sVarName, "cnr_misc");
}

/////////////////////////////////////////////////////////
void CnrSQLExecDirect(string sSQL)
{
  // If you're using APS, uncomment the following line
  //if (CNR_DATA_TO_DBS == 2)
    //SQLExecDirect(sSQL);
}

/////////////////////////////////////////////////////////
int CnrSQLFetch()
{
  // If you're using APS, comment out the following line
  //if (CNR_DATA_TO_DBS < 2)
    return CNR_SQL_ERROR;

  // If you're using APS, uncomment the following line
  //if (CNR_DATA_TO_DBS == 2)
    //return SQLFetch();
}

/////////////////////////////////////////////////////////
string CnrSQLGetData(int iCol)
{
  // If you're using APS, comment out the following line
  //if (CNR_DATA_TO_DBS < 2)
    return "";

  // If you're using APS, uncomment the following line
  //if (CNR_DATA_TO_DBS == 2)
    //return SQLGetData(iCol);
}

// Additions for nwnx2_sysdata2 support

/////////////////////////////////////////////////////////
string CnrCreateUniquePlayerID(object oHost)
{
  string sAcc = GetPCPlayerName(oHost);
  string sPlayerName = GetName(oHost);

  if (GetStringLength(sAcc) >= 16) // Scan, if string exceeds 16 letters
    sAcc = GetStringLeft(sAcc, 15); // Strip to 15

  if (GetStringLength(sPlayerName) >= 9) // Scan, if string exceeds 9 letters
    sPlayerName = GetStringLeft(sPlayerName, 9); // Strip to 9

  return sAcc + "_" + sPlayerName; // So 15 + 1 + 9 never exceeds 25 letters
}