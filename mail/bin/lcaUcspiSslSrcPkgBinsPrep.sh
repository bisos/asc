#!/bin/bash

IimBriefDescription="MODULE BinsPrep based on apt based seedSubjectBinsPrepDist.sh"

ORIGIN="
* Revision And Libre-Halaal CopyLeft
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaUcspiSslSrcPkgBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/mail/bin/lcaUcspiSslSrcPkgBinsPrep.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh -l $0 "$@"
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Cycle Vis]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(delete-other-windows)][1 Win]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]]

####+END:
_CommentEnd_



_CommentBegin_
*      ================
*      ################ CONTENTS-LIST #################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Module Description, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_
function vis_describe {  cat  << _EOF_

https://www.fehcom.de/qmail/smtptls.html


edit conf-tcpbin to /usr/bin from /usr/local/bin

Run openssl dhparam -out dhparam 1024

You then need to edit conf-dhparam

http://www.superscript.com/ucspi-ssl/install.html
http://www.suspectclass.com/sgifford/ucspi-tls/ucspi-tls-qmail-howto.html
http://www.suspectclass.com/sgifford/ucspi-tls/

---
This script is not to be run as part of the 
genesis process. It produces the binary tar pkg that 
is used in the genesis process.

Scope of this script is:
   - Obtain a source package
   - Build the source package
   - Generate a tar Binary package
   - Publish the Binary package

Outside of the scope of this script is:
   - Obtaining the binary package
   - Installing the binary package
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

#apt-cache search something | egrep '^something'

function pkgsList_DEFAULT_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    #sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext   libz-dev libssl-dev

    itemOrderedList=( 
        "asciidoc"
        "openssl" 
        "libssh_dev" 
        "libperl_dev" 
        "ucspiSslSrcPkg"              # - Custom Package
    )
}

distFamilyGenerationHookRun pkgsList


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Specific Additions -- examplesHookPost
_CommentEnd_


function examplesHookPost {
  cat  << _EOF_
----- ADDITIONS -------
${G_myName} -i srcPkgRePubAgent
${G_myName} -i srcPkgObtain
${G_myName} -i srcPkgPrepare
${G_myName} -i srcPkgBuild
${G_myName} -i srcPkgResultsInstall
${G_myName} -i srcPkgFullUpdate
${G_myName} -i srcPkgClean
${G_myName} -i srcPkgFullClean
_EOF_
}


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "asciidoc"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Apt-Pkg: asciidoc
_CommentEnd_
item_asciidoc () { distFamilyGenerationHookRun binsPrep_asciidoc; }

binsPrep_asciidoc_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "asciidoc"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "openssl"
_CommentBegin_
*      ================ Apt-Pkg: openssl
_CommentEnd_
item_openssl () { distFamilyGenerationHookRun binsPrep_openssl; }

binsPrep_openssl_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "openssl"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libssh-dev"
_CommentBegin_
*      ================ Apt-Pkg: libssh-dev
_CommentEnd_
item_libssh_dev () { distFamilyGenerationHookRun binsPrep_libssh_dev; }

binsPrep_libssh_dev_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libssh-dev"; }

####+END:


####+BEGIN: bx:dblock:lsip:binsprep:apt :module "libperl-dev"
_CommentBegin_
*      ================ Apt-Pkg: libperl-dev
_CommentEnd_
item_libperl_dev () { distFamilyGenerationHookRun binsPrep_libperl_dev; }

binsPrep_libperl_dev_DEFAULT_DEFAULT () { binsPrepAptPkgNameSet "libperl-dev"; }

####+END:


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Custom-Pkg: ucspiSslSrcPkg
_CommentEnd_


item_ucspiSslSrcPkg () {
  distFamilyGenerationHookRun binsPrep_ucspiSslSrcPkg
}

binsPrep_ucspiSslSrcPkg_DEFAULT_DEFAULT () {
    mmaThisPkgName="ucspiSslSrcPkg"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="custom"

    function customInstallScript {
        opDo vis_srcPkgFullUpdate
    }
}


