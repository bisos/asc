#!/bin/bash

IcmBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part of [[http://www.by-star.net][ByStar]] -- Best Used With [[http://www.by-star.net/PLPC/180004][Blee]] or [[http://www.gnu.org/software/emacs/][Emacs]]
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


####+BEGIN: bx:bsip:bash:seed-spec :types "seedSubjectBinsPrepDist.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/lcaMailToolsBinsPrep.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh -l $0 "$@" 
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
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  [Notes]       :: *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  [Xrefs]       :: *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
Xref-Here-
**  [[elisp:(org-cycle)][| ]]  Subject      :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  [Info]        :: *[Module Description:]* [[elisp:(org-cycle)][| ]]

_EOF_
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [Pkgs-List]   :: Components List [[elisp:(org-cycle)][| ]]
_CommentEnd_

#apt-cache search something | egrep '^something'

function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #  [[elisp:(lsip-local-run-command "apt-cache search something | egrep '^something'")][apt-cache search something | egrep '^something']]

    itemOrderedList=( 
        "swaks"            # submit SMTP messages -- Obsoletes ssmtp
        "offlineimap"      # imap synching -- Obsoletes fetchmail
        "notmuch"          # email searches
        "balsa"            # MUA
        "evolution"        # MUA
        "claws_mail"       # MUA
    )

    itemOptionalOrderedList=()
    itemLaterOrderedList=()
}

distFamilyGenerationHookRun pkgsList


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [ExamplesExt] :: Module Specific Additions -- examplesHook [[elisp:(org-cycle)][| ]]
_CommentEnd_


function examplesHookPost {
  cat  << _EOF_
----- ADDITIONS -------
${G_myName} -i moduleDescription
_EOF_
}

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "swaks"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: swaks [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_swaks () { distFamilyGenerationHookRun binsPrep_swaks; }

binsPrep_swaks_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "swaks"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "offlineimap"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: offlineimap [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_offlineimap () { distFamilyGenerationHookRun binsPrep_offlineimap; }

binsPrep_offlineimap_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "offlineimap"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "notmuch"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: notmuch [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_notmuch () { distFamilyGenerationHookRun binsPrep_notmuch; }

binsPrep_notmuch_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "notmuch"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "alot"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: alot [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_alot () { distFamilyGenerationHookRun binsPrep_alot; }

binsPrep_alot_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "alot"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "balsa"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: balsa [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_balsa () { distFamilyGenerationHookRun binsPrep_balsa; }

binsPrep_balsa_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "balsa"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "evolution"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: evolution [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_evolution () { distFamilyGenerationHookRun binsPrep_evolution; }

binsPrep_evolution_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "evolution"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "claws-mail"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: claws-mail [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_claws_mail () { distFamilyGenerationHookRun binsPrep_claws_mail; }

binsPrep_claws_mail_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "claws-mail"; }

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
