void main()
{
    object oSpieler = GetLastUsedBy();
    AssignCommand(oSpieler, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,
    1.0));
}

