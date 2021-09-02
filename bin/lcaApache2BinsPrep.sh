#!/bin/bash

IimBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part of [[http://www.by-star.net][ByStar]] -- Best Used With [[http://www.by-star.net/PLPC/180004][Blee]] or [[http://www.gnu.org/software/emacs/][Emacs]]
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaApache2BinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/bin/lcaApache2BinsPrep.sh
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
*      ################  CONTENTS-LIST ###############
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Module Description, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_
function vis_moduleDescription {  cat  << _EOF_
**      ====[[elisp:(org-cycle)][Fold]]==== /Module Desrciption/
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related-Xrefs:]* <<Xref-Here->>  -- External Documents 
Xref-Here-
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]
_CommentEnd_

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Components List
_CommentEnd_

#apt-cache search something | egrep '^something'

function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #  [[elisp:(lsip-local-run-command "apt-cache search something | egrep '^something'")][apt-cache search something | egrep '^something']]

    itemOrderedList=( 
	"apache2"
	apache2_utils
	#"apache2_common" 
	# "libapache2_mod_python"  # conflicts with uwsgi
	"libapache2_mod_php"
	"libapache2_mod_wsgi_py3"
	"libapache2_mod_proxy_uwsgi"
	"apache2_suexec_pristine"
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

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "apache2"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: apache2
_CommentEnd_
item_apache2 () { distFamilyGenerationHookRun binsPrep_apache2; }

binsPrep_apache2_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "apache2"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "apache2-utils"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: apache2-utils
_CommentEnd_
item_apache2_utils () { distFamilyGenerationHookRun binsPrep_apache2_utils; }

binsPrep_apache2_utils_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "apache2-utils"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "apache2-common"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg -- Obsoleted: apache2-common
_CommentEnd_
item_apache2_common () { distFamilyGenerationHookRun binsPrep_apache2_common; }

binsPrep_apache2_common_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "apache2-common"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libapache2-mod-python"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: libapache2-mod-python
_CommentEnd_
item_libapache2_mod_python () { distFamilyGenerationHookRun binsPrep_libapache2_mod_python; }

binsPrep_libapache2_mod_python_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libapache2-mod-python"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libapache2-mod-php"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: libapache2-mod-php [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_libapache2_mod_php () { distFamilyGenerationHookRun binsPrep_libapache2_mod_php; }

binsPrep_libapache2_mod_php_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libapache2-mod-php"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libapache2-mod-wsgi-py3"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: libapache2-mod-wsgi-py3 [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_libapache2_mod_wsgi_py3 () { distFamilyGenerationHookRun binsPrep_libapache2_mod_wsgi_py3; }

binsPrep_libapache2_mod_wsgi_py3_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libapache2-mod-wsgi-py3"; }

####+END:

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libapache2-mod-proxy-uwsgi"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: libapache2-mod-proxy-uwsgi [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_libapache2_mod_proxy_uwsgi () { distFamilyGenerationHookRun binsPrep_libapache2_mod_proxy_uwsgi; }

binsPrep_libapache2_mod_proxy_uwsgi_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libapache2-mod-proxy-uwsgi"; }

####+END:



####+BEGIN: bx:dblock:lsip:binsprep:apt :module "apache2-suexec-pristine"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: apache2-suexec-pristine
_CommentEnd_
item_apache2_suexec_pristine () { distFamilyGenerationHookRun binsPrep_apache2_suexec_pristine; }

binsPrep_apache2_suexec_pristine_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "apache2-suexec-pristine"; }

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

