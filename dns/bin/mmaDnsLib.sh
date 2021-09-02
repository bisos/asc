#
#

. ${opLibBase}/opDoAsLib.sh
# lpParams.libSh 
. ${opBinBase}/lpParams.libSh

# DNS IpV4Addr Parameters

hereDnscacheIpV4Addr="127.0.0.1"
hereTinydnsMainIpV4Addr="127.0.0.2"
hereTinydnsBlackListIpV4Addr="127.0.0.3"
hereTinydnsWhiteListIpV4Addr="127.0.0.4"


mmaDns_tinydnsBaseDir=/etc/tinydns

mmaDns_tinydnsDataDir=${mmaDns_tinydnsBaseDir}/root
mmaDns_tinydnsDataFile=${mmaDns_tinydnsDataDir}/data
mmaDns_tinydnsDataFileCombined=${mmaDns_tinydnsDataFile}.combined

mmaDns_exportBaseDir=${mmaDns_tinydnsBaseDir}/export
mmaDns_importBaseDir=${mmaDns_tinydnsBaseDir}/import
mmaDns_origContentBaseDir=${mmaDns_tinydnsBaseDir}/origContent

mmaDns_origContentDataFile=${mmaDns_tinydnsBaseDir}/origContent/data.origZones
mmaDns_origContentDataFileTmp=${mmaDns_origContentDataFile}.new

if [ -f /usr/bin/tinydns-data  ] ; then
    mmaDns_binsDir=/usr/bin
elif [ -f /usr/local/bin/tinydns-data ] ; then
  mmaDns_binsDir=/usr/local/bin
else
    doNothing
  #EH_problem "tinydns binaries missing"
fi


if [ "${opRunOsType}_" == "SunOS_" ] ; then
  mmaDns_privateRootServer=127.0.0.1
  mmaDns_privateNonRootServer=127.0.0.1
elif [ "${opRunOsType}_" == "Linux_" ] ; then
  mmaDns_privateRootServer=127.53.0.1
  mmaDns_privateNonRootServer=127.53.0.2
else
  EH_problem "Unsupported OS: ${opRunOsType}"
fi


tinydnsEdit=${mmaDns_binsDir}/tinydns-edit 
tinydnsData=${mmaDns_binsDir}/tinydns-data



function mmaDnsUsersAndGroupsAdd {
  echo "Creating Basic DJBDNS User Ids"
  opDoComplain opAcctGroups.sh -s gid_djbdns -a verifyAndFix

  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnslog -a verifyAndFix
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnscache -a verifyAndFix
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_tinydns -a verifyAndFix
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_axfrdns -a verifyAndFix
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnswall -a verifyAndFix
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnsadmin -a verifyAndFix
}

function mmaDnsUsersAndGroupsDel {
  echo "Deleting Basic DJBDNS User Ids"

  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnslog -a delete
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnscache -a delete
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_tinydns -a delete
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_axfrdns -a delete
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnswall -a delete
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnsadmin -a delete

  opDoComplain opAcctGroups.sh -s gid_djbdns -a delete
}

function mmaDnsUsersAndGroupsInfo {
  echo "Info Basic DJBDNS User Ids"

  opDoComplain opAcctGroups.sh -s gid_djbdns -a info

  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnslog -a info
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnscache -a info
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_tinydns -a info
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_axfrdns -a info
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnswall -a info
  opDoComplain opAcctUsers.sh -p acctType=mmaProgramAccount -s dnsUsr_dnsadmin -a info
}


