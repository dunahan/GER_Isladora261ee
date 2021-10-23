#include "_isla_inc"

void main()
{
  object oPC = GetExitingObject();
  object oItem = GetFirstItemInInventory(oPC);  string sResRef;

  SendServerMessageToPC(oPC, "Mit dem Serverreset werden nun alle gemieteten Zimmer, bzw. Zimmerschlüssel eingezogen.");
  SendServerMessageToPC(oPC, "Mit dem Serverreset werden nun alle autoquestbedingte Schlüssel eingezogen.");

  while (GetIsObjectValid(oItem))
  {
    sResRef = GetResRef(oItem);

    if (FindSubString(sResRef, "_tavtuer_") >= 1)
      DestroyObject(oItem);

    else if (sResRef == "que_trolldorf")
      DestroyObject(oItem);

    else if (sResRef == "sk_mansion")
      DestroyObject(oItem);

    oItem = GetNextItemInInventory(oPC);
  }

  ExecuteScript("key_tritake_onex", oPC);
}
