#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: bystarDnsAdmin.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     /opt/public/osmt/bin/seedSubjectAction.sh -l $0 $@
     exit $?
fi

vis_help () {
  cat  << _EOF_

See ./bystarDnsDomain.libSh for details.

The resolver related parts are now in: 
  ./bystarDnsResolvAdmin.sh


TODO:

  - -i dnsContentAdjsut hereAcct  -- add /etc/dnscache/root/servers/
  - -i dnsContentAdjust hereAcctNot --
  - -i dnsContentAdjust hereAcctAll
  - -i dnsContentAdjust hereAcctNone


_EOF_

}

. ${opBinBase}/bystarHook.libSh

# bystarLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/bystarHereAcct.libSh


# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh

# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh


. ${opBinBase}/lpCurrents.libSh
. ${opBinBase}/lpParams.libSh

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
  oneZoneMastersBase=$( bystarDnsInfoAdmin.sh -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  zoneMastersList 2> /dev/null | head -1  )
  allZoneMastersBase=$( bystarDnsInfoAdmin.sh -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  zoneMastersList 2> /dev/null )
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- See Also ---
bystarDnsReport.sh  -i dnsSeeAlso
--- DNS All Update ---
${G_myName} ${extraInfo} -i  platformPrep
--- DNS All Update ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i  dnsLocalFullUpdate
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i  dnsFullUpdate
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i dnsServicesFullUpdate
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i  zonesExportFullUpdate
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i  zonesExportFullUpdate
--- Exports Prep (ssh keys ...) ---
${G_myName} ${extraInfo} -i exportPrepPlatformPrep
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i exportPrep
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i exportPrep
${G_myName} ${extraInfo} -i exportPrepZoneMaster ${oneZoneMastersBase}
${G_myName} ${extraInfo} -i exportPrepZoneMaster ${allZoneMastersBase}
--- Local Export Prep ---
${G_myName} ${extraInfo} -f -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zoneMastersExportToFile
${G_myName} ${extraInfo} -f -p bystarUid=${thisOneSaNu} -p DomainForm=all -i zoneMastersExportToFile
--- Export (scp) ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zoneMastersExport
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i zoneMastersExport
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zoneMastersExportToDest /etc/tinydns/export/librecenter.net.export
--- Remote Export Post ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zonesExportPostProcess
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i zonesExportPostProcess
--- DNS Name Server Update ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zoneMastersDnsNsUpdate
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i zoneMastersDnsNsUpdate
--- 
bystarDnsInfoAdmin.sh ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=FormTld -i zoneMastersList
bystarDnsInfoAdmin.sh ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i zoneMastersList
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}


 
function vis_dnsFullUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  thisDomainForm=${DomainForm}
  opDo vis_dnsLocalFullUpdate

  #vis_exportPrep  ## Done Once in PlatformInit

  DomainForm=${thisDomainForm}
  vis_zonesExportFullUpdate

  DomainForm=${thisDomainForm}
}

 
function vis_dnsLocalFullUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  thisDomainForm=${DomainForm}

  opDo bystarDnsInfoAdmin.sh -h -v -n showRun -p bystarUid=${bystarUid} -i infoBaseAcctDefaultWrite

  DomainForm=${thisDomainForm}
  opDo vis_zoneMastersDnsNsUpdate

  DomainForm=${thisDomainForm}
  opDo bystarServiceAdmin.sh -p bystarUid=${bystarUid} -p DomainForm=${DomainForm} -i allDnsServices

  DomainForm=${thisDomainForm}
  opDo bystarDnsZoneMasters.sh -i zonesRebuildData

  DomainForm=${thisDomainForm}
  #opDo vis_dnscacheFakeHere
  opDo bystarDnsResolvAdmin.sh -h -v -n showRun -p bystarUid=${bystarUid} -p DomainForm=${DomainForm} -i dnscacheFakeHere

  DomainForm=${thisDomainForm}
}




 
function vis_zonesExportFullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
List all in Servers directory
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

    if [[ "${DomainForm}_" == "all_" ]] ; then
        for DomainForm in ${DomainFormTypes} ; do
            vis_zonesExportFullUpdate
        done
    fi

    opDoRet bystarAcctAnalyze ${bystarUid}

  # NOTYET, debugging for now
  #opDo vis_dnscacheFakeHereNot

  #ANT_raw "${DomainForm}"

  # One time Activity
  #opDo vis_exportPrep
      
    opDo vis_zoneMastersExport
    
    opDo vis_zonesExportPostProcess
}


function vis_platformPrep {
  EH_assert [[ $# -eq 0 ]]

    # Make sure permissions are right
    #
    # Makesure account has a shell 
    #
        opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate

}

 
function vis_exportPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]


  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_exportPrep
      done
  fi

  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainBase=$( bystarDomainBaseGet )

  mastersList=$( vis_zoneMastersList )

  for thisOne in ${mastersList} ; do
      opDo vis_exportPrepZoneMaster ${thisOne}
  done
}


