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
*  /This File/ :: /bisos/asc/mail/bin/bystarMailAddrManage.sh 
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

BUGS
====
 BUG: addrFqmaList stops after service (alphabetically)

HOWTO:
======

  1) Make sure that all folders have been created with bystarMailFolderManage.sh
       See HowTo in bystarMailFolderManage.sh for details.
  2) edit ~sa-20000/NSP/mailAddrItems.nsp
         Conventions
         - For Each MailBox create a fdmb-mailBoxName
         - Use Dashes Where . goes to indicate hierarchy
 3) bystarMailAddrManage.sh -h -v -n showRun -p bystarUid=sa-20000 -f -i addrUpdate
 4) bystarMailAddrManage.sh -h -v -n showRun -p bystarUid=sa-20000 -p msgFunc=testEmailStdout -i injectMsgTo AddrList

TODO:
=====

 - Envelope and from line -p env= -f from= to injectMsgTo
 - Add BadBad addr for backscatter test
 
_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/lpErrno.libSh

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/bystarHook.libSh

# bystarMail.libSh 
. ${opBinBase}/bystarMail.libSh

# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh


. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

. ${opBinBase}/bystarInfoBase.libSh


# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

. ${opBinBase}/bystarHook.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh

# ./bystarHereAcct.libSh 
. ${opBinBase}/bystarHereAcct.libSh

. ${opBinBase}/bystarCentralAcct.libSh

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
$( examplesSeperatorTopLabel "${G_myName}" )
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
  typeset oneFdmbSubject="qmailAddr_fdmb_test"  # Final Delivery MailBox
  typeset runInfo="-p ri=root:passive"

  #typeset oneFqmaAddr=$( echo $( ${G_myName} -p bystarUid=${thisOneSaNu} -i addrFqmaList 2> /dev/null | grep test ) )
  typeset oneFqmaAddr=$( echo $( ${G_myName} -p bystarUid=${thisOneSaNu} -i fqmaListFromAcct 2> /dev/null | grep test ) )

  typeset oneMailDirBase=$( FN_absolutePathGet ~sa-20000 )/${bystarAcctMailDirBase}


#${doLibExamples}
 cat  << _EOF_
