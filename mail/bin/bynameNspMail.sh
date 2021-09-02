#!/bin/osmtKsh 
#!/bin/osmtKsh

typeset RcsId="$Id: bynameNspMail.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     seedSubjectAction.sh -l $0 $@
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

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
  typeset thisAcctTypePrefix="sa"
  #typeset thisOneSaNu="sa-20051"
  typeset thisOneSaNu="sa-20000"
  typeset oneSubsSelector=1 oneLastName=simpson oneFirstName=homer
  typeset oneSubject="qmailAddr_test"
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- PROVISIONING ACTIONS ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  fullAdd
${G_myName} -p bynameUid=${thisOneSaNu} -i  fullAdd
${G_myName} -f -p bynameUid=${thisOneSaNu} -i  fullAdd
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  dnsUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i dnsUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i virDomAdd
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i addrUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i injectWelcome
--- DEACTIVATION ACTIONS ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  fullDelete
${G_myName} -p bynameUid=${thisOneSaNu} -i  fullDelete
${G_myName} -p bynameUid=${thisOneSaNu} -i  addrDelete
${G_myName} -p bynameUid=${thisOneSaNu} -i  addrDelete
${G_myName} -p bynameUid=${thisOneSaNu} -i  virDomDelete
${G_myName} -p bynameUid=${thisOneSaNu} -i  dnsDelete
--- MAINTENANCE ACTIONS ---
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i addrUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -s ${oneSubject} -a addrUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -f -s ${oneSubject} -a addrUpdate
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -s ${oneSubject} -a injectMsg testEmailStdout
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i injectMsgAll testEmailStdout
${G_myName} ${extraInfo} -p bynameUid=${thisOneSaNu} -i injectWelcome
${G_myName} ${extraInfo} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  aliasToMainAt
--- INFORMATION ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -p acctTypePrefix=${thisAcctTypePrefix} -i  addrSummary
${G_myName} -p bynameUid=${thisOneSaNu} -i addrSummary
${G_myName} -p bynameUid=${thisOneSaNu} -i addrFqmaShow
mmaQmailAddrs.sh  -p domainPart=${byname_acct_baseDomain} -p domainType=virDomain   -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s $subject -a addrFqmaShow
--- OLDIES ---
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -i updateOverWriteQmailFiles
${G_myName} -p SubsSelector=${oneSubsSelector}  -p LastName=${oneLastName} -p FirstName=${oneFirstName} -i  acctAdd
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

opDoComplain vis_dnsUpdate
opDoComplain vis_virDomAdd
opDoComplain vis_addrUpdate
opDoComplain vis_injectWelcome

}


function vis_injectWelcome {
  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    typeset thisOne=""
    mmaQmailMsgDefaults

    mmaQmailMsg_envelopeAddr="admin@mohsen.banan.1.byname.net"
    mmaQmailMsg_fromAddr="admin@byname.net"

    #mmaQmailMsg_ccAddrList=""
    mmaQmailMsg_subjectLine="Welcome Byname NSP First Message"
  
    tmpContentFile=/tmp/${G_myName}.$0.$$

    cat  << _EOF_ > ${tmpContentFile}
Some Text ${thisOne}
_EOF_

    mmaQmailMsg_contentFile=${tmpContentFile}
    mmaQmailMsg_extraHeaders="_nil"
    mmaQmailMsg_toAddrList="office@${byname_acct_baseDomain}"
    mmaQmailMsgInject

    FN_fileRmIfThere  ${tmpContentFile}
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function vis_injectMsgAll {
  EH_assert [[ $# -eq 1 ]]
  subject="all"
  do_injectMsg $1
}


function do_injectMsg {
  EH_assert [[ $# -eq 1 ]]

  msgFuncStdout=$1

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -ne 0 ]] ; then
    EH_problem "$0: not enough info."
    return 1
  fi

  bystarAddrList=$( mmaQmailAddrs.sh  -p domainPart=${byname_acct_baseDomain} -p domainType=virDomain   -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s $subject -a addrFqmaShow )

  for thisAddr in ${bystarAddrList} ; do

    typeset thisOne=""
    mmaQmailMsgDefaults

    mmaQmailMsg_envelopeAddr="admin@mohsen.banan.1.byname.net"
    mmaQmailMsg_fromAddr="admin@byname.net"

    #mmaQmailMsg_ccAddrList=""
    mmaQmailMsg_subjectLine="Welcome Byname NSP First Message"
  
    tmpContentFile=/tmp/${G_myName}.$0.$$

    ${msgFuncStdout} > ${tmpContentFile}

    mmaQmailMsg_contentFile=${tmpContentFile}
    mmaQmailMsg_extraHeaders="_nil"
    mmaQmailMsg_toAddrList="${thisAddr}"
    mmaQmailMsgInject

    FN_fileRmIfThere  ${tmpContentFile}
  done
}

function testEmailStdout {
  cat  << _EOF_
  Some Text Goes Here
_EOF_
}

function vis_dnsUpdate {

  opDoExit mmaDnsServerHosts.sh -i hostIsOrigContentServer

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}

    opDoRet mmaDnsEntryMxUpdate ${byname_acct_baseDomain} ${opRunHostName}
    opDoRet mmaDnsEntryMxUpdate ${byname_acct_numberDomain} ${opRunHostName}
  else
    EH_problem "$0: not enough info."
    return 1
  fi

}


function vis_virDomAdd {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    acctName=${byname_acct_acctTypePrefix}-${byname_acct_uid}
    virDomFQDN="${byname_acct_baseDomain}"
    echo "Virtual Domain: ${virDomFQDN} -- AcctId: ${acctName}" 

    opDoExit mmaQmailVirDomUpdate ${virDomFQDN} ${acctName}
    opDoExit mmaQmailVirDomUpdate ${byname_acct_numberDomain} ${acctName}
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}



function vis_addrUpdate {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    if [[ "${G_forceMode}_" == "force_" ]] ; then
      opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s all -a addrUpdate
    else
      opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s all -a addrUpdate
    fi
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function do_addrUpdate {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -ne 0 ]] ; then
    EH_problem "$0: not enough info."
    return 1
  fi

  if [[ "${G_forceMode}_" == "force_" ]] ; then
    opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s $subject -a addrUpdate
  else
    opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s $subject -a addrUpdate
  fi
}

function vis_addrFqmaShow {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoComplain mmaQmailAddrs.sh  -p domainPart=${byname_acct_baseDomain} -p domainType=virDomain   -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s all -a addrFqmaShow
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}






function vis_addrDelete {
  opDoComplain byname_acctInfoGet ${SubsSelector} ${LastName} ${FirstName} ${acctTypePrefix}

 opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${acctTypePrefix}-${byname_acct_uid}" -s all -a addrDelete
}

function vis_addrSummary {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -s all -a summary
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}

function vis_acctAdd {
  #set -x


  # NOTYET, verify that  ${SubsSelector} ${LastName} ${FirstName}
  # are all set
  #

  opDoComplain vis_virDomAdd 
  opDoComplain vis_updateOverWriteQmailFiles

}



function vis_fullDelete {
  #set -x

  # NOTYET, verify that  ${SubsSelector} ${LastName} ${FirstName}
  # are all set
  #
  opParamMandatoryVerify

  opDoComplain vis_addrDelete
  opDoComplain vis_virDomDelete
  opDoComplain vis_dnsDelete
}

function vis_dnsDelete {

  opDoExit mmaDnsServerHosts.sh -i hostIsOrigContentServer

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}

    opDoRet mmaDnsEntryMxUpdate ${byname_acct_baseDomain} ${opRunHostName}
    opDoRet mmaDnsEntryMxUpdate ${byname_acct_numberDomain} ${opRunHostName}
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}