buildBaseDirRoot="/var/osmt"
buildBaseDirName="ucspiSsl"
buildBaseDir="${buildBaseDirRoot}/${buildBaseDirName}"

pkgRePubAgent="lcaUcspiSslSrcPkgRePub.sh"

function vis_srcPkgRePubAgent {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    echo ${pkgRePubAgent}
}


function vis_srcPkgObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    opDo $( vis_srcPkgRePubAgent ) -h -v -n showRun -i prpListBxObtain
}

function vis_srcPkgPrepare {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    opDo mkdir -p ${buildBaseDir}

    typeset basePkgName=$( $( vis_srcPkgRePubAgent )  -i prpName basePkg )
    typeset patch1Name=$( $( vis_srcPkgRePubAgent )  -i prpName patch1 )

    typeset basePkgLocalPath=$( $( vis_srcPkgRePubAgent )  -i prpLocalPath basePkg )
    typeset patch1LocalPath=$( $( vis_srcPkgRePubAgent )  -i prpLocalPath patch1 )

    if ! FN_fileDoesExist ${basePkgLocalPath} ; then
        EH_problem "Missing ${basePkgLocalPath} -- Perhaps srcPkgObtain Failed."
        lpReturn 101
    fi

    if ! FN_fileDoesExist ${patch1LocalPath} ; then
        EH_problem "Missing ${patch1LocalPath} -- Perhaps srcPkgObtain Failed."
        lpReturn 101
    fi

    inBaseDirDo ${buildBaseDir} eval gunzip -cd ${basePkgLocalPath} '|' tar xf -

    #typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.70"
    typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.73"

    if [ ! -d ${basePkgSrcDir} ] ; then
        EH_problem "Missing ${basePkgSrcDir}"
        lpReturn 101
    fi

    inBaseDirDo ${basePkgSrcDir} eval patch -p1 '<' ${patch1LocalPath}
}

function vis_srcPkgBuild {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.70"
    typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.73"

    if [ ! -d ${basePkgSrcDir} ] ; then
        EH_problem "Missing ${basePkgSrcDir}"
        lpReturn 101
    fi

    # NOTYET
    # - edit conf-tcpbin to /usr/bin from /usr/local/bin
    # - Run openssl dhparam -out dhparam 1024
    # - You then need to edit conf-dhparam
    #
    inBaseDirDo ${basePkgSrcDir} package/compile
    #inBaseDirDo ${basePkgSrcDir} package/compile sslperl

    inBaseDirDo ${basePkgSrcDir} package/compile it.command  # Puts the results in command directory (need not be root)
    #inBaseDirDo ${basePkgSrcDir} package/compile sslperl.command

    # Run Some Tests
    #inBaseDirDo ${basePkgSrcDir} package/compile it.rts
    #inBaseDirDo ${basePkgSrcDir} package/compile sslperl.rts
}

function vis_srcPkgResultsInstall {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
See
http://www.superscript.com/ucspi-ssl/install.html#completing
for details.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    #typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.70"
    typeset basePkgSrcDir="${buildBaseDir}/host/superscript.com/net/ucspi-ssl-0.73"

    if [ ! -d ${basePkgSrcDir} ] ; then
        EH_problem "Missing ${basePkgSrcDir}"
        lpReturn 101
    fi

    inBaseDirDo ${basePkgSrcDir} package/install
    #inBaseDirDo ${basePkgSrcDir} package/install sslperl

    inBaseDirDo ${basePkgSrcDir} package/docs
}


function vis_srcPkgFullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    if [[ "${G_forceMode}" != "force" ]] ; then
        if  [ -f "/usr/local/bin/sslserver" ] ; then
            ANT_raw "Module Is Already Installed -- Skipped -- use G_forceMode to force re-install"
            lpReturn 0
        else
            ANT_raw "Module Was Not Installed -- Will Install It."
        fi
    fi

    opDo vis_srcPkgObtain
    opDo vis_srcPkgPrepare
    opDo vis_srcPkgBuild
    opDo vis_srcPkgResultsInstall
}


function vis_srcPkgClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}


function vis_srcPkgFullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
