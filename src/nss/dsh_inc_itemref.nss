//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string WORKING_ITEM = "di0_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
object get_working_item(object user);
void set_working_item(object user, object item);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
object get_working_item(object user)
//==========================================/
    {
    return GetLocalObject(user, WORKING_ITEM);
    }

//==========================================/
void set_working_item(object user, object item)
//==========================================/
    {
    SetLocalObject(user, WORKING_ITEM, item);
    }
