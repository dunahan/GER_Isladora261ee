#include "shifter_inc"
#include "x2_inc_switches"

void main()
{
    if (GetUserDefinedItemEventNumber()==X2_ITEM_EVENT_ACTIVATE)
    {
        object oItem = GetItemActivated();
        object oUser = GetItemActivator();
        object oTarget = GetItemActivatedTarget();
        if(!IsDruidOrShifter(oUser))
        {
            SendServerMessageToPC(oUser, SHIFTER_NOTALLOW);
            DestroyObject(oItem);
            return;
        }

        if (oTarget == oUser)
        {
            ResetAppearance(oUser);
            SendServerMessageToPC(oUser, SHIFTER_TRUEFORM);
        }
        else if (GetResRef(oTarget) == MimicFormResRef)
        {
            SendServerMessageToPC(oUser, SHIFTER_FORGFORM);
            SetPlotFlag(oTarget,FALSE);
            DestroyObject(oTarget,0.1);
        }
        else if (AllowMimic(oUser, oTarget))
        {
            if (oUser==oTarget) ResetAppearance(oUser);
            object oDoppled = CreateItemOnObject(MimicFormResRef,oUser);
            string sTargetName = GetName(oTarget);
            SetName(oDoppled, SHIFTER_ITMTITLE+sTargetName);
            SaveParts(oTarget, oDoppled);
            SendServerMessageToPC(oUser, sTargetName+SHIFTER_SUCLEARN);
            DebugMode(GetName(oUser)+":"+sTargetName+" Size : "+IntToString(GetCreatureSize(oTarget)));
        }
    }
}
