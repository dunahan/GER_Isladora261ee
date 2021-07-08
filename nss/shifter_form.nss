#include "shifter_inc"
#include "x2_inc_switches"

void main()
{
    if (GetUserDefinedItemEventNumber()==X2_ITEM_EVENT_ACTIVATE)
    {
        object oItem = GetItemActivated();
        object oUser = GetItemActivator();
        if(!IsDruidOrShifter(oUser))
        {
            SendServerMessageToPC(oUser, SHIFTER_NOTALLOW);
            DestroyObject(oItem);
            return;
        }

        if (GetLocalInt(oItem, "CREATURE_APPEARANCE")==0) {DestroyObject(oItem); return;}
        else if (GetLocalString(oUser,"CREATURE_RESREF")!="")
        //(GetLocalString(oItem,"CREATURE_RESREF")==GetLocalString(oUser,"CREATURE_RESREF"))
            ResetAppearance(oUser);
        else DelayCommand(MimicPreDelay,LoadParts(oUser, oItem));
    }
}
