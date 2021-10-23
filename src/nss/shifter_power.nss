//_combo_tag_base_
//_tag_spell_targ_
//first 16 letters = script to execute, beyond 17+ = subtag data
#include "x2_inc_switches"
#include "shifter_inc"

void main()
{
    if (GetUserDefinedItemEventNumber()==X2_ITEM_EVENT_ACTIVATE)
    {
        object oUser = GetItemActivator();
        object oItem = GetItemActivated();
        string sTag = GetTag(oItem);
        if(!IsDruidOrShifter(oUser))
        {
            SendServerMessageToPC(oUser, SHIFTER_NOTALLOW);
            DestroyObject(oItem);
            return;
        }

        int iSpell = GetLocalInt(oItem, "SPELL");
        int iSelf = GetLocalInt(oItem, "SELF");
        if (iSelf)
        {
            AssignCommand(oUser,ActionCastSpellAtObject(iSpell, oUser, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        }
        else
        {
            object oTarget = GetItemActivatedTarget();
            int iItemType = GetObjectType(oTarget);
            SendServerMessageToPC(oUser,SHIFTER_TYPETARG+IntToString(iItemType));
            switch(iItemType)
            {
                case OBJECT_TYPE_CREATURE:
                case OBJECT_TYPE_DOOR:
                case OBJECT_TYPE_PLACEABLE:
                    AssignCommand(oUser,ActionCastSpellAtObject(iSpell, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
                break;
                default :
                    AssignCommand(oUser,ActionCastSpellAtLocation(iSpell, GetItemActivatedTargetLocation(),METAMAGIC_ANY,TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
                break;
            }
        }
    }
}
