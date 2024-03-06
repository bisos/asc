#!/bin/bash

IimBriefDescription="svcXxSysdAdmin.sh SysD (systemd) Daemon Admin -- nichable"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaSambaSysdAdmin.sh,v 1.1 2016-11-25 05:31:42 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedAdminDaemonSysD.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedAdminDaemonSysD.sh]] | 
"
FILE="
*  /This File/ :: /bisos/bsip/bin/svcDhcpSysdAdmin.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedAdminDaemonSysD.sh -l $0 "$@" 
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/ ::  [[elisp:(org-cycle)][| ]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[file:Panel.org][Panel]] | [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] | [[elisp:(bx:org:run-me)][Run]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] [[elisp:(org-cycle)][| ]]
** /Version Control/ ::  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_

_CommentBegin_
*      ================
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes         :: *[Current-Info]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xrefs         :: *[Related/Xrefs:]*  <<Xref->>  -- BxPanels  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  BxPanel      :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxSupervision/systemd/fullUsagePanel-en.org::Xref-][Systemd Panel]] [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  BxPanel      :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxPlatform/baseDirs/samba/fullUsagePanel-en.org::Xref-][Samba Panel]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Info          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  SysD         :: BISOS Customizations [[elisp:(org-cycle)][| ]]
    Based on the generic SysD (systemd) init daemon Start/Stop/Restart.
    This facility only manages the start/stop of daemon.

_EOF_
}

function vis_describe { vis_moduleDescription; }

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Parameters    :: SysD (systemd) Daemon Parameter Settings [[elisp:(org-cycle)][| ]]
_CommentEnd_


daemonName="tinydns"  # common name, used as a tag
daemonsServiceName=(
    "tinydns"
    # "isc_dhcp_server6"
)
daemonControlScript="/etc/sv/tinydns/conf"
daemonControlBase="/etc/sv/tinydns/conf"

daemonDefaultFile="NA-daemonDefaultFile"

# Daemon Config Vars
daemonConfigDir="/etc/sv/tinydns/root/"
daemonConfigFile="${daemonConfigDir}/data"

# Daemon Log Vars
daemonLogDir="/var/log"
daemonLogFile="${daemonLogDir}/syslog"
daemonLogErrFile="${daemonLogDir}/syslog"
daemonLogTag=${daemonName}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples      :: Customized Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_examples_general {
    EH_assert [[ $# -eq 1 ]]

    local context="$1"
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""

    if [ "${context}" == "general" ] ; then
        doNothing
    elif [ "${context}" == "niche" ] ; then
        doNothing
        #G_myName=$( G_myUnNicheNameGet )      
    else
        EH_problem "Bad context=${context}"
        lpReturn 101
    fi
  
    visLibExamplesOutput ${G_myName} 
    cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
_EOF_

    vis_examplesFullService
    vis_examplesDaemonControl

    cat  << _EOF_
$( examplesSeperatorChapter "Server Config" )
_EOF_
  
    vis_examplesDefaultConfig

    vis_examplesServerConfig  

    vis_examplesLogInfo
    vis_examplesLogSysd

cat  << _EOF_
$( examplesSeperatorChapter "Client Verification" )
sudo lsof -i :53
_EOF_

    ANT_raw "/bisos/git/auth/bxRepos/blee-binders/bisos-svcs/dns/tinydns-diag/_nodeBase_/fullUsagePanel-en.org"
    ANT_raw "/bisos/git/auth/bxRepos/blee-binders/connectivity/dnsResolution/_nodeBase_/fullUsagePanel-en.org"
    
    cat  << _EOF_
$( examplesSeperatorChapter "Niche Pointer" )
_EOF_
  
    ANT_raw "_niche has not been automated yet"
    # vis_examplesNicheRun
    
}

noArgsHook() {
    vis_examples_general "general"
}

function vis_examplesDefaultConfig {
 cat  << _EOF_
$( examplesSeperatorSection "DEFAULT CONFIG FILES" )
Not Applicable --- tinydns does not use /etc/default 
_EOF_
}

function vis_examplesServerConfig {
    local extraInfo="-h -v -n showRun"
 cat  << _EOF_
$( examplesSeperatorSection "SERVER CONFIG ACTIONS" )
${G_myName} ${extraInfo} -i serverConfigUpdate                 # _niche: canonical, IpAddrSet, DataFileSet, DataFileProc
${G_myName} ${extraInfo} -i tinydnsConfigIpAddrSet  a.b.c.d    # _niche: /etc/sv/tinydns/conf/IP
${G_myName} ${extraInfo} -i tinydnsConfigIpAddrGet             # /etc/sv/tinydns/conf/IP
${G_myName} ${extraInfo} -i tinydnsConfigDataFileSet filePath   # _niche: symLink in /etc/sv/tinydns/root/data
${G_myName} ${extraInfo} -i tinydnsConfigDataFileShow           # /etc/sv/tinydns/root/data
${G_myName} ${extraInfo} -i tinydnsConfigDataFileProc           # in /etc/sv/tinydns/root run make
${G_myName} ${extraInfo} -i cntnrCharIpAddrForTinydns
_EOF_
}

function vis_tinydnsConfigIpAddrGet { lpDo cat ${daemonControlBase}/IP; }

function vis_tinydnsConfigIpAddrSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]
    EH_assert daemonPrep

    lpDo eval echo $1 | sudo tee ${daemonControlBase}/IP
}


