#!/bin/bash

IimBriefDescription="Functionally Grouped Components Software: Mail Access"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: fgcMailAccessSw.sh,v 1.2 2016-06-29 23:42:13 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/mail/bin/fgcMailAccessSw.sh
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
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Module Description, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_

function vis_describe {  cat  << _EOF_
This is the top-level PkgRePub Publisher.

It is to be run each time we transition to a new PlatformDistro. 
It is preGenesis. It is not part of BinsPrep.sh -- BinsPrep assumes that this has happened.

It simply calls each of the specified PkgRePubs.
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related-Xrefs:]* <<Xref-Here->>  -- External Documents 
Xref-Here-
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxMailMta/fullUsagePanel-en.org::Xref-BxMailTransfer-SA][Panel Roadmap Documentation]]
_CommentEnd_

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
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
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
-----  EXAMPLES -------
${G_myName} ${extraInfo} -i  itemsOrderedList
${G_myName} ${extraInfo} -i  itemsOrderedListApply -- -i showMe
${G_myName} ${extraInfo} -i  fullVerify
${G_myName} ${extraInfo} -i  fullUpdate
_EOF_
}

noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Items List
_CommentEnd_

# ls | grep -i RePub.sh | grep -v aggregatorPkgRePub.sh


itemsOrderedList=( 
    lcaCourierBinsPrep.sh
)


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
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

function vis_fullUpdate {
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


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ######[[elisp:(org-cycle)][Fold]]###### /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:

