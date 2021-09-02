#!/bin/osmtKsh

typeset RcsId="$Id: bynameNspMailLists.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    `dirname $0`/seedSubjectAction.sh -l $0 "$@"
    exit $?
fi

. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# PRE parameters
typeset -t acctTypePrefix=""
typeset -t FirstName=MANDATORY
typeset -t LastName=MANDATORY
typeset -t SubsSelector=""
typeset -t bynameUid=""
typeset -t subsdItemsFile="nil"

function G_postParamHook {

  # NOTYET, Perhaps
  # if ${subsdItemsFile} starts with '/'
  # just load it.
  # Otherwise, analyse byname params and 
  # load subs/NSP/itemsFile
  #
  # All of the above can then become
  # bynameNspLoadItemsFile function in bynameLib
  # and re-used amongs all NSP facilities.
  #
  # Perhaps, verify that the file exists also
  # 
  # prior to calling this, have convention of 
  # all expand to equivalent of star
  #

  if [[  "${subsdItemsFile}_" != "nil_" ]] ; then
    integer thisRetVal=0
    FN_fileIsAbsolutePath ${subsdItemsFile} || thisRetVal=$?

    if [[ ${thisRetVal} -eq 0 ]] ; then
      ItemsFiles=${subsdItemsFile}
    else
      bynameAcctAnalyze
      ItemsFiles="${byname_acct_NSPdir}/${subsdItemsFile}"
      subsdItemsFile="${byname_acct_NSPdir}/${subsdItemsFile}"
    fi
  fi
}

function vis_examples {
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
  typeset thisAcctTypePrefix="sa"
  typeset thisOneSaNu="sa-20051"
  #typeset thisOneSaNu="sa-20000"
  typeset oneSubsSelector=1 oneLastName=tjandana oneFirstName=pinneke
  typeset thisOneItemsFileAbsolute=`echo ~${thisOneSaNu}/NSP/mailListItems.ByName.nsp`
  typeset thisOneItemsFile="mailListItems.ByName.nsp"
  typeset thisOneList="subsdList_net_payk_iran_news"
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- INFORMATION ---
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a describe
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a fullVerify
--- FULL MANIPULATORS ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -p subsdItemsFile=${thisOneItemsFile} -s all -a  fullUpdate
${G_myName} -f -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFileAbsolute} -s all -a  fullUpdate
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a  fullUpdate
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a fullDelete
--- ADDRESS MANIPULATORS ---
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -i  addrSummary
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -i addrFqmaShow
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s all -a addrUpdate
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a addrUpdate
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a addrDelete
--- SUBSCRIPTION MANIPULATORS ---
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a subscribe
${G_myName} -p bynameUid=${thisOneSaNu} -p subsdItemsFile=${thisOneItemsFile} -s ${thisOneList} -a unsubscribe
_EOF_
}


vis_help () {
 cat  << _EOF_ 
NOTYET, 
    Make itemsFile parameter
    Complete examples
    Add schema verify
_EOF_

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

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}

function do_fullUpdate {
  opDoComplain do_addrUpdate
  opDoComplain do_subscribe
}

function do_fullDelete {
  opDoComplain do_unsubscribe
  #opDoComplain do_addrDelete
 cat  << _EOF_

To permanently delete this address, run

${G_myName} -p bynameUid=${bynameUid} -p subsdItemsFile=${subsdItemsFile} -s ${subject} -a addrDelete

after you receive the confirmation e-mail.
_EOF_
}

function do_addrUpdate {
  subjectValidatePrepare
  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    if [[ -f ${byname_acct_homedir}/.qmail-${iv_qmailAddr_itemName} ]] ; then
      return 0
    else
      opDoComplain mmaQmailAddrs.sh -p addrItemsFile=${subsdItemsFile} -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s ${subject} -a addrUpdate
    fi
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function vis_addrFqmaShow {
  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoComplain mmaQmailAddrs.sh  -p domainPart=${byname_acct_baseDomain} -p domainType=virDomain -p addrItemsFile="${subsdItemsFile}" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s all -a addrFqmaShow
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
  bynameAcctAnalyze || gotVal=$?

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
  bynameAcctAnalyze || gotVal=$?

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
  bynameAcctAnalyze || gotVal=$?

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
  if [[ -f ${byname_acct_homedir}/.qmail-${listRecords} ]] ; then
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
  subjectValidatePrepare

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    if [[ -f ${byname_acct_homedir}/.qmail-${iv_qmailAddr_itemName} ]] ; then
      print ".qmail-${iv_qmailAddr_itemName} -- Verified"
      return 0
    else
      print ".qmail-${iv_qmailAddr_itemName} -- Does not exist"
      return 1
    fi
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}
