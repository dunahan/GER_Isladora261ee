void main()
{
    if (GetIsDusk() && GetLocalInt(OBJECT_SELF,"Feuer_var")==0)
    {
        SetLocalInt(OBJECT_SELF,"Feuer_var",1);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE); // aktivieren
        SetPlaceableIllumination(OBJECT_SELF,TRUE);
        RecomputeStaticLighting(GetArea(OBJECT_SELF));
    }
    else if (GetIsDawn() && (GetLocalInt(OBJECT_SELF,"Feuer_var")==1) )
    {
        SetLocalInt(OBJECT_SELF,"Feuer_var",0);
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE); // deaktivieren
        SetPlaceableIllumination(OBJECT_SELF,FALSE);
        RecomputeStaticLighting(GetArea(OBJECT_SELF));
    }
}

