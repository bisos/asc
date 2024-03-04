#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"

####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/dns/bin/bystarDnsAdmin.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:

vis_help () {
  cat  << _EOF_

See ./bystarDnsDomain.libSh for details.

InfoBase Admin.

_EOF_

}



. ${opBinBase}/bystarHook.libSh

# bystarLib.sh
. ${opBinBase}/bystarLib.sh

# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh

# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh


. ${opBinBase}/lpCurrents.libSh

# PRE parameters
typeset -t acctTypePrefix=""
typeset -t bystarUid="MANDATORY"

function G_postParamHook {
  lpCurrentsGet
  return 0
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  #typeset thisOneSaNu="sa-20051"
  #typeset thisOneSaNu=${oneBystarAcct}
  typeset thisOneSaNu=${currentBystarUid}
  typeset oneSubject="qmailAddr_test"
  oneZoneMastersBase=$( ${G_myName} -p bystarUid=${thisOneSaNu} -p DomainForm=bysmb -i  zoneMastersList 2> /dev/null | head -1  )
  allZoneMastersBase=$( ${G_myName} -p bystarUid=${thisOneSaNu} -p DomainForm=bysmb -i  zoneMastersList 2> /dev/null )
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- See Also ---
bystarDnsReport.sh  -i dnsSeeAlso
--- InfoBase Acct Write ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu}  -i infoBaseAcctDefaultWrite
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu}  -i infoBaseAcctDefaultShow
--- InfoBase Acct Read/Load From ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu}  -i infoBaseAcctShow
--- DNS Masters/Export Info Assign ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  dnsZoneAssign
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  dnsZoneAssign /libre/ByStar/InfoBase/ZoneSvc/...
--- DNS Zones Get ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  dnsZoneGet
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i  dnsZoneGet 2> /dev/null | sort | uniq
--- DNS Masters/Export Info Get ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  zoneMastersList 2> /dev/null
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i  zoneMastersList 2> /dev/null | sort | uniq
--- Domain Base and Domain Types ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i bystarDomainBaseGet
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i bystarDomainBaseGet 2> /dev/null
${G_myName} ${extraInfo} -i bystarDomainFormTypes
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}


function vis_infoBaseAcctShow {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  EH_assert [[ -d ${infoBaseAcctBase} ]]

  opDo fileParamsCodeGenToFile  ${infoBaseAcctBase}
  opDo fileParamsLoadVarsFromBaseDir  ${infoBaseAcctBase}

  opDo fileParamsShow ${infoBaseAcctBase} | sort
}


function vis_infoBaseAcctDefaultWrite {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}


  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  if [ ! -d ${infoBaseAcctBase} ] ; then
      opDoExit mkdir -p ${infoBaseAcctBase}
  fi

  bystarDomainFormsPrep  2> /dev/null

  echo "${bystarDomFormTld}" > ${infoBaseAcctBase}/domFormTld:dr
  echo "${bystarDomFormTldZoneDefault}" > ${infoBaseAcctBase}/domFormTldZoneMasters:dr
  
  echo "${bystarDomFormTld2}" > ${infoBaseAcctBase}/domFormTld2:dr
  echo "${bystarDomFormTld2ZoneDefault}" > ${infoBaseAcctBase}/domFormTld2ZoneMasters:dr
  
  echo "${bystarDomFormSld}" > ${infoBaseAcctBase}/domFormSld:dr
  echo "${bystarDomFormSldZoneDefault}" > ${infoBaseAcctBase}/domFormSldZoneMasters:dr
  
  echo "${bystarDomFormBynumber}" > ${infoBaseAcctBase}/domFormBynumber:dr
  echo "${bystarDomFormBynumberZoneDefault}" > ${infoBaseAcctBase}/domFormBynumberZoneMasters:dr
  
  echo "${bystarDomFormNumbered}" > ${infoBaseAcctBase}/domFormNumbered:dr
  echo "${bystarDomFormNumberedZoneDefault}" > ${infoBaseAcctBase}/domFormNumberedZoneMasters:dr
  
  echo "${bystarDomFormNumberedSld}" > ${infoBaseAcctBase}/domFormNumberedSld:dr
  echo "${bystarDomFormNumberedSldZoneDefault}" > ${infoBaseAcctBase}/domFormNumberedSldZoneMasters:dr

  opDo chown -R lsipusr:employee ${infoBaseAcctBase}

  opDo ls -l ${infoBaseAcctBase}
}


