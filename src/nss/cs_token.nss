//============================================================================
//
// Name: CS String Tokeniser - Main Include File
// File: cs_token
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
//----------------------------------------------------------------------------
// This software is distributed in the hope that it will be useful. It is
// provided "as is" WITHOUT WARRANTY OF ANY KIND, either expressed or implied,
// including, but not limited to, the implied warranties of merchantability
// and fitness for a particular purpose. You may redistribute or modify this
// software for your own purposes so long as all original credit information
// remains intact.
//----------------------------------------------------------------------------
//
// Introduction
// ------------
// The functions in this file allow strings to be broken down into substrings
// at specific points, i.e. via a separator character such as an underscore.
// Such a facility allows data fields to be embedded into strings such as
// object or creature tags for easy retrieval.
//
// Using the CS String Tokeniser in your own code
// ----------------------------------------------
// To use the tokeniser, simple include this file into your own scripts by
// placing the following line near the top of the script file:
//
//  #include "cs_token"
//
// If you then scroll through the function list on the right of the toolset's
// code editor, you will see various functions beginning with a "cs_tkn"
// prefix.
//
// In general, there are two approaches to using a string tokeniser. One
// usually either knows the fields that are present within the string and
// so merely extracts them one after the other, or a loop is used to walk
// through the string until no more tokens are left.
//
// If you already know the number of tokens in the string, then a code
// fragment like this is likely to be the sort of thing you would use:
//
//  #include "cs_token"
//  void main() {
//      cs_tkn_SetTokenString("some_string_3");
//      string firstToken = cs_tkn_GetNextToken();
//      string secondToken = cs_tkn_GetNextToken();
//      int thirdToken = StringToInt(cs_tkn_GetNextToken());
//
//      .. now do something with the values returned..
//  }
//
// At the end of this code fragment, the string variable 'firstToken will
// hold a value of "some", 'secondToken' will hold "string" and the integer
// variable 'thirdToken' will have the value 3. Note that you must convert
// numeric token values to integers manually as the tokeniser only returns
// strings. Looping through the tokens in the string is only slightly more
// complex:
//
//  #include "cs_token"
//  void main() {
//      cs_tkn_SetTokenString("another_string_of_tokens");
//      while(!cs_tkn_GetIsLastToken()) {
//          string token = cs_tkn_GetNextToken();
//          .. do something with the string 'token' ..
//      }
//  }
//
// If you wish to use a character other than an underscore as the separator
// between tokens, pass a single character string as the second parameter
// to the cs_tkn_GetFirstToken() function like this:
//
//      cs_tkn_SetTokenString("some:string:3", ":");
//
// Note that you cannot nest calls to the tokeniser within nested loops or
// within function calls. Bit of a bugger, that, and I might fix it one day
// if I need it.
//
// Revision History
// ----------------
// 0.4.0dev     Refactored cs_tkn_GetFirstToken to cs_tkn_SetTokenString.
// 0.3.0dev     Added cs_tkn_GetRemainingTokens().
// 0.2.0dev     Consolidation of all tokeniser functions in one place.
// 0.1.0dev     Various functions in numerous places.
//
//============================================================================
#include "cs_dbg"

// The version numbering I use is comprised of a tripartite version number
// and a trailing string. The version is arranged into 1.2.3 form, where 1 is
// the major release number, 2 is the minor release number and 3 is the bugfix
// level. Each number in the version starts at 0 and increments each time a
// change is made to the code that classifies as that level. The trailing
// string is either "dev", "beta" or "final" depending upon whether the code
// is still under development (it will have bugs, count on it), is considered
// to be beta quality (i.e. technically finished but probably has bugs), or
// finished, tested and believed to be correctly functional. If you wish to
// report a bug, please include the version number with your bug report.
string cs_tkn_version = "0.4.0dev";


//============================================================================
//
// Data Types and Constants
//
//============================================================================

// The delimiter used to break down the string.
string cs_tkn_tokenDelimiter = "_";

// The string we're tokenising.
string cs_tkn_tokenString = "";

// The length of the string being tokenised (to avoid multiple function calls).
int cs_tkn_tokenLen;

// The position of the last delimiter found (i.e. start of next token).
int cs_tkn_tokenPos;

// TRUE when the end of the string is reached and there are no more tokens.
int cs_tkn_tokenLast;


//============================================================================
//
// Function Prototypes and toolset IDE documentation.
//
//============================================================================

// Determine whether there are any more tokens in the current string. This
// function is intended primarily to be used as the controlling conditional
// for loop constructs.
//
// returns      TRUE if there are no more tokens, otherwise FALSE.
int cs_tkn_GetIsLastToken();

// Return all remaining tokens in the string. After this function is called,
// the string is considered exhausted and the cs_tkn_GetIsLastToken() function
// will return TRUE.
//
// returns      The entirety of the remaining tokens in the string as a single
//              string with all delimiters in place.
string cs_tkn_GetRemainingTokens();

