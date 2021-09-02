#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaPlone3Config.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
# *CopyLeft*
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/plone3/bin/lcaPlone3Config.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(org-cycle)][Fold]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(delete-other-windows)][(1)]]  | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] 
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_

_CommentBegin_
*      ================
*      ################ CONTENTS-LIST ################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*

_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/distHook.libSh

# ./lcaPlone3.libSh
. ${opBinBase}/lcaPlone3.libSh

. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaBinsPrepLib.sh

# ./bystarHereAcct.libSh
. ${opBinBase}/bystarHereAcct.libSh

. ${opBinBase}/lpReRunAs.libSh


# PRE parameters

baseDir=""

function G_postParamHook {
     return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Chapter Title" )
$( examplesSeperatorSection "Section Title" )
--- Config File MANIPULATORS  ---
${G_myName} ${extraInfo} -i bystarBldoutCfgLocate
${G_myName} ${extraInfo} -i bystarBldoutCfgDiff
${G_myName} ${extraInfo} -i bystarBldoutCfgVerify
${G_myName} ${extraInfo} -i bystarBldoutCfgUpdate
--- Build / Process ---
${G_myName} ${extraInfo} -i runBldout
${G_myName} ${extraInfo} -i plone3BaseMoreReadPerms
--- Container Plone3 Parameters ---
${G_myName} ${extraInfo} -i hereContainerPlone3ParamCapture
${G_myName} -i hereContainerPlone3UserGet
${G_myName} -i hereContainerPlone3PasswdGet
--- FULL SERVICE ---
${G_myName} ${extraInfo} -i fullUpdate  # plone3BaseMoreReadPerms + bystarBldoutCfgUpdate + hereContainerPlone3ParamCapture +  runBldout
--- Post Config Verifications ---
pftp -n localhost 8021
http://127.0.0.1:8080
http://127.0.0.1:8081
_EOF_
}

noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_


function vis_bystarBldoutCfgLocate {
    EH_assert [[ $# -eq 0 ]]

    typeset fileName=""

    if [ ! -f ${lcaPlone3BuildoutCfgFile} ] ; then 
	EH_problem "Missing lcaPlone3BuildoutCfgFile=${lcaPlone3BuildoutCfgFile}"
	return 101
    fi

    if [ ! -f ${lcaPlone3BuildoutVersionsFile} ] ; then 
	EH_problem "Missing lcaPlone3BuildoutVersionsFile=${lcaPlone3BuildoutVersionsFile}"
	return 101
    fi

    if grep "3.3.4" ${lcaPlone3BuildoutVersionsFile} > /dev/null ; then
	fileName=/opt/public/osmt/sysConfigInput/plone3/buildout.cfg.3.3.4_unified
    elif grep "3.3.5" ${lcaPlone3BuildoutVersionsFile} > /dev/null ; then
	fileName=/opt/public/osmt/sysConfigInput/plone3/buildout.cfg.3.3.5_unified
    elif grep "3.3.6" ${lcaPlone3BuildoutVersionsFile} > /dev/null ; then
	fileName=/opt/public/osmt/sysConfigInput/plone3/buildout.cfg.3.3.6_unified
    else
	EH_problem "UnRecognized/UnSupported Version"
	return 100
    fi


    # opDo eval grep "/release/3" ${lcaPlone3BuildoutCfgFile} \> /tmp/$$.grep

    # if grep "3.3.4" /tmp/$$.grep > /dev/null ; then
    # 	fileName=/opt/public/osmt/sysConfigInput/plone3/buildout.cfg.3.3.4_unified
    # elif grep "3.3.5" /tmp/$$.grep > /dev/null ; then
    # 	fileName=/opt/public/osmt/sysConfigInput/plone3/buildout.cfg.3.3.5_unified
    # else
    # 	EH_problem "UnRecognized/UnSupported Version"
    # 	return 100
    # fi

    if [[ ! -f ${fileName} ]] ; then
	EH_problem "Missing File: bystarBldoutCfgFile=${fileName}"
	return 100
    fi

    echo ${fileName}
}

function vis_bystarBldoutCfgDiff {
    EH_assert [[ $# -eq 0 ]]

    bystarBldoutCfgFile=$( vis_bystarBldoutCfgLocate 2> /dev/null )

    EH_assert [[ "${bystarBldoutCfgFile}_" != "_" ]]

    opDo diff ${lcaPlone3BuildoutCfgFile} ${bystarBldoutCfgFile}
}

function vis_bystarBldoutCfgVerify {
    EH_assert [[ $# -eq 0 ]]

    bystarBldoutCfgFile=$( vis_bystarBldoutCfgLocate 2> /dev/null )

    EH_assert [[ "${bystarBldoutCfgFile}_" != "_" ]]

   if (opDo cmp ${lcaPlone3BuildoutCfgFile} ${bystarBldoutCfgFile}) ; then
       ANT_raw "VERIFIED: Are identical"
       return 0
   else
       ANT_raw "INCONSISTENT: Are Different"
       return 100
   fi
}

function vis_bystarBldoutCfgUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    bystarBldoutCfgFile=$( vis_bystarBldoutCfgLocate )

    EH_assert [[ "${bystarBldoutCfgFile}_" != "_" ]]

    FN_fileSafeCopy ${lcaPlone3BuildoutCfgFile} ${lcaPlone3BuildoutCfgFile}.${dateTag}

    opDo cp ${bystarBldoutCfgFile} ${lcaPlone3BuildoutCfgFile}

    opDo ls -l ${lcaPlone3BuildoutCfgFile}
}


function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    opDoRet vis_plone3BaseMoreReadPerms

    opDoRet vis_bystarBldoutCfgUpdate

    opDoRet vis_hereContainerPlone3ParamCapture

    opDoRet vis_runBldout
}


function vis_runBldout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    #opDo python2.4 bootstrap.py
    #./bin/buildout buildout:log-level=50 instance:debug-mode=on
    #opDo ${lcaPlone3BuildoutProg}

    inBaseDirDo ${lcaPlone3BaseDir}  ${lcaPlone3BuildoutProg}
}


function vis_plone3BaseMoreReadPerms {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    inBaseDirDo ${lcaPlone3BaseDir}  chmod go+r \*

    # NOTYET, this may be excessive
    inBaseDirDo ${lcaPlone3BaseDir}  chmod 777 var
}


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ================ /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:

