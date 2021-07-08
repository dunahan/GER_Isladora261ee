#include "x0_i0_stringlib"

const int LWJB_CUSTOMTOKENSTART=1100;

void lwjb_if_init(); // EXTERNAL
string lwjb_if_getline(int i); // EXTERNAL
void lwjb_if_waspressed(int i); // EXTERNAL


void lwjb_dispatcher()
{

string para;

para=GetLocalString(OBJECT_SELF,"lwjb_para");

string cmd;

struct sStringTokenizer stTestTok = GetStringTokenizer(para, "|");
stTestTok = AdvanceToNextToken(stTestTok);
cmd = GetNextToken(stTestTok);

if (cmd=="getline")
 {
 int parai;
 stTestTok = AdvanceToNextToken(stTestTok);
 parai = StringToInt(GetNextToken(stTestTok));
 string result;
 result = lwjb_if_getline(parai);
 SetLocalString(OBJECT_SELF,"lwjb_result",result);
 }
else
if (cmd=="waspressed")
 {
 int parai;
 stTestTok = AdvanceToNextToken(stTestTok);
 parai = StringToInt(GetNextToken(stTestTok));
 lwjb_if_waspressed(parai);
 }
else
if (cmd=="init")
 {
 lwjb_if_init();
 }

}

// void main() {}