function vis_tinydnsConfigDataFileShow { lpDo ls -l  ${daemonConfigDir}/data; }

function vis_tinydnsConfigDataFileSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]
    EH_assert daemonPrep

    local dataFile="$1"
    
    if [ ! -r "${dataFile}" ] ; then
        EH_problem "Bad Usage: Missing ${dataFile}"
        lpReturn 101
    fi

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
    
    lpDo FN_fileSymlinkUpdate ${dataFile} ${daemonConfigDir}/data
}

function vis_tinydnsConfigDataFileProc {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert daemonPrep

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
    
    inBaseDirDo ${daemonConfigDir} make
}

function vis_serverConfigUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert daemonPrep

    ANT_raw "Expected to be done with _niche. No action taken here."
}


function vis_cntnrCharIpAddrForTinydns {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local thisCntnrBpoId=$( lpDo cat /bisos/var/bpoId/sysChar.fp/value )
    EH_assert [ ! -z "${thisCntnrBpoId}" ]

    local thisCntnrId=${thisCntnrBpoId##pmp_}
    EH_assert [ ! -z "${thisCntnrId}" ]

    local bpoHome=$( FN_absolutePathGet ~${thisCntnrBpoId} )

    local cntnrChar_ipAddr
    
    local thisCntnrIpAddrsBase="${bpoHome}/${thisCntnrId}/steady/net/ipv4"
    EH_assert [ -d "${thisCntnrIpAddrsBase}" ]

    # NOTYET, based on model more verifications should be made

    if [ -r "${thisCntnrIpAddrsBase}/pubB.fps/addr/value" ] ; then
            cntnrChar_ipAddr=$( lpDo cat "${thisCntnrIpAddrsBase}/pubB.fps/addr/value" )
    elif [ -r "${thisCntnrIpAddrsBase}/privA.fps/addr/value" ] ; then
            cntnrChar_ipAddr=$( lpDo cat "${thisCntnrIpAddrsBase}/privA.fps/addr/value" )
    else
        # cntnrChar_ipAddr="127.0.0.1"
        EH_problem "Missing ${thisCntnrIpAddrsBase}/pubB.fps/addr/value"
        EH_problem "Missing ${thisCntnrIpAddrsBase}/privA.fps/addr/value"        
        lpReturn
    fi

    echo ${cntnrChar_ipAddr}
       
    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  serverConfig  :: serverConfigUpdate Overwrites [[elisp:(org-cycle)][| ]]
_CommentEnd_


_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *End Of Editable Text*
_CommentEnd_

####+BEGIN: bx:dblock:bash:end-of-file :types ""
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:

