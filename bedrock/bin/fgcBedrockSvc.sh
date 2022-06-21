#!/bin/bash

IcmBriefDescription="Functionally Grouped Components Software: Mail Transfer"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
### Args: :control "enabled|disabled|hide|release|fVar"  :vc "cvs|git|nil" :partof "bystar|nil" :copyleft "halaal+minimal|halaal+brief|nil"
typeset RcsId="$Id: dblock-iim-bash.el,v 1.4 2017-02-08 06:42:32 lsipusr Exp $"
# *CopyLeft*
__copying__="
* Libre-Halaal Software"
#  This is part of ByStar Libre Services. http://www.by-star.net
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/asc/bedrock/bin/fgcBedrockSvc.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*  /Controls/ ::  [[elisp:(org-cycle)][| ]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[file:Panel.org][Panel]] | [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] | [[elisp:(bx:org:run-me)][Run]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] [[elisp:(org-cycle)][| ]]
** /Version Control/ ::  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]]
####+END:
_CommentEnd_


_CommentBegin_
*      ================
*      ################ CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  [Info]        :: *[Current-Info:]* Module Description, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_describe {  cat  << _EOF_
This is the top-level Functionally Group Components Service Manager.
_EOF_
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Info]        :: *[Related-Xrefs:]* <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
Xref-Here-
**  [[elisp:(org-cycle)][| ]]  Subject      :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxMailMta/fullUsagePanel-en.org::Xref-BxMailTransfer-SA][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Libs]        :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh


# PRE parameters

baseDir=""

function G_postParamHook {
     return 0
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Examples]    :: Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

#$( examplesSeperatorChapter "Chapter Title" )

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "Functionally Grouped Mail Transfer Services" )
$( examplesSeperatorSection "Items Based Operators" )
${G_myName} ${extraInfo} -i itemsOrderedList
${G_myName} ${extraInfo} -i itemsOrderedListApply -- -i showMe
$( examplesSeperatorSection "Full Operators" )
${G_myName} ${extraInfo} -i fullVerify
${G_myName} ${extraInfo} -i fullUpdate
$( examplesSeperatorSection "Configurations" )
${G_myName} ${extraInfo} -i qmailConfig
${G_myName} ${extraInfo} -i mailfrontConfig
${G_myName} ${extraInfo} -i fgcMtaSvcConfig
${G_myName} ${extraInfo} -i fgcMtaSvcConfigVerify
$( examplesSeperatorSection "Reports" )
${G_myName} ${extraInfo} -i fgcMtaSvcReport
$( examplesSeperatorSection "Stop / Start" )
${G_myName} ${extraInfo} -i fgcMtaSvcStop
${G_myName} ${extraInfo} -i fgcMtaSvcStart
$( examplesSeperatorSection "Telnet Testing" )
telnet localhost 25    # SMTP --ehlo localhost
telnet localhost 587    # SMTP --ehlo localhost
openssl s_client -crlf -connect localhost:465 -quiet 
mconnect
_EOF_
}

#Start TLS is not supported -- telnet localhost 25    # SMTP --ehlo localhost--starttls
#Start TLS is not supported -- openssl s_client -starttls smtp -crlf -connect localhost:25 -quiet


noArgsHook() {
  vis_examples
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Items]       :: Items List [[elisp:(org-cycle)][| ]]
_CommentEnd_

itemsOrderedList=( 
    # lcaQmailHosts.sh
)


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_itemsOrderedList, vis_itemsOrderedListApply [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_itemsOrderedList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    for this in ${itemsOrderedList[@]} ; do
        echo ${this}
    done

    lpReturn
}

function vis_itemsOrderedListApply {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    for this in ${itemsOrderedList[@]} ; do
        opDo eval "${this}" " " $@
    done

    lpReturn
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_fullVerify, vis_fullUpdate [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_fullVerify {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Creates needed directories and permissions.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    vis_itemsOrderedListApply -s all -a fullVerify

    lpReturn
}

function vis_fullUpdateOrderedList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    vis_itemsOrderedListApply -i fullUpdate

    #opDoAfterPause lcaUcspiSslBinsPrep.sh -h -v -n showRun -i fullUpdate
    #opDoAfterPause lcaMailfrontHosts.sh -h -v -n showRun -i sslKeysGen

    lpReturn
}



function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    opDo vis_qmailConfig
    opDo vis_mailfrontConfig

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_qmailConfig [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_qmailConfig {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS"|"BISP"|"BUE")

            # Stop Everything
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStop all

            # Disable Everything
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -i servicesDisable inNetSmtp
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -i servicesDisable inNetVerify
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -i servicesDisable outNetSmtp

            # Configure Everything
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesConfig all
            #opDoAfterPause mmaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a configFilestransition

            # Configure Everything For mailfront usage
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a configFilesRenew

            # Is this the right place to do this?
            opDoAfterPause mmaQmailAddrs.sh -h -v -n showRun -p acctName=alias -i acctUpdate
            opDoAfterPause mmaQmailAddrs.sh -h -v -n showRun  -f -s qmailAcct_alias -a acctAddrsUpdate

            # Enable qmail-send daemon
            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -i servicesEnable  outNetSmtp 

            # Enable lcaSpamAAdmin.sh
            opDoAfterPause lcaSpamAAdmin.sh -h -v -n showRun -i daemonEnable
            opDoAfterPause lcaSpamAAdmin.sh -h -v -n showRun -i fullUpdate                 # serverConfigUpdate + daemonRestart

            ;;

        "OTHER")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;

        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_mailfrontConfig [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_mailfrontConfig {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS"|"BISP"|"BUE")

            # - Configure and Run lcaCvmHosts.sh 
            opDoAfterPause lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a fullUpdate

            # - Take care of additional binspreps
            opDoAfterPause lcaMailfrontHosts.sh -h -v -n showRun -i sslKeysGen

            # - Configure and Run lcaMailfrontHosts.sh 
            opDoAfterPause lcaMailfrontHosts.sh -h -v -n showRun -s ${opRunHostName} -a fullUpdate

            # - Restart Qmail
            #opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStart all

            opDoAfterPause lcaDaemontoolsAdmin.sh -h -v -n showRun -i fullReport

            # 5- Test badaddr for qmail backscatter, good addr and authsmtp

            ;;
        "OTHER")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_fgcMtaSvcReport, vis_fgcMtaSvcStop, vis_fgcMtaSvcStart [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_fgcMtaSvcReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS"|"BISP"|"BUE")
            ANT_raw "Supervision Reports"
            ANT_raw "Qmail Supervision Reports"
            #opDo lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesShow all
            opDo lcaQmailHosts.sh  -s ${opRunHostName} -a servicesShow all
            ANT_raw "Mailfront Supervision Reports"
            #opDo lcaMailfrontHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesShow all
            opDo lcaMailfrontHosts.sh  -s ${opRunHostName} -a servicesShow all      
            ANT_raw "CVM Supervision Reports"
            #opDo lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesShow all
            opDo lcaCvmHosts.sh  -s ${opRunHostName} -a servicesShow all
            
            ANT_raw "Process Reports"
            ;;
        "OTHER")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}


function vis_fgcMtaSvcStop {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS"|"BISP"|"BUE")
            ANT_raw "Supervision Reports"
            ANT_raw "Qmail Supervision Reports"
            opDo lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStop all
            ANT_raw "Mailfront Supervision Reports"
            opDo lcaMailfrontHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStop all
            ANT_raw "CVM Supervision Reports"
            opDo lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStop all
            
            ANT_raw "Process Reports"

            ;;
        "OTHER")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}


function vis_fgcMtaSvcStart {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS"|"BISP"|"BUE")
            ANT_raw "Supervision Reports"
            ANT_raw "Qmail Supervision Reports"
            opDo lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStart all
            ANT_raw "Mailfront Supervision Reports"
            opDo lcaMailfrontHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStart all
            ANT_raw "CVM Supervision Reports"
            opDo lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStart all
            
            ANT_raw "Process Reports"

            ;;
        "OTHER")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Code]        :: vis_fgcMtaSvcLogs [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_fgcMtaSvcLogs {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS")
            ANT_raw "Supervision Logs"

            ANT_raw "Process Logs"

            ;;
        "BISP")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        "BUE")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Obsoleted]   :: vis_fgcMtaSvcConfigOrig [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_fgcMtaSvcConfigOrig {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    case ${opRunHostFamily} in
        "BACS")
            # 0- Take care of additional binspreps

            opDoAfterPause lcaMailfrontHosts.sh -h -v -n showRun -i sslKeysGen

            # 1- Fixup Qmail Config Files

            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStop all

            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a configFilesRenew

            # 2- Disable qmail-smtpd

            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -i servicesDisable inNetSmtp 

            # 3- Configure and Run lcaCvmHosts.sh 

            opDoAfterPause lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a fullUpdate

            # 4- Configure and Run lcaMailfrontHosts.sh 

            opDoAfterPause lcaMailfrontHosts.sh -h -v -n showRun -s ${opRunHostName} -a fullUpdate

            # 5- Restart Qmail

            opDoAfterPause lcaQmailHosts.sh -h -v -n showRun -s ${opRunHostName} -a servicesStart all

            opDoAfterPause lcaDaemontoolsAdmin.sh -h -v -n showRun -i fullReport

            # 5- Test badaddr for qmail backscatter, good addr and authsmtp

            ;;
        "BISP")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        "BUE")
            ANT_raw "$0 Does Not Apply -- Skipped for opRunHostFamily=${opRunHostFamily}"
            ;;
        *)
            EH_problem "Unknown: opRunHostFamily=${opRunHostFamily}"
            return
            ;;
    esac
}



####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:

