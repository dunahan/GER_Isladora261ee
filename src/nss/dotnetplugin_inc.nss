//Executes methods and paramenters agains the DotNet Plugin
//The methods and parameters MUST exist in the Exection class of that Plugin
//The buffer size should be adjusted to fit the size of your expected return
//(if you inform a buffer lesser than expected results, it will be truncated)
//(parameters informed with {&qt} are ignored, once that string is reserved for the function)
string DotNetExecute(string MethodName, string Param1="{&qt}", string Param2="{&qt}", string Param3="{&qt}", string Param4="{&qt}", string Param5="{&qt}", string Param6="{&qt}", string Param7="{&qt}", string Param8="{&qt}", string Param9="{&qt}", string Param10="{&qt}", int BufferSize=500);

//Get the filler string based in the informed length.
string DotNetGetFiller(int Length);

//Encode quotes
string DotNetEncodeQuote(string sString);


string DotNetExecute(string MethodName, string Param1="{&qt}", string Param2="{&qt}", string Param3="{&qt}", string Param4="{&qt}", string Param5="{&qt}", string Param6="{&qt}", string Param7="{&qt}", string Param8="{&qt}", string Param9="{&qt}", string Param10="{&qt}", int BufferSize=500) {
    //encode quotes
    //first, check it
    string strQuote = "{&qt}";
    int blnError = FALSE;
    if (Param1 != "{&qt}" && FindSubString(Param1, strQuote) >-1 ) { blnError = TRUE; }
    if (Param2 != "{&qt}" && FindSubString(Param2, strQuote) >-1 ) { blnError = TRUE; }
    if (Param3 != "{&qt}" && FindSubString(Param3, strQuote) >-1 ) { blnError = TRUE; }
    if (Param4 != "{&qt}" && FindSubString(Param4, strQuote) >-1 ) { blnError = TRUE; }
    if (Param5 != "{&qt}" && FindSubString(Param5, strQuote) >-1 ) { blnError = TRUE; }
    if (Param6 != "{&qt}" && FindSubString(Param6, strQuote) >-1 ) { blnError = TRUE; }
    if (Param7 != "{&qt}" && FindSubString(Param7, strQuote) >-1 ) { blnError = TRUE; }
    if (Param8 != "{&qt}" && FindSubString(Param8, strQuote) >-1 ) { blnError = TRUE; }
    if (Param9 != "{&qt}" && FindSubString(Param9, strQuote) >-1 ) { blnError = TRUE; }
    if (Param10 != "{&qt}" && FindSubString(Param10, strQuote) >-1 ) { blnError = TRUE; }
    if (blnError) {
        return "(error)Don't use the substring {&qt}, it is reserved";
    }
    //now, replace
    if (Param1 != "{&qt}" && FindSubString(Param1, "'") >-1 ) { Param1 = DotNetEncodeQuote(Param1); }
    if (Param2 != "{&qt}" && FindSubString(Param2, "'") >-1 ) { Param2 = DotNetEncodeQuote(Param2); }
    if (Param3 != "{&qt}" && FindSubString(Param3, "'") >-1 ) { Param3 = DotNetEncodeQuote(Param3); }
    if (Param4 != "{&qt}" && FindSubString(Param4, "'") >-1 ) { Param4 = DotNetEncodeQuote(Param4); }
    if (Param5 != "{&qt}" && FindSubString(Param5, "'") >-1 ) { Param5 = DotNetEncodeQuote(Param5); }
    if (Param6 != "{&qt}" && FindSubString(Param6, "'") >-1 ) { Param6 = DotNetEncodeQuote(Param6); }
    if (Param7 != "{&qt}" && FindSubString(Param7, "'") >-1 ) { Param7 = DotNetEncodeQuote(Param7); }
    if (Param8 != "{&qt}" && FindSubString(Param8, "'") >-1 ) { Param8 = DotNetEncodeQuote(Param8); }
    if (Param9 != "{&qt}" && FindSubString(Param9, "'") >-1 ) { Param9 = DotNetEncodeQuote(Param9); }
    if (Param10 != "{&qt}" && FindSubString(Param10, "'") >-1 ) { Param10 = DotNetEncodeQuote(Param10); }

    //get parameter count
    int intParamCount = 0;
    if (Param1 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param2 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param3 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param4 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param5 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param6 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param7 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param8 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param9 != "{&qt}") { intParamCount = intParamCount + 1; }
    if (Param10 != "{&qt}") { intParamCount = intParamCount + 1; }

    //build request string
    string strRequest = "";
    strRequest = "-m:'" + MethodName + "' -pc:'" + IntToString(intParamCount) + "' -p1:'" + Param1 + "'" + " -p2:'" + Param2 + "'" + " -p3:'" + Param3 + "'" + " -p4:'" + Param4 + "'" + " -p5:'" + Param5 + "'" + " -p6:'" + Param6 + "'" + " -p7:'" + Param7 + "'" + " -p8:'" + Param8 + "'" + " -p9:'" + Param9 + "'" + " -p10:'" + Param10 + "' ";
    PrintString(strRequest);

    //set filler
    if (GetStringLength(strRequest) < BufferSize) {
        strRequest = strRequest + DotNetGetFiller(BufferSize-GetStringLength(strRequest));
    }

    //execute
    SetLocalString(GetModule(), "NWNX!DOTNETPLUGIN!EXECUTE", strRequest);

    //return
    return GetLocalString(GetModule(), "NWNX!DOTNETPLUGIN!EXECUTE");
}

string DotNetGetFiller(int Length) {
    if (Length > 0) {
        int i = 0;
        string strReturn = "....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................";
        while (GetStringLength(strReturn) < Length) {
            strReturn = strReturn + strReturn;
            i++;
            if (i>50) break;
        }
        return GetSubString(strReturn, 0, Length);
    }
    else {
        return "";
    }
}

string DotNetEncodeQuote(string sString)
{
    if (FindSubString(sString, "'") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "'")
            sReturn += "{&qt}";
        else
            sReturn += sChar;
    }
    return sReturn;
}