function vis_infoBaseAcctDefaultShow {
    # NOTE: Also duplicated in bystarAcctInfo.sh
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}


  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  if [ ! -d ${infoBaseAcctBase} ] ; then
      opDoExit mkdir -p ${infoBaseAcctBase}
  fi

  bystarDomainFormsPrep  2> /dev/null


  varNameValueStdout bystarDomFormTld bystarDomFormTldZoneDefault
  
  varNameValueStdout bystarDomFormTld2
  varNameValueStdout bystarDomFormTld2ZoneDefault
  
  varNameValueStdout bystarDomFormSld
  varNameValueStdout bystarDomFormSldZoneDefault
  
  varNameValueStdout bystarDomFormBynumber
  varNameValueStdout bystarDomFormBynumberZoneDefault

  varNameValueStdout bystarDomFormNumbered
  varNameValueStdout bystarDomFormNumberedZoneDefault

  varNameValueStdout bystarDomFormNumberedSld
  varNameValueStdout bystarDomFormNumberedSldZoneDefault
}

function vis_bystarDomainBaseGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_bystarDomainBaseGet
      done
  else 
      bystarDomainBaseGet
  fi


}

function vis_dnsZoneAssign {
  EH_assert [[ $# -ge 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  opDo bystarBagpLoad

 #     dnsServersBase=$( domainDnsServersBaseGet )

  if [ "$1_" == "_" ] ; then
      mastersBase="/libre/ByStar/InfoBase/ZoneSvc/net/bysmb/_Zone/dnsContent"
  else 
      mastersBase=$1
  fi


  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  if [ ! -d ${infoBaseAcctBase} ] ; then
      EH_problem "Missing Directory: ${infoBaseAcctBase}"
      return 101
  fi

  zoneMastersFileName=${infoBaseAcctBase}/dom${DomainForm}ZoneMasters:dr

  # NOTYET, safekeep old one
  echo ${mastersBase} > ${zoneMastersFileName}

  opDo ls -l ${zoneMastersFileName}
}


function vis_dnsZoneGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_dnsZoneGet
      done
  else 
      infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

      EH_assert [[ -d ${infoBaseAcctBase} ]]

      opDo fileParamsLoadVarsFromBaseDir  ${infoBaseAcctBase}

      varName="cp_dom${DomainForm}ZoneMasters"

      # Indirection, dereferencing
      eval zoneMaster=\$${varName}

      echo "${zoneMaster}"
  fi
}

function vis_zoneMastersList {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]


  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_zoneMastersList
      done
  else 
      opDo bystarBagpLoad

      zoneBase=$( vis_dnsZoneGet )

      if [ "${zoneBase}_" != "_" ] ; then
          ls -d ${zoneBase}/* | grep -v CVS
      else
          EH_problem "Empty zoneBase"
      fi
  fi
}


function vis_bystarDomainFormTypes {
  EH_assert [[ $# -eq 0 ]]

  for DomainForm in ${DomainFormTypes} ; do
      echo "${DomainForm}"
  done
}


#
#  Junk Yard
#

function vis_bystarDomainNameGetObsoleted {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]
  EH_assert [[ "${ServiceName}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainNameGet
}


function domainDnsServersBaseGetObsoleted {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  opDo bystarBagpLoad

  # NOTYET, this needs to become perByStar

  # /libre/ByStar/InfoBase/Domain/net/librecenter/dnsServers/

  typeset dnsServersBase="/libre/ByStar/InfoBase/Domain/${cp_Domain1}/${cp_Domain2}/dnsServers"

  if [ ! -d ${dnsServersBase} ] ; then 
      opDo mkdir -p ${dnsServersBase}
  fi

  echo ${dnsServersBase}
}

