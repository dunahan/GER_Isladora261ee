//::///////////////////////////////////////////////
//:: FileName gesp_hure_jim
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.08.2013 18:04:44
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Die Geschlechts-Einschränkungen hinzufügen
	if(GetGender(GetPCSpeaker()) != GENDER_FEMALE)
		return FALSE;

	return TRUE;
}
