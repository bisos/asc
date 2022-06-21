#!/bin/bash
#!/bin/bash

typeset RcsId="$Id: bueMailListManage.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     $( dirname $0)/seedSubjectAction.sh -l $0 "$@"
     exit $?
fi



vis_help () {
 cat  << _EOF_ 
NOTYET, 
    Make itemsFile parameter
    Complete examples
    Add schema verify
_EOF_

}


. ${opBinBase}/lpErrno.libSh

. ${opBinBase}/bystarHook.libSh

# bystarMail.libSh 
. ${opBinBase}/bystarMail.libSh

# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh


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
typeset -t subsdItemsFile="INVALID"

function G_postParamHook {
    bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
    lpCurrentsGet
    bystarNspItemFileLoad 
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

  #typeset thisOneItemsFile="/acct/subs/banan/1/mohsen/NSP/mailListItems.ByStar.nsp"
  typeset thisOneItemsFile="mailListItems.ByStar.nsp"

  #typeset thisOneItemsFile="/acct/subs/banan/1/mohsen/NSP/mailListItems.Main.nsp"
  typeset thisTwoItemsFile="mailListItems.Main.nsp"

  typeset thisOneList="subsdList_net_payk_iran_news"

#${doLibExamples}
 cat  << _EOF_
EXAMPLES:
----  INFORMATION  ----
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a describe
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -i  addrSummary
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -i addrFqmaShow
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a describe
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -i  addrSummary
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -i addrFqmaShow
===== ByStar Container Facilities =====
--- FULL MANIPULATORS ---
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a  fullUpdate
${G_myName} -f -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a  fullUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a fullVerify
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a fullDelete
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a  fullUpdate
${G_myName} -f -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a  fullUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a fullVerify
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a fullDelete
--- ADDRESS MANIPULATORS ---
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a addrUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a addrUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a addrDelete
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a addrUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a addrUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a addrDelete
--- FDMB Folder/MailDir MANIPULATORS ---
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a maildirUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a maildirUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a maildirDelete
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s all -a maildirUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a maildirUpdate
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a maildirDelete
===== BUE Container Facilities =====
--- SUBSCRIPTION MANIPULATORS ---
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a subscribe
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a unsubscribe
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a subscribe
${G_myName} -p bystarUid=${thisOneSaNu} -p subsdItemsFile=${thisTwoItemsFile} -s ${thisOneList} -a unsubscribe
--- Extra Features For Developers ---
${G_myName} ${extraInfo} ${runInfo} -i developerExamples
_EOF_
}


function vis_developerExamples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

 cat  << _EOF_
EXAMPLES:
--- BUE (SpamBeGone) INFORMATION / Status ---
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}


function bystarNspItemFileLoad {
  if [[  "${subsdItemsFile}_" != "INVALID_" ]] ; then
    integer thisRetVal=0
    FN_fileIsAbsolutePath ${subsdItemsFile} || thisRetVal=$?

    if [[ ${thisRetVal} -eq 0 ]] ; then
      ItemsFiles=${subsdItemsFile}
    else
      ItemsFiles="${bystarUidHome}/NSP/${subsdItemsFile}"
      subsdItemsFile="${ItemsFiles}"
    fi
    . ${ItemsFiles}
  fi
}


itemIsSubjectHook () {
  # $1=subject
  
  selectedSubject=`echo $1 | egrep 'subsdList_'`
  if [ "${selectedSubject}X" == "X" ] ; then
    TM_trace 7  "Ignoring $1"
    return 0
  else
    TM_trace 7 "Selecting $1"
    return 1
  fi
}

function do_fullUpdate {
  opDoComplain do_addrUpdate
  #opDoComplain do_subscribe
}

function do_fullDelete {
  #opDoComplain do_unsubscribe
  #opDoComplain do_addrDelete
 cat  << _EOF_

To permanently delete this address, run

${G_myName} -p bystarUid=${bystarUid} -p subsdItemsFile=${subsdItemsFile} -s ${subject} -a addrDelete

after you receive the confirmation e-mail.
_EOF_
}


function do_maildirUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]
  EH_assert [[  "${subsdItemsFile}_" != "INVALID_" ]]

  subjectValidatePrepare

  bystarHereAnalyzeAcctBagp 2> /dev/null

  EH_assert [[ "${iv_qmailAddr_mailDir}_" != "_" ]]

  bystarMaildirBase=$( FN_dirsPart ${iv_qmailAddr_mailDir} )
  bystarMaildirName=$( FN_nonDirsPart ${iv_qmailAddr_mailDir} )

  if [[ ${bystarAcctMailDirBase} != ${bystarMaildirBase} ]] ; then
      EH_problem "Unexpected: ${bystarMaildirBase}"
      return 101
  fi

  opDoComplain echo bystarMailFolderManage.sh -p bystarUid=${bystarUid} -p folder=${bystarMaildirName} -i maildirCreate
}


