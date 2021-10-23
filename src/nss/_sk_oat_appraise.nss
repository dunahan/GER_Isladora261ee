//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Activate Appraise
//:: _sk_oat_appraise
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einf�gen
    Gibt dem SL die M�glichkeit das Nutzen von
    "Sch�tzen" beim H�ndler ein- oder auszuschalten

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

#include "_sk_include"

void main()
{
  string sStore = GetTag(OBJECT_SELF);
  object oStore = GetObjectByTag(SK_PREFIX+sStore);

  int nAppraise = GetLocalInt(oStore, "UseAppraise");

  if (nAppraise == 1)                                                           // Sch�tzen aktiviert?
  {                                                                             // Ja, dann ausschalten
    SetLocalInt(oStore, "UseAppraise", 0);
    DebugMode(GetName(oStore)+" nutzt kein -Sch�tzen- mehr.");
    SendMessageToAllDMs(GetName(oStore)+" nutzt kein -Sch�tzen- mehr.");
  }
  else                                                                          // Nein, dann einschalten
  {
    SetLocalInt(oStore, "UseAppraise", 1);
    DebugMode(GetName(oStore)+" nutzt ab nun -Sch�tzen-.");
    SendMessageToAllDMs(GetName(oStore)+" nutzt ab nun -Sch�tzen-.");
  }
}

