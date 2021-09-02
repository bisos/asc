#!/bin/bash

IimBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part of [[http://www.by-star.net][ByStar]] -- Best Used With [[http://www.by-star.net/PLPC/180004][Blee]] or [[http://www.gnu.org/software/emacs/][Emacs]]
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaSquirrelmailBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedSubjectBinsPrepDist.sh"
SEED="
* /[dblock]/--Seed/: /opt/public/osmt/bin/seedSubjectBinsPrepDist.sh
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedSubjectBinsPrepDist.sh -l $0 "$@" 
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
*      ################  CONTENTS-LIST ###############
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_
function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related-Xrefs:]* <<Xref-Here->>  -- External Documents 
Xref-Here-
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxWebMail/fullUsagePanel-en.org::Xref-BxWebSquirrelmail-SA][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Desrciption]*
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Components List
_CommentEnd_

#apt-cache search squirrelmail | egrep '^squirrelmail'

function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #  [[elisp:(lsip-local-run-command "apt-cache search squirrelmail | egrep '^squirrelmail'")][apt-cache search squirrelmail | egrep '^squirrelmail']]

    itemOrderedList=( 
        "squirrelmail" 
        "squirrelmail_compatibility" 
        "squirrelmail_decode" 
        "squirrelmail_locales"
        "squirrelmail_viewashtml"
    )

    # "php_pear"  # For mysql likely not needed

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

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "squirrelmail"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: squirrelmail
_CommentEnd_
item_squirrelmail () { distFamilyGenerationHookRun binsPrep_squirrelmail; }

binsPrep_squirrelmail_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "squirrelmail"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "squirrelmail-compatibility"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: squirrelmail-compatibility
_CommentEnd_
item_squirrelmail_compatibility () { distFamilyGenerationHookRun binsPrep_squirrelmail_compatibility; }

binsPrep_squirrelmail_compatibility_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "squirrelmail-compatibility"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "squirrelmail-decode"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: squirrelmail-decode
_CommentEnd_
item_squirrelmail_decode () { distFamilyGenerationHookRun binsPrep_squirrelmail_decode; }

binsPrep_squirrelmail_decode_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "squirrelmail-decode"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "squirrelmail-locales"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: squirrelmail-locales
_CommentEnd_
item_squirrelmail_locales () { distFamilyGenerationHookRun binsPrep_squirrelmail_locales; }

binsPrep_squirrelmail_locales_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "squirrelmail-locales"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "squirrelmail-viewashtml"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: squirrelmail-viewashtml
_CommentEnd_
item_squirrelmail_viewashtml () { distFamilyGenerationHookRun binsPrep_squirrelmail_viewashtml; }

binsPrep_squirrelmail_viewashtml_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "squirrelmail-viewashtml"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "php-pear"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: php-pear
_CommentEnd_
item_php_pear () { distFamilyGenerationHookRun binsPrep_php_pear; }

binsPrep_php_pear_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "php-pear"; }

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
