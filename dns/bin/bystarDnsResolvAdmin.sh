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

# {{{ Help/Info

function vis_describe {
    cat  << _EOF_

See ./bystarDnsDomain.libSh for details.


_EOF_
}

# }}}

# {{{ Prefaces

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


# }}}

# {{{ Examples

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
--- /etc/resolv.conf --- 
cat /etc/resolv.conf
============ Resolution Modifications
Replace /etc/resolv.conf:  
Just dnscache localhost
dnscache local + Bx Pub Res
Bx Public Resolvers
ISPs Public Resolvers
--- DNSCACHE Faking / Resolution Reports and Information ---
${G_myName} ${extraInfo} -p bystarUid=all -p DomainForm=all -i dnscacheFakeHereReport      # for all BUIDs on platform
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i dnscacheFakeHereReport      # for all BUIDs on platform
ls -ld /etc/dnscache/root/servers/*
egrep ^. /etc/dnscache/root/servers/*
--- DNSCACHE Faking / Resolution Complete Disabling ---
${G_myName} ${extraInfo} -i dnscacheFakeHereDisableEverything     # for all BUIDs on platform
--- DNSCACHE Faking / Resolution Adjustement (fakeHereNot) ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i dnscacheFakeHereNot
--- DNSCACHE Faking / Resolution Adjustement (fakeHere) ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p DomainForm=all -i dnscacheFakeHere
--- DNSCACHE Faking / Resolution hereSpecific ---
${G_myName} ${extraInfo} -i dnscacheServerDomainPtrAdd local someDomain.tld 192.168.x.x
${G_myName} ${extraInfo} -i dnscacheServerDomainPtrDelete local someDomain.tld
_EOF_
}


noArgsHook() {
  vis_examples
}

# }}}


noSubjectHook() {
  return 0
}


#
# Resolver Adjust and Report
#

function vis_dnscacheFakeHereReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
List all in Servers directory
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

    if [[ "${bystarUid}" == "all" ]] ; then
        typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
        typeset origDomainForm=${DomainForm}
        for bystarUid in ${hereBystarUidList} ; do
            DomainForm=${origDomainForm}
            vis_dnscacheFakeHereReport 
        done
        lpReturn
    fi

    if [[ "${DomainForm}_" == "all_" ]] ; then
        for DomainForm in ${DomainFormTypes} ; do
            vis_dnscacheFakeHereReport
        done
        lpReturn
    fi

    #G_abortIfNotRunningAsRoot

    #opDoRet mmaDnsServerHosts.sh -i hostIsOrigContentServer

    opDoRet bystarAcctAnalyze ${bystarUid} 2> /dev/null

    bystarDomainBase=$( bystarDomainBaseGet 2> /dev/null)

    ANT_raw "Reporting: bystarUid=${bystarUid} -- DomainForm=${DomainForm} -- bystarDomainBase=${bystarDomainBase}"

    if [ "${bystarDomainBase}_" != "_" ] ; then
        vis_dnscacheServerDomainPtrReport local ${bystarDomainBase}
    fi

    lpReturn
}


function vis_dnscacheFakeHereDisableEverything {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    G_abortIfNotRunningAsRoot

    serverDir=/etc/dnscache/root/servers

    opDo eval "find ${serverDir} -type f -print | grep -v @ | xargs /bin/rm"

    opDo mmaDnsServerHosts.sh -v -n showRun -i cacheRestart
}


function vis_dnscacheFakeHereNot {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

    if [[ "${bystarUid}" == "all" ]] ; then
        typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
        typeset origDomainForm=${DomainForm}
        for bystarUid in ${hereBystarUidList} ; do
            DomainForm=${origDomainForm}
            vis_dnscacheFakeHereNot
        done
        lpReturn
    fi

    if [[ "${DomainForm}_" == "all_" ]] ; then
        for DomainForm in ${DomainFormTypes} ; do
            vis_dnscacheFakeHereNot
        done
        lpReturn
    fi

    G_abortIfNotRunningAsRoot

    #opDoRet mmaDnsServerHosts.sh -i hostIsOrigContentServer

    opDoRet bystarAcctAnalyze ${bystarUid}

    bystarDomainBase=$( bystarDomainBaseGet )

    if [ "${bystarDomainBase}_" != "_" ] ; then
        opDo vis_dnscacheServerDomainPtrDelete local ${bystarDomainBase} ${thisIPAddress}
    fi

    opDo mmaDnsServerHosts.sh -v -n showRun -i cacheRestart
}

function vis_dnscacheFakeHere {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert [[ "${DomainForm}_" != "MANDATORY_" ]]

    if [[ "${bystarUid}" == "all" ]] ; then
        typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
        typeset origDomainForm=${DomainForm}
        for bystarUid in ${hereBystarUidList} ; do
            DomainForm=${origDomainForm}
            vis_dnscacheFakeHere 
        done
        lpReturn
    fi

    if [[ "${DomainForm}_" == "all_" ]] ; then
        for DomainForm in ${DomainFormTypes} ; do
            vis_dnscacheFakeHere 
        done
        lpReturn
    fi

    G_abortIfNotRunningAsRoot

    #opDoRet mmaDnsServerHosts.sh -i hostIsOrigContentServer

    opDoRet bystarAcctAnalyze ${bystarUid}

    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
    #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`    
    #opDo lpParamsBasicGet
  
    #thisIPAddress=${lpDnsEntryIpAddr}
    thisIPAddress=$( cat /etc/tinydns/env/IP )

    bystarDomainBase=$( bystarDomainBaseGet )

    if [ "${bystarDomainBase}_" != "_" ] ; then
        opDo vis_dnscacheServerDomainPtrAdd local ${bystarDomainBase} ${thisIPAddress}
    fi

    opDo mmaDnsServerHosts.sh -v -n showRun -i cacheRestart
}


#
# NOTYET, Func below should go in lcaDns.libSh
#

function vis_dnscacheServerDomainPtrAdd {
  # $1 -- "net" or "local"
  # $2 --  domainName
  # $3 - $@ --  domainAddrList

  EH_assert [[ $# -ge 3 ]]

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


function vis_dnscacheServerDomainPtrDelete {
  # $1 -- "net" or "local"
  # $2 --  domainName

  EH_assert [[ $# -eq 2 ]]

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

  opDoComplain eval "( /bin/rm ${serverDir}/${domainName} )"
}


function vis_dnscacheServerDomainPtrReport {
  # $1 -- "net" or "local"
  # $2 --  domainName

  EH_assert [[ $# -eq 2 ]]

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

  if [ -f "${serverDir}/${domainName}" ] ; then
      #opDoComplain eval "( egrep -H ^. ${serverDir}/${domainName} )"
      egrep -H ^. ${serverDir}/${domainName}
  else
      ANT_raw "Missing ${serverDir}/${domainName} -- Skipped"
  fi
}


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: shellscript-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:
