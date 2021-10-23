
//#include "x0_i0_corpses"

void main ()
{
object oZombieFood = GetNearestObjectByTag("plc_zombfood");
location   locFood = GetLocation(oZombieFood);
effect      eRegen = EffectRegenerate(1, 4.0);

if (GetLocalInt(OBJECT_SELF, "Undead") == 2)
    {
        ActionForceMoveToObject(oZombieFood, FALSE, 1.0f, 30.0f);
        SetFacingPoint(GetPosition(oZombieFood));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,19.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, 16.0);
        DelayCommand(19.5, ClearAllActions());
        DelayCommand(25.0, ExecuteScript("sk_zombfeed", OBJECT_SELF));
    }

ActionRandomWalk();

}
