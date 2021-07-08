//::///////////////////////////////////////////////
//:: FileName sk_classproof
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 08.11.2009 11:42:07
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Einschränkungen nach Klasse des Spielers
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker()) >= 2)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
