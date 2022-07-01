#!/bin/bash
#!/bin/bash

typeset RcsId="$Id: bueMailManage.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     $( dirname $0)/seedActions.sh -l $0 "$@"
     exit $?
fi

vis_help () {
  cat  << _EOF_

   IDEAS: 
       Per Message sa-learn for Gnus is at
             /usr/share/doc/spamassassin/examples/gnus 

       sa-learn happens on local host but can be forwarded 
        with spamc --learntype=type --dest=host

_EOF_
}


. ${opBinBase}/lpErrno.libSh

. ${opBinBase}/bystarHook.libSh

# bystarMail.libSh 
. ${opBinBase}/bystarMail.libSh

# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh


. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

# bystarHereAcct.libSh
. ${opBinBase}/bystarHereAcct.libSh

# bystarCentralAcct.libSh 
. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/bystarInfoBase.libSh

# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

. ${opBinBase}/bystarHook.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

# PRE parameters
typeset -t acctTypePrefix=""
typeset -t bystarUid="INVALID"
typeset -t subjectFolder="INVALID"
typeset -t destSpamFolder="INVALID"

function G_postParamHook {
    bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
    lpCurrentsGet
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  typeset thisOneSaNu="sa-20000"
  #typeset thisOneSaNu=${oneBystarAcct}
  #typeset thisOneSaNu=${currentBystarUid}
  typeset oneSubject="qmailAddr_test"
  typeset runInfo="-p ri=any:mailFolders"

  typeset oneMailDirBase=$( FN_absolutePathGet ~sa-20000 )/${bystarAcctMailDirBase}

  typeset oneSubjectFolder=INBOX.job
  typeset oneDestSpamFolder=INBOX.spam.detected.often


#${doLibExamples}
 cat  << _EOF_
EXAMPLES:
./isbg.py --help
--- GNUS ---
${G_myName} ${extraInfo} -i gnusBystarHowto
${G_myName} ${extraInfo} -i gnusBystarFdmbLevelsPolicy
${G_myName} ${extraInfo} -i mailBystarAddressFdmbPolicy
${G_myName} ${extraInfo} -i gnusClearReset
--- BUE MHONARC for Gnus Reading ---
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -i mhonarcBasePrep
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -i browserHtmlResourceStdout
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -i inlineHtmlResourceStdout
---
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -i msgHtmlHook
--- Extra Features For Developers ---
${G_myName} ${extraInfo} ${runInfo} -i developerExamples
_EOF_
}


function vis_developerExamples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  typeset thisOneSaNu="sa-20000"
  #typeset thisOneSaNu=${oneBystarAcct}
  #typeset thisOneSaNu=${currentBystarUid}
  typeset oneSubject="qmailAddr_test"
  typeset runInfo="-p ri=any:mailFolders"

  typeset oneMailDirBase=$( FN_absolutePathGet ~sa-20000 )/${bystarAcctMailDirBase}

  typeset oneSubjectFolder=INBOX.job
  typeset oneDestSpamFolder=INBOX.spam.detected.often

#${doLibExamples}
 cat  << _EOF_
EXAMPLES:
--- BUE (SpamBeGone) INFORMATION / Status ---
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -p subjectFolder=${oneSubjectFolder} -p destSpamFolder=${oneDestSpamFolder} -i bueFlagSpam
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -p subjectFolder=${oneSubjectFolder} -p destSpamFolder=${oneDestSpamFolder} -i bueDeSpam
--- ByStar (SpamBeGone) INFORMATION / Status ---
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -p subjectFolder=${oneSubjectFolder} -p destSpamFolder=${oneDestSpamFolder} -i bystarDespamReport
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -p subjectFolder=${oneSubjectFolder} -p destSpamFolder=${oneDestSpamFolder} -i bystarDespam
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}



vis_gnusBystarHowto () {
  cat  << _EOF_

A Task Oriented Guide To ByStar Gnus
************************************

* Service-Software Continum
===========================

 - Service
     - qmail
     - spamAssassin
     - courier Imap
 - Software (User Env)
     - qmail (user-env-resident-mta)
     - Gnus

* MESSAGE READING
===============

**Fresh  Start/ReStart
--------------------

 - bueMailManage.sh -h -v -n showRun -i gnusClearReset
 - "^" In Gnus/Groups -- Takes you to server 
 - "s" In Servers -- scan gets you the groups list - but is not displayed
 - "q" In Servers -- takes you back  
 - "R" In Gnus/Groups Restart Gnus
 - You Will Now See the Groups

**Organizing The Groups (Lists/Levels)
------------------------------------

 - To See All Groups -- Group "INBOX"
 - Sort Alphabetical

**Bringing New Mail
-----------------

  All in Gnus/Groups

 - "g" -- Bring in all groups
 - "M-g" -- bring in just this group
 - "C-U <levelNu> g" --

** Reading Mail (Ham Groups)
----------------------------

  All in Article Buffer

*** Identifying Spam (False Negatives)
######################################

 - "M-d" -- Will be tagged with '$'
 - Upon "q" (quit) -- Will be moved to training.spam 

*** Mark As Read
################
 
 - "d" or "C-u <num> d" 
  (gnus-summary-mark-as-read-forward N)

*** Mark For Deletion (Mark As Expirable)
#########################################
 
 - "E" or "C-u <num> E" 
  (gnus-summary-mark-as-expirable N)
     E, M x, M e, <menu-bar> <Gnus> <Mark Various> <Set expirable mark>.

*** Force Deletions
###################
 
 - "E" or "C-u <num> E" 
  (gnus-summary-mark-as-expirable N)

*** Move To Different Folder
############################
 
 - "B m"

** Reading Mail (Spam Groups)
----------------------------

*** Identifying Ham
####################

 - "M-d" -- Will be tagged with '$'
 - Upon "q" (quit) -- Will be moved to training.spam 

** Reading Mail (Mixed Spam/Ham Groups)
---------------------------------------

 - For Now, Same as Ham Groups

*** Creating New Folders
------------------------

 - bound to G m, <menu-bar> <Groups> <Foreign groups> <Make a foreign group...>
    (gnus-group-make-group NAME &optional METHOD ADDRESS ARGS ENCODED)

* Message Sending
=================

** Envelope Addresses (Ephemeral)
---------------------------------

 - envelope201001@...byname.net
 - ephemeral201001@
 - e201001@

* General
=========

Mailboxes are Spam protected
Normally spam should end up in 
spam.detected.rare,often,usual

When reading real mail, when you note 
spam, move it to training.spam

When scanning a spam.detected folder have bbdb 
identify false positives.

Archives go in -extra.1.20000

_EOF_
}

vis_gnusBystarFdmbLevelsPolicy () {
  cat  << _EOF_

Gnus Level Facilities
*********************

l    List all groups that have unread articles.
     With numeric prefix and lower.

L    List all groups With numeric prefix and lower.

A l
    List all unread groups on a specific level.
    With a prefix, also list the groups with no unread articles. 

* ByStar Level Conventions
============================

0- unused

1- Urgent:  text, urgent, mobile, 

2- Important / Noraml / Usual

3: Confirmation/Exceptions  /Spam (attention)

4: Reports/FYI/ Self Originated: Archives / References / Bookmarks /Sent /Record -- 

5: Lists Primary

_EOF_
}


vis_mailBystarAddressFdmbPolicy () {
  cat  << _EOF_

Address and Fdmb purposes
*************************

* Syntax
========
  - address@
  - [fdmb]  -- no spam protection
  - (fdmb)  -- spam protected
  - <level> --

** fdmb to address mapping and purposes
---------------------------------------

[.]       main@
           Purpose: 

[test]    test@
           Purpose: 

[text]    text@
           Purpose: 

[school]    kid@ kids@ shs@ tillicum@
           Purpose: 

_EOF_
}



function vis_fullReport {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "INVALID_" ]]
    
    return
}

