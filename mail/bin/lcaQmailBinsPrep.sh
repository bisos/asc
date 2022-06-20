#!/bin/bash

IimBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part of [[http://www.by-star.net][ByStar]] -- Best Used With [[http://www.by-star.net/PLPC/180004][Blee]] or [[http://www.gnu.org/software/emacs/][Emacs]]
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaQmailBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/mail/bin/lcaQmailBinsPrep.sh
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
function vis_moduleDescription {
  cat  << _EOF_
**      ====[[elisp:(org-cycle)][Fold]]==== /Module Desrciption/
apt-get of qmail will fail unless 
hostname -f produces a real looking FQDN.
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related-Xrefs:]* <<Xref-Here->>  -- External Documents 
Xref-Here-
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxMailMta/fullUsagePanel-en.org::Xref-BxMailTransfer-SA][Panel Roadmap Documentation]]
_CommentEnd_

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Components List
_CommentEnd_

#  [[elisp:(lsip-local-run-command "apt-cache search qmail | egrep '^qmail'")][apt-cache search qmail | egrep '^qmail']]

#qmail - a secure, reliable, efficient, simple message transfer agent
#qmail-run - sets up qmail as mail-transfer-agent
#qmail-tools - collection of tools for qmail
#qmail-uids-gids - user ids and group ids for qmail


function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #  [[elisp:(lsip-local-run-command "apt-cache search something | egrep '^something'")][apt-cache search something | egrep '^something']]

    itemOrderedList=(
        "qmailPrep"
        "qmail_uids_gids"
        "qmail"
        # "qmail_run"
        # "qmail_tools"  # Obsoleted and not used
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
----- POST HOOK ADDITIONS -------
${G_myName} -i moduleDescription
${G_myName} -i prepareAndCleanUp
${G_myName} -f -i prepareAndCleanUp
_EOF_
}


function vis_prepareAndCleanUp {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Started using this in Ubuntu 13.10.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    if [[ "${G_forceMode}" != "force" ]] ; then
        if  mmaCompDebian_isInstalled qmail ; then
            ANT_raw "Qmail Is Already Installed -- Skipped -- use G_forceMode to force re-install"
            lpReturn 101
        else
            ANT_raw "Qmail Was Not Installed -- Will Install It."
        fi
    fi

    opDo lcaQmailHosts.sh -v -n showRun -s ${opRunHostName} -a servicesStop all

    opDo lcaQmailAdmin.sh -i showProcs

    opDoAfterPause echo "Kill Any Remaining Processes -- Before Continuing"

    opDo apt-get  -y purge qmail-run
    opDo apt-get  -y purge qmail-uids-gids
    opDo apt-get  -y purge qmail

    opDo  userdel alias
    opDo  userdel qmaild
    opDo  userdel qmaill
    opDo  userdel qmailp
    opDo  userdel qmailq
    opDo  userdel qmailr
    opDo  userdel qmails

    opDo  groupdel qmail
    opDo  groupdel nofiles

    opDo  FN_dirSafeKeep /var/lib/qmail
    opDo  FN_dirSafeKeep /etc/qmail

    opDo rm -r -f /var/lib/qmail
    opDo rm -r -f /etc/qmail

    opDo rm /etc/service/qmail-smtpd
    opDo rm /etc/service/qmail-send

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Custom-Pkg: qmailPrep
_CommentEnd_


item_qmailPrep () {
  distFamilyGenerationHookRun binsPrep_qmailPrep
}

binsPrep_qmailPrep_DEFAULT_DEFAULT () {
    mmaThisPkgName="qmailPrep"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="custom"  #  or "apt" no need for customInstallScript but with binsPrep_installPostHook
    binsPrep_installPostHook=""

    function customInstallScript {
        lpDo vis_prepareAndCleanUp
        lpReturn
    }
}

debPkgsBase="/bisos/var/debPkgs"

####+BEGIN: bx:dblock:lsip:binsprep:apt :module "qmail-uids-gids"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: qmail-uids-gids [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_qmail_uids_gids () { distFamilyGenerationHookRun binsPrep_qmail_uids_gids; }

binsPrep_qmail_uids_gids_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "qmail-uids-gids"; }

