#!/bin/bash 
#!/bin/bash

typeset RcsId="$Id: bysmbNspMail.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     seedSubjectAction.sh -l $0 $@
     exit $?
fi

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# PRE parameters
typeset -t acctTypePrefix="MANDATORY"
typeset -t acctUid="MANDATORY"
typeset -t adminEmail="MANDATORY"
typeset -t enterpriseName="MANDATORY"
typeset -t enterpriseTld="MANDATORY"
typeset -t acctMailAddrItems=""

function vis_examples {
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
  typeset thisAcctTypePrefix="ea"
  typeset thisAcctUid="59000"
  typeset thisAdminEmail="pinneke@neda.com" 
  typeset thisAcctMailAddrItems="secLvlDomBasic" 
  typeset thisEnterpriseName="mehrsoft"
  typeset thisEnterpriseTld="com"
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- PROVISIONING ACTIONS ---
${G_myName} -p enterpriseName=${thisEnterpriseName} -p enterpriseTld=${thisEnterpriseTld} -p acctTypePrefix=${thisAcctTypePrefix} -p adminEmail="${thisAdminEmail}" -p acctUid="${thisAcctUid}" -p acctMailAddrItems="${thisAcctMailAddrItems}" -i  fullAdd

${G_myName} -p enterpriseName="${thisEnterpriseName}" -p enterpriseTld="${thisEnterpriseTld}"  -i  dnsUpdate

${G_myName} -p acctTypePrefix=${thisAcctTypePrefix} -p acctUid="${thisAcctUid}" -p enterpriseName="${thisEnterpriseName}" -p enterpriseTld="${thisEnterpriseTld}" -i virDomAdd

${G_myName} -p acctTypePrefix=${thisAcctTypePrefix} -p enterpriseName="${thisEnterpriseName}" -p enterpriseTld="${thisEnterpriseTld}" -p acctUid="${thisAcctUid}" -p acctMailAddrItems="${thisAcctMailAddrItems}" -i addrUpdate

${G_myName} -p adminEmail="${thisAdminEmail}" -i injectWelcome
--- INFORMATION ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  addrSummary
${G_myName} -p bynameUid=${thisOneSaNu} -i addrSummary
${G_myName} -p bynameUid=${thisOneSaNu} -i addrFqmaShow
_EOF_
}

vis_help () {
  cat  << _EOF_

  NOTYETs:
    - Top level, do everything
     - Top Level information
     - Generate Test Messages
     - Cleanups, 
     - Delete accounts

  FILES
       ${opSiteControlBase}/${opSiteName}/acctSubsItems

_EOF_

}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}

function vis_fullAdd {

opParamMandatoryVerify

opDoComplain vis_dnsUpdate
opDoComplain vis_virDomAdd
opDoComplain vis_addrUpdate
opDoComplain vis_injectWelcome

}


function vis_injectWelcome {

  typeset thisOne=""
  mmaQmailMsgDefaults

  mmaQmailMsg_envelopeAddr="admin@mohsen.banan.1.byname.net"
  mmaQmailMsg_fromAddr="admin@bysmb.net"

  #mmaQmailMsg_ccAddrList=""
  mmaQmailMsg_subjectLine="Welcome Bysmb NSP First Message"
  
    tmpContentFile=/tmp/${G_myName}.$0.$$

    cat  << _EOF_ > ${tmpContentFile}
Some Text ${thisOne}
_EOF_

    mmaQmailMsg_contentFile=${tmpContentFile}
    mmaQmailMsg_extraHeaders="_nil"
    mmaQmailMsg_toAddrList="${adminEmail}"
    mmaQmailMsgInject

    FN_fileRmIfThere  ${tmpContentFile}
}


function vis_dnsUpdate {

  EH_assert [[ "${enterpriseName}_" != "_" ]]
  EH_assert [[ "${enterpriseTld}_" != "_" ]]

  opDoExit mmaDnsServerHosts.sh -i hostIsOrigContentServer

  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
  # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
  
  opDoRet mmaDnsEntryMxUpdate ${enterpriseName}.bysmb.${enterpriseTld}  ${opRunHostName}
  opDoRet mmaDnsEntryMxUpdate ${enterpriseName}.${enterpriseTld} ${opRunHostName}

}


function vis_virDomAdd {

  EH_assert [[ "${acctTypePrefix}_" != "_" ]]
  EH_assert [[ "${acctUid}_" != "_" ]]
  EH_assert [[ "${enterpriseName}_" != "_" ]]
  EH_assert [[ "${enterpriseTld}_" != "_" ]]

  acctName=${acctTypePrefix}-${acctUid}
  echo "Virtual Domain: ${enterpriseName}.bysmb.${enterpriseTld} -- AcctId: ${acctName}" 
  opDoExit mmaQmailVirDomUpdate ${enterpriseName}.bysmb.${enterpriseTld} ${acctName}
  opDoExit mmaQmailVirDomUpdate ${enterpriseName}.${enterpriseTld} ${acctName}
}


function vis_addrUpdate {

  opParamMandatoryVerify

  if [[ "${G_forceMode}_" == "force_" ]] ; then
    opDoComplain mmaQmailAddrs.sh -f -p acctName="${acctTypePrefix}-${acctUid}" -i acctUpdate
    opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${opSiteControlBase}/${opRunSiteName}/mmaQmailAddrItems.${acctMailAddrItems}" -p acctName="${acctTypePrefix}-${acctUid}" -s all -a addrUpdate
  else
    opDoComplain mmaQmailAddrs.sh -p acctName="${acctTypePrefix}-${acctUid}" -i acctUpdate
    opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${opSiteControlBase}/${opRunSiteName}/mmaQmailAddrItems.${acctMailAddrItems}" -p acctName="${acctTypePrefix}-${acctUid}" -s all -a addrUpdate
  fi

  opDoExit opAcctInfoGet ${acctName}
  typeset dotQmailLists=`ls ${opAcct_homeDir}/.qmail*`
  typeset oneDotQmail
  for oneDotQmail in ${dotQmailLists} ; do
    cat ${oneDotQmail} | grep -v forward > ${oneDotQmail}
  done
}


function vis_addrFqmaShow {

  opParamMandatoryVerify

  opDoComplain mmaQmailAddrs.sh  -p domainPart=${enterpriseName}.bysmb.${enterpriseTld} -p domainType=virDomain   -p addrItemsFile="${opSiteControlBase}/${opRunSiteName}/mmaQmailAddrItems.${acctMailAddrItems}" -p acctName="${acctTypePrefix}-${acctUid}" -s all -a addrFqmaShow

}

function vis_addrSummary {

  opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${opSiteControlBase}/${opRunSiteName}/mmaQmailAddrItems.${acctMailAddrItems}" -s all -a summary

}

function do_schemaVerify {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  print "NOTYET"
  exit 1
}