function vis_gnusClearReset {
  EH_assert [[ $# -eq 0 ]]
  #EH_assert [[ "${bystarUid}_" != "INVALID_" ]]

  bystarUidHome=$( FN_absolutePathGet ~ )

  # 
  FN_fileSafeKeep ${bystarUidHome}/.newsrc
  FN_fileSafeKeep ${bystarUidHome}/.newsrc-dribble
  FN_fileSafeKeep ${bystarUidHome}/.newsrc.eld
  FN_fileSafeKeep ${bystarUidHome}/.gnus.registry.eld

  FN_fileRmIfThere ${bystarUidHome}/.newsrc~ ${bystarUidHome}/.newsrc-dribble~ ${bystarUidHome}/.newsrc-eld~ ${bystarUidHome}/.gnus.registry.eld~

  FN_dirSafeKeep ${bystarUidHome}/Mail
  FN_dirSafeKeep ${bystarUidHome}/News

  opDoComplain ls -ld ${bystarUidHome}/.newsrc* ${bystarUidHome}/Mail*  ${bystarUidHome}/News*  
}

#
# Gnus/Mhonarc/Mozilla/Firefox Interface
#
#   Html bodypart is detected in Gnus
#      - The entire message is stored in ~/mhonarc/var/input/tmpFile
#      - vis_msgHtmlProc is called with input message as arg
#      1)
#         - mhonarc is invoked on msg with ${myHome}/mhonarc/control/browserHtml.rc
#         - Resulting html file is pushed to firefox
#      2) 
#         - mhonarc is invoked on msg with ${myHome}/mhonarc/control/inlineHtml.rc
#         - Resulting html is puton Stdout
#         - Gnus shows that with w3m
#

function vis_msgHtmlHook {
  EH_assert [[ $# -eq 0 ]]
  inMsgFile=$( ls -t /acct/employee/lsipusr/News/drafts/drafts/* | head -1 )

  browserHtml=/tmp/${G_progName}.browserHtml.$$
  inlineHtml=/tmp/${G_progName}.inlineHtml.$$

  if [ ! -f ${inMsgFile} ] ; then 
      echo "${G_myName} mozStdin got an empty file. For now do a Post Forward to see it"
      return
  fi


  myHome=$( FN_absolutePathGet ~ )

  cat ${inMsgFile} | mhonarc -rcfile ${myHome}/mhonarc/control/browserHtml.rc \
                           -attachmentdir ${myHome}/mhonarc/var/attachments \
                           -attachmenturl ${myHome}/mhonarc/var/attachments \
                           -single  > ${browserHtml}

    opDo ls -l ${inMsgFile} ${browserHtml}

    bx-browse-url.sh -i openUrlNewTab file://${browserHtml} #&
    #firefox -remote "openurl(file://${browserHtml})" &
    ##lcaMozReplProc.sh -i mozUrlNewtabGoto  file://${browserHtml} &

    if [ "${opRunDistGeneration}" == "SQUEEZE" ] ; then
        opDo lcaWmctrlManage.sh -h -v -n showRun -p host=$( hostname ) -p app=emacs -p win=Summary  -i hostAppWindowRaise
    fi
}


function vis_msgHtmlProc {
  EH_assert [[ $# -eq 1]]

  inMsgFile=$1

  browserHtml=/tmp/${G_progName}.browserHtml.$$
  inlineHtml=/tmp/${G_progName}.inlineHtml.$$

  if [ ! -f ${inMsgFile} ] ; then 
      echo "${G_myName} mozStdin got an empty file. For now do a Post Forward to see it"
      return
  fi

  myHome=$( FN_absolutePathGet ~ )

  cat ${tmpFile} | mhonarc -rcfile ${myHome}/mhonarc/control/browserHtml.rc \
                           -attachmentdir ${myHome}/mhonarc/var/attachments \
                           -attachmenturl ${myHome}/mhonarc/var/attachments \
                           -single  > ${browserHtml}

  firefox -remote "openurl(file://${browserHtml}, new-tab)" &


  cat ${tmpFile} | mhonarc -rcfile ${myHome}/mhonarc/control/inlineHtml.rc \
                           -attachmentdir ${myHome}/mhonarc/var/attachments \
                           -attachmenturl ${myHome}/mhonarc/var/attachments \
                           -single  |  w3m -T text/html
}


function vis_mhonarcBasePrep {
  EH_assert [[ $# -eq 0 ]]
  #EH_assert [[ "${bystarUid}_" != "INVALID_" ]]

  myHome=$( FN_absolutePathGet ~ )

  opDo mkdir -p ${myHome}/mhonarc
  opDo mkdir -p ${myHome}/mhonarc/control
  opDo mkdir -p ${myHome}/mhonarc/var
  opDo mkdir -p ${myHome}/mhonarc/var/input
  opDo mkdir -p ${myHome}/mhonarc/var/attachments

  vis_browserHtmlResourceStdout > ${myHome}/mhonarc/control/browserHtml.rc

  vis_inlineHtmlResourceStdout  > ${myHome}/mhonarc/control/inlineHtml.rc
}

function vis_browserHtmlResourceStdout {
  EH_assert [[ $# -eq 0 ]]

  cat  << _EOF_
<TextEncode>
utf-8; MHonArc::UTF8::to_utf8; MHonArc/UTF8.pm
</TextEncode>

<-- With data translated to UTF-8, it simplifies CHARSETCONVERTERS -->
<CharsetConverters override>
default; mhonarc::htmlize
</CharsetConverters>

<-- Need to also register UTF-8-aware text clipping function -->
<TextClipFunc>
MHonArc::UTF8::clip; MHonArc/UTF8.pm
</TextClipFunc>

<IdxPgBegin>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>\$IDXTITLE\$</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>\$IDXTITLE\$</h1>
</IdxPgBegin>

<TIdxPgBegin>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>\$TIDXTITLE\$</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>\$TIDXTITLE\$</h1>
</TIdxPgBegin>


<MsgPgBegin>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>\$SUBJECTNA\$</title>
<link rev="made" href="mailto:\$FROMADDR\$">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
</MsgPgBegin>

<LiTemplate>
<img src="\$ICONURL\$" alt="*">
<strong>\$SUBJECT:40\$</strong>
<em>\$FROMNAME\$</em><br>
</LiTemplate>


<FIELDSBEG>
<table>
</FIELDSBEG>
<LABELBEG>
<tr>
<td align="right" valign="top">
</LABELBEG>
<LABELEND>
</td>
</LABELEND>
<FLDBEG>
<td align="left">
</FLDBEG>
<FLDEND>
</td>
</tr>
</FLDEND>
<FIELDSEND>
</table>
</FIELDSEND>

<FIELDORDER>
from
subject
date
-extra-
</FIELDORDER>

<EXCS>
x-
precendence
delivered-to
importance
references
dkim-signature
domainkey-signature
xref
</EXCS>


<MIMEFilters>
application/octet-stream;  m2h_external::filter;        mhexternal.pl
application/*;             m2h_external::filter;        mhexternal.pl
application/x-patch;       m2h_text_plain::filter;      mhtxtplain.pl
audio/*;                   m2h_external::filter;        mhexternal.pl
chemical/*;                m2h_external::filter;        mhexternal.pl
model/*;                   m2h_external::filter;        mhexternal.pl
message/delivery-status;   m2h_text_plain::filter;      mhtxtplain.pl
message/external-body;     m2h_msg_extbody::filter;     mhmsgextbody.pl
message/partial;           m2h_text_plain::filter;      mhtxtplain.pl
text/*;                    m2h_text_plain::filter;      mhtxtplain.pl
text/enriched;             m2h_text_enriched::filter;   mhtxtenrich.pl
text/html;                 m2h_text_html::filter;       mhtxthtml.pl
text/plain;                m2h_text_plain::filter;      mhtxtplain.pl
text/richtext;             m2h_text_enriched::filter;   mhtxtenrich.pl
text/tab-separated-values; m2h_text_tsv::filter;        mhtxttsv.pl
text/x-html;               m2h_text_html::filter;       mhtxthtml.pl
video/*;                   m2h_external::filter;        mhexternal.pl
x-sun-attachment;          m2h_text_plain::filter;      mhtxtplain.pl
</MIMEFilters>



_EOF_
}

function vis_inlineHtmlResourceStdout {
  EH_assert [[ $# -eq 0 ]]

  vis_browserHtmlResourceStdout

  cat  << _EOF_

<FIELDSBEG>
<table>
</FIELDSBEG>
<LABELBEG>
<tr>
<td align="right" valign="top">
</LABELBEG>
<LABELEND>
</td>
</LABELEND>
<FLDBEG>
<td align="left">
</FLDBEG>
<FLDEND>
</td>
</tr>
</FLDEND>
<FIELDSEND>
</table>
</FIELDSEND>

<FIELDORDER>
from
subject
date
-extra-
</FIELDORDER>

<EXCS>
x-
precendence
from
subject
date
delivered-to
importance
in-reply-to
to
references
</EXCS>

_EOF_
}



#
# isbg -- Spam Be Gone
#

function vis_bueFlagSpam {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]

  EH_assert [[ "${subjectFolder}_" != "INVALID_" ]]
  EH_assert [[ "${destSpamFolder}_" != "INVALID_" ]]

  #bystarAcctParamsPrep 2> /dev/null

  bystarHereAnalyzeAcctBagp

  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  EH_assert [[ -d ${infoBaseAcctBase} ]]

  opDo fileParamsCodeGenToFile  ${infoBaseAcctBase} 2> /dev/null
  opDo fileParamsLoadVarsFromBaseDir  ${infoBaseAcctBase} 2> /dev/null

  opDoComplain isbg.py --imaphost imap.${cp_acctMainBaseDomain} --imapuser ${cp_acctUid} --imappassword  ${bystarUidPasswdDecrypted} --imapinbox ${subjectFolder} --spaminbox ${destSpamFolder}  --delete --expunge  --verbose --spamc

  #opDoComplain echo isbg.py --imaphost imap.${cp_acctMainBaseDomain} --imapuser ${cp_acctUid} --imappassword  ${bystarUidPasswdDecrypted} --imapinbox ${subjectFolder} --spaminbox ${destSpamFolder} --delete --expunge --verbose --spamc --flag
}

function vis_bueDespam {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]

  bystarAcctParamsPrep 2> /dev/null

  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  EH_assert [[ -d ${infoBaseAcctBase} ]]

  opDo fileParamsCodeGenToFile  ${infoBaseAcctBase} 2> /dev/null
  opDo fileParamsLoadVarsFromBaseDir  ${infoBaseAcctBase} 2> /dev/null

  opDoComplain isbg.py --imaphost imap.${cp_acctMainBaseDomain} --imapuser ${cp_acctUid} --imappassword ${cp_currentPasswd} 

#isbg.py --imaphost imap.mohsen.1.banan.byname.net --imapuser sa-20000 --imappassword mb2neda --imapinbox INBOX.job --spaminbox INBOX.spam.one --delete --expunge --verbose --spamc --flag
}


