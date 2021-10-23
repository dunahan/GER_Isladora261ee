void Respawn(string Me, location RightHere)
{
    object NewLife = CreateObject(OBJECT_TYPE_PLACEABLE,Me,RightHere);
}

void main()
{
    DelayCommand(5.0, Respawn(GetResRef(OBJECT_SELF),GetLocation(OBJECT_SELF)));
}
