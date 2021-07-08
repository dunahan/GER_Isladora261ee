#include "x2_inc_itemprop"
#include "x3_inc_string"

#include "_tokenizer_inc"
#include "_debugisla"

const int    KEYSYS_FEEPDAYS = 100;

const string KEYSYS_TEMPLATE = "key_template";
const string KEYSYS_ULTIMATE = "key_ultimate";
const string KEYSYS_DIALOGUE = "key_board";
const string KEYSYS_DOORKEYS = "KEY_DOORS";
const string KEYSYS_DOORSFEE = "KEYFEE";
const string KEYSYS_DOORLINI = "KEYI";
const string KEYSYS_DOORRENT = "key_rented";

const string KEYSYS_ERROR001 = "DM:  Es existiert kein Ziel, um einen Schlüssel zu erstellen.";
const string KEYSYS_BOARD001 = "Hier hängen genug Schlüssel, die Du Dir täglich borgen kannst. Bei Rückgabe musst Du jedoch eine Gebühr von 100 Goldmünzen entrichten.";
const string KEYSYS_BOARD002 = "Derzeit gibt es keine Schlüssel, somit müssten alle Räume vermietet sein.";
const string KEYSYS_BOARD003 = "Du besitzt nicht genug Gold um die Miete zu zahlen. Deshalb musst Du den Schlüssel behalten, bis Du genug Gold hast.";
const string KEYSYS_BOARD004 = "Rückgabe des Schlüssels zu ";
const string KEYSYS_BOARD005 = "Nächste Reihe.";
const string KEYSYS_BOARD006 = "DM: Zentralschlüssel geben.";
const string KEYSYS_BOARD007 = "Schlüssel ";


// Returns current game-time in seconds.
int CalcCurrent()
{
    int iYear   = GetCalendarYear();
    int iMonth  = GetCalendarMonth();
    int iDay    = GetCalendarDay();
    int iHour   = GetTimeHour();
    int iMinute = GetTimeMinute();
    int iSecond = GetTimeSecond();
    int iSecondsPerHour = FloatToInt(HoursToSeconds(1));

    return     iYear  * 12 * 28 * 24 * iSecondsPerHour
            + (iMonth - 1) * 28 * 24 * iSecondsPerHour
            + (iDay - 1)        * 24 * iSecondsPerHour
            +  iHour                 * iSecondsPerHour
            +  iMinute                    * 60
            +  iSecond;
}

int CalcActualDays()
{
    int iYear   = GetCalendarYear();
    int iMonth  = GetCalendarMonth();
    int iDay    = GetCalendarDay();

    return    iYear  * 12 * 28 * 24
           + (iMonth - 1) * 28 * 24
           + (iDay   - 1)      * 24;
}

string CreateKeyList(object oArea)
{
  string sResult = "";
  object oObject = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oObject))
  {
    if (GetObjectType(oObject) == OBJECT_TYPE_DOOR
    &&  GetLockKeyTag(oObject) != ""
    &&  GetLocalInt(oObject, KEYSYS_DOORRENT) != 1)
       sResult = AddTokenToString(GetLockKeyTag(oObject), sResult);
    oObject = GetNextObjectInArea(oArea);
  }

  if (sResult == "")
    return "Error";

  return sResult;
}

object GetDoorByKeyTag(string sKeyTag, object oArea)
{
  object oObject = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oObject))
  {
    if (GetObjectType(oObject) == OBJECT_TYPE_DOOR && GetLockKeyTag(oObject) == sKeyTag)
      return oObject;
    oObject = GetNextObjectInArea(oArea);
  }
  return OBJECT_INVALID;
}

int CalcFee(object oKey, object oPC)
{
  object oDoor = GetDoorByKeyTag(GetTag(oKey), GetArea(oPC));
  int nStart = GetLocalInt(oKey, KEYSYS_DOORSFEE);
  if (nStart < 0)
    return 0;
  return ((CalcActualDays() - nStart) / 24) * KEYSYS_FEEPDAYS;
}

void CalcFeeAndTakeIt(object oKey, object oPC)
{
  object oDoor = GetDoorByKeyTag(GetTag(oKey), GetArea(oPC));
  int nFee = CalcFee(oKey, oPC);

  if (GetGold(oPC) >= nFee) // if more than seconds ran away, minutes for example, take a fee.
  {
    TakeGoldFromCreature(nFee, oPC, TRUE);
    DestroyObject(oKey);
    ActionDoCommand(ActionCloseDoor(oDoor));
    ActionDoCommand(SetLocked(oDoor, TRUE));
  }

  else   // you dont have any gold! you can't pay the rent, so you have to keep it!
    SendMessageToPC(oPC, KEYSYS_BOARD003);
}

object GetItemPossessedByResRefWise(object oCreature, string sItemResRef, int nOccurence=1)
{
  object oItem = GetFirstItemInInventory(oCreature);
  int c = 1;

  while (GetIsObjectValid(oItem))
  {
    if (GetResRef(oItem) == sItemResRef && c == nOccurence)
      return oItem;

    c++;
    oItem = GetNextItemInInventory(oCreature);
  }

  return OBJECT_INVALID;
}

int GetNbrOfItemsInInventoryByResRef(object oCreature, string sItemResRef)
{
  object oItem = GetFirstItemInInventory(oCreature);
  int c;
  while (GetIsObjectValid(oItem))
  {
    if (GetResRef(oItem) == sItemResRef)
      c++;

    oItem = GetNextItemInInventory(oCreature);
  }
  return c;
}

