object GetFirstFreePortalSlot(object oPC)
{
//I've optimized this code, so it looks confusing.
int nBind = GetLocalInt(oPC, "bind");
string sBind = IntToString(nBind);
object oWP=GetWaypointByTag("TP_"+sBind+"_1");
int found=FALSE;
int i=1;
//If you add additional town portal locations to a town and want to increase
//the number of TP locations to loook for past the default 8, change this to
//while (!found&&i<=X)
//X is your number.
while (!found&&i<=8)
    {
    if (GetDistanceBetween(oWP,GetNearestObject(OBJECT_TYPE_PLACEABLE, oWP, 1))>0.1f)
        {
        found=TRUE;
        return oWP;
        }
    else
        {
        i++;
        oWP=GetWaypointByTag("TP_"+sBind+"_"+IntToString(i));
        }
    }
return oWP;
}

void main()
{
object oPC = GetItemActivator();
location lLocation = GetLocation(oPC);

string sCharName = GetName(oPC);
string sNewTag1 = (sCharName+"1"); //original tp
string sNewTag2 = (sCharName+"2"); //town tp

object oOldTP1 = GetLocalObject(oPC,"tp1");
object oOldTP2 = GetLocalObject(oOldTP1,"destination");
DestroyObject(oOldTP1);
DestroyObject(oOldTP2);

object oWP = GetFirstFreePortalSlot(oPC);
location lLocation2 = GetLocation(oWP);
object oarea=GetArea(oWP);

vector v1=GetPositionFromLocation(lLocation2);
v1+=Vector(0.05f,0.05f);
lLocation2=Location(oarea,v1,0.0f);

//creates a vfx effect where the town portals will spawn
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(149), lLocation);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(149), lLocation2);

//creates a town portal at oPC's location, then creates one in the binded town.
object oTP1 = CreateObject(OBJECT_TYPE_PLACEABLE, "town_portal_orig", lLocation, TRUE, "");  //pc loc
object oTP2 = CreateObject(OBJECT_TYPE_PLACEABLE, "town_portal_town", lLocation2, TRUE, ""); //wp loc

//Sets the destinations for area transition on both portals.
SetLocalObject(oTP1, "destination", oTP2);
SetLocalObject(oTP2, "destination", oTP1);

//sets the owner of the town portal.
SetLocalObject(oTP2, "owner", oPC);
SetLocalObject(oTP1, "owner", oPC);
SetLocalObject(oPC,"tp1",oTP1);

//sets the name of the town portal to include its owner's name and the destination area
string area1=GetName(GetAreaFromLocation(lLocation));
string area2=GetName(GetAreaFromLocation(lLocation2));
SetName(oTP1, "<cþþþ>"+sCharName+"'s</c> Portal nach <cþþþ>"+area2+"</c>");
SetName(oTP2, "<cþþþ>"+sCharName+"'s</c> Portal nach <cþþþ>"+area1+"</c>");
}
