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


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/bystarMailFolderManage.sh 
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
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info]* Status/Maintenance -- General TODO List
_CommentEnd_

function vis_describe {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Description:]*
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxsoMailAddr/fullUsagePanel-en.org::Xref-BxsoMailAddr][Panel Roadmap Documentation]]
HOWTO
=====

   - Adding New Folders
      1) Edit bystarMail.libSh -- Make sure to update List
      2) bystarMailFolderManage.sh -p ri=root:passive -h -v -n showRun -p bystarUid=sa-20000 -i maildirCreateBueFull
      3) lcaCourierImapAdmin.sh -v -n showRun -p Maildir=/acct/subs/banan/1/mohsen/ByStarMailDir -i fullUpdate

_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_



. ${opBinBase}/lpErrno.libSh

. ${opBinBase}/bystarHook.libSh

# bystarMail.libSh 
. ${opBinBase}/bystarMail.libSh

. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

. ${opBinBase}/bystarHook.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/bisosCurrents_lib.sh

# PRE parameters
typeset -t acctTypePrefix=""
typeset -t bystarUid="INVALID"

function G_postParamHook {
    bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
    lpCurrentsGet
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examplesToBecome {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "BASIC" )
$( examplesSeperatorChapter "Chapter Title" )
$( examplesSeperatorSection "Section Title" )
${G_myName} ${extraInfo} -i doTheWork
_EOF_
}

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
# NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  typeset thisOneSaNu="sa-20000"
  #typeset thisOneSaNu=${oneBystarAcct}
  #typeset thisOneSaNu=${currentBystarUid}
  typeset oneSubject="qmailAddr_test"
  typeset runInfo="-p ri=root:passive"

  typeset oneMailDirBase=$( FN_absolutePathGet ~sa-20000 )/${bystarAcctMailDirBase}


#${doLibExamples}
 cat  << _EOF_
EXAMPLES:
--- INFORMATION / Status ---
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -i  fullReport 2> /dev/null
${G_myName} ${runInfo} ${extraInfo} -i  bystarMboxesListBue     # Blee User Environment
${G_myName} ${runInfo} ${extraInfo} -i  bystarMboxesListWue     # WebBrowser User Environment
--- Common Folders Creation ---
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=school -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=desk -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=main -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=personal -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=fax -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=vendor -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=job -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=forms -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=null -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=indirect -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=callerid -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=web -i maildirCreate
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=lists/misc -i maildirCreate
--- Folders Manipulation (maildirmake) ---
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -i maildirCreateBueFull  # Blee User Environment
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -i maildirCreateWueFull  # WebBrowser User Environment
${G_myName} ${runInfo} ${extraInfo} -i maildirMake mailPath Owner
${G_myName} ${runInfo} ${extraInfo} -i maildirMake ${oneMailDirBase} ${thisOneSaNu}
${G_myName} ${runInfo} ${extraInfo} -i maildirMakeIn ${oneMailDirBase} ${thisOneSaNu}
${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${thisOneSaNu} -p folder=school -i maildirSafeKeep
--- IMAP Folders Manipulation ---
lcaCourierImapAdmin.sh -v -n showRun -p Maildir=${oneMailDirBase} -i fullUpdate
lcaCourierImapAdmin.sh -v -n showRun -p Maildir=${oneMailDirBase} -i updateSubscribedFolders
lcaCourierImapAdmin.sh -v -n showRun -i isMaildir ${oneMailDirBase}
lcaCourierImapAdmin.sh -v -n showRun -i findMaildirs ${oneMailDirBase}
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_


function vis_fullReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep

    opDoRet bystarAcctAnalyze ${bystarUid}
    
    opDoExit cd ${bystarUidHome}/${bystarAcctMailDirBase}

    opDo ls -d * | egrep -v "courierimapuiddb|cur|new|tmp|courierimapkeywords|courierimapsubscribed"
    return
}

function vis_bystarMboxesListBue {
  EH_assert [[ $# -eq 0 ]]
 
 echo ${bystarMboxesListBue}
}


function vis_bystarMboxesListWue {
  EH_assert [[ $# -eq 0 ]]
 
 echo ${bystarMboxesListWue}
}



function vis_maildirCreateWueFull {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep

    for thisOne in ${bystarMboxesListWue} ; do
        opDo ${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${bystarUid} -p folder=${thisOne} -i maildirCreate
    done

}

function vis_maildirCreateBueFull {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep

    for thisOne in ${bystarMboxesListBue} ; do
        opDo ${G_myName} ${runInfo} ${extraInfo} -p bystarUid=${bystarUid} -p folder=${thisOne} -i maildirCreate
    done
}


function vis_maildirCreate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    EH_assert [[ "${folder}_" != "INVALID_" ]]

    maildirPath=${bystarUidHome}/${bystarAcctMailDirBase}/${folder}

    opDo vis_maildirMake ${maildirPath}  ${bystarUid}
}

function vis_maildirSafeKeep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    EH_assert [[ "${folder}_" != "INVALID_" ]]

    maildirPath=${bystarUidHome}/${bystarAcctMailDirBase}/${folder}

    opDoExit mkdir -p ${bystarUidHome}/SafeKeep.Maildir

    opDoExit /bin/mv ${maildirPath} ${bystarUidHome}/SafeKeep.Maildir/${folder}

    #FN_dirSafeKeep ${maildirPath}
}


function vis_maildirMake {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 2 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    maildirPath=$1
    maildirUid=$2

    i=${maildirPath}
    typeset dirsPart=`FN_dirsPart ${i}`
    typeset nonDirsPart=`FN_nonDirsPart ${i}`
    if [[ "${dirsPart}_" != "_" ]] ; then 
        if [[ ! -d ${dirsPart} ]] ; then
            FN_dirCreatePathIfNotThere ${acctQmailBaseDir}/${dirsPart}
            opDoRet chmod 700 ${acctQmailBaseDir}/${dirsPart}
            opDoRet chown ${maildirUid} ${acctQmailBaseDir}/${dirsPart}
        fi
    fi

    if [[ ! -d ${i} ]] ; then
        opDoComplain ${qmailMaildirmakeProgram} ${i}
        opDoRet chown -R ${maildirUid} ${i}
    else
        ANT_raw "Directory ${maildirPath} exists, Creation Skipped"
    fi
}


function vis_maildirMakeIn {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    EH_assert [[ $# -eq 2 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    maildirPath=$1
    maildirUid=$2

    if [[ ! -d ${maildirPath} ]] ; then
        ANT_raw "Directory ${maildirPath} exists -- Use ${qmailMaildirmakeProgram} Instead"
        return 101
    fi

    FN_dirCreatePathIfNotThere ${maildirPath}/cur
    opDoRet chmod 700 ${maildirPath}/cur
    opDoRet chown ${maildirUid} ${maildirPath}/cur

    FN_dirCreatePathIfNotThere ${maildirPath}/new
    opDoRet chmod 700 ${maildirPath}/new
    opDoRet chown ${maildirUid} ${maildirPath}/new

    FN_dirCreatePathIfNotThere ${maildirPath}/tmp
    opDoRet chmod 700 ${maildirPath}/tmp
    opDoRet chown ${maildirUid} ${maildirPath}/tmp
}



function vis_fullSupplements {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep
    return
}

function vis_fullEssentials {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    bystarBagpLoad

    opDoComplain vis_generateMailNspFile

    opDoComplain vis_virDomAdd
    opDoComplain vis_addrUpdate

    if bystarIsControlledAcct ${bystarUid} ; then
        opDo ${G_myName} ${extraInfo} -p bystarUid=${cp_MasterAcct} -i masterAcctUpdate ${bystarUid}
    fi
}

function vis_fullAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    bystarBagpLoad

    opDoComplain vis_dnsUpdate

    opDoComplain vis_fullEssentials

    opDoComplain vis_fullSupplements
}



function vis_addrUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert bystarUidCentralPrep

  bystarAcctAnalyze ${bystarUid}

    if [[ "${G_forceMode}_" == "force_" ]] ; then
      #opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" -s all -a addrUpdate
      opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}"  -s qmailAddrsList_ordered -a addrUpdate
    else
      #opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" -s all -a addrUpdate
      opDoComplain mmaQmailAddrs.sh  -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}"  -s qmailAddrsList_ordered -a addrUpdate
    fi
}


function vis_addrDelete {
  opDoComplain byname_acctInfoGet ${SubsSelector} ${LastName} ${FirstName} ${acctTypePrefix}

 opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${acctTypePrefix}-${byname_acct_uid}" -s all -a addrDelete
}

function vis_addrSummary {
  EH_assert [[ $# -eq 0 ]]
  EH_assert bystarUidCentralPrep

  bystarAcctAnalyze ${bystarUid}

  opDoRet mmaQmailAddrs.sh -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -s all -a summary
}

function vis_acctAdd {
  #set -x


  # NOTYET, verify that  ${SubsSelector} ${LastName} ${FirstName}
  # are all set
  #

  opDoComplain vis_virDomAdd 
  opDoComplain vis_updateOverWriteQmailFiles

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