function do_addrUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]
  EH_assert [[  "${subsdItemsFile}_" != "INVALID_" ]]

  subjectValidatePrepare
  integer gotVal=0
  bystarHereAnalyzeAcctBagp || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    if [[ -f ${bystarUidHome}/.qmail-${iv_qmailAddr_itemName} ]] ; then
      return 0
    else
      opDoComplain mmaQmailAddrs.sh -p addrItemsFile=${subsdItemsFile} -p acctName="${bystarUid}" -s ${subject} -a addrUpdate
    fi
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function vis_addrFqmaShow {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]
  EH_assert [[  "${subsdItemsFile}_" != "INVALID_" ]]

  integer gotVal=0
  bystarHereAnalyzeAcctBagp || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoComplain mmaQmailAddrs.sh  -p domainPart=${cp_acctMainBaseDomain} -p domainType=virDomain -p addrItemsFile="${subsdItemsFile}" -p acctName="${bystarUid}" -s all -a addrFqmaShow
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function do_addrDelete {
  if [[ "${G_forceMode}_" != "force_" ]] ; then
    ANT_raw "Dangerous: Are you sure? If so, use G_forceMode"
    return 1
  fi

  subjectValidatePrepare
  integer gotVal=0
  bystarHereAnalyzeAcctBagp || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${subsdItemsFile}" -p acctName="${acctTypePrefix}-${byname_acct_uid}" -s ${subject} -a addrDelete
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function vis_addrSummary {
  opDoComplain mmaQmailAddrs.sh -p addrItemsFile=${subsdItemsFile} -s all -a summary
}

function do_subscribe {

  subjectValidatePrepare
  integer gotVal=0
  bystarHereAnalyzeAcctBagp || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    thisAction="subscribe"
    opDoComplain oneSubscribeAtATime
  else
    EH_problem "$0: not enough info."
    return 1
  fi

}

function do_unsubscribe {
  subjectValidatePrepare
  integer gotVal=0
  bystarHereAnalyzeAcctBagp || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    thisAction="unsubscribe"
    opDoComplain oneSubscribeAtATime
  else
    EH_problem "$0: not enough info."
    return 1
  fi

}

function oneSubscribeAtATime {
  case ${iv_subsdList_listManagerType} in
    'ezmlm')
       opDoComplain usingEzmlm
       ;;
    'mojordomo')
       EH_problem "NOTYET"
       ;;
    'manual')
       EH_problem "NOTYET"
       ;;
    *)
       EH_problem "Unknown action: ${thisAction}"
       exit 1
       ;;
  esac
}

listRecords="list-records"

function listRecordsAssert {
  if [[ -f ${bystarUidHome}/.qmail-${listRecords} ]] ; then
    return 0
  else
    opDoComplain mmaQmailAddrs.sh -p FQMA=${listRecords}@${byname_acct_baseDomain} -p mbox="mail/lists/records" -i addrUpdate
  fi
}



function usingEzmlm {

  if [[ "${thisAction}_" == "subscribe_" ]] ; then
    if [[ "${G_forceMode}_" != "force_" ]] ; then
      if [[ "${iv_subsdList_status}_" == "Subscribed_" ]] ; then
        print "Skipped: You already subcribed to ${iv_subsdList_listName}"
        return 0
      fi
    fi
  elif [[ "${thisAction}_" == "unsubscribe_" ]] ; then
    if [[ "${G_forceMode}_" != "force_" ]] ; then
      if [[ "${iv_subsdList_status}_" == "Unsubscribed_" ]] ; then
        print "Skipped: You already unsubcribed to ${iv_subsdList_listName}"
        return 0
      fi
    fi
  else
    EH_problem "Unknown action: ${thisAction}"
    return 1
  fi

  typeset thisLocalPart=`MA_localPart ${iv_subsdList_listName}`
  typeset thisDomainPart=`MA_domainPart ${iv_subsdList_listName}`
  
  mmaQmailMsgDefaults
  mmaQmailMsg_envelopeAddr="${iv_qmailAddr_itemName}@${byname_acct_baseDomain}"
  mmaQmailMsg_fromAddr="public@${byname_acct_baseDomain}"
  opDo listRecordsAssert 
  mmaQmailMsg_ccAddrList="${listRecords}@${byname_acct_baseDomain}"
  if [[ "${thisAction}_" == "subscribe_" ]] ; then
    mmaQmailMsg_subjectLine="${iv_subsdList_listName} SUBSCRIBE REQUEST"
  elif [[ "${thisAction}_" == "unsubscribe_" ]] ; then
    mmaQmailMsg_subjectLine="${iv_subsdList_listName} UNSUBSCRIBE REQUEST"
  else
    EH_problem "Unknown action: ${thisAction}"
    return 1
  fi

  tmpContentFile=/tmp/${G_myName}.$0.$$

  cat  << _EOF_ > ${tmpContentFile}

_EOF_

  mmaQmailMsg_contentFile=${tmpContentFile}
  mmaQmailMsg_extraHeaders="_nil"
  if [[ "${thisAction}_" == "subscribe_" ]] ; then
    mmaQmailMsg_toAddrList="${thisLocalPart}-subscribe@${thisDomainPart}"
  elif [[ "${thisAction}_" == "unsubscribe_" ]] ; then
    mmaQmailMsg_toAddrList="${thisLocalPart}-unsubscribe@${thisDomainPart}"
  else
    EH_problem "Unknown action: ${action}"
    return 1
  fi
  mmaQmailMsgInject

  FN_fileRmIfThere  ${tmpContentFile}
}

function do_fullVerify {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "INVALID_" ]]
  EH_assert [[  "${subsdItemsFile}_" != "INVALID_" ]]

  subjectValidatePrepare

  integer gotVal=0
  bystarHereAnalyzeAcctBagp 2> /dev/null || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    if [[ -f ${bystarUidHome}/.qmail-${iv_qmailAddr_itemName} ]] ; then
      print "${bystarUidHome}/.qmail-${iv_qmailAddr_itemName} -- Verified"
      return 0
    else
      print "${bystarUidHome}/.qmail-${iv_qmailAddr_itemName} -- Does not exist"
      return 1
    fi
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