function vis_aliasToMainAt {
  #set -x

  # NOTYET, verify that  ${SubsSelector} ${LastName} ${FirstName}
  # are all set
  #
  opParamMandatoryVerify

    echo  ${SubsSelector} ${LastName} ${FirstName}
    
    typeset dotQmailFile=~alias/.qmail-${FirstName}:${LastName}


    #NOTYET, verify that account exists

    opDoComplain byname_acctInfoGet ${SubsSelector} ${LastName} ${FirstName} ${acctTypePrefix} 

    typeset bynumberDotQmailFile=/acct/progs/qmaildom/net/bynumber/.qmail-${byname_acct_uid}

    echo "| forward main@${FirstName}.${LastName}.${SubsSelector}.byname.net" > ${dotQmailFile}
    chown alias ${dotQmailFile}
    chgrp qmail ${dotQmailFile}
    chmod 600 ${dotQmailFile}

    ls -l  ${dotQmailFile}
    cat ${dotQmailFile}

    echo "| forward main@${FirstName}.${LastName}.${SubsSelector}.byname.net" > ${bynumberDotQmailFile}

    # There should be a better way instead of qvd-0016
    chown qvd-0016  ${bynumberDotQmailFile}
    #chgrp qmail ${bynumberDotQmailFile}
    chmod 600 ${bynumberDotQmailFile}

   ls -l  ${bynumberDotQmailFile} 
    cat ${bynumberDotQmailFile} 
 
 
}


function vis_virDomDelete {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then
    acctName=${byname_acct_acctTypePrefix}-${byname_acct_uid}
    virDomFQDN="${byname_acct_baseDomain}"
    echo "Virtual Domain: ${virDomFQDN} -- AcctId: ${acctName}" 

    # NOTYET
    opDoExit mmaQmailVirDomDelete ${virDomFQDN} ${acctName}
  else
    EH_problem "$0: not enough info."
    return 1
  fi

}


function vis_updateOverWriteQmailFiles {

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    if ! test -f ${byname_acct_NSPdir}/mailAddrItems.nsp ; then
      /bin/cp ${opSiteControlBase}/${opSiteName}/NSP.mailAcct.sh ${byname_acct_NSPdir}/mailAddrItems.nsp
    fi
    
    #echo "Running:\nmmaQmailAddrs.sh -p acctName=${acctTypePrefix}-${byname_acct_uid} -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -s all -a updateOverwrite"
    opDoComplain mmaQmailAddrs.sh -p acctName=${byname_acct_acctTypePrefix}-${byname_acct_uid} -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -s all -a updateOverwrite
  else
    EH_problem "$0: not enough info."
    return 1
  fi    
}

function do_schemaVerify {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  print "NOTYET"
  exit 1
}

