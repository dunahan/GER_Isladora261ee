void main()
{
  object oPC = GetPCSpeaker();
  location loc = GetLocation(oPC);

  // "Anhängsel" teleportieren
  object oKreatur = GetFirstFactionMember(oPC, TRUE);

  while(GetIsObjectValid(oKreatur) == TRUE)
  {
    oKreatur = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    AssignCommand(oKreatur, ClearAllActions(TRUE));
    AssignCommand(oKreatur, ActionJumpToLocation(loc));

    oKreatur = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    AssignCommand(oKreatur, ClearAllActions(TRUE));
    AssignCommand(oKreatur, ActionJumpToLocation(loc));

    oKreatur = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    AssignCommand(oKreatur, ClearAllActions(TRUE));
    AssignCommand(oKreatur, ActionJumpToLocation(loc));

    oKreatur = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    AssignCommand(oKreatur, ClearAllActions(TRUE));
    AssignCommand(oKreatur, ActionJumpToLocation(loc));

    oKreatur = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    AssignCommand(oKreatur, ClearAllActions(TRUE));
    AssignCommand(oKreatur, ActionJumpToLocation(loc));

    oKreatur = GetNextFactionMember(oKreatur, FALSE);

  }
}

