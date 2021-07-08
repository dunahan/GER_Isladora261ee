#include "lwjb_inc_common"

const int LWJB_LINESPERPAGE=5;


void lwjb_executenoresult(string para)
{

SetLocalString(OBJECT_SELF,"lwjb_para",para);
ExecuteScript(GetLocalString(OBJECT_SELF,"lwjb_interface"),OBJECT_SELF);

}


string lwjb_execute(string para)
{

string result;
lwjb_executenoresult(para);
result=GetLocalString(OBJECT_SELF,"lwjb_result");
return(result);

}


void lwjb_refresh(int pos,int max)
{

int j;
for (j=0;j<LWJB_LINESPERPAGE;j++)
 {

 int l;
 l=j+pos;

 string s;
 if (l>=max) s="<empty>";
 else
  {
  string ls;
  ls=IntToString(l);
  s=ls+" - '"+lwjb_execute("getline|"+ls)+"'";
  }

 SetCustomToken(LWJB_CUSTOMTOKENSTART+j,s);
 }

}


int lwjb_i_line0()
{

if (GetLocalInt(OBJECT_SELF,"lwjb_initted")==FALSE)
 {

 string interface;
 interface=GetLocalString(OBJECT_SELF,"lwjb_interface");
 if (interface=="")
  {
  interface=GetLocalString(OBJECT_SELF,"lwjb_if_default");
  SetLocalString(OBJECT_SELF,"lwjb_interface",interface);
  }

 SetCustomToken(LWJB_CUSTOMTOKENSTART+50,"<cþþ >");
 SetCustomToken(LWJB_CUSTOMTOKENSTART+51,"</c>");

 lwjb_executenoresult("init");

 SetLocalInt(OBJECT_SELF,"lwjb_pos",0);
 lwjb_refresh(0,GetLocalInt(OBJECT_SELF,"lwjb_max"));

 SetLocalInt(OBJECT_SELF,"lwjb_initted",TRUE);

 }

return TRUE;

}


void lwjb_move(int i)
{

int max;
max=GetLocalInt(OBJECT_SELF,"lwjb_max");
int pos;
pos=GetLocalInt(OBJECT_SELF,"lwjb_pos");

int newpos;
newpos=pos+i;
if (newpos+LWJB_LINESPERPAGE>max) newpos=max-LWJB_LINESPERPAGE; // NOT "else".
if (newpos<0) newpos=0;

if (newpos!=pos)
 {
 SetLocalInt(OBJECT_SELF,"lwjb_pos",newpos);
 lwjb_refresh(newpos,max);
 }

}


void lwjb_select(int i)
{

int max;
max=GetLocalInt(OBJECT_SELF,"lwjb_max");
int pos;
pos=GetLocalInt(OBJECT_SELF,"lwjb_pos");
if (pos+i<max)
 lwjb_executenoresult("waspressed|"+IntToString(pos+i));

}


void lwjb_reset()
{

SetLocalInt(OBJECT_SELF,"lwjb_initted",FALSE);
SetLocalString(OBJECT_SELF,"lwjb_interface","");

}


void lwjb_done()
{

DeleteLocalInt(OBJECT_SELF,"lwjb_initted");
DeleteLocalInt(OBJECT_SELF,"lwjb_pos");
DeleteLocalInt(OBJECT_SELF,"lwjb_max");
DeleteLocalString(OBJECT_SELF,"lwjb_interface");
DeleteLocalString(OBJECT_SELF,"lwjb_para");
DeleteLocalString(OBJECT_SELF,"lwjb_result");

}

// void main() {}
