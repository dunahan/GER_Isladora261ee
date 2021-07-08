//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: sk_questtoken
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    Ein Questsystem per Item.
    Befuellung des Questgebergespraechs
    Einsetzbar bei einem Gespraech bei OnTextAppear

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"

int StartingConditional()
{
  // Grundlegendes Anfangsgeplaenkel
  SetCustomToken(40000, GetLocalString(OBJECT_SELF, "40000") );
  SetCustomToken(40001, GetLocalString(OBJECT_SELF, "40001") );
  SetCustomToken(40002, GetLocalString(OBJECT_SELF, "40002") );
  // Start der Quest
  SetCustomToken(40010, GetLocalString(OBJECT_SELF, "40010") );
  SetCustomToken(40011, GetLocalString(OBJECT_SELF, "40011") );
  SetCustomToken(40012, GetLocalString(OBJECT_SELF, "40012") );
  // Waehrend der Quest
  SetCustomToken(40020, GetLocalString(OBJECT_SELF, "40020") );
  SetCustomToken(40021, GetLocalString(OBJECT_SELF, "40021") );
  SetCustomToken(40022, GetLocalString(OBJECT_SELF, "40022") );
  // Schluss der Quest
  SetCustomToken(40030, GetLocalString(OBJECT_SELF, "40030") );
  SetCustomToken(40031, GetLocalString(OBJECT_SELF, "40031") );

  // Grundlegendes Anfangsgeplaenkel
  SetCustomToken(40003, GetLocalString(OBJECT_SELF, "40003") );
  SetCustomToken(40004, GetLocalString(OBJECT_SELF, "40004") );
  SetCustomToken(40005, GetLocalString(OBJECT_SELF, "40005") );

  return TRUE;  // Immer einen Wert zurueckgeben.
}