####+END:

binsPrep_qmail_uids_gids_DEBIAN_11 () {
    mmaThisPkgName="qmail_uids_gids"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="custom"  #  or "apt" no need for customInstallScript but with binsPrep_installPostHook
    binsPrep_installPostHook=""

    function customInstallScript {
        if [ ! -d ${debPkgsBase} ] ; then lpDo mkdir -p ${debPkgsBase}; fi;
        local debPkgFile=${debPkgsBase}/qmail-uids-gids.deb

        lpDo wget -O ${debPkgFile} http://ftp.us.debian.org/debian/pool/main/n/netqmail/qmail-uids-gids_1.06-6.2~deb10u1_all.deb

        lpDo sudo apt-get install -y ${debPkgFile}
    }
}


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "qmail"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Apt-Pkg       :: qmail [[elisp:(org-cycle)][| ]]
_CommentEnd_
item_qmail () { distFamilyGenerationHookRun binsPrep_qmail; }

binsPrep_qmail_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "qmail"; }

####+END:

binsPrep_qmail_DEBIAN_11 () {
    mmaThisPkgName="qmail"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="custom"  #  or "apt" no need for customInstallScript but with binsPrep_installPostHook
    binsPrep_installPostHook=""

    function customInstallScript {
	#lpDo sudo dpkg --purge --force-all qmail
        if [ ! -d ${debPkgsBase} ] ; then lpDo mkdir -p ${debPkgsBase}; fi;
        local debPkgFile=${debPkgsBase}/qmail.deb

        lpDo wget -O ${debPkgFile} http://ftp.us.debian.org/debian/pool/main/n/netqmail/qmail_1.06-6.2~deb10u1_amd64.deb

        lpDo sudo apt-get install -y ${debPkgFile}
    }
}


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "qmail-run"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: qmail-run
_CommentEnd_
item_qmail_run () { distFamilyGenerationHookRun binsPrep_qmail_run; }

binsPrep_qmail_run_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "qmail-run"; }

####+END:

binsPrep_qmail_run_DEBIAN_11 () {
    mmaThisPkgName="qmail_run"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="custom"  #  or "apt" no need for customInstallScript but with binsPrep_installPostHook
    binsPrep_installPostHook=""

    function customInstallScript {
        if [ ! -d ${debPkgsBase} ] ; then lpDo mkdir -p ${debPkgsBase}; fi;
        local debPkgFile=${debPkgsBase}/qmail-run.deb

        lpDo wget -O ${debPkgFile} http://ftp.us.debian.org/debian/pool/main/q/qmail-run/qmail-run_2.0.2+nmu1_all.deb

        lpDo sudo apt-get install -y ${debPkgFile}
    }
}


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "qmail-tools"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: qmail-tools
_CommentEnd_
item_qmail_tools () { distFamilyGenerationHookRun binsPrep_qmail_tools; }

binsPrep_qmail_tools_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "qmail-tools"; }

####+END:


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Custom-Pkg: qmail
_CommentEnd_


item_qmail () {
  distFamilyGenerationHookRun binsPrep_qmail
}

#binsPrep_qmail_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "qmail"; }
binsPrep_qmail_DEFAULT_DEFAULT () {
    mmaThisPkgName="qmail"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="apt" 
    binsPrep_installPreHook="qmail_installPre"
    binsPrep_installPostHook="qmail_installPost"
}

function qmail_installPre {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    opDo vis_prepareAndCleanUp
}

function qmail_installPost {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
qmail_installPost -- Completed.
_EOF_
    }
    opDo describeF
}





_CommentBegin_
*      ================ /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