EXAMPLES:
--- INFORMATION / Status ---
egrep ^. ~${thisOneSaNu}/.qmail-*
${G_myName}  ${runInfo} -p bystarUid=${thisOneSaNu} -i dotQmailsFromAcct
${G_myName}  ${runInfo} -p bystarUid=${thisOneSaNu} -i dotQmailsFromAcct | grep main
${G_myName}  ${runInfo} -p bystarUid=${thisOneSaNu} -i localPartsListFromAcct
${G_myName}  ${runInfo} -p bystarUid=${thisOneSaNu} -i fqmaListFromAcct
${G_myName}  ${runInfo} -p bystarUid=${thisOneSaNu} -i fdmbListFromAcct
${G_myName} -p bystarUid=${thisOneSaNu} -i addrSummaryFromNsp
mmaQmailAddrs.sh -h -v -n showRun -p acctName=${thisOneSaNu} -i addrsFqmaShow
${G_myName} -p bystarUid=${thisOneSaNu} -i addrFqmaList
${G_myName} -p bystarUid=${thisOneSaNu} -i addrFqmaList | grep -v fdmb-
mmaQmailAddrs.sh  -p domainPart=${byname_acct_baseDomain} -p domainType=virDomain   -p addrItemsFile="${byname_acct_NSPdir}/mailAddrItems.nsp" -p acctName="${byname_acct_acctTypePrefix}-${byname_acct_uid}" -s $subject -a addrFqmaShow
--- MAINTENANCE ACTIONS ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i addrUpdate all
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -f -i addrUpdate all
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i addrUpdate ${oneSubject} 
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -f -i addrUpdate ${oneSubject} 
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i addrUpdate ${oneFdmbSubject} 
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -f -i addrUpdate ${oneFdmbSubject} 
${G_myName} -p bystarUid=${thisOneSaNu} -i  addrDelete
--- TEST Addrs ALL ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p msgBodyFunc=testEmailStdout -i injectMsgToAddrs ${oneFqmaAddr}
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p msgBodyFunc=spamGtubeEmailStdout -i injectSpamMsgToAddrs ${oneFqmaAddr}
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p msgBodyFunc=testEmailStdout -i injectMsgToAddrs all
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -p msgBodyFunc=spamGtubeEmailStdout -i injectSpamMsgToAddrs all
--- Ephemeral Addrs  ---
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraGetCurrentLocalPart e
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraGetCurrentLocalPart envelope
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraGetCurrentFqma e
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraGetCurrentFqma envelope
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraAdjust e201008
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraAdjust envelope201008
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraUpdateAddrs e envelope
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i ephemeraUpdateAddrs all
--- dotQmail Manipulation  ---
${G_myName} ${extraInfo} ${runInfo} -p bystarUid=${thisOneSaNu} -i vcardsStdout all
${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i vcardsStdout office
--- dotQmail Manipulation  ---
echo "./ByStarMailDir/ephemera/" | ${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -i dotQmailFromStdin e201008
echo "./ByStarMailDir/ephemera/" | ${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -f -i dotQmailFromStdin e201008
echo "| forward fdmb-ephemera-despam@mohsen.1.banan.byname.net" | ${G_myName} ${extraInfo} -p bystarUid=${thisOneSaNu} -f -i dotQmailFromStdin e201008
_EOF_
}


noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Full Actions
_CommentEnd_


function vis_fullReport {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep
    
    return
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== BxSO InfoBase (mailAddrItems.nsp) Actions and Reports
_CommentEnd_


function vis_addrInfoBase {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
 
    echo "${cp_acctUidHome}/NSP/mailAddrItems.nsp"
}


function vis_addrUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep

    bystarAcctAnalyze ${bystarUid}

    typeset subjsArgs=""

    if [[ "$1_" = "all_" ]] ; then
        subjsArgs="-s qmailAddrsList_ordered"
    else
        argv="$@"
        typeset thisOne=""
        for thisOne in ${argv} ; do
            subjsArgs="-s ${thisOne} ${subjsArgs}"
        done
    fi

    if [[ "${G_forceMode}_" == "force_" ]] ; then
        #opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" -s all -a addrUpdate
        opDoComplain mmaQmailAddrs.sh -f -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" ${subjsArgs} -a addrUpdate
    else
        #opDoComplain mmaQmailAddrs.sh -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" -s all -a addrUpdate
        opDoComplain mmaQmailAddrs.sh  -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" ${subjsArgs} -a addrUpdate
    fi
}


function vis_addrUpdateOrig {
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

function vis_addrSummaryFromNsp {
  EH_assert [[ $# -eq 0 ]]
  EH_assert bystarUidCentralPrep

  bystarAcctAnalyze ${bystarUid}

  opDoRet mmaQmailAddrs.sh -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -s all -a summary
}


# Use vis_addrFqmaList
# vis_addrFqmaShow produces separate lines vis_addrFqmaList produces one line

function vis_addrFqmaShow {
  EH_assert [[ $# -eq 0 ]]
  EH_assert bystarUidCentralPrep

bystarAcctParamsPrep 2> /dev/null

  infoBaseAcctBase="${infoBaseAcctCurrent}/${bystarUid}"

  EH_assert [[ -d ${infoBaseAcctBase} ]]
  # If the above fails -- Run:
  # bystarDnsInfoAdmin.sh -h -v -n showRun -p bystarUid=current  -i infoBaseAcctDefaultWrite

  opDo fileParamsCodeGenToFile  ${infoBaseAcctBase} 2> /dev/null
  opDo fileParamsLoadVarsFromBaseDir  ${infoBaseAcctBase} 2> /dev/null

     opDoComplain mmaQmailAddrs.sh  -p domainPart=${cp_domFormSld} -p domainType=virDomain   -p addrItemsFile="${cp_acctUidHome}/NSP/mailAddrItems.nsp" -p acctName="${cp_acctUid}" -s all -a addrFqmaShow 2> /dev/null
}

function vis_addrFqmaList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    # vis_addrFqmaShow | cut -d: -f1 |&
    coproc { vis_addrFqmaShow | cut -d: -f1; sleep 2; }
    #     while read -p thisLine ; do
    while read -u  ${COPROC[0]} thisLine ; do
        echo ${thisLine} #${cp_domFormSld}
    done
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== InjectMsgToAddr
_CommentEnd_


function vis_injectMsgToAddrs {
    EH_assert [[ $# -gt 0 ]]
    EH_assert bystarUidCentralPrep
    EH_assert [[ "${msgBodyFunc}_" != "INVALID_" ]]

    msgFuncStdout=${msgBodyFunc}

    integer gotVal=0

    #bystarAcctAnalyze ${bystarUid}
    bystarAcctParamsPrep 2> /dev/null

    typeset subjsArgs=""


    if [[ "$1_" = "all_" ]] ; then
        #vis_fqmaListFromAcct | grep -v fdmb- |&
        #vis_addrFqmaList | grep -v fdmb- |&
        coproc { vis_fqmaListFromAcct | grep -v fdmb-; sleep 2; }

        #while read -p thisAddr ; do
        while read -u  ${COPROC[0]} thisAddr ; do
            mmaQmailMsgDefaults

            mmaQmailMsg_envelopeAddr="admin@mohsen.banan.1.byname.net"
            mmaQmailMsg_fromAddr="admin@byname.net"

            #mmaQmailMsg_ccAddrList=""
            mmaQmailMsg_subjectLine="ByStar Test Message -- ${thisAddr}"
            
            tmpContentFile=/tmp/${G_myName}.$$

            ${msgFuncStdout} ${thisAddr} > ${tmpContentFile}

            mmaQmailMsg_contentFile=${tmpContentFile}
            mmaQmailMsg_extraHeaders="_nil"
            mmaQmailMsg_toAddrList="${thisAddr}"
            mmaQmailMsgInject

            FN_fileRmIfThere  ${tmpContentFile}
        done
    else
        argv="$@"
        typeset thisAddr=""
        for thisAddr in ${argv} ; do
            mmaQmailMsgDefaults

            mmaQmailMsg_envelopeAddr="admin@mohsen.banan.1.byname.net"
            mmaQmailMsg_fromAddr="admin@byname.net"

            #mmaQmailMsg_ccAddrList=""
            mmaQmailMsg_subjectLine="ByStar Test Message -- ${thisAddr}"
            
            tmpContentFile=/tmp/${G_myName}.$$

            ${msgFuncStdout} ${thisAddr} > ${tmpContentFile}

            mmaQmailMsg_contentFile=${tmpContentFile}
            mmaQmailMsg_extraHeaders="_nil"
            mmaQmailMsg_toAddrList="${thisAddr}"
            mmaQmailMsgInject

            FN_fileRmIfThere  ${tmpContentFile}
        done
    fi
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== InjectSpamMsgToAddr
_CommentEnd_



function vis_injectSpamMsgToAddrs {
    EH_assert [[ $# -gt 0 ]]
    EH_assert bystarUidCentralPrep
    EH_assert [[ "${msgBodyFunc}_" != "INVALID_" ]]

    msgFuncStdout=${msgBodyFunc}

    integer gotVal=0

    #bystarAcctAnalyze ${bystarUid}
    bystarAcctParamsPrep 2> /dev/null

    typeset subjsArgs=""


    if [[ "$1_" = "all_" ]] ; then
        #vis_addrFqmaList | grep -v fdmb- |&
        coproc { vis_addrFqmaList | grep -v fdmb- ; sleep 2; }

        #while read -p thisAddr ; do
        while read -u  ${COPROC[0]} thisAddr ; do
            mmaQmailMsgDefaults

            mmaQmailMsg_envelopeAddr="envelope@example.com"
            mmaQmailMsg_fromAddr="from@example.com"

            #mmaQmailMsg_ccAddrList=""
            mmaQmailMsg_subjectLine="Test spam mail (GTUBE)"
            
            tmpContentFile=/tmp/${G_myName}.$$

            ${msgFuncStdout} ${thisAddr} > ${tmpContentFile}

            mmaQmailMsg_contentFile=${tmpContentFile}
            mmaQmailMsg_extraHeaders="_nil"
            mmaQmailMsg_toAddrList="${thisAddr}"
            mmaQmailMsgInject

            FN_fileRmIfThere  ${tmpContentFile}
        done
    else
        argv="$@"
        typeset thisAddr=""
        for thisAddr in ${argv} ; do
            mmaQmailMsgDefaults

            mmaQmailMsg_envelopeAddr="envelope@example.com"
            mmaQmailMsg_fromAddr="from@example.com"

            #mmaQmailMsg_ccAddrList=""
            mmaQmailMsg_subjectLine="Test spam mail (GTUBE)"
            
            tmpContentFile=/tmp/${G_myName}.$$

            ${msgFuncStdout} ${thisAddr} > ${tmpContentFile}

            mmaQmailMsg_contentFile=${tmpContentFile}
            mmaQmailMsg_extraHeaders="_nil"
            mmaQmailMsg_toAddrList="${thisAddr}"
            mmaQmailMsgInject

            FN_fileRmIfThere  ${tmpContentFile}
        done
    fi
}


function testEmailStdout {
  cat  << _EOF_
  Some Text Goes Here with -- $@
_EOF_
}


function spamGtubeEmailStdout {
  cat  << _EOF_

This is the GTUBE, the
        Generic
        Test for
        Unsolicited
        Bulk
        Email

If your spam filter supports it, the GTUBE provides a test by which you
can verify that the filter is installed correctly and is detecting incoming
spam. You can send yourself a test mail containing the following string of
characters (in upper case and with no white spaces and line breaks):

XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X

You should send this test mail from an account outside of your network.

_EOF_
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== ephemeraAddrProcessing
_CommentEnd_



function vis_ephemeraGetCurrentLocalPart {
    EH_assert [[ $# -eq 1 ]]
    EH_assert bystarUidCentralPrep

    ephemeraPrefix=$1

     # NOTYET, Exits if it does ot exist

    ephemeraSuffix=$( date +%Y%m )

    echo ${ephemeraPrefix}${ephemeraSuffix}
}

function vis_ephemeraGetCurrentFqma {
    EH_assert [[ $# -eq 1 ]]
    EH_assert bystarUidCentralPrep

    ephemeraPrefix=$1

    bystarHereAnalyzeAcctBagpDomForms

    localPart=$( vis_ephemeraGetCurrentLocalPart ${ephemeraPrefix} )

    echo ${localPart}@${bystarDomFormTld}
}


function vis_ephemeraUpdateAddrs {
    EH_assert [[ $# -gt 0 ]]
    EH_assert bystarUidCentralPrep

    #bystarAcctAnalyze ${bystarUid}

    typeset subjsArgs=""

    if [[ "$1_" = "all_" ]] ; then
        argv="envelope e"
    else
        argv="$@"
    fi

    typeset thisOne=""
    for thisOne in ${argv} ; do
        case ${thisOne} in 
            "e")
                curAddr=$( vis_ephemeraGetCurrentLocalPart ${thisOne} )
                ANT_raw "Processing ${curAddr}"
                echo "| forward fdmb-ephemera-despam@mohsen.1.banan.byname.net" | ${G_myName} -p bystarUid=${bystarUid} -f -i dotQmailFromStdin ${curAddr}
                ;;
            "envelope")
                curAddr=$( vis_ephemeraGetCurrentLocalPart ${thisOne} )
                ANT_raw "Processing ${curAddr}"
                echo "| forward fdmb-envelopecurrent-despam@mohsen.1.banan.byname.net" | ${G_myName} -p bystarUid=${bystarUid} -f -i dotQmailFromStdin ${curAddr}
                ;;
            *)
                EH_problem "Unknown ${thisOne}"
                return 101
        esac
    done
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== FromAccount Information
_CommentEnd_



function vis_dotQmailsFromAcct {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarHereAnalyzeAcct

    inBaseDirDo ${bystarUidHome} egrep ^. .qmail-*
}


function vis_localPartsListFromAcct {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarHereAnalyzeAcct

    opDoExit cd ${bystarUidHome}

    ls .qmail-* | egrep -v '\.10' | grep -v fdmb | egrep -v 'ham$|spam$|-spam-' | cut -d '-' -f 2-100
}


function vis_fqmaListFromAcct {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    bystarHereAnalyzeAcctBagp

    #vis_localPartsListFromAcct | cut -d: -f1 |&
    coproc { vis_localPartsListFromAcct | cut -d: -f1 ; sleep 2; }    
    #while read -p thisLine ; do
    while read -u  ${COPROC[0]} thisLine ; do
        echo ${thisLine}@${cp_acctMainBaseDomain}
    done
}

function vis_fdmbListFromAcct {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    bystarHereAnalyzeAcct

    opDoExit cd ${bystarUidHome}

    ls .qmail-*  | grep qmail-fdmb | cut -d '-' -f 3 | sort | uniq
}


function vis_dotQmailFromStdin {
    EH_assert [[ $# -eq 1 ]]
    EH_assert bystarUidCentralPrep

    bystarHereAnalyzeAcct

    typeset dotQmailFile=${bystarUidHome}/.qmail-$1

    function genDotQmailFile {
        cat > $1
    }

    if [[ -f ${dotQmailFile} ]] ;  then
        if [[ "${G_forceMode}_" == "force_" ]] ; then
            opDoRet FN_fileDefunctMake ${dotQmailFile} ${dotQmailFile}.${dateTag}

            genDotQmailFile ${dotQmailFile}

        else
            ANV_raw "${dotQmailFile} exists -- Skipped."
            opDo ls -l ${dotQmailFile}
            return
        fi
    else
        genDotQmailFile ${dotQmailFile}
    fi
    

    opDoRet chmod 600 ${dotQmailFile}
    opDoRet chown  ${bystarUid}:${bystarUidGroupName} ${dotQmailFile}

    opDo ls -l ${dotQmailFile}
}

function vis_bystarAcctParamsPrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    bystar_acct_lastName=$( STR_toTitleCaseWords ${cp_LastName} )
    bystar_acct_firstName=$( STR_toTitleCaseWords ${cp_FirstName} )
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== vcardsGeneration
_CommentEnd_



function vis_vcardsStdout {
    EH_assert [[ $# -gt 0 ]]
    EH_assert bystarUidCentralPrep

    bystarHereAnalyzeAcctBagpDomForms

    vis_bystarAcctParamsPrep

    if [[ "$1_" = "all_" ]] ; then
        argv=$( vis_localPartsListFromAcct )
    else
        argv="$@"
    fi

    thisDateTag=$( date +"%Y-%m-%d" )

    typeset thisOne=""
    for thisOne in ${argv} ; do
# Bug  -- too many spaces
#N:${bystar_acct_lastName};${bystar_acct_firstName};;;  #
#
        cat  << _EOF_
BEGIN:VCARD
VERSION:3.0
N:${bystar_acct_lastName};${bystar_acct_firstName} 
NICKNAME:${bystarUidNu} ${thisOne}
EMAIL;TYPE=INTERNET:${thisOne}@${bystarDomFormTld}
REV:${thisDateTag}
END:VCARD

_EOF_

    done
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Misc. ToBe Absorbed
_CommentEnd_


function STR_toTitleCaseWords {
    EH_assert [[ $# -gt 0 ]]
    argv=$@

    typeset thisOne=""
    for thisOne in ${argv} ; do
        echo ${thisOne} | awk 'BEGIN{OFS=FS=""}{$1=toupper($1);print}'
    done
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
