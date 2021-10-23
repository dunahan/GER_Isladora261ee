    object oChair = OBJECT_SELF;
    object oNPC = GetObjectByTag("HeilerPorta");
    object oPC = GetLastUsedBy();

void main()
{

//    int BeginConversation   ("tlk_andorn",oPC);

    if (!GetIsObjectValid(GetSittingCreature(OBJECT_SELF)))

        AssignCommand(GetLastUsedBy(), ActionSit(oChair));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(),oPC, 120.0);

        //Das Skript, das den NPC zum Spieler bewegt und das Gespraech anfaengt.

    if      (
    (GetIsPC(oPC)) &&
    (IsInConversation(oNPC) == FALSE)
            )
       {
        AssignCommand(oNPC,ClearAllActions());
        AssignCommand(oNPC,ActionMoveToObject(oPC));
        AssignCommand(oNPC,ActionStartConversation(oPC));



        }

     DelayCommand(121.0, ExecuteScript("heil_andorn01", OBJECT_SELF));
}
