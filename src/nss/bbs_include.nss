//BULLETIN BOARD SYSTEM VERSION 1.2

//This is an include file. Upon building your module you will get
//a compile error in this file. That is normal and does not
//affect the operation of the bulletin board.

// Included Ini-File support over nwnx_sysdata2. Do a search for GetCampaign and SetCampaign
// to get in touch with it. Settings are done at CUSTOM SETTINGS

#include "nw_i0_plot"
#include "_debugisla"

// CUSTOM SETTINGS
// Following the path and filename for working with an ini-file
// provided by nwnx_systdata2
const int BBS_INI = 0;                        // 0 is BioWareDB and 1 is Ini-DB
const string PATH = "D:/_ini/";               // path to file
const string BBS  = "DB_BBS.ini";             // leave it, so it will be a new file, or add it to a other?!
const string BBS_ADMIN_TAG = "bbs_chalk_bp";  // if you use a moderator like a council you will need a item (thats its tag!)

const int MAXITEM = 100;
const int PAGESIZ = 10;

const int BBS_DEBUG = 0;

void bbs_do_board_stats();
void bbs_initiate(object oBBS);
int bbs_can_show(int WhichEntry);
void bbs_change_page(int PageChange);
void bbs_select_entry(int WhichEntry);
void bbs_add_notice(object oBBS, string sPoster, string sTitle, string sMessage, string sDate, string sBBStag = "");

void bbs_debug_speak(string sMessage);

//Loads into tokens the stats for a board
void bbs_do_board_stats() {
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));
  int PageSize = GetLocalInt(oBBS, "PageSize");

  int TotalItems;
  TotalItems = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C");

  int PageIndex = GetLocalInt(GetPCSpeaker(), "PageIndex") + 1;
  SetCustomToken(3671, IntToString(TotalItems));

  if (TotalItems == 0) {PageIndex = 0;}
  SetCustomToken(3672, IntToString(PageIndex));
  SetCustomToken(3673, IntToString((TotalItems + PageSize - 1) / PageSize));
}

//Initiates a bulletin board's settings if neccessary
void bbs_initiate(object oBBS) {
  string sBBS = "BBS_" + GetTag(oBBS);                                          DebugMode("bbs_initiate: TagOBoard "+sBBS);
  object myBBS = GetLocalObject(GetModule(), sBBS);                             DebugMode("bbs_initiate: LocalBoard "+GetName(myBBS));

  if (!GetIsObjectValid(myBBS)) {
    SetLocalObject(GetModule(), sBBS, oBBS);                                    DebugMode("bbs_initiate: NewLocalBoard "+GetName(GetLocalObject(GetModule(), sBBS) ));
    myBBS = oBBS;
    //MaxItems is the maximum number of messages
    SetLocalInt(myBBS, "MaxItems", MAXITEM);                                    DebugMode("bbs_initiate: MaxItems "+IntToString(GetLocalInt(myBBS, "MaxItems")));
    //PageSize is the number of entries per page, between 1 and 10
    SetLocalInt(myBBS, "PageSize", PAGESIZ);                                    DebugMode("bbs_initiate: PageSize "+IntToString(GetLocalInt(myBBS, "PageSize")));
  }
}

//Determines whether a dialogue option is visible in conversation
int bbs_can_show(int WhichEntry) {
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));      DebugMode("bbs_can_show: LocalBoard "+GetName(oBBS));
  int PageSize = GetLocalInt(oBBS, "PageSize");                                 DebugMode("bbs_can_show: PageSize "+IntToString(PageSize));
  int nSpot = GetLocalInt(GetPCSpeaker(), "PageIndex") * PageSize + WhichEntry; DebugMode("bbs_can_show: PageIndex "+IntToString(nSpot));
                                                                                DebugMode("bbs_can_show: GetCampaignInt('DB_BBS',GetTag(oBBS) "+IntToString(GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C")));
  int nTotalItems;
  nTotalItems = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C");

  if(nSpot <= nTotalItems && WhichEntry <= PageSize) {return TRUE;}

  return FALSE;
}

//Moves the page by the required PageFlip:
//0 to reload page, -1 for previous page, 1 for next page
void bbs_change_page(int PageFlip) {
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));      DebugMode("bbs_change_page: LocalBoard "+GetName(oBBS));
  int PageSize = GetLocalInt(oBBS, "PageSize");                                 DebugMode("bbs_change_page: PageSize "+IntToString(PageSize));

  int TotalItems;                                                               DebugMode("bbs_change_page: TotalItems "+IntToString(TotalItems));
  TotalItems = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C");

  int MaxItems = GetLocalInt(oBBS, "MaxItems");                                 DebugMode("bbs_change_page: MaxItems "+IntToString(MaxItems));

  int LatestItem;                                                               DebugMode("bbs_change_page: LatestItem "+IntToString(LatestItem));
  LatestItem = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#L");

  int PageIndex = GetLocalInt(GetPCSpeaker(), "PageIndex") + 1 * PageFlip;      DebugMode("bbs_change_page: PageIndex "+IntToString(MaxItems));
  if (PageIndex < 0) {PageIndex = 0;}
  SetLocalInt(GetPCSpeaker(), "PageIndex", PageIndex);                          DebugMode("bbs_change_page: LocalPageIndex "+IntToString(GetLocalInt(GetPCSpeaker(), "PageIndex")));
  SetLocalString(GetPCSpeaker(),"PostAuthor","");                               DebugMode("bbs_change_page: LocalPostAuthor "+GetLocalString(GetPCSpeaker(),"PostAuthor"));

  string sInfo;  int iLoop;  int iNotice;

  for (iLoop = 0; iLoop < PageSize; iLoop++) {                                  DebugMode("bbs_change_page: Loop for Items");
    iNotice = LatestItem - PageIndex * PageSize - iLoop;
    if (iNotice < 1) {iNotice = MaxItems + iNotice;}

    sInfo = GetCampaignString("DB_BBS",GetTag(oBBS)+"#T"+IntToString(iNotice));

    SetCustomToken(3680 + iLoop, sInfo);

    sInfo = GetCampaignString("DB_BBS",GetTag(oBBS)+"#P"+IntToString(iNotice));

    if (((PageIndex * PageSize + iLoop + 2) > TotalItems) || (iLoop == PageSize - 1)){ sInfo = sInfo + "\n "; }
    SetCustomToken(3690 + iLoop, sInfo);
  }
  bbs_do_board_stats();
  SetCustomToken(3674, "");
  SetCustomToken(3675, "");
  SetCustomToken(3676, "");
  SetCustomToken(3677, "");
  SetCustomToken(3678, "");
}

//Displays the selected post
void bbs_select_entry(int WhichEntry) {
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));
  int PageSize = GetLocalInt(oBBS, "PageSize");
  int MaxItems = GetLocalInt(oBBS, "MaxItems");

  int LatestItem;
  LatestItem = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#L");

  int PageIndex = GetLocalInt(GetPCSpeaker(), "PageIndex");

  int iNotice = LatestItem - PageIndex * PageSize - WhichEntry + 1;
  if (iNotice < 1) {iNotice = MaxItems + iNotice;}

  SetLocalInt(GetPCSpeaker(),"CurrentEntry",iNotice);
  string sNotice = IntToString(iNotice);

  string sAuthor;
  sAuthor = GetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + sNotice);

  SetLocalString(GetPCSpeaker(),"PostAuthor",sAuthor);
  bbs_do_board_stats();

  SetCustomToken(3674, "\n\n" + GetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + sNotice) + "\nvon: ");

  SetCustomToken(3675, sAuthor);
  SetCustomToken(3676, "     am: ");

  SetCustomToken(3677, GetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + sNotice));
  SetCustomToken(3678, "\n" + GetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + sNotice));
}

//Adds a post to the bulletin board. This can be called at any time
//so you can insert your own notices. If you don't specify a sDate,
//it will use the current game time. The proper format for sDate is
//something like "6/30/1373 11:58". The last two lines write code to
//the log file for restoring the messages after a module edit.
void bbs_add_notice(object oBBS, string sPoster, string sTitle, string sMessage, string sDate, string sBBStag = "")
{
  if (sBBStag != "") {oBBS = GetObjectByTag(sBBStag);}
  bbs_initiate(oBBS);
  oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(oBBS));
  if (sDate == "") {
    sDate = IntToString(GetTimeMinute());

    if (GetStringLength(sDate) == 1) {sDate = "0" + sDate;}
      sDate = IntToString(GetCalendarDay()) + "." + IntToString(GetCalendarMonth()) + "." + IntToString(GetCalendarYear()) + sDate;// + "; " + IntToString(GetTimeHour()) + ":" + sDate; // cut off time
  }

  int MaxItems = GetLocalInt(oBBS, "MaxItems");

  int TotalItems;
  TotalItems = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C");

  int nSpot = TotalItems + 1;
  if (nSpot > MaxItems)
  {
    nSpot = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#L") +1;

    if (nSpot > MaxItems) nSpot = nSpot - MaxItems;
  }
  SetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + IntToString(nSpot), sPoster);

  SetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + IntToString(nSpot), sTitle);

  SetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + IntToString(nSpot), sMessage);

  SetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + IntToString(nSpot), sDate);

  SetCampaignInt("DB_BBS",GetTag(oBBS)+"#L", nSpot);

  if (MaxItems > TotalItems)
    SetCampaignInt("DB_BBS",GetTag(oBBS)+"#C", TotalItems + 1);

  string sQuote = GetSubString(GetStringByStrRef(464), 13, 1);
  //PrintString("bbs_add_notice(OBJECT_SELF, " + sQuote + sPoster + sQuote + ", " + sQuote + sTitle + sQuote + ", " + sQuote + sMessage + sQuote + ", " + sQuote + sDate + sQuote + ", " + sQuote + GetTag(oBBS) + sQuote + "); //:::BBS:::");
}


void bbs_delete_entry() {
  int CurrentEntry = GetLocalInt(GetPCSpeaker(), "CurrentEntry");
  object oBBS = GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF));

  int LatestItem;
  LatestItem = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#L");

  int TotalItems;
  TotalItems = GetCampaignInt("DB_BBS",GetTag(oBBS)+"#C");

  int iLoop, i;

//An attempt to store the CampaignStrings in Local Arrays.  Still slow though.
//5-10 entries, upon testing, results in a 1 - 2 second spike when you delete
//an entry.
  for(i = 1; i <= TotalItems; i++) {
    SetLocalString(oBBS,"#P"+IntToString(i),
    GetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + IntToString(i)));

    SetLocalString(oBBS,"#D"+IntToString(i),
    GetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + IntToString(i)));

    SetLocalString(oBBS,"#T"+IntToString(i),
    GetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + IntToString(i)));

    SetLocalString(oBBS,"#M"+IntToString(i),
    GetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + IntToString(i)));
  }

  for (iLoop = CurrentEntry; iLoop < TotalItems; iLoop++) {
    SetLocalString(oBBS,"#P"+IntToString(iLoop),
    GetLocalString(oBBS,"#P"+IntToString(iLoop+1)));

    SetLocalString(oBBS,"#D"+IntToString(iLoop),
    GetLocalString(oBBS,"#D"+IntToString(iLoop+1)));

    SetLocalString(oBBS,"#T"+IntToString(iLoop),
    GetLocalString(oBBS,"#T"+IntToString(iLoop+1)));

    SetLocalString(oBBS,"#M"+IntToString(iLoop),
    GetLocalString(oBBS,"#M"+IntToString(iLoop+1)));
  }

  TotalItems = TotalItems - 1;
  if (CurrentEntry <= LatestItem) {LatestItem = LatestItem - 1;}
  if (LatestItem == 0) {LatestItem = TotalItems;}

  while (LatestItem < TotalItems) {
    for (iLoop = TotalItems; iLoop > 0; iLoop--) {
      SetLocalString(oBBS,"#P"+IntToString(iLoop+1),
      GetLocalString(oBBS,"#P"+IntToString(iLoop)));

      SetLocalString(oBBS,"#D"+IntToString(iLoop+1),
      GetLocalString(oBBS,"#D"+IntToString(iLoop)));

      SetLocalString(oBBS,"#T"+IntToString(iLoop+1),
      GetLocalString(oBBS,"#T"+IntToString(iLoop)));

      SetLocalString(oBBS,"#M"+IntToString(iLoop+1),
      GetLocalString(oBBS,"#M"+IntToString(iLoop)));
    }

    SetLocalString(oBBS,"#P"+IntToString(1),
    GetLocalString(oBBS,"#P"+IntToString(TotalItems+1)));

    SetLocalString(oBBS,"#D"+IntToString(1),
    GetLocalString(oBBS,"#D"+IntToString(TotalItems+1)));

    SetLocalString(oBBS,"#T"+IntToString(1),
    GetLocalString(oBBS,"#T"+IntToString(TotalItems+1)));

    SetLocalString(oBBS,"#M"+IntToString(1),
    GetLocalString(oBBS,"#M"+IntToString(TotalItems+1)));

    LatestItem++;
  }

  for(i=1; i<=TotalItems; i++) {
    SetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + IntToString(i),
    GetLocalString(oBBS,"#P" + IntToString(i)));

    SetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + IntToString(i),
    GetLocalString(oBBS,"#D" + IntToString(i)));

    SetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + IntToString(i),
    GetLocalString(oBBS,"#T" + IntToString(i)));

    SetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + IntToString(i),
    GetLocalString(oBBS,"#M" + IntToString(i)));
  }

  SetCampaignInt("DB_BBS", GetTag(oBBS) + "#L", LatestItem);
  SetCampaignInt("DB_BBS", GetTag(oBBS) + "#C", TotalItems);

  //I don't remember if the syntax allows to simply pass "-TotalItems"
  //so I'm playing safe
  //This will move the BBS display to page 1
  bbs_change_page(TotalItems * -1);
}

void bbs_debug_speak(string sMessage)
{
  if (BBS_DEBUG == 1)
    WriteTimestampedLogEntry(sMessage);
}