// Extract the next token from the string most recently passed to the
// cs_tkn_SetTokenString() function. Note that it is possible for a value
// of "" (i.e. an empty string) to be returned as a valid token if two
// separator characters occur next to each other. Use the function
// cs_tkn_GetIsLastToken() to determine when the last token has been
// reached.
//
// returns      A string of the value of the next token, or "" if there are
//              no more tokens.
string cs_tkn_GetNextToken();

// Initialise the tokeniser with a new string.
//
// tokenString  The string to be broken down into tokens
// delimiter    The separator character between tokens. If not specified,
//              the separator character defaults to an underscore.
void cs_tkn_SetTokenString(string tokenString, string delimiter="_");

// Determine the number of tokens in the string most recently initialised.
//
// returns      The number of tokens in the current token string.
int cs_tkn_GetNumberOfTokens();


//----------------------------------------------------------------------------
int cs_tkn_GetIsLastToken() {
    cs_dbg_Trace("cs_tkn_GetIsLastToken(): " + IntToString(cs_tkn_tokenLast));
    return cs_tkn_tokenLast;
}

//----------------------------------------------------------------------------
string cs_tkn_GetRemainingTokens() {
    cs_dbg_Enter("cs_tkn_GetRemainingTokens()");

    string token = "";
    cs_dbg_Trace(
        "before: "  +
        IntToString(cs_tkn_tokenPos) + ", " +
        IntToString(cs_tkn_tokenLast)
    );

    // Only do anything if we have not already reached the last token.
    if (!cs_tkn_tokenLast) {

        // Extract the token.
        token = GetSubString(
            cs_tkn_tokenString,
            cs_tkn_tokenPos,
            cs_tkn_tokenLen - cs_tkn_tokenPos
        );
        cs_tkn_tokenPos = cs_tkn_tokenLen;

        // No more tokens left now.
        cs_tkn_tokenLast = TRUE;
    }

    cs_dbg_Exit("cs_tkn_GetRemainingTokens");
    return token;
}

//----------------------------------------------------------------------------
string cs_tkn_GetNextToken() {
    cs_dbg_Enter("cs_tkn_GetNextToken()");

    string token = "";
    cs_dbg_Trace(
        "before: "  +
        IntToString(cs_tkn_tokenPos) + ", " +
        IntToString(cs_tkn_tokenLast)
    );

    // Only do anything if we have not already reached the last token.
    if (!cs_tkn_tokenLast) {
        int lastPos = cs_tkn_tokenPos;
        // search util we find the end of the string or the next delimiter.
        while ((cs_tkn_tokenPos < cs_tkn_tokenLen) &&
               (GetSubString(
                    cs_tkn_tokenString, cs_tkn_tokenPos, 1
                ) != cs_tkn_tokenDelimiter)
            ) {
            cs_tkn_tokenPos++;
        }

        // Determine if we're at the end of the string.
        if (cs_tkn_tokenPos >= cs_tkn_tokenLen) {
            cs_tkn_tokenLast = TRUE;
        }

        // Extract the token.
        token = GetSubString(
            cs_tkn_tokenString,
            lastPos,
            cs_tkn_tokenPos - lastPos
        );
        cs_tkn_tokenPos++;
    }

    cs_dbg_Trace(
        "after: "  +
        IntToString(cs_tkn_tokenPos) + ", " +
        IntToString(cs_tkn_tokenLast)
    );

    cs_dbg_Exit("cs_tkn_GetNextToken");
    return token;
}

//----------------------------------------------------------------------------
void cs_tkn_SetTokenString(string tokenString, string delimiter="_") {
    cs_dbg_Enter("cs_tkn_GetFirstToken(" + tokenString + ")");

    // Initialise the token string.
    cs_tkn_tokenString = tokenString;
    cs_tkn_tokenLen = GetStringLength(tokenString);
    cs_tkn_tokenPos = 0;
    cs_tkn_tokenLast = FALSE;
    cs_tkn_tokenDelimiter = delimiter;

    cs_dbg_Trace(
        "initial: "  +
        cs_tkn_tokenString + ", " +
        IntToString(cs_tkn_tokenLen) + ", " +
        cs_tkn_tokenDelimiter + ", " +
        IntToString(cs_tkn_tokenPos) + ", " +
        IntToString(cs_tkn_tokenLast)
    );

    cs_dbg_Exit("cs_tkn_GetFirstToken");
}

//----------------------------------------------------------------------------
int cs_tkn_GetNumberOfTokens() {
    int count = (cs_tkn_tokenLen > 0? 1 : 0);
    int pos = 0;
    while (pos < cs_tkn_tokenLen) {
        if (GetSubString(cs_tkn_tokenString, pos, 1) == cs_tkn_tokenDelimiter) {
            count++;
        }
        pos++;
    }

    cs_dbg_Trace("cs_tkn_GetNumberOfTokens: " + IntToString(count));
    return count;
}
