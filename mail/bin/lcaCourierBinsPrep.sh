#!/bin/bash

IimBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part of [[http://www.by-star.net][ByStar]] -- Best Used With [[http://www.by-star.net/PLPC/180004][Blee]] or [[http://www.gnu.org/software/emacs/][Emacs]]
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaCourierBinsPrep.sh,v 1.2 2016-08-14 01:43:31 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedSubjectBinsPrepDist.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/mail/bin/lcaCourierBinsPrep.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh -l $0 "$@"
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
Xref-Here-
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*

_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Components List
_CommentEnd_

#apt-cache search courier-imap | egrep '^courier-imap'

function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #  [[elisp:(lsip-local-run-command "apt-cache search courier-imap | egrep '^courier-imap'")][apt-cache search courier-imap | egrep '^courier-imap']]

    itemOrderedList=(
	"gamin" 
	"courier_imap" 
	#"courier_imap_ssl"
    )

    itemOptionalOrderedList=()
    itemLaterOrderedList=()
}

distFamilyGenerationHookRun pkgsList


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Specific Additions -- examplesHook
_CommentEnd_


function examplesHookPost {
  cat  << _EOF_
----- ADDITIONS -------
${G_myName} -i moduleDescription
_EOF_
}

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "courier-imap"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Apt-Pkg       :: courier-imap [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_courier_imap () { distFamilyGenerationHookRun binsPrep_courier_imap; }

binsPrep_courier_imap_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "courier-imap"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "courier-imap-ssl"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Apt-Pkg       :: courier-imap-ssl [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_courier_imap_ssl () { distFamilyGenerationHookRun binsPrep_courier_imap_ssl; }

binsPrep_courier_imap_ssl_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "courier-imap-ssl"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "fam"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Apt-Pkg       :: fam [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_fam () { distFamilyGenerationHookRun binsPrep_fam; }

binsPrep_fam_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "fam"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "gamin"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Apt-Pkg       :: gamin [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_gamin () { distFamilyGenerationHookRun binsPrep_gamin; }

binsPrep_gamin_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "gamin"; }

####+END:




_CommentBegin_
*      ================ /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
