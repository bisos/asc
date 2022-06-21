#!/bin/bash

IcmBriefDescription="NOTYET: Short Description Of The Module"

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


####+BEGIN: bx:bsip:bash:seed-spec :types "seedSubjectHosts.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedSubjectHosts.sh]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/lcaSquirrelmailSvcUse.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectHosts.sh -l $0 "$@" 
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
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info]* Status/Maintenance -- General TODO List
_CommentEnd_

function vis_describe {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Description:]*
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxWebMail/fullUsagePanel-en.org::Xref-BxWebSquirrelmail-SA][Panel Roadmap Documentation]]
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh
. ${opBinBase}/mmaLib.sh

. ${opBinBase}/bisosCurrents_lib.sh

# PRE parameters

function G_postParamHook {
    lpCurrentsGet

    return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Chapter Title" )
$( examplesSeperatorSection "Section Title" )
${G_myName} ${extraInfo} -i doTheWork
_EOF_
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -i serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -i serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -i serviceSoftwareProfile showCmdLine -a fullUpdate
--- Service Config (update/verify/delete) ---
${G_myName} ${extraInfo} -i serviceConfig fullVerify
${G_myName} ${extraInfo} -i serviceConfig fullUpdate
${G_myName} ${extraInfo} -i serviceConfig showCmdLine -i fullUpdate
--- SERVER ACTIONS FULL ---
${G_myName} ${extraInfo} -i serviceDaemonType  # sysv, daemontools, other -- used to generate xxAdmin.sh
${G_myName} ${extraInfo} -i serviceDaemonList  # local, unix, ...
${G_myName} ${extraInfo} -i serviceFeatures    # local, unix, ...
=== Details with -- -T 7 ===
${G_myName} ${extraInfo} -i serviceFullInfo
=== More For Developers ===
${G_myName} ${extraInfo} -i examplesDev
_EOF_
}

function vis_examplesDev {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile showCmdLine -a fullUpdate
--- Service Config (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig showCmdLine -i fullUpdate
_EOF_
}


noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== serviceSoftwareProfile
_CommentEnd_


function do_serviceSoftwareAssert {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "NOTYET"
}

function vis_serviceSoftwareProfile {
  EH_assert [[ $# -ge 1 ]]

  subject=${opRunHostName}

  do_serviceSoftwareProfile $@
}

function do_serviceSoftwareProfile {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "Software Service Profile For ${subject}"

  # NOTYET, untested - set binsPrepCmd in seedUserScript
  if [ "${binsPrepCmd}_" == "_" ] ; then
      binsPrepCmdBase=${G_myName%%SvcUse.sh}
      binsPrepCmd="${binsPrepCmdBase}BinsPrep.sh"
  fi

  cmdLineBase=""

    case ${iv_serviceHost_setup} in
      "server"|"client"|"fullServer")
        orderedSubjectsList=$( ${binsPrepCmd} -i orderedList )
        cmdLineBase="${binsPrepCmd} ${orderedSubjectsList}"
        ;;

      "noService")
        cmdLineBase="echo ${G_myName}: noService -- BinsPrep skipped"
        break
        ;;

      *)
       EH_problem "Unknown:  ${iv_serviceHost_setup}"
       return 1  
       ;;
    esac

  case ${1} in
    "fullUpdate"|"fullVerify"|"fullDelete")
               opDo ${cmdLineBase} -a $1
               ;;
    "showCmdLine")
              shift 
              echo "${cmdLineBase} $@"
               ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== serviceConfig
_CommentEnd_


function vis_serviceConfig {
  EH_assert [[ $# -ge 1 ]]

  subject=${opRunHostName}

  do_serviceConfig $@
}


function do_serviceConfig {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "Service Configuration For ${subject}"

  # NOTYET, untested - set serviceConfigCmd in seedUserScript
  if [ "${serviceConfigCmd}_" == "_" ] ; then
      serviceConfigCmdBase=${G_myName%%SvcUse.sh}
      serviceConfigCmd="${serviceConfigCmdBase}Admin.sh"
  fi

  cmdLineBase=""

    case ${iv_serviceHost_setup} in
      "server"|"client"|"fullServer")
        cmdLineBase="${serviceConfigCmd}"
        ;;

      "noService")
        cmdLineBase="echo ${G_myName}: noService -- BinsPrep skipped"
        break
        ;;

      *)
       EH_problem "Unknown:  ${iv_serviceHost_setup}"
       return 1  
       ;;
    esac

  case ${1} in
    "fullUpdate"|"fullVerify"|"fullDelete")
               opDo ${cmdLineBase} -i $1
               ;;
    "showCmdLine")
              shift 
              echo "${cmdLineBase} $@"
               ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Platform and Platform Types Items Description
_CommentEnd_


function itemPre_serviceHost {
  iv_serviceHost_host=""

  iv_serviceHost_setup="noService"

  function iv_descriptionFunction {
cat << _EOF_
Undefined -- No iv_descriptionFunction for
_EOF_
}

}

function itemPost_serviceHost {
  EH_assert [[ "${iv_serviceHost_host}_" != "_" ]]      
}

function itemDefault_serviceHost {
  itemPre_serviceHost
  itemPost_serviceHost
}


function itemFamily_BACS {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}


function itemFamily_BISP {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="noService"

  itemPost_serviceHost
}


function itemFamily_BUE {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}


function item_bacs000Example {
  itemPre_serviceHost

  iv_serviceHost_host="bacs000Example"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
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
