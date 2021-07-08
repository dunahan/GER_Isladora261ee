void main()
{
  if(IsInConversation(OBJECT_SELF) == FALSE)
  { int nAnim = GetLocalInt(OBJECT_SELF, "anim");
    float fDuration = GetLocalFloat(OBJECT_SELF, "duration");
    if ( fDuration == 0.0 ) { fDuration = 10000.0; }
    ActionPlayAnimation(nAnim, 1.0, fDuration); }
}