function vis_exportPrepZoneMaster {
    # argv=${oneZoneMastersBase} argv=${allZoneMastersBase}
  EH_assert [[ $# -gt 0 ]]

  for thisOne in $* ; do
      opDo fileParamsLoadVarsFromBaseDir ${thisOne}
      #echo "cp_acct=${cp_acct} cp_ipAddr=${cp_ipAddr} cp_passwd=${cp_passwd}"

      opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${cp_ipAddr}  -i authorizedKeysUpdate
  done

}

 
function vis_zonesExportPostProcess {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_zonesExportPostProcess
      done
  fi

  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainBase=$( bystarDomainBaseGet )

  mastersList=$( vis_zoneMastersList )

  for thisOne in ${mastersList} ; do
      opDo fileParamsLoadVarsFromBaseDir ${thisOne}
      #echo "cp_acct=${cp_acct} cp_ipAddr=${cp_ipAddr} cp_passwd=${cp_passwd}"

      opDoComplain sudo -u dnsadmin ssh ${cp_ipAddr} ${opBinBase}/bystarDnsZoneMasters.sh -i zonesRebuildData
  done
}

function vis_zoneMastersExport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_zoneMastersExport
      done
  fi

  exportFileName=$( vis_zoneMastersExportToFile )

  if [ "${exportFileName}_" = "_" ] ; then
      return 
  fi

  #echo ${exportFileName}

  opDo vis_zoneMastersExportToDest ${exportFileName}
}

function vis_zoneMastersList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  opDo bystarDnsInfoAdmin.sh -p bystarUid=${bystarUid} -p DomainForm=${DomainForm} -i  zoneMastersList
}


function vis_zoneMastersExportToDest {
  EH_assert [[ $# -eq 1 ]]
  exportFileName=$1
  EH_assert [[ -f ${exportFileName} ]]

  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]


  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainBase=$( bystarDomainBaseGet )

  mastersList=$( vis_zoneMastersList )

  for thisOne in ${mastersList} ; do
      opDo fileParamsLoadVarsFromBaseDir ${thisOne}
      #echo "cp_acct=${cp_acct} cp_ipAddr=${cp_ipAddr} cp_passwd=${cp_passwd}"

      opDoComplain sudo -u dnsadmin scp -pq ${exportFileName} ${cp_ipAddr}:${mmaDns_importBaseDir}/${bystarDomainBase}
  done

}


function vis_zoneMastersExportToFile {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  #
  # Combination of bystarUid and DomainForm gives us what is needed to
  #   grep in data file for what needs to be exported

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_zoneMastersExportToFile
      done
  fi
 
  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainBase=$( bystarDomainBaseGet )

  if [ "${bystarDomainBase}_" = "_" ] ; then
      return 
  fi

  exportBaseDirAssert

  typeset exportFileName="${mmaDns_exportBaseDir}/${bystarDomainBase}.export"

  
  opDoComplain eval "( grep ${bystarDomainBase} ${mmaDns_origContentDataFile} > ${exportFileName}.new )"


  # if [[ "${G_forceMode}_" != "force_" ]] ; then
  #   rightHere "Should Zone $1  be exported?"
  #   getConfirmation
  # fi

  if [[ ! -f ${exportFileName} ]] ; then
    touch ${exportFileName}
  fi
    
  if cmp ${exportFileName}.new ${exportFileName} ; then
    if [[ "${G_forceMode}_" != "force_" ]] ; then
      ANT_raw "$0: $1 Nothing New, Skipped"
      echo ${exportFileName}
      return 0
    fi
    # Leaving .new in place, it will be renewed next time
  else
    mv ${exportFileName}.new ${exportFileName}
  fi

  echo ${exportFileName}

}

function vis_zoneMastersDnsNsUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
  EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

  if [[ "${DomainForm}_" == "all_" ]] ; then
      for DomainForm in ${DomainFormTypes} ; do
          vis_zoneMastersDnsNsUpdate
      done
  fi

  opDoRet bystarAcctAnalyze ${bystarUid}

  bystarDomainBase=$( bystarDomainBaseGet )

  if [ "${bystarDomainBase}_" == "_" ] ; then
     return
  fi


  # mastersList=$( vis_zoneMastersList )

  # for thisOne in ${mastersList} ; do
  #     opDo fileParamsLoadVarsFromBaseDir ${thisOne}
  #     #echo "cp_acct=${cp_acct} cp_ipAddr=${cp_ipAddr} cp_passwd=${cp_passwd}"

  #     opDoRet mmaDnsContentNsAdd ${bystarDomainBase} ${cp_ipAddr}
  # done


  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}

  opDoRet mmaDnsContentNsAdd ${bystarDomainBase} ${thisIPAddress}

  opDo ls -l /etc/tinydns/origContent/data.origZones 1>&2
}
