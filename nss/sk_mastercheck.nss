//::///////////////////////////////////////////////
//:: FileName sk_mastercheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23.01.2010 14:14:59
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Einschränkungen nach Klasse des Spielers
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 20)
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 20))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) >= 20))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 20))
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
