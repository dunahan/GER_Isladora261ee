#include "_key_include"
string s = "key_ultimate: ";

void main()
{
  object oTarget = GetItemActivatedTarget();    // Get the target of the key
  object oUser = GetItemActivator();            // Get the activator of the item
  int nObjType = GetObjectType(oTarget);        // Get the object type of the target
  string sNewTag, sNewName; object oNewKey;     // Declare necessary variables

  if (nObjType != OBJECT_TYPE_DOOR)             // Abort the script if target is anything else then a door
  {
    if (GetTag(oTarget) == "KeyBoard")          // But if its the keyboard print the actual not rented rooms
      SendServerMessageToPC(oUser, GetLocalString(oTarget, KEYSYS_DOORKEYS));
    return;
  }

  sNewTag = GetLockKeyTag(oTarget);             // Get the tag of the key, that opens the door

  if (sNewTag != "")
  {
    // Create one similar key and rename it to the target area
    oNewKey = CreateItemOnObject(KEYSYS_TEMPLATE, oUser, 1, sNewTag);
    if (GetName(GetArea(GetTransitionTarget(oTarget))) == "")
      SetName(oNewKey, GetName(GetDoorByKeyTag(sNewTag, GetArea(oTarget))));
    else
      SetName(oNewKey, GetName(GetArea(GetTransitionTarget(oTarget))));
  }
  else
    SendServerMessageToPC(oUser, KEYSYS_ERROR001);

    DebugMode("Keylock-Target: "+GetName(oTarget)+"\nKey: "+GetLockKeyTag(oTarget)+"\nLocation: "+GetName(GetArea(GetTransitionTarget(oTarget))));

    // Remove all item properties so make it unique
    IPRemoveAllItemProperties(oNewKey, DURATION_TYPE_PERMANENT);
    IPRemoveAllItemProperties(oNewKey, DURATION_TYPE_TEMPORARY);
    IPRemoveAllItemProperties(oNewKey, DURATION_TYPE_INSTANT);
}
