#!/bin/bash


if [ "${loadFiles}X" == "X" ] ; then
     #`dirname $0`/seedSubjectAction.sh -l $0 "$@"
     /opt/public/osmt/bin/seedSubjectAction.sh -l $0 "$@"
     exit $?
fi

. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDaemontoolsLib.sh
. ${opBinBase}/mmaDnsLib.sh

# ./lpParams.libSh
. ${opBinBase}/lpParams.libSh


# ./lpReRunAs.libSh 
. ${opBinBase}/lpReRunAs.libSh


# ../siteControl/nedaPlus/mmaDnsServerHostItems.site
#setBasicItemsFiles mmaDnsServerHostItems
if [[ "${BASH_VERSION}X" != "X" ]] ; then
    . /opt/public/osmt/siteControl/nedaPlus/mmaDnsServerHostItems.site.bash
else
    . /opt/public/osmt/siteControl/nedaPlus/mmaDnsServerHostItems.site.ksh
fi

opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
# ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}

#externalResolversList=( "66.93.87.2" )
externalResolversList=( "66.93.87.2" "198.62.92.20" )
#externalResolversList=( "198.62.92.20" )

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo="-v -n showOnly"
  #typeset extraInfo=""
    typeset doLibExamples=`doLibExamplesOutput ${G_myName} ${extraInfo}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- INFORMATION ---
${G_myName} ${extraInfo} -s all -a summary
${G_myName} ${extraInfo} -s ${opRunHostName} -a describe
${G_myName} ${extraInfo} -s ${opRunHostName} -a serverType
${G_myName} ${extraInfo} -i hostIsOrigContentServer
--- SERVER ACTIONS FULL ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullDelete
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullCleanAll
--- SERVER ACTIVATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serverEnable
${G_myName} ${extraInfo} -s ${opRunHostName} -a serverDisable
--- SERVICES MANIPULATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesList
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesShow all
${G_myName} ${extraInfo} -i servicesShow all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRunningVerify all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart all
${G_myName} ${extraInfo} -i cacheRestart
--- CONTENT SERVER CONFIGURATION ---
${G_myName} ${extraInfo} -i contentServerIpAddrFileName
${G_myName} ${extraInfo} -i contentServerIpAddrGet
${G_myName} ${extraInfo} -i contentServerIpAddrSet 192.168.0.181
${G_myName} ${extraInfo} -i contentServerIpAddrSetNet
${G_myName} ${extraInfo} -i contentServerIpAddrSetLocal
--- LOCATE SERVERS -- RESOLV.CONF ---
${G_myName} ${extraInfo} -i origContentServerFind ${opRunDomainName}
${G_myName} ${extraInfo} -i netResolvingServerFind ${opRunDomainName}
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfOutput ${opRunDomainName}  # deprecated see resolvConfAutoStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfDjbDnsUpdate  # deprecated see resolvConfAutoStdout
--- RESOLV.CONF ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutoStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutoUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfExternalStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfExternalUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfLocalStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfLocalUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfLocalVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutonomousStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutonomousUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutonomousVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfBystarStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfBystarUpdate
--- DHCP for RESOLV.CONF ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfLocalDhcpStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfLocalDhcpUpdate
${G_myName} ${extraInfo} -i dhcpClientAddLocalResolver
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutonomousDhcpStdout
${G_myName} ${extraInfo} -s ${opRunHostName} -a resolvConfAutonomousDhcpUpdate
${G_myName} ${extraInfo} -i dhcpClientAddAutonomousResolver
--- DNS POPULATION ---
${G_myName} ${extraInfo} -i contentCombineData
${G_myName} ${extraInfo} -i contentOrigHostNamesUpdate
${G_myName} ${extraInfo} -i contentOrigServicesUpdate
${G_myName} ${extraInfo} -i contentAction Alias Add tehran 192.168.0.38
${G_myName} ${extraInfo} -i contentActionInvokerPrep
${G_myName} ${extraInfo} -i contentActionPerformerPrep tehran
--- IMPORT ---
${G_myName} ${extraInfo} -i zonesImportList
${G_myName} ${extraInfo} -i zonesImportPrep
${G_myName} ${extraInfo} -i zonesImport all
--- EXPORT ---
${G_myName} ${extraInfo} -i zonesExportList
${G_myName} ${extraInfo} -i zonesExportPrep
${G_myName} ${extraInfo} -i zonesExport all
${G_myName} ${extraInfo} -f -i zonesExport all
--- REMOTELY INVOKED ---
sudo -u dnsadmin ssh shoosh ${opBinBase}/${G_myName} -i contentCombineData
sudo -u dnsadmin ssh shoosh ${opBinBase}/${G_myName} -i contentAction Alias Add name addr
--- MISC ACTIONS ---
${G_myName} ${extraInfo} -i logsList
${G_myName} ${extraInfo} -i showProcs
${G_myName} ${extraInfo} -i killProcs
--- INCONSISTENT and BAD USAGES ---
${G_myName} ${extraInfo} -i isValidDomainName badbad.com
_EOF_
}


function vis_help {
  cat  << _EOF_
    DESCRIPTION

localResolvingServer -- at 127.0.0.1 co-operates with tinydnsserver at 127.0.02
autonomousResolvingServer -- at 127.0.1.1 no domain exceptions

 resolvConfAutoUpdate               # smartly decide on one of below based on host
 resolvConfExternalUpdate           # Non-Bystar External Resolver
 resolvConfLocalUpdate              # 127.0.0.1 cooperating with local tinydns
 resolvConfAutonomousUpdate         # 127.0.1.1 automously resolve to world
 resolvConfBystarUpdate             # ByStar External Server

 resolvConfLocalDhcpUpdate          # 127.0.0.1 plus dhcpclient adjustments not to overwrite it
 resolvConfAutonomousDhcpUpdate     # 127.0.1.1 plus dhcpclient adjustments not to overwrite it


--- INFORMATION ---
do_summary
do_describe
do_serverType
vis_hostIsOrigContentServer
--- SERVER ACTIONS FULL ---
do_fullVerify
do_fullUpdate
do_fullDelete
fullCleanAll
    To delete old left over dirs
--- SERVER ACTIVATION ---
do_serverEnable
do_serverDisable
    Used by fullUpdate. Perhaps Should not even be
    made visible. Stops, deletes service, safekeeps dnsdir.
--- SERVICES MANIPULATION ---
do_servicesList
do_servicesShow all
do_servicesStop all
do_servicesStart all
do_servicesRestart all
vis_cacheRestart
--- LOCATE SERVERS ---
vis_origContentServerFind ${opRunDomainName}
    Find the content server to which entryUpdates will go.
    Based on iv_dnsContentActionPermittedDomains.
vis_netResolvingServerFind ${opRunDomainName}
do_resolvConfOutput
--- DNS POPULATION ---
vis_contentCombineData
vis_contentOrigHostNamesUpdate
vis_contentOrigServicesUpdate
vis_contentAction Alias Add tehran 192.168.0.38
vis_contentActionInvokerPrep
vis_contentActionPerformerPrep tehran
-------- IMPORT AND EXPORT ------------
OrigContentServers export.
CopyContentServers import.
Currently Following Methods are supported:
    - sshPush
Following methods may be supported later.
    - axfr-get, sshPoll, mailbot, ...
mailbot is expected to become the prefered method.
--- IMPORT ---
vis_zonesImportList
vis_zonesImportPrep
vis_zonesImport all
--- EXPORT ---
vis_zonesExportList
vis_zonesExportPrep
vis_zonesExport all
--- REMOTELY INVOKED ---
--- MISC ACTIONS ---
--- INCONSISTENT and BAD USAGES ---
_EOF_
}

noSubjectHook() {
  subject=all
}

noArgsHook() {
  vis_examples
}


firstSubjectHook() {
  case ${action} in
    "summary")
               typeset -L20 f1="DNS Srvr Name" f2="Setup"
               print "$f1$f2"
               echo "----------------------------------------------------"
       ;;
    *)

       return
       ;;
  esac

}

lastSubjectHook() {
  case ${action} in
    "summary")
               echo "----------------------------------------------------"
       ;;
    *)
       return
       ;;
  esac
}


function do_summary {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  typeset -L10 dnsHost=${iv_dnsHost}
  typeset dnsSetup=${iv_dnsSetup}
  print "${dnsHost}${dnsSetup}"
}


function vis_hostIsOrigContentServer {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid

  if [[ $? == 0 ]] ; then
    ${targetSubject}
    if [[ ${iv_dnsSetup} == "" ]] ; then
      EH_problem ""
      return 1
    fi
    TM_trace 3 "${iv_dnsSetup}"

    typeset retVal=1

    typeset thisOne=""
    for thisOne in ${iv_dnsSetup} ; do
      if [[ "${thisOne}_" == "localOrigContentServer_" || "${thisOne}_" == "netOrigContentServer_" ]] ; then
        #ANT_raw "OrigContentServer: ${thisOne}"
        retVal=0
        break
      fi
    done

    if [[ ${retVal} != 0  ]] ; then
      ANT_raw "${subject}: Not an OrigContentServer: ${iv_dnsSetup}"
    fi

    return ${retVal}
  else
    print "noService"
    return 1
  fi
}

function hostIsNotOfType {
  EH_assert [[ $# -eq 1 ]]
  ! hostIsOfType "$@" > /dev/null
}

function hostIsOfType {
  EH_assert [[ $# -eq 1 ]]

  hostType=$1

  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
    if [[ ${iv_dnsSetup} == "" ]] ; then
      EH_problem ""
      return 1
    fi
    TM_trace 3 "${iv_dnsSetup}"

    typeset retVal=1

    typeset thisOne=""
    for thisOne in ${iv_dnsSetup} ; do
      if [[ "${thisOne}_" == "${hostType}_" ]] ; then
        print -u2 "DNS Server Host Type: ${hostType}"
        retVal=0
        break
      fi
    done

    if [[ ${retVal} != 0  ]] ; then
      print -u2 "DNS Server Host Type: ${hostType} not any of: ${iv_dnsSetup}"
    fi

    return ${retVal}
  else
    print -u2 "noService"
    return 1
  fi
}

function do_resolvConfDjbDnsUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

    subjectValidatePrepare

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

  opDoComplain ${opBinBase}/mmaDnsServerHosts.sh -s ${opRunHostName} -a resolvConfOutput ${opRunDomainName} > /etc/resolv.conf

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf
}


function do_serverType {
  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
    if [[ ${iv_dnsSetup} == "" ]] ; then
      EH_problem ""
      return 1
    fi
    print "${iv_dnsSetup}"
    return 0
  else
    print "noService"
    return 1
  fi
}


function do_fullVerify {
  subjectValidatePrepare
  #
  mmaDnsUsersAndGroupsAdd
  opDoRet mmaDnsBinsPrep.sh -i fullVerify || return

  ANT_raw "Verifying That Needed Processes Are Running"
  #vis_showProcs
  do_servicesShow all
  #ANT_raw "Verifying That Needed Directories Are In Place -- NOTYET"
  #ANT_raw "Verifying That no directory that is not needed is in place -- NOTYET"

  #verify that resolv.conf is same as would be generated.
}


function do_fullUpdate {
  subjectValidatePrepare

  continueAfterThis
  mmaDnsUsersAndGroupsAdd
  opDoRet mmaDnsBinsPrep.sh -i fullVerify || return
  continueAfterThis

  do_servicesStop all
  continueAfterThis

  do_serverDisable
  continueAfterThis
  do_serverEnable
  continueAfterThis
  vis_contentOrigHostNamesUpdate
  continueAfterThis

  ANT_raw "NOTYET: Also Need to run mmaSysMgmtActions.sh -s ${opRunHostName} -a serviceDnsUpdate"

  vis_contentCombineData
}


function do_fullDelete {
  subjectValidatePrepare
  do_servicesStop all
  do_serverDisable
}

function do_fullCleanAll {
  # Independent of iv_dnsSetup, just clean everything up
  subjectValidatePrepare

  localResolvingServerDisable
  autonomousResolvingServerDisable
  netResolvingServerDisable
  origContentServerDisable
  copyContentServerDisable
  netZoneXferServerDisable
  netDnsWallServerDisable
}

#--- SERVICES MANIPULATION ---
#${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesList
#${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop all
#${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart all
#${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart all

function do_servicesList {
  EH_assert [[ $# -eq 0 ]]
  do_serverType
}

function subjectIsRunHost {
  if [[ "${subject}_" != "${opRunHostName}_" ]] ; then
    EH_problem "Remote not supported"
    return 1
  fi
  return 0
}

function do_servicesStop {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv=${iv_dnsSetup}
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Stop"
  done
}

function do_servicesStart {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv=${iv_dnsSetup}
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Start"
  done
}

function do_servicesRestart {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv=${iv_dnsSetup}
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Restart"
  done
}

function vis_servicesShow {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Must run as root.
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    subject=${opRunHostName}

    subjectValidatePrepare
    opDoRet subjectIsRunHost || return $?

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;
    
    typeset argv=""
    if [[ "$1_" = "all_" ]] ; then
        argv=${iv_dnsSetup}
    else
        argv="$@"
    fi
    
    typeset thisOne=""
    for thisOne in ${argv} ; do
        serviceAction  "${thisOne}" "Show"
    done
}


function do_servicesShow {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Must run as root.
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]
    subjectValidatePrepare

    opDoRet subjectIsRunHost || return $?

    typeset argv=""
    if [[ "$1_" = "all_" ]] ; then
        argv=${iv_dnsSetup}
    else
        argv="$@"
    fi

    typeset thisOne=""
    for thisOne in ${argv} ; do
        serviceAction  "${thisOne}" "Show"
    done
}


function do_servicesRunningVerify {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv=${iv_dnsSetup}
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "RunningVerify"
  done
}

function serviceAction {
  # $1 -- "service"
  # $2 --  action
  EH_assert [[ $# -eq 2 ]]

  case ${1} in
    "localResolvingServer")
       mmaDaemon${2} dnscache
        ;;

    "autonomousResolvingServer")
       mmaDaemon${2} dnscachew
        ;;

    "netResolvingServer")
       mmaDaemon${2} dnscachex
        ;;

    "localOrigContentServer"|"netOrigContentServer")
       mmaDaemon${2} tinydns
        ;;

    "localCopyContentServer"|"netCopyContentServer")
       mmaDaemon${2} tinydns                                                             ;;

    "netZoneXferServer")
       mmaDaemon${2} axfrdns
         ;;

    *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
  esac
}

function resolvingServerAddDomainPtr {
  # $1 -- "net" or "local"
  # $2 --  domainName
  # $3 - $@ --  domainAddrList

  EH_assert [[ $# -eq 3 ]]

  typeset serverDir=""
  case $1 in
    "net")
        serverDir=/etc/dnscachex/root/servers
        ;;
    "local")
        serverDir=/etc/dnscache/root/servers
        ;;
    *)
       EH_problem "Bad Usage: Arg1=$1"
       return 1
       ;;
  esac

  EH_assert [[ -d ${serverDir} ]]

  typeset domainName=$2

  opDoComplain eval "( print -- $3  > ${serverDir}/${domainName} )"

  shift
  shift
  shift

  typeset thisOne=""
  for thisOne in $@ ; do
    opDoComplain eval "( print -- ${thisOne} >> ${serverDir}/${domainName} )"
  done

  # NOTYET, if verbose
  opDoComplain ls -l ${serverDir}/${domainName}
  opDoComplain cat ${serverDir}/${domainName}
}


function localResolvingServerEnable {
  EH_assert [[ $# -eq 0 ]]
  opDoComplain dnscache-conf dnscache dnslog /etc/dnscache
  mmaDaemonUpdate dnscache /etc/dnscache
}

function autonomousResolvingServerEnable {
  EH_assert [[ $# -eq 0 ]]
  opDoComplain dnscache-conf dnscache dnslog /etc/dnscachew 127.0.1.1
  mmaDaemonUpdate dnscachew /etc/dnscachew
}

function netResolvingServerEnable {
  # $1 - $@ --  accessList
  EH_assert [[ $# -ge 0 ]]

  opDoRet dnscache-conf dnscache dnslog /etc/dnscachex ${iv_dnsNetResolvingServer[ipAddr]}
  mmaDaemonUpdate dnscachex /etc/dnscachex

  # Setup Access List
  typeset thisOne=""
#  for thisOne in $@ ; do
  for thisOne in ${iv_dnsNetResolvingServer[accessList]} ; do
      if [ "${thisOne}" == "all" ] ; then
          for l in $( seq 255 ); do
              print -- "Allowing Access By: ${l}"
              opDoComplain touch /etc/dnscachex/root/ip/${l}
          done
      else
          print -- "Allowing Access By: ${thisOne}"
          opDoComplain touch /etc/dnscachex/root/ip/${thisOne}
      fi
  done
}


function localResolvingServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop dnscache dnscache/log
  mmaDaemonDelete dnscache

  FN_dirSafeKeep /etc/dnscache
}

function autonomousResolvingServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop dnscachew dnscachew/log
  mmaDaemonDelete dnscachew

  FN_dirSafeKeep /etc/dnscachew
}

function netResolvingServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop dnscachex dnscachex/log
  mmaDaemonDelete dnscachex

  FN_dirSafeKeep /etc/dnscachex
}


function origContentServerEnable {
  EH_assert [[ $# -eq 1 ]]
  # $1 -- ipAddress To Run the server on

  ANV_raw "Enabling OrigContentServr on $1"
  if [[ -d ${mmaDns_tinydnsBaseDir} ]] ; then
    if  hostIsNotOfType "localCopyContentServer" && hostIsNotOfType "netCopyContentServer"  ; then
        EH_problem "${mmaDns_tinydnsBaseDir} exists. Get it out of the way"
        return 1
    else
      ANV_raw "Also, a CopyContentServer, ${mmaDns_tinydnsBaseDir} is in place"
    fi
  else
    opDoComplain tinydns-conf tinydns dnslog ${mmaDns_tinydnsBaseDir} ${1}
    opDo chown -R dnsadmin:djbdns  ${mmaDns_tinydnsBaseDir}/root
    # NOTYET, BUG
    # ~dnsadmin should not be at this base -- May be import or something like that
    #
    #  opDo chown -R dnsadmin:djbdns  ${mmaDns_tinydnsBaseDir}       # VERIFY -- needed for dnsadmin ssh keys ...
    #
  fi

  origContentBaseDirAssert

  vis_zonesExportPrep

  vis_zonesExport all

  mmaDaemonUpdate tinydns ${mmaDns_tinydnsBaseDir}
}


function copyContentServerEnable {
  EH_assert [[ $# -eq 1 ]]
  # $1 -- ipAddress To Run the server on

  ANV_raw "Enabling CopyContentServer on $1"

  if [[ -d ${mmaDns_tinydnsBaseDir} ]] ; then
    if  hostIsNotOfType "localOrigContentServer" && hostIsNotOfType "netOrigContentServer"  ; then
        EH_problem "${mmaDns_tinydnsBaseDir} exists. Get it out of the way"
        return 1
    else
      ANV_raw "Also, an OrigContentServer, ${mmaDns_tinydnsBaseDir} is in place"
    fi
  else
    opDoComplain tinydns-conf tinydns dnslog ${mmaDns_tinydnsBaseDir} ${1}
    opDo chown -R dnsadmin:djbdns  ${mmaDns_tinydnsBaseDir}/root
    # NOTYET, BUG
    # ~dnsadmin should not be at this base -- May be import or something like that
    #
    #  opDo chown -R dnsadmin:djbdns  ${mmaDns_tinydnsBaseDir}       # VERIFY -- needed for dnsadmin ssh keys ...
    #
  fi

  vis_zonesImportPrep

  vis_zonesImport all

  mmaDaemonUpdate tinydns ${mmaDns_tinydnsBaseDir}
}

function origContentServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop tinydns tinydns/log
  mmaDaemonDelete tinydns

  FN_dirSafeKeep /etc/tinydns
}

function copyContentServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop tinydns tinydns/log
  mmaDaemonDelete tinydns

  FN_dirSafeKeep /etc/tinydns
}


function netZoneXferServerEnable {
  EH_assert [[ $# -eq 1 ]]
  # $1 ipAddr
  opDoComplain axfrdns-conf axfrdns dnslog /etc/axfrdns /etc/tinydns ${1}
  mmaDaemonUpdate axfrdns /etc/axfrdns
}

function netZoneXferServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop axfrdns axfrdns/log
  mmaDaemonDelete axfrdns

  FN_dirSafeKeep /etc/axfrdns
}

function netDnsWallServerEnable {
  EH_assert [[ $# -eq 1 ]]
  # $1 ipAddr
  EH_problem "NOTYET"
  return
  opDoComplain dnswall-conf dnswall dnslog /etc/dnswall /etc/tinydns ${1}
  mmaDaemonUpdate dnswall /etc/dnswall
}

function netDnsWallServerDisable {
  EH_assert [[ $# -eq 0 ]]
  mmaDaemonStop dnswall dnswall/log
  mmaDaemonDelete dnswall

  FN_dirSafeKeep /etc/dnswall
}

function vis_contentCombineData  {
  #
  # Combine contents of origContent directory with
  # the import directory and produce root/data
  #
  #
  subject=${opRunHostName}
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
  else
    return 1
  fi

  typeset thisOne=""
  typeset thisFeature=""

  typeset needsProcessing="nil"

  opDo cp /dev/null ${mmaDns_tinydnsDataFileCombined}

    #set -x
  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localOrigContentServer"|"netOrigContentServer")
         opDoComplain eval "( cat ${mmaDns_origContentDataFile} >> ${mmaDns_tinydnsDataFileCombined} )"
         needsProcessing="t"
         ;;
      "localCopyContentServer"|"netCopyContentServer")
         importContainersLoad
         typeset thisOne=""
         for thisOne in ${iv_dnsImport_refsList[@]} ; do
           ANV_cooked "${thisOne}"
           item_dnsImport_${thisOne}
           if [[ -f ${mmaDns_importBaseDir}/${iv_dnsImport_zoneName} ]] ; then
             cat ${mmaDns_importBaseDir}/${iv_dnsImport_zoneName} >> ${mmaDns_tinydnsDataFileCombined}
           else
             EH_problem "${mmaDns_importBaseDir}/${thisOne} Missing"
           fi
         done
         needsProcessing="t"
         ;;
    esac
  done

  if [[ -f ${mmaDns_importBaseDir}/extra.zones ]] ; then
     opDoComplain eval "( cat ${mmaDns_importBaseDir}/extra.zones >> ${mmaDns_tinydnsDataFileCombined} )"
  else
    ANV_raw "No ${mmaDns_importBaseDir}/extra.zones -- Skipped"
  fi

  if [[ ${needsProcessing} == "nil" ]] ; then
    ANT_raw "$0: Skipped -- ${subject} -- Not An OrigContentServer"
    return 0
  fi

  ANT_raw "$0: Processing ${subject}"

  FN_fileSafeCopy ${mmaDns_tinydnsDataDir}/data ${mmaDns_tinydnsDataDir}/data.${dateTag}

  opDo mv ${mmaDns_tinydnsDataFileCombined} ${mmaDns_tinydnsDataFile}

  mmaDnsContentBuild
}

function vis_contentOrigHostNamesUpdate  {
  #
  # Add/Update ip assignments for origContent
  #
  subject=${opRunHostName}
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
  else
    return 1
  fi

  typeset thisOne=""
  typeset thisFeature=""

  typeset needsProcessing="nil"

  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localOrigContentServer"|"netOrigContentServer")
         needsProcessing="t"
         break
         ;;
    esac
  done

  if [[ ${needsProcessing} == "nil" ]] ; then
    print -- "Skipped -- ${subject} -- Not An OrigContentServer"
    return 0
  fi

  ANT_raw -- "$0: Processing ${subject}"

  if [[ "${BASH_VERSION}X" == "X" ]] ; then
  for thisOne in ${iv_dnsContentServer.domainsOrigList[@]} ; do
    mmaDnsContentNsAdd ${thisOne} ${opNetCfg_ipAddr}

    typeset clusterName=`opDomains.sh  -i findCluster ${thisOne}`
    if [[ "${clusterName}_" == "_" ]] ; then
      EH_problem "opDomains.sh  -i findCluster ${thisOne} -- failed"
    fi
    opDoComplain opNetNameServices.sh -p domainName=${thisOne} -p clusterName=${clusterName} -i dnsHostsAdd doit

  done
  fi
}

function vis_contentOrigServicesUpdate  {
  #
  # Add/Update ip assignments for origContent
  #
  subject=${opRunHostName}
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
  else
    return 1
  fi

  opDoComplain mmaSysMgmtActions.sh -i  serviceDnsUpdate
}


function vis_contentActionInvokerPrep  {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}

  opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate

  typeset origContentServerHost=`mmaDnsServerHosts.sh -i origContentServerFind ${opRunDomainName}`
  if [[ "${origContentServerHost}_" = "_" ]] ; then
    EH_problem "origContentServerFind ${opDomainName} -- failed"
    return 1
  fi

  opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${origContentServerHost}  -i authorizedKeysUpdate
}

function vis_contentActionPerformerPrep  {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}

  opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${1}  -i authorizedKeysUpdate
}


function vis_contentAction  {
  # $1 --  type  -- host, ...
  # $2 -- "action" -- update, delete, verify
  # $3 --  domainName
  # $4 --  ipAddr
  # ..$@ --
  EH_assert [[ $# -gt 3 ]]

  subject=${opRunHostName}
  targetSubject=item_${subject}

  if subjectIsValid ; then
    ${targetSubject}
  else
    return 1
  fi

  typeset thisOne=""
  typeset thisFeature=""

  typeset needsProcessing="nil"

  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localOrigContentServer"|"netOrigContentServer")
         needsProcessing="t"
         break
         ;;
    esac
  done

  if [[ ${needsProcessing} == "nil" ]] ; then
    ANT_raw "Skipped -- $0: -- ${subject} Not An OrigContentServer: $@"
    return 1
  fi

  ANT_raw -- "$0: Processing ${subject}"

  opDoComplain mmaDnsContent${1}${2} ${3} ${4}
}



function do_serverEnable  {

  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  typeset thisOne=""
  typeset thisFeature=""

  for thisFeature in ${iv_dnsSetup} ; do

    case ${thisFeature} in
      "localResolvingServer")
        TM_trace 7 "Setup for localResolvingServer"

        localResolvingServerEnable

        if [[ "${BASH_VERSION}X" == "X" ]] ; then
        for thisOne in ${iv_dnsResolvingServer.domainsPtrList[@]} ; do
          typeset domainName=""
          typeset domainAddrList=""

          eval domainName='${'${thisOne}.domainName'}'
          eval domainAddrList='${'${thisOne}.domainAddrList'}'
          TM_trace 7 "domainsPtrList[]=${thisOne} ${domainName} ${domainAddrList}"

          resolvingServerAddDomainPtr "local" "${domainName}" ${domainAddrList}
        done
        fi
        ;;

      "autonomousResolvingServer")
        TM_trace 7 "Setup for autonomousResolvingServer"

        autonomousResolvingServerEnable
        ;;

      "netResolvingServer")
        TM_trace 7 "Setup for netResolvingServer"

        #netResolvingServerEnable ${iv_dnsResolvingServer.accessList[@]}
        netResolvingServerEnable

        if [[ "${BASH_VERSION}X" == "X" ]] ; then
        for thisOne in ${iv_dnsResolvingServer.domainsPtrList[@]} ; do
          typeset domainName=""
          typeset domainAddrList=""

          eval domainName='${'${thisOne}.domainName'}'
          eval domainAddrList='${'${thisOne}.domainAddrList'}'
          TM_trace 7 "domainsPtrList[]=${thisOne} ${domainName} ${domainAddrList}"

          resolvingServerAddDomainPtr "net" "${domainName}" ${domainAddrList}
        done
        fi
        ;;

      "localOrigContentServer"|"netOrigContentServer")
        TM_trace 7 "Setup for OrigContentServer"

        lpParamsBasicGet
        if [ "${dynamicIpAddrSupported}_" = "TRUE_" ] ; then
            origContentServerEnable ${hereTinydnsMainIpV4Addr}
        else
            if [[ "${BASH_VERSION}X" != "X" ]] ; then
                origContentServerEnable ${iv_dnsContentServer_ipAddr}
            else
                origContentServerEnable ${iv_dnsContentServer.ipAddr}
            fi
        fi
        ;;

      "localCopyContentServer"|"netCopyContentServer")
         TM_trace 7 "Setup for CopyContentServer"

        lpParamsBasicGet
        if [ "${dynamicIpAddrSupported}_" = "TRUE_" ] ; then
            origContentServerEnable ${hereTinydnsMainIpV4Addr}
        else
            if [[ "${BASH_VERSION}X" != "X" ]] ; then
                origContentServerEnable ${iv_dnsContentServer_ipAddr}
            else
                origContentServerEnable ${iv_dnsContentServer.ipAddr}
            fi
        fi

        ;;

      "netZoneXferServer")
         TM_trace 7 "Setup for netZoneXferServer"

         if [[ "${BASH_VERSION}X" != "X" ]] ; then
             netZoneXferServerEnable ${iv_dnsContentServer_ipAddr}
         else
             netZoneXferServerEnable ${iv_dnsContentServer.ipAddr}
         fi
         ;;

      "netZoneXferGet")
         TM_trace 7 "NOTYET: Setup for netZoneXferGet"

         # NOTYET, replace with import
         #netZoneXferGet
         ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
    esac
  done
}


function do_serverDisable  {

  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  typeset thisOne=""
  typeset thisFeature=""

  for thisFeature in ${iv_dnsSetup} ; do

    case ${thisFeature} in
      "localResolvingServer")
        TM_trace 7 "Disable localResolvingServer"

        localResolvingServerDisable
        ;;

      "autonomousResolvingServer")
        TM_trace 7 "Disable autonomousResolvingServer"

        autonomousResolvingServerDisable
        ;;

      "netResolvingServer")
        TM_trace 7 "Disable netResolvingServer"

        netResolvingServerDisable
        ;;

      "localOrigContentServer"|"netOrigContentServer")
        TM_trace 7 "Disable OrigContentServer"

        origContentServerDisable
        ;;

      "localCopyContentServer"|"netCopyContentServer")
         TM_trace 7 "Disable CopyContentServer"

         copyContentServerDisable
         ;;

      "netZoneXferServer")
         TM_trace 7 "Disable netZoneXferServer"

         netZoneXferServerDisable
         ;;

      "netZoneXferGet")
         TM_trace 7 "Disable netZoneXferGet"

         doNothing
         ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
    esac
  done
}

function vis_showProcs {
  subject=${opRunHostName}
  subjectValidatePrepare

  typeset thisFeature=""

  for thisFeature in ${iv_dnsSetup} ; do

    case ${thisFeature} in
      "localResolvingServer")
        mmaDaemonCheck dnscache
        ;;
      "autonomousResolvingServer")
        mmaDaemonCheck dnscachew
        ;;
      "netResolvingServer")
        mmaDaemonCheck dnscachex
        ;;
      "localOrigContentServer"|"netOrigContentServer")
        mmaDaemonCheck tinydns
        ;;
      "localCopyContentServer"|"netCopyContentServer")
         EH_problem "NOTYET"
         ;;
      "netZoneXferServer")
         mmaDaemonCheck axfrdns
         ;;
      "netZoneXferGet")
         EH_problem "NOTYET"
         doNothing
         ;;
      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
    esac
  done
}

function vis_killProcs {
  # NOTYET, This is not safe and right Just temporary
  #
  #pkill 'dnscache'

  ANT_raw "NOTYET"
  vis_showProcs
}

function vis_restartCachex {
  # Backwards compatibility
  vis_cacheRestart $@
}

function vis_restartCache {
  # Backwards compatibility
  vis_cacheRestart $@
}

function vis_cacheRestart {
  EH_assert [[ $# -eq 0 ]]

  subject=${opRunHostName}
  subjectValidatePrepare

  typeset thisFeature=""
  typeset needsProcessing="nil"

  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localResolvingServer")
         do_servicesRestart ${thisFeature}
         ANV_raw "dnscache restarted"
         needsProcessing="t"
         break
         ;;
      "autonomousResolvingServer")
         do_servicesRestart ${thisFeature}
         ANV_raw "dnscachew restarted"
         needsProcessing="t"
         break
         ;;
      "netResolvingServer")
         do_servicesRestart ${thisFeature}
         ANV_raw "dnscachex restarted"
         needsProcessing="t"
         break
         ;;
      *)
         doNothing
         ;;
    esac
  done

  if [[ ${needsProcessing} == "nil" ]] ; then
    ANT_raw "$0: Skipped -- Not A ResolvingServer"
  fi
}


function vis_origContentServerFind {
  # $1 specifies a zone for which a list of content servers
  # are to be found
  EH_assert [[ $# -eq 1 ]]

  typeset itemsList=`typeset +f | egrep '^item_'`
  integer retVal=1

  typeset origContentServerList=""
  typeset thisServer=""
  typeset thisFeature=""
  for thisFeature in ${itemsList} ; do
    ${thisFeature}
    for thisOne in ${iv_dnsSetup} ; do
      if [[ "${thisOne}_" == "localOrigContentServer_" || "${thisOne}_" == "netOrigContentServer_" ]] ; then
        ANV_raw "OrigContentServer: ${thisFeature} ${thisOne}"
        if hostIsOrigContentServerForZone $1 ; then
          origContentServerList="${iv_dnsHost} ${origContentServerList}"
          retVal=0
          break
        fi
      fi
    done
  done
  if [[ ${retVal} = 0 ]] ; then
    print ${origContentServerList}
  fi
  return   ${retVal}
}

function hostIsOrigContentServerForZone {
  # $1 specifies a zone to be checked if is kept at this origContentServer
  EH_assert [[ $# -eq 1 ]]
  integer retVal=1
  typeset thisOne=""

  if [[ "${BASH_VERSION}X" == "X" ]] ; then
  for thisOne in ${iv_dnsContentServer.domainsOrigList[@]} ; do
    #print ${thisOne}
    if [[ "${thisOne}_" == "${1}_" ]] ; then
      ANV_raw "${iv_dnsHost} ${thisOne}"
      retVal=0
      break
    fi
  done
  fi
  return ${retVal}
}

netResolvingServersList=""

function vis_netResolvingServerFind {
  # $1 specifies a zone for which a list of netResolvingServers
  # are to be found
  EH_assert [[ $# -eq 1 ]]

  typeset itemsList=`typeset +f | egrep '^item_'`
  integer retVal=1

  typeset foundServersList=""
  typeset thisServer=""
  typeset thisFeature=""
  for thisFeature in ${itemsList} ; do
    ${thisFeature}
    for thisOne in ${iv_dnsSetup} ; do
      if [[ "${thisOne}_" == "netResolvingServer_" ]] ; then
        ANV_raw "$0: OrigContentServer: ${thisFeature} ${thisOne}"
        if hostIsNetResolvingServerForDomain $1 ; then
          foundServersList="${iv_dnsHost} ${foundServersList}"
          retVal=0
          break
        fi
      fi
    done
  done
  if [[ ${retVal} = 0 ]] ; then
    print ${foundServersList}
    netResolvingServersList=${foundServersList}
  fi
  return   ${retVal}
}

function hostIsNetResolvingServerForDomain {
  # $1 specifies a zone to be checked if is kept at this origContentServer
  EH_assert [[ $# -eq 1 ]]
  integer retVal=1
  typeset thisOne=""

  for thisOne in ${iv_dnsResolvingServer.accessByDomainsList[@]} ; do
    #print ${thisOne}
    if [[ "${thisOne}_" == "${1}_" ]] ; then
      ANV_raw "$0: ${iv_dnsHost} ${thisOne}"
      retVal=0
      break
    fi
  done
  return ${retVal}
}

function do_resolvConfOutput {
  # $1 specifies a domain for which a resolv.conf format
  # output is to be generated
  EH_assert [[ $# -eq 1 ]]

  subjectValidatePrepare

  m_myName=$0
  print -- ";MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}"
  print -- "domain \t${opRunDomainName}"

  if  hostIsOfType "localResolvingServer"  ; then
    print -- "nameserver \t127.0.0.1"
    return 0
  fi

  vis_netResolvingServerFind $1 > /dev/null
  #typeset resolversList=`vis_netResolvingServerFind $1` -- KSH bug? dumps core


  if LIST_isIn "${opRunHostName}" "${netResolvingServersList}" ; then
    LIST_set ${netResolvingServersList}
    LIST_minus ${opRunHostName}
    netResolvingServersList=`LIST_setMinusResult`

    opDoRet opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName} || return $?
    print -- "nameserver \t${opNetCfg_ipAddr}"
  fi

  for thisOne in ${netResolvingServersList} ; do
    opDoRet opNetCfg_paramsGet ${opRunClusterName} ${thisOne} || return $?
    print -- "nameserver \t${opNetCfg_ipAddr}"
  done
}


#
# Replaces do_resolvConfOutput
#
function do_resolvConfAutoStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  if mmaDaemonRunningVerify "dnscache" ; then
      do_resolvConfLocalStdout
  else
      do_resolvConfExternalStdout
  fi
}

function do_resolvConfAutoUpdate {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  if mmaDaemonRunningVerify "dnscache" ; then
      do_resolvConfLocalUpdate
  else
      do_resolvConfExternalUpdate
  fi
}



function do_resolvConfExternalStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  print -- ";MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}"
  print -- "domain  ${opRunDomainName}"

  if [ -z "${iv_dnsNetResolvingServer[ipAddr]}" ] ; then
      for thisOne in ${externalResolversList} ; do
          print -- "nameserver  ${thisOne}"
      done
  else
      print -- "nameserver  ${iv_dnsNetResolvingServer[ipAddr]}"
  fi
}


function do_resolvConfExternalUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

    do_resolvConfExternalStdout  > /etc/resolv.conf

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf
}


function vis_dhcpClientAddLocalResolver {
    if [[ -f /etc/dhcp3/dhclient.conf ]] ; then
        opDo FN_fileSafeCopy  /etc/dhcp3/dhclient.conf   /etc/dhcp3/dhclient.conf.${dateTag}
        opDo sudo sed -i -e '/^\#prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.0\.1\;' /etc/dhcp3/dhclient.conf
        opDo sudo sed -i -e '/^\prepend domain-name-servers 127\.0\.1\.1/ c\prepend domain-name-servers 127\.0\.0\.1\;' /etc/dhcp3/dhclient.conf

        opDo sudo /etc/init.d/networking restart
    elif [[ -f /etc/dhcp/dhclient.conf ]] ; then   # 11.04 and squeeze
        opDo FN_fileSafeCopy  /etc/dhcp/dhclient.conf   /etc/dhcp/dhclient.conf.${dateTag}
        opDo sudo sed -i -e '/^\#prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.0\.1\;' /etc/dhcp/dhclient.conf
        opDo sudo sed -i -e '/^\prepend domain-name-servers 127\.0\.1\.1/ c\prepend domain-name-servers 127\.0\.0\.1\;' /etc/dhcp/dhclient.conf

        opDo sudo /etc/init.d/networking restart
    else
        ANT_raw "No /etc/dhcp3/dhclient.conf -- $0 skipped"
    fi
}


function vis_dhcpClientAddAutonomousResolver {
    if [[ -f /etc/dhcp3/dhclient.conf ]] ; then
        opDo FN_fileSafeCopy  /etc/dhcp3/dhclient.conf   /etc/dhcp3/dhclient.conf.${dateTag}
        opDo sudo sed -i -e '/^\#prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.1\.1\;' /etc/dhcp3/dhclient.conf
        opDo sudo sed -i -e '/^\prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.1\.1\;' /etc/dhcp3/dhclient.conf

        opDo sudo /etc/init.d/networking restart
    elif [[ -f /etc/dhcp/dhclient.conf ]] ; then   # 11.04 and squeeze
        opDo FN_fileSafeCopy  /etc/dhcp/dhclient.conf   /etc/dhcp/dhclient.conf.${dateTag}
        opDo sudo sed -i -e '/^\#prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.0\.1\;' /etc/dhcp/dhclient.conf
        opDo sudo sed -i -e '/^\prepend domain-name-servers 127\.0\.0\.1/ c\prepend domain-name-servers 127\.0\.1\.1\;' /etc/dhcp/dhclient.conf

        opDo sudo /etc/init.d/networking restart
    else
        ANT_raw "No /etc/dhcp3/dhclient.conf or /etc/dhcp/dhclient.conf -- $0 skipped"
    fi
}


function do_resolvConfLocalUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    if do_resolvConfLocalVerify ; then
        ANT_raw "Already Resolving with localhost"
        ANT_raw "/etc/resolv.conf now reads:"
        cat /etc/resolv.conf
        return
    fi

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

    do_resolvConfLocalStdout  > /etc/resolv.conf

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf

    opDo vis_dhcpClientAddLocalResolver
}


function do_resolvConfAutonomousUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    if do_resolvConfAutonomousVerify ; then
        ANT_raw "Already Resolving with localhost"
        ANT_raw "/etc/resolv.conf now reads:"
        cat /etc/resolv.conf
        return
    fi

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

    do_resolvConfAutonomousStdout  > /etc/resolv.conf

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf

    opDo vis_dhcpClientAddAutonomousResolver
}


function do_resolvConfLocalStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  cat  << _EOF_
;MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
domain  ${opRunDomainName}
nameserver      127.0.0.1
_EOF_
}


function do_resolvConfAutonomousStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  cat  << _EOF_
;MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
domain  ${opRunDomainName}
nameserver      127.0.1.1
_EOF_
}

function do_resolvConfLocalVerify {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  typeset retVal=0

  typeset tmpFile1=$( FN_tempFile )
  typeset tmpFile2=$( FN_tempFile )

  opDo eval "do_resolvConfLocalStdout | grep -v 'MACHINE GENERATED' > ${tmpFile1}"
  opDo eval "cat /etc/resolv.conf | grep -v 'MACHINE GENERATED' > ${tmpFile2}"

  FN_fileCmpAndDiff ${tmpFile1} ${tmpFile2}; retVal=$?

  #opDo ls -l ${tmpFile1} ${tmpFile2}

  FN_fileRmIfThere ${tmpFile}

  #ANT_raw "$0: Returning ${retVal}"
  return ${retVal}
}


function do_resolvConfAutonomousVerify {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  typeset retVal=0

  typeset tmpFile1=$( FN_tempFile )
  typeset tmpFile2=$( FN_tempFile )

  opDo eval "do_resolvConfAutonomousStdout | grep -v 'MACHINE GENERATED' > ${tmpFile1}"
  opDo eval "cat /etc/resolv.conf | grep -v 'MACHINE GENERATED' > ${tmpFile2}"

  FN_fileCmpAndDiff ${tmpFile1} ${tmpFile2}; retVal=$?

  #opDo ls -l ${tmpFile1} ${tmpFile2}

  FN_fileRmIfThere ${tmpFile}

  #ANT_raw "$0: Returning ${retVal}"
  return ${retVal}
}


function do_resolvConfAutonomousDhcpUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

  opDoComplain eval "do_resolvConfAutonomousDhcpStdout  > /etc/resolv.conf"

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf

    opDo vis_dhcpClientAddAutonomousResolver
}


function do_resolvConfAutonomousDhcpStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  print -- ";MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}"
  print -- "domain \t${opRunDomainName}"

  print -- "nameserver \t127.0.1.1"
}



function do_resolvConfLocalDhcpUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

  opDoComplain eval "do_resolvConfLocalDhcpStdout  > /etc/resolv.conf"

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf

    opDo vis_dhcpClientAddLocalResolver
}


function do_resolvConfLocalDhcpStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  print -- ";MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}"
  print -- "domain \t${opRunDomainName}"

  print -- "nameserver \t127.0.0.1"
}





function do_resolvConfBystarUpdate {
    ANT_raw "About to Update resolvConf"
    continueAfterThis

  subjectValidatePrepare

    FN_fileSafeCopy /etc/resolv.conf   /etc/resolv.conf.${dateTag}

  opDoComplain ${opBinBase}/mmaDnsServerHosts.sh -s ${opRunHostName} -a resolvConfOutput ${opRunDomainName} > /etc/resolv.conf

    chmod 444 /etc/resolv.conf

    ANT_raw "/etc/resolv.conf now reads:"
    cat /etc/resolv.conf

    opDo vis_dhcpClientAddLocalResolver
}


function do_resolvConfBystarStdout {
  EH_assert [[ $# -eq 0 ]]

  subjectValidatePrepare

  m_myName=$0
  print -- ";MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}"
  print -- "domain \t${opRunDomainName}"

  print -- "nameserver \t127.0.0.1"
}



function importContainersLoad {
  typeset thisOne=""
  for thisOne in ${iv_dnsImport_containersList[@]} ; do
    ANV_cooked "Loading ${thisOne}"
    EH_assert [[ -f ${opSiteControlBase}/${opRunSiteName}/${thisOne} ]]
    . ${opSiteControlBase}/${opRunSiteName}/${thisOne}
  done
}


function vis_zonesImportList {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localCopyContentServer" && hostIsNotOfType "netCopyContentServer"  ; then
    ANT_raw "$0: no import service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  typeset thisOne=""
  for thisOne in ${iv_dnsImport_refsList[@]} ; do
    print ${thisOne}
  done
}


function vis_zonesImport {
  EH_assert [[ $# -gt 0 ]]

  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localCopyContentServer" && hostIsNotOfType "netCopyContentServer"  ; then
    ANT_raw "$0: no import service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  typeset thisArg=""
  for thisArg in "$@" ; do
    if [[ "${thisArg}_" == "all_" ]] ; then
      typeset thisOne=""
      for thisOne in ${iv_dnsImport_refsList[@]} ; do
        zonesImportOne ${thisOne}
      done
    elif IS_inList ${thisArg} "${iv_dnsImport_refsList[@]}" ; then
      zonesImportOne ${thisArg}
    else
      EH_problem "${thisArg} not in ${iv_dnsImport_refsList[@]} -- skipped"
    fi
  done
}


function zonesImportOne {
  EH_assert [[  $# -eq 1 ]]

  typeset thisArg="$1"
  item_dnsImport_${thisArg}
  #print ${thisArg}

  typeset thisOne2=""
  for thisOne2 in ${iv_dnsImport_exporterMethodsList[@]} ; do
    case ${thisOne2} in
      "axfrdns")
           opDoComplain importBaseDirAssert
           #tcpclient $host 53 axfr-get $zone $file.conf $file.tmp
           typeset importFile=${mmaDns_importBaseDir}/${iv_dnsImport_zoneName}
           opDoComplain tcpclient ${iv_dnsImport_exporterHostName} 53 axfr-get ${iv_dnsImport_zoneName} ${importFile}.axfr ${importFile}.tmp
           if [[ $? == 0 ]] ; then
             # No Need to try any other method
             break
           fi
           ;;
      "rsyncPush")
           opDoComplain importBaseDirAssert
           doNothing
           ;;
      "sshPush")
           opDoComplain importBaseDirAssert
           ANT_raw "Initiate an export sshPush of: ${iv_dnsImport_zoneName} from:  ${iv_dnsImport_exporterHostName} to ${subject}"
           ;;
      "mailbot")
           opDoComplain importBaseDirAssert
           doNothing
           ;;
      *)
           return
           ;;
    esac
  done
}

function vis_zonesExportList {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localOrigContentServer" && hostIsNotOfType "netOrigContentServer"  ; then
    ANT_raw "$0: no export service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  typeset thisOne=""
  for thisOne in ${iv_dnsExport_refsList[@]} ; do
    print ${thisOne}
  done
}

function zonesExportFind {
  EH_assert [[ $# -eq 1 ]]

  # Given a domain name locate item_dnsImport_${thisArg}

  typeset thisOne=""
  for thisOne in ${iv_dnsExport_refsList[@]} ; do
    ANV_cooked "${thisOne}"
    item_dnsImport_${thisOne}
    if [[ "${iv_dnsImport_zoneName}_" == "$1_" ]] ; then
      print ${thisOne}
      return 0
    fi
  done
  return 1
}


needZoneExportPostProcessing=""

function vis_zonesExport {
  EH_assert [[ $# -gt 0 ]]

  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localOrigContentServer" && hostIsNotOfType "netOrigContentServer"  ; then
    ANT_raw "$0: no export service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  needZonesExportPostProcess="nil"

  typeset exportRef=""
  typeset thisArg=""
  for thisArg in "$@" ; do
    if [[ "${thisArg}_" == "all_" ]] ; then
      typeset thisOne=""
      for thisOne in ${iv_dnsExport_refsList[@]} ; do
        zonesExportOne ${thisOne}
      done
    elif IS_inList ${thisArg} "${iv_dnsExport_refsList[@]}" ; then
      zonesExportOne ${thisArg}
    elif exportRef=`zonesExportFind ${thisArg}` ; then
      zonesExportOne ${exportRef}
    else
      EH_problem "${thisArg} not in ${iv_dnsExport_refsList[@]} -- skipped"
    fi
  done
  if [[ "${needZonesExportPostProcess}_" != "nil_" ]] ; then
    zonesExportPostProcess
  fi
}

function zonesExportOne {
  EH_assert [[  $# -eq 1 ]]

  typeset thisArg="$1"
  item_dnsImport_${thisArg}
  ANV_cooked "${thisArg}"
  typeset exportFileName="${mmaDns_exportBaseDir}/${iv_dnsImport_zoneName}.export"
  opDoComplain eval "( grep ${iv_dnsImport_zoneName} ${mmaDns_origContentDataFile} > ${exportFileName}.new )"

  if [[ "${G_forceMode}_" != "force_" ]] ; then
    rightHere "Should Zone $1  be exported?"
    getConfirmation
  fi


  if [[ ! -f ${exportFileName} ]] ; then
    touch ${exportFileName}
  fi

  if cmp ${exportFileName}.new ${exportFileName} ; then
    if [[ "${G_forceMode}_" != "force_" ]] ; then
      ANT_raw "$0: $1 Nothing New, Skipped"
      return 0
    fi
    # Leaving .new in place, it will be renewed next time
  else
    mv ${exportFileName}.new ${exportFileName}
  fi

  needZonesExportPostProcess="t"

  typeset thisOne2=""
  for thisOne2 in ${iv_dnsImport_exporterMethodsList[@]} ; do
    ANV_cooked "${thisOne2}"
    case ${thisOne2} in
      "axfrdns")
           opDoComplain exportBaseDirAssert
           doNothing
           ;;
      "rsyncPush")
           opDoComplain exportBaseDirAssert
           doNothing
           ;;
      "sshPush")
           opDoComplain exportBaseDirAssert
           typeset thisDest=""
           for thisDest in ${iv_dnsExport_sshPushDestList[@]} ; do
             opDoComplain sudo -u dnsadmin scp -pq ${exportFileName} ${thisDest}:${mmaDns_importBaseDir}/${iv_dnsImport_zoneName}
             #opDoComplain sudo -u dnsadmin scp -BCpq ${exportFileName} ${thisDest}:${mmaDns_importBaseDir}/${iv_dnsImport_zoneName}
           done
           ;;
      "sshPoll")
           opDoComplain exportBaseDirAssert
           doNothing
           ;;
      "getMasters")
           opDoComplain exportBaseDirAssert
           doNothing
           ;;
      "mailbot")
           opDoComplain exportBaseDirAssert
           typeset thisDest=""
           for thisDest in ${v_dnsExport_mailbotAddrList[@]} ; do
             # NOTYET, prepare and sendout the mail
             doNothing
           done
           ;;
      *)
           return
           ;;
    esac
  done
}


function zonesExportPostProcess {
  EH_assert [[  $# -eq 0 ]]

  ANV_cooked ""

  typeset thisDest=""
  for thisDest in ${iv_dnsExport_sshPushDestList[@]} ; do
    opDoComplain sudo -u dnsadmin ssh ${thisDest} ${opBinBase}/mmaDnsServerHosts.sh -i contentCombineData
  done
}



function vis_zonesImportPrep {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localCopyContentServer" && hostIsNotOfType "netCopyContentServer"  ; then
    ANT_raw "$0: no import service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  typeset thisOne=""
  for thisOne in ${iv_dnsImport_refsList[@]} ; do
    item_dnsImport_${thisOne}
    ANV_raw "$0:  ${thisOne}"

    importBaseDirAssert

    typeset prepedHosts=""

    function localSshPrep {
      if LIST_isIn ${opRunHostName} "${prepedHosts}" ; then
        return 0
      else
        opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate
        prepedHosts="${opRunHostName} ${prepedHosts}"
      fi
      return
    }

    typeset thisOne2=""
    for thisOne2 in ${iv_dnsImport_exporterMethodsList[@]} ; do
      echo ${thisOne2}
      case ${thisOne2} in
        "axfrdns")
                   doNothing
           ;;
        "rsyncPush")
                     doNothing
           ;;
        "sshPush")
                   localSshPrep

           ;;
        "sshPoll")
           localSshPrep
           if LIST_isIn ${iv_dnsImport_exporterHostName} "${prepedHosts}" ; then
             continue
           else
             opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${iv_dnsImport_exporterHostName}  -i authorizedKeysUpdate
             prepedHosts="${iv_dnsImport_exporterHostName} ${prepedHosts}"
           fi
           ;;
        "getMasters")
           localSshPrep
           if LIST_isIn ${iv_dnsImport_exporterHostName} "${prepedHosts}" ; then
             continue
           else
             opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${iv_dnsImport_exporterHostName}  -i authorizedKeysUpdate
             prepedHosts="${iv_dnsImport_exporterHostName} ${prepedHosts}"
           fi
           ;;
        "mailbot")
                   doNothing
           # NOTYET, setup a mailbot receiver
           ;;
        *)
           EH_problem "Unknown: ${thisOne2}"
           ;;
      esac
    done
  done
}


function vis_zonesExportPrep {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
  if  hostIsNotOfType "localOrigContentServer" && hostIsNotOfType "netOrigContentServer"  ; then
    ANT_raw "$0: no export service for ${subject} -- skipped"
    return 1
  fi

  importContainersLoad

  typeset prepedHosts=""

  typeset thisOne=""
  for thisOne in ${iv_dnsExport_refsList[@]} ; do
    item_dnsImport_${thisOne}
    print ${thisOne}
    exportBaseDirAssert
    typeset thisOne2=""
    for thisOne2 in ${iv_dnsImport_exporterMethodsList[@]} ; do
      echo ${thisOne2}
      case ${thisOne2} in
        "axfrdns")
           typeset thisPoller=""
           for thisPoller in ${iv_dnsExport_axfrPermitList[@]} ; do
             #EH_problem "NOTYET ${thisPoller} to be permitted"
             doNothing
           done
           ;;
        "sshPoll")
                   doNothing
           ;;
        "rsyncPush")
                   doNothing
           ;;
        "sshPush")
           opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate
           typeset thisDest=""
           for thisDest in ${iv_dnsExport_sshPushDestList[@]} ; do
             echo ${thisDest}
             if LIST_isIn ${thisDest} "${prepedHosts}" ; then
               continue
             else
               opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${thisDest}  -i authorizedKeysUpdate
               prepedHosts="${thisDest} ${prepedHosts}"
             fi
           done
           ;;
        "getMasters")
           opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate
           ;;
        "mailbot")
           doNothing
           ;;
        *)
           EH_problem "Unknown: ${thisOne2}"
           ;;
      esac
    done
  done
}

function vis_logsList {
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}

  typeset thisFeature=""

  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localResolvingServer")
        print "/etc/dnscache/log/main/current"
        ;;

      "autonomousResolvingServer")
        print "/etc/dnscachew/log/main/current"
        ;;

      "netResolvingServer")
        print "/etc/dnscachex/log/main/current"
        ;;

      "localOrigContentServer"|"netOrigContentServer")
        print "/etc/tinydns/log/main/current"
        ;;

      "localCopyContentServer"|"netCopyContentServer")
        print "/etc/tinydns/log/main/current"
        ;;

      "netZoneXferServer")
         print "/etc/axfrdns/log/main/current"
         ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
    esac
  done
}


function do_schemaVerify {
  subjectValidatePrepare

  typeset thisFeature=""

  for thisFeature in ${iv_dnsSetup} ; do
    case ${thisFeature} in
      "localResolvingServer")
        if [[ "${iv_dnsResolvingServer.accessList[@]}_" != "_" ]] ; then
          EH_problem "${subject}: ${thisFeature}: ${iv_dnsResolvingServer.accessList[@]}"
        fi
        ;;

      "autonomousResolvingServer")
        doNothing
        ;;

      "netResolvingServer")
        doNothing
        ;;

      "localOrigContentServer"|"netOrigContentServer")
        doNothing
        ;;

      "localCopyContentServer"|"netCopyContentServer")
        doNothing
        ;;

      "netZoneXferServer")
         doNothing
         ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1
       ;;
    esac
    ANT_raw "$0: ${subject}: ${thisFeature}: Okay"
  done
}



function vis_contentServerIpAddrFileName {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    echo /etc/tinydns/env/IP

    lpReturn
}

function vis_contentServerIpAddrGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo cat $( vis_contentServerIpAddrFileName ) 

    lpReturn
}

function vis_contentServerIpAddrSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDo eval echo $1 \>  $( vis_contentServerIpAddrFileName ) 

    lpReturn
}

function vis_contentServerIpAddrSetNet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset thisNetIpAddr=$( mmaLayer3Admin.sh -i ipAddrGetGivenInterface eth0 ) 
    
    opDo vis_contentServerIpAddrSet ${thisNetIpAddr}

    lpReturn
}


function vis_contentServerIpAddrSetLocal {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_contentServerIpAddrSet ${hereTinydnsMainIpV4Addr}

    lpReturn
}