function mmaDnsContentSelectServer {
  EH_assert [[ $# -eq 1 ]]
  # Future mmaDnsContent Actions Apply to the selected server
  # $1 -- server name
  # 
  # NOTYET
  # perhaps not a good idea, 
  # usefull if we were to do a remote management model
}

function mmaDnsAssertOrigContentServer {
  EH_assert [[ $# -eq 0 ]]
  if opDo mmaDnsServerHosts.sh -i hostIsOrigContentServer ; then
    return 0
  else
    return 1
  fi
}


function mmaDnsDoComplain {
  EH_assert [[ $# -gt 0 ]]
  opDoComplainAs dnsadmin "$@"
}

 
function mmaDnsContentBuild {
  EH_assert [[ $# -eq 0 ]]
  opDoComplain cd ${mmaDns_tinydnsDataDir}
  # NOTYET, this needs to go into binsprep so it is done once
  opDo chmod g+w /etc/tinydns/root/
  mmaDnsDoComplain ${tinydnsData}
}

function mmaDnsContentHostAdd {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  typeset exactLine="^=$1:$2:86400$"

  if FN_lineIsInFile ${exactLine} ${mmaDns_origContentDataFile} ; then
    ANT_raw "$0: $1:$2 -- Already in, skipped"
  else
    # NOTYET, remove entry that this one replaces
    mmaDnsDoComplain ${tinydnsEdit} ${mmaDns_origContentDataFile} ${mmaDns_origContentDataFileTmp} add host $1 $2
  fi
}


function mmaDnsContentAliasAdd {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  mmaDnsAssertOrigContentServer || return $?

  typeset exactLine="^\+$1:$2:86400$"

  if FN_lineIsInFile "${exactLine}" "${mmaDns_origContentDataFile}" ; then
    ANT_raw "$0: $1:$2 -- Already in, skipped"
  else
    mmaDnsDoComplain ${tinydnsEdit} ${mmaDns_origContentDataFile} ${mmaDns_origContentDataFileTmp} add alias $1 $2
  fi
}

function mmaDnsContentNsAdd {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  mmaDnsAssertOrigContentServer || return $?

  typeset exactLine="^\.$1:$2:[a-z]:259200$"

  if FN_lineIsInFile ${exactLine} ${mmaDns_origContentDataFile} ; then
    ANT_raw "$0: $1:$2 -- Already in, skipped"
  else
    mmaDnsDoComplain ${tinydnsEdit} ${mmaDns_origContentDataFile} ${mmaDns_origContentDataFileTmp} add ns $1 $2
  fi
}

function mmaDnsContentMxAdd {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  #@pinneke300.tjandana33.1.byname.intra:192.168.0.10:a::86400
  typeset exactLine="^@$1:$2:a::86400$"

  if FN_lineIsInFile ${exactLine} ${mmaDns_origContentDataFile} ; then
    ANT_raw "$0: $1:$2 -- Already in, skipped"
  else
    mmaDnsDoComplain ${tinydnsEdit} ${mmaDns_origContentDataFile} ${mmaDns_origContentDataFileTmp} add mx $1 $2
  fi
}  

function mmaDnsContentChldnsAdd {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  mmaDnsDoComplain ${tinydnsEdit} ${mmaDns_origContentDataFile} ${mmaDns_origContentDataFileTmp} add childns $1 $2
}  

function mmaDnsContentHostDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^=$1:$2:" ${mmaDns_origContentDataFile}
}

function mmaDnsContentAliasDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^\+$1:$2:" ${mmaDns_origContentDataFile}
}

function mmaDnsContentNsDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^\.$1:$2:" ${mmaDns_origContentDataFile}
}

function mmaDnsContentMxDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^@$1:$2:" ${mmaDns_origContentDataFile}
}

function mmaDnsContentDeleteChildns {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- hostName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^&$1:$2:" ${mmaDns_origContentDataFile}
}  


#
# mmaDnsEntryTypeAction
#

function mmaDnsEntryTypeAction {

  # $1 -- Type -- Host, Alias, Mx, 
  # $2 -- Action -- update, delete, verify, show
  # $3 -- FQDN
  # $4 -- hostName
  EH_assert [[ $# -ge 3 ]]

  ANV_raw "$0: $@"

  typeset entryType=$1
  typeset entryAction=$2
  typeset FQDN=$3
  typeset hostName=$4

    typeset contentAction=${entryAction}
    case ${entryAction} in
    "Update")
            contentAction="Add"
            ;;
    "Verify")
             doNothing
             ;;
    *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1  
       ;;
  esac

  opDo mmaDnsServerHosts.sh -i hostIsOrigContentServer
  if [[ $? = 0 ]] ; then
    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${hostName}
    opDoRet mmaDnsContentSelectServer ${opRunClusterName}

    opDo lpParamsBasicGet

    dnsEntryIpAddr=${lpDnsEntryIpAddr}

    opDoRet mmaDnsContent${entryType}${contentAction} ${FQDN} ${dnsEntryIpAddr}
  else
    # NOTYET, only do this for FQDNs marked as legit for this 
    # item entry -- Use what was found in 
    # the list instead.
    thisset thisOne=""
    for thisOne in iv_dnsContentActionPermittedDomains[@] ; do
      doNothing
      # Make sure $FQND is a substring of ${thisOne}
      # if not, just return. 
      # if yes, then use that to find the origContentServerFind
      # below
    done
    typeset origContentServerHost=`mmaDnsServerHosts.sh -i origContentServerFind ${opRunDomainName}`
    if [[ "${origContentServerHost}_" = "_" ]] ; then
      EH_problem "origContentServerFind ${opDomainName} -- failed"
      return 1
    fi
    
    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${hostName}
    
    
    sudo -u dnsadmin ssh ${origContentServerHost} ${opBinBase}/mmaDnsServerHosts.sh -i contentAction ${entryType} ${contentAction}  ${FQDN} ${opNetCfg_ipAddr}
  fi
  return 
}



function mmaDnsEntryHostVerify {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Host" "Verify" $@
}

function mmaDnsEntryHostUpdate {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Host" "Update" $@
}  

function mmaDnsEntryHostDelete {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Host" "Delete" $@
}  


function mmaDnsEntryAliasVerify {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Alias" "Verify" $@
}

function mmaDnsEntryAliasUpdate {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Alias" "Update" $@
}  

function mmaDnsEntryAliasDelete {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Alias" "Delete" $@
}  


function mmaDnsEntryMxVerify {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Mx" "Verify" $@
}  

function mmaDnsEntryMxUpdate {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Mx" "Update" $@
}  


function mmaDnsEntryMxDelete {
  # $1 -- FQDN
  # $2 -- hostName
  EH_assert [[ $# -eq 2 ]]
  mmaDnsEntryTypeAction "Mx" "Delete" $@
}  



function origContentBaseDirAssert {
  if [[ -d ${mmaDns_origContentBaseDir} ]] ; then
    return 0
  else
    FN_dirCreateIfNotThere ${mmaDns_origContentBaseDir}
    chown dnsadmin ${mmaDns_origContentBaseDir}
    touch ${mmaDns_origContentDataFile}
    chown dnsadmin ${mmaDns_origContentDataFile}
    return 1
  fi
}

function importBaseDirAssert {
  if [[ -d ${mmaDns_importBaseDir} ]] ; then
    return 0
  else
    ANV_raw "Creating ${mmaDns_importBaseDir}"
    FN_dirCreateIfNotThere ${mmaDns_importBaseDir}
    chown dnsadmin ${mmaDns_importBaseDir}
    return 1
  fi
}

function exportBaseDirAssert {
  if [[ -d ${mmaDns_exportBaseDir} ]] ; then
    return 0
  else
    FN_dirCreateIfNotThere ${mmaDns_exportBaseDir}
    chown dnsadmin ${mmaDns_exportBaseDir}
    return 1
  fi
}


#
# JUNKYARD
#

  # NOTYET, Based on the checkMode
  #opDoRet mmaDnsContentBuild
  
  # NOTYET, Based on the checkMode
  #opDoComplain mmaDnsServerHosts.sh -i restartCachex

#   case ${entryType} in
#     "Host")
#           doNothing
#           ;;
#     "Alias")
#            doNothing
#            ;;
#     "Mx")
#         doNothing
#         ;;
#     "Chidns")
#            doNothing
#            ;;
#     "Ns")
#         doNothing
#         ;;
#     *)
#        EH_problem "Unknown:  ${thisFeature}"
#        return 1  
#        ;;
#   esac
