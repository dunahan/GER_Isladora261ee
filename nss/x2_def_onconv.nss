//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //Speak a oneliner w/o dlg-file?!
    if (GetLocalString(OBJECT_SELF, "OneLinerDlg") != "") {
        AssignCommand(OBJECT_SELF, ClearAllActions());
        AssignCommand(OBJECT_SELF, ActionSpeakString(GetLocalString(OBJECT_SELF, "OneLinerDlg")));
    }

    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
