#!/bin/bash
#!/bin/osmtKsh


typeset RcsId="$Id: lcnMailFolderProc.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  `dirname $0`/seedActions.sh -l $0 "$@"
  exit $?
fi


# PRE parameters
typeset -t splitFolder=""
typeset -t destFolder=""
typeset -t msg=""
typeset -t fileSizeLimit=500000
#typeset -t scanWith="spamA+clamAV"
typeset -t scanWith="spamA"

function G_postParamHook {
  splitFolder=$( FN_absolutePathGet ${splitFolder} )
  destFolder=$( FN_absolutePathGet "${destFolder}" )
  msg=$( FN_absolutePathGet "${msg}" )
  set -- $(IFS="+"; echo ${scanWith})
  scanWithList="$*"
}

function vis_examples {
 typeset extraInfo="-h -v -n showRun"
 typeset visLibExamples=`visLibExamplesOutput ${G_myName}`

 typeset oneSplitFolder="/tmp/oneSplitFolder"
 typeset oneDestFolder="/tmp/oneDestFolder"
 typeset oneMboxFolder="/opt/public/osmt/samples/email/html.inMail"
 typeset oneMboxMail="/opt/public/osmt/samples/email/html.inMail"
 typeset oneSortFunc="largerThanFileSize"
 typeset oneFileSizeLimit=500000

 typeset oneDestMaildir="/acct/subs/banan/1/mohsen/ByStarMailDir/spam.detected.despam"

 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- History and Credits  ---
${G_myName} -i credits
=== BinsPrep  ===
apt-get install -y mb2md
apt-get install -y mboxgrep
=== SplitFolder: Create/Generate/Convert  ===
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i folderSplit ${oneMboxFolder}
${G_myName} ${extraInfo} -i folderSplit ${oneMboxFolder}
--- SplitFolder: Report ---
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i clamScan
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i spamScan
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i spamList
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i duplicatesList
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i messageIdList
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i folderReportFunc isLargerThanFileSize ${oneFileSizeLimit}
--- Message List -- Stdin Processor ---
bystarMailFolderManage.sh -h -v -n showRun -i maildirMake mailPath Owner
echo /acct/subs/banan/1/mohsen/ByStarMailDir/spam.detected.rare/cur/1282287057.M483827P9334V0000000000000900I0045AB57_0.bacs0016,S=6706:2, | ${G_myName} ${extraInfo} ${runInfo} -p destMaildir=${oneDestMaildir} -i msgsMoveToMaildir sa-20000
echo /acct/subs/banan/1/mohsen/ByStarMailDir/spam.detected.rare/cur/1282287057.M483827P9334V0000000000000900I0045AB57_0.bacs0016,S=6706:2, | ${G_myName} ${extraInfo} ${runInfo} -p destMaildir=${oneDestMaildir} -i msgsCopyToMaildir sa-20000
${G_myName} ${extraInfo} ${runInfo} -p destFolder=${oneDestFolder} -i msgsCopyToMaildir uid < msgList
--- SplitFolder: Recombine and Cleanup ---
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i folderRecombine ${oneMboxFolder}
--- Msg Filters: msg to stdout ---
${G_myName} ${extraInfo} -i clamScanTag ${oneMboxMail}
--- Msg: Test/Report ---
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc isLargerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc isSmallerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc grepFor -i mohsen
--- SplitFolder: General Sorters ---
${G_myName} ${extraInfo} -p destFolder=${oneDestFolder} -p splitFolder=${oneSplitFolder} -i folderSortFunc isLargerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -p destFolder=${oneDestFolder} -p splitFolder=${oneSplitFolder} -i folderSortFunc isSmallerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -e "equivalent of Merge/Copy" -p destFolder=${oneDestFolder} -p splitFolder=${oneSplitFolder} -i folderSortFunc true
${G_myName} ${extraInfo} -p destFolder=${oneDestFolder} -p splitFolder=${oneSplitFolder} -i folderSortFunc grepFor -i mohsen
--- SplitFolder: HAM/SPAM Sorters ---
${G_myName} ${extraInfo} -p scanWith="spamA"  -p splitFolder=${oneSplitFolder} -i folderHamSpam
${G_myName} ${extraInfo} -p fileSizeLimit=262144 -p scanWith="spamA+clamAV"  -p splitFolder=${oneSplitFolder} -i folderHamSpam
--- Folder: Full Service (eg HAM/SPAM) ---
${G_myName} ${extraInfo} -i folderHamSpam ${oneMboxFolder}
${G_myName} ${extraInfo} -p splitFolder=${oneSplitFolder} -i folderHamSpam
${G_myName} ${extraInfo} -p fileSizeLimit=262144 -p scanWith="spamA+clamAV" -i folderHamSpam ${oneMboxFolder}
=== MboxToMaildir Conversions ===
mb2md
maildir2mbox
=== MaildirToMbox Conversions ===
mbox2maildir
=== Misc ===
_EOF_
}


function isLargerThanFileSize {
  EH_assert [[ $# -eq 1 ]]
  EH_assert opParamIsSet msg


  integer fileSize=$( FN_fileSize ${msg})
  
  #opDo ls -l $msg

  if [[ ${fileSize} -gt ${1} ]] ; then
    #echo TRUE ${fileSize} -gt ${1}
    return 0
  else
    #echo FALSE ${fileSize} -gt ${1}
    return 1
  fi    
}

function isSmallerThanFileSize {
  EH_assert [[ $# -eq 1 ]]
  EH_assert opParamIsSet msg

  integer fileSize=$( FN_fileSize ${msg})
  
  #opDo ls -l $msg

  if [[ ${fileSize} -lt ${1} ]] ; then
    #echo TRUE ${fileSize} -lt ${1}
    return 0
  else
    #echo FALSE ${fileSize} -lt ${1}
    return 1
  fi    
}

function grepFor {
  EH_assert [[ $# -gt 0 ]]
  EH_assert opParamIsSet msg

  if ( cat ${msg} | grep $@ > /dev/null ) ; then
    #echo TRUE Found $@
    return 0
  else
    #echo FALSE No $@
    return 1
  fi    
}

noArgsHook() {
  vis_examples
}

function vis_help {
 cat  << _EOF_


 SplitFolder Functionality is built on top of 
 formail which is part of procmail.

A--
  1) Given an Mbox Folder, first split it

  2) Process The Split Folder

  3) Recombine The Split Folder

B-- 
  Combinations of the above 

TODO BEGIN: 
    - For sorting Use something like safecat instead of FN_FileSafeMove 
    - Look for a date range capability. Probably already in nmh or formail
TODO END:


_EOF_
}


function vis_folderSplit {
  EH_assert [[ $# -gt 0 ]]

  myArgs="$@"

  if ! which formail 1> /dev/null 2>&1 ; then
    EH_problem "Missing formail executable, perhaps:"
    ANT_raw "apt-get install procmail"
    return 100
  fi

  for thisArg in ${myArgs} ; do
    #ANT_raw "thisArg=${thisArg} splitFolder=${splitFolder}"

    if [ "${splitFolder}_" == "_" ] ; then
      splitFolder="${thisArg}.splitFolder"
    fi

    if [ -d ${splitFolder} ] ; then
      EH_problem "Did not expect ${splitFolder} directory to exist"
      EH_problem "Clean Up and ReRun:"
      ANT_raw "rm -r -f ${splitFolder}"
      return 101
    fi

    opDoExit mkdir -p  ${splitFolder}


    # set the FILENO variable and export so formail will update it...
    FILENO=000000
    export FILENO
    export splitFolder

    ANT_raw "Extracting individual mail files with formail from ${thisArg} ..."
    formail -d -s sh -c 'cat - > ${splitFolder}/$FILENO.mbox' < ${thisArg}

    # this is a klugey but workable way to do this if there 
    # are lots of files (like 10000 or more)
    echo "Counting up the new files in $TMP_SCANDIR..."
    NEWF=000000;  I=0;
    while [ -e ${splitFolder}/$NEWF.mbox ]
    do
      I=$((I+1)); NEWF=`printf "%06d" $I`
    done
    LASTFILE=`printf "%06d" $((I-1))`
    echo "Split ${thisArg} into files 000000.mbox thru $LASTFILE.mbox"
    echo "${splitFolder}"
  done
}


function vis_clamScan {
  EH_assert [[ $# -eq 0 ]]

  if ! which clamscan 1> /dev/null 2>&1 ; then
    EH_problem "Missing clamscan executable, Consider:"
    ANT_raw "apt-get install clamav"
    return 100
  fi

  if [ -d ${splitFolder} ] ; then
    clamscan -ri ${splitFolder}
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
}

function vis_clamScanTag {

  myArgs="$@"

  for thisArg in ${myArgs} ; do
    SCAN=$(clamscan ${thisArg} --stdout --disable-summary 2> /dev/null)
    EXIT="$?"
    VIRUS=$(echo "$SCAN" | awk '{print $2}')

    SUBJECT=$(cat ${thisArg} | reformail -x Subject:)

    if [ "$EXIT" == "1" ]; then
      SUBJECT="**VIRUS** [$VIRUS] $SUBJECT"
      cat ${thisArg} | reformail -i"X-Virus-Status: INFECTED" -i"Subject: ${SUBJECT}"
    else
      cat ${thisArg} | reformail -i"X-Virus-Status: CLEAN"
    fi
  done
  return ${EXIT}
}

function vis_clamScanTagORIG {

  myArgs="$@"

  for thisArg in ${myArgs} ; do
    MSG=$(< ${thisArg})
    SCAN=$(echo "$MSG" | clamscan - --stdout --disable-summary 2> /dev/null)
    EXIT="$?"
    VIRUS=$(echo "$SCAN" | awk '{print $2}')
    SUBJECT=$(echo "$MSG" | reformail -x Subject:)

    if [ "$EXIT" == "1" ]; then
      SUBJECT="**VIRUS** [$VIRUS] $SUBJECT"
      MSG=$(echo "$MSG" | reformail -i"X-Virus-Status: INFECTED")
      MSG=$(echo "$MSG" | reformail -i"Subject: $(echo "$SUBJECT")")
    else
      MSG=$(echo "$MSG" | reformail -i"X-Virus-Status: CLEAN")
    fi

    echo "$MSG"
  done
  return ${EXIT}
}


function vis_spamScan {
  EH_assert [[ $# -eq 0 ]]

  if ! which spamassassin 1> /dev/null 2>&1 ; then
    EH_problem "Missing spamassassin executable, Consider:"
    ANT_raw "apt-get install spamassassin"
    return 100
  fi

  if [ -d ${splitFolder} ] ; then
    cd ${splitFolder}
    #ls |&
    #while read -p thisLine ; do
    coproc { ls; sleep 2; }
    while read -u  ${COPROC[0]} thisLine ; do

      #echo ${thisLine}
      spamLine=`spamassassin < ${thisLine} | reformail -X X-Spam-Flag:`
      if [ "${spamLine}_" != "_" ] ; then
        echo ${splitFolder}/${thisLine}: ${spamLine}
      fi
    done
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
}

function vis_msgsMoveToMaildir {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${destMaildir}_" != "_" ]]

  if [ ! -d ${destMaildir} ] ; then
      #opDoExit mkdir -p ${destMaildir}
      runUname=$( id -u -n )
      opDo bystarMailFolderManage.sh -h -v -n showRun -i maildirMake ${destMaildir} ${runUname}
  fi

  dotMailfilterFile="/tmp/${G_myName}.mailfilter.$$"

  #FN_fileSafeKeep ${dotMailfilterFile}

cat  << _EOF_ > ${dotMailfilterFile}
# Machine Generated from code in ${G_myName}
# .Mailfilter - rules for maildrop

MAILDIR="${destMaildir}"

to \$MAILDIR
_EOF_

  opDo chown $1 ${dotMailfilterFile}
  #opDo chmod 640 ${dotMailfilterFile}
  opDo chmod 644 ${dotMailfilterFile}

  #opDo ls -l ${dotMailfilterFile}
  #opDo echo cat ${dotMailfilterFile}

  while read  thisLine ; do
       #echo ZZZ ${thisLine}
       echo cat ${thisLine} \| sudo -u $1 maildrop ${dotMailfilterFile}

       cat ${thisLine} | sudo -u $1 maildrop ${dotMailfilterFile}
       opDo /bin/rm ${thisLine}
  done
}

function vis_msgsCopyToMaildir {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${destMaildir}_" != "_" ]]

  if [ ! -d ${destMaildir} ] ; then
      #opDoExit mkdir -p ${destMaildir}
      runUname=$( id -u -n )
      opDo bystarMailFolderManage.sh -h -v -n showRun -i maildirMake ${destMaildir} ${runUname}
  fi

  dotMailfilterFile="/tmp/${G_myName}.mailfilter.$$"

  #FN_fileSafeKeep ${dotMailfilterFile}

cat  << _EOF_ > ${dotMailfilterFile}
# Machine Generated from code in ${G_myName}
# .Mailfilter - rules for maildrop

MAILDIR="${destMaildir}"

to \$MAILDIR
_EOF_

  opDo chown $1 ${dotMailfilterFile}
  opDo chmod 640 ${dotMailfilterFile}

  #opDo ls -l ${dotMailfilterFile}
  #opDo echo cat ${dotMailfilterFile}

  while read  thisLine ; do
       #echo ZZZ ${thisLine}
       echo cat ${thisLine} \| sudo -u $1 maildrop ${dotMailfilterFile}

       cat ${thisLine} | sudo -u $1 maildrop ${dotMailfilterFile}
  done
}


function vis_duplicatesList {
  EH_assert [[ $# -eq 0 ]]

  opDo /bin/rm /tmp/.msgid.cache

  if [ -d ${splitFolder} ] ; then
    cd ${splitFolder}
    #ls |&
    #while read -p thisLine ; do
    coproc { ls; sleep 2; }
    while read -u  ${COPROC[0]} thisLine ; do

        #echo ${thisLine}
        if formail -D 65536 /tmp/.msgid.cache < ${thisLine}
        then 
           echo ${splitFolder}/${thisLine} 
        fi
    done
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
}


function vis_messageIdList {
  EH_assert [[ $# -eq 0 ]]

  if [ -d ${splitFolder} ] ; then
    cd ${splitFolder}
    #ls  |&
    #while read -p thisLine ; do
    coproc { ls; sleep 2; }
    while read -u  ${COPROC[0]} thisLine ; do

        #echo ${thisLine}
        thisMsgId=$( formail -x Message-ID < ${thisLine} )
        if [ "${thisMsgId}_" == "_" ] ; then
            thisMsgId=$( formail -x Message-Id < ${thisLine} )
        fi
        echo ${thisMsgId} ${splitFolder}/${thisLine}
    done
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
}

function vis_spamList {
  EH_assert [[ $# -eq 0 ]]

  if [ -d ${splitFolder} ] ; then
    cd ${splitFolder}
    #ls |&
    #while read -p thisLine ; do
    coproc { ls; sleep 2; }
    while read -u  ${COPROC[0]} thisLine ; do

      #echo ${thisLine}
      spamLine=$( reformail -X X-Spam-Flag: < ${thisLine} )
      if [ "${spamLine}_" != "_" ] ; then
        #echo ${splitFolder}/${thisLine}: ${spamLine}
        echo ${splitFolder}/${thisLine}
      fi
    done
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
}


function vis_folderRecombine {
  EH_assert [[ $# -eq 1 ]]

  resultFile=$1

  if [ -f ${resultFile} ] ; then
    EH_problem "File ${resultFile} exists. Will not overwrite"
    return 100
  fi


  if [ -d ${splitFolder} ] ; then
    cd ${splitFolder}
    #ls |&
    #while read -p thisLine ; do
    coproc { ls; sleep 2; }
    while read -u  ${COPROC[0]} thisLine ; do

      cat ${thisLine} >> ${resultFile}
    done
  else
    EH_problem "Missing directory: ${splitFolder}"
    return 100
  fi
  
  opDo ls -l ${resultFile}
}

function vis_folderHamSpam {
  if [ "${splitFolder}_" == "_" ] ; then
    EH_assert [[ $# -gt 0 ]]
  else
    EH_assert [[ $# -eq 0 ]]
  fi


  myArgs="$@"

  function oneFolderHamSpam {  
    splitFolderHam=${splitFolder}.Ham
    splitFolderSpam=${splitFolder}.Spam

    opDoExit mkdir ${splitFolderHam}
    opDoExit mkdir ${splitFolderSpam}

    splitFolderNext=${splitFolder}

    integer thisFileSize

    if  LIST_isIn clamAV "${scanWithList}" ; then
      # First we look for Viruses
      ANT_raw "Scanning For Viruses with clamscan in ${splitFolder}"
      cd ${splitFolder}
      #ls |&
      #while read -p thisLine ; do
      coproc { ls; sleep 2; }
      while read -u  ${COPROC[0]} thisLine ; do

        #echo ${thisLine}
        vis_clamScanTag ${thisLine} > ${splitFolderHam}/${thisLine}
        retVal=$?
        if [ "${retVal}" == "1" ]; then
          opDo mv ${splitFolderHam}/${thisLine} ${splitFolderSpam}/${thisLine}
          thisFileSize=$( FN_fileSize ${splitFolderSpam}/${thisLine} )
          ANT_raw "INFECTED: ${splitFolderSpam}/${thisLine} : ${thisFileSize}"
        else
          thisFileSize=$( FN_fileSize ${splitFolderHam}/${thisLine} )
          ANT_raw " CLEAN  : ${splitFolderHam}/${thisLine} : ${thisFileSize}"
        fi
      done
      splitFolderNext=${splitFolderHam}
    fi

    if  LIST_isIn spamA "${scanWithList}" ; then
      # Next in the ham directoy sans virus we look for spam
      ANT_raw "Scanning For Spam with spamassasin in ${splitFolder}"
      cd ${splitFolderNext}
      #ls |&
      #while read -p thisLine ; do
      coproc { ls; sleep 2; }
      while read -u  ${COPROC[0]} thisLine ; do

        #echo ${thisLine}
        #spamassassin < ${thisLine} > ${splitFolderSpam}/${thisLine} 
        #spamLine=`cat ${splitFolderSpam}/${thisLine} | reformail -X X-Spam-Flag:`
        spamLine=`spamassassin < ${thisLine} | tee ${splitFolderSpam}/${thisLine} | reformail -X X-Spam-Flag:`
        if [ "${spamLine}_" == "_" ] ; then
          opDo mv ${splitFolderSpam}/${thisLine} ${splitFolderHam}/${thisLine}
          thisFileSize=$( FN_fileSize ${splitFolderHam}/${thisLine} )
          ANT_raw "HAM : ${splitFolderHam}/${thisLine} : ${thisFileSize}"
        else
          thisFileSize=$( FN_fileSize ${splitFolderSpam}/${thisLine} )
          ANT_raw "SPAM: ${splitFolderSpam}/${thisLine} : ${thisFileSize}"
        fi
      done
    fi
  }

  if [ "${splitFolder}_" != "_" ] ; then
    if [ ! -d ${splitFolder} ] ; then
      EH_problem "Missing directory: ${splitFolder}"
      return 1
    fi
    oneFolderHamSpam
    return
  fi

  for thisArg in ${myArgs} ; do
    #ANT_raw "thisArg=${thisArg} splitFolder=${splitFolder}"

    opDoRet vis_folderSplit ${thisArg}
    splitFolder="${thisArg}.splitFolder"

    oneFolderHamSpam

    splitFolder=${thisArg}.splitFolder.Ham
    vis_folderRecombine ${thisArg}.Ham
    
    splitFolder=${thisArg}.splitFolder.Spam
    vis_folderRecombine ${thisArg}.Spam

    # NOTYET, Clean Up the 3 Split Directories
  done
}


function vis_folderReportFunc {
  EH_assert [[ $# -gt 0 ]]

  myFuncs="$@"

  #Verify that funcs or program exists

  if [ "${splitFolder}_" != "_" ] ; then
    if [ ! -d ${splitFolder} ] ; then
      EH_problem "Missing directory: ${splitFolder}"
      return 1
    fi
  else
    EH_problem "Mandatory Parameter splitFolder not set"
    return 
  fi

  ANT_raw "Scanning/Reporting with $@ in ${splitFolder}"
  cd ${splitFolder}
  #ls |&
  #while read -p thisLine ; do
  coproc { ls; sleep 2; }
  while read -u  ${COPROC[0]} thisLine ; do

    msg=${splitFolder}/${thisLine}
    $@
    retVal=$?
    if [ "${retVal}" == "0" ]; then
      thisFileSize=$( FN_fileSize ${destFolder}/${thisLine} )
      ANT_raw "  MATCH : ${destFolder}/${thisLine} : ${thisFileSize}"
    else
      thisFileSize=$( FN_fileSize ${splitFolder}/${thisLine} )
      ANT_raw "NO MATCH: ${splitFolder}/${thisLine} : ${thisFileSize}"
    fi
  done
}

function vis_folderSortFunc {
  EH_assert [[ $# -gt 0 ]]

  myFuncs="$@"

  #Verify that funcs or program exists

  if [ "${destFolder}_" != "_" ] ; then
    if [ ! -d ${destFolder} ] ; then
      opDoExit mkdir -p ${destFolder}
    fi
  else
    EH_problem "Mandatory Parameter destFolder not set"
    return 
  fi

  if [ "${splitFolder}_" != "_" ] ; then
    if [ ! -d ${splitFolder} ] ; then
      EH_problem "Missing directory: ${splitFolder}"
      return 1
    fi
  else
    EH_problem "Mandatory Parameter splitFolder not set"
    return 
  fi

  ANT_raw "Scanning with $@ in ${splitFolder}"
  cd ${splitFolder}
  #ls |&
  #while read -p thisLine ; do
  coproc { ls; sleep 2; }
  while read -u  ${COPROC[0]} thisLine ; do

    msg=${splitFolder}/${thisLine}
    $@
    retVal=$?
    if [ "${retVal}" == "0" ]; then
      opDo FN_fileSafeMove ${splitFolder}/${thisLine} ${destFolder}/${thisLine}
      thisFileSize=$( FN_fileSize ${destFolder}/${thisLine} )
      ANT_raw "  MATCH : ${destFolder}/${thisLine} : ${thisFileSize}"
    else
      thisFileSize=$( FN_fileSize ${splitFolder}/${thisLine} )
      ANT_raw "NO MATCH: ${splitFolder}/${thisLine} : ${thisFileSize}"
    fi
  done
}


function vis_testMsgFunc {
  EH_assert [[ $# -gt 0 ]]
  EH_assert opParamIsSet msg


  ANT_raw "Scanning with $@ message ${msg}"

  $@
  retVal=$?
  thisFileSize=$( FN_fileSize ${msg} )
  if [ "${retVal}" == "0" ]; then
      ANT_raw "  MATCH : ${msg} : ${thisFileSize}"
  else
      ANT_raw "NO MATCH: ${msg} : ${thisFileSize}"
  fi
}


function vis_credits {
 cat  << _EOF_

Google the info below to find the original script that 
was used. This work has diverged enough such that 
keeping the original code does not make sense.

Partially built on work of:

#
# Copyright (C) 2006, r. gritzo, gritzo at
# jerichodata then a dot then com
#
####################################################################################
# Mailbox file split and scan tool.
# splits up mbox files (like kept by thunderbird) into individual messages
# and scans them one by one with clamscan, with a summary of problems found. 
# Intended to be used to find out which message in a mbox collection of messages
# is the problem child. (i.e. is responsible for clamscan tagging the mbox file
# as infected)

_EOF_
}

#
# JUNK YARD
#


function vis_clamScanTagOrig {

#!/bin/bash
# Created by Tom Walsh, slim at ala.net
# slightly modified by Wolfgang Ziegler, nuppla at gmx.at

RUN=clamscan
# Enable this line, if you are using the clamav-daemon.
# RUN=clamdscan


#start
MSG=$(< /proc/self/fd/0) # stdin -> $MSG
SCAN=$(echo "$MSG" | $RUN - --stdout --disable-summary)
EXIT="$?"
VIRUS=$(echo "$SCAN" | awk '{print $2}')
SUBJECT=$(echo "$MSG" | reformail -x Subject:)

if [ "$EXIT" == "1" ]; then
 SUBJECT="**VIRUS** [$VIRUS] $SUBJECT"
 MSG=$(echo "$MSG" | reformail -i"X-Virus-Status: INFECTED")
 MSG=$(echo "$MSG" | reformail -i"Subject: $(echo "$SUBJECT")")
else
 MSG=$(echo "$MSG" | reformail -i"X-Virus-Status: CLEAN")
fi

echo "$MSG"
exit 0
}

function vis_folderSplitOrig {
#!/bin/bash

####################################################################################
# set these settings up to suit...
# !!! Note - if CLEAN_TMP_DIR is set this directory is wiped clean during the run !!!
# !!! DO NOT set this to any directory that has something useful in it or to a toplevel
#     directory, or it will be purged.  you have been warned....
TMP_SCANDIR=~/tmp_scandir
TMP_EXT=mtxt
CLEAN_TMP_DIR=0    # 0 means don't clean the tmp_scan dir first, 1 means do
# probably don't need to change this
#CLAMSCAN=/usr/bin/clamscan
CLAMSCAN=/bin/echo
FORMAIL=/usr/bin/formail
# nothing below here needs normally needs to be changed....

# check to see if everything we need is here...
if [ ! -x $FORMAIL ]; then
    echo "Error - formail executeable $FORMAIL not found."
    exit 1
fi
if [ ! -x $CLAMSCAN ]; then
    echo "Error - clamscan executeable $CLAMSCAN not found."
    exit 1
fi
   
if [ $# -ne 1 ]; then
    echo -e "Useage:  ./scan_mbox.sh <mailbox_file>"
    echo -e "\tNote:  the <mailbox_file> needs to be the full path to the mailbox file,"
    echo -e "\t       for example /home/user/.thunderbird/default/Mail/mailserver/Trash"
    if [ $CLEAN_TMP_DIR -eq 1 ]; then
        echo -e "\t\t!!! will clean out the $TMP_SCANDIR directory prior to each run !!!"
    else
        echo -e -n "\t\t!!! will NOT clean out the $TMP_SCANDIR directory before running,"
        echo -e " will overwrite existing files !!!"
    fi
    exit 2
fi

# cleanup the tmp-scandir if needed
if [ $CLEAN_TMP_DIR -eq 1 ]; then
    echo "Cleaning up any files from the previous runs..."
    # change the -i to a -f below to bypass the need for confirmations...
    rm -i -rv $TMP_SCANDIR
fi

# create or re-create the tmpdir
echo "Creating (if needed) the TMP_SCANDIR location $TMP_SCANDIR..."
#opDo mkdir -p -v $TMP_SCANDIR
opDoExit mkdir -p  $TMP_SCANDIR

# set the FILENO variable and export so formail will update it...
FILENO=000000
export FILENO
export TMP_SCANDIR
export TMP_EXT

echo "Extracting individual mail files from $1..."
#echo $FORMAIL -d -s sh -c 'cat - >$TMP_SCANDIR/$FILENO.$TMP_EXT' <$1
$FORMAIL -d -s sh -c 'cat - >$TMP_SCANDIR/$FILENO.$TMP_EXT' <$1

# this is a klugey but workable way to do this if there are lots of files (like 10000 or more)
echo "Counting up the new files in $TMP_SCANDIR..."
NEWF=000000;  I=0;
while [ -e $TMP_SCANDIR/$NEWF.$TMP_EXT ]
do
    I=$((I+1)); NEWF=`printf "%06d" $I`
done
LASTFILE=`printf "%06d" $((I-1))`
echo "Split $1 into files 000000.$TMP_EXT thru $LASTFILE.$TMP_EXT..."
}
