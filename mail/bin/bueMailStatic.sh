#!/bin/bash

IcmBriefDescription="DebPkg (Debian Package) BinsPrep."

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
*  /This File/ :: /bisos/asc/mail/bin/bueMailStatic.sh 
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
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes          :: *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xrefs          :: *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Panel         :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Info           :: *[Module Description:]* [[elisp:(org-cycle)][| ]]

_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Imports        :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh


# PRE parameters

pdf="noPdf"
baseDir=""

function G_postParamHook {
     return 0
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples       :: Examples  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Static Mailings Starting Point Generator" )
$( examplesSeperatorSection "Start -- With Default Parameters" )
${G_myName} ${extraInfo} -i staticStart                    # Mailing Name Will Be Date Tagged
${G_myName} ${extraInfo} -i staticStart dated                   # Mailing Name Will Be Date Tagged
${G_myName} ${extraInfo} -i staticStart mailingName ""       # mailingName is specified
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName ""
${G_myName} ${extraInfo} -p pdf=pdf -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName "qualifier"
${G_myName} ${extraInfo} -p base=. -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName
${G_myName} ${extraInfo} -p base=. -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/faEn/generic" -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName
$( examplesSeperatorSection "Start Globish -- EnFa -- With Specified Parameters" )
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header="~/BUE/mailings/headers/enFa-office.mail" -i staticStart mailingName 
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header="~/BUE/mailings/headers/enFa-office.mail" -i staticStart mailingName ""
${G_myName} ${extraInfo} -p pdf=pdf -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header="~/BUE/mailings/headers/enFa-office.mail" -i staticStart mailingName "qualifier"
${G_myName} ${extraInfo} -p base=. -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic" -p header="~/BUE/mailings/headers/enFa-office.mail" -i staticStart mailingName
$( examplesSeperatorSection "Start Farsi -- FaEn -- With Specified Parameters" )
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/faEn/generic" -p header="~/BUE/mailings/headers/faEn-family.mail" -i staticStart mailingName 
${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template="/libre/ByStar/InitialTemplates/mailing/staticMailing/faEn/generic" -p header="~/BUE/mailings/headers/faEn-family.mail" -i staticStart mailingName ""
_EOF_
}

noArgsHook() {
  vis_examples
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  IIF            :: vis_staticStart |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_staticStart {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Example:  ${G_myName} -p base=~/BUE/mailings/com/t-mobile/statics -p header=~/BUE/mailings/com/t-mobile/pabloLopez/content.mail -p template=baseDir -i staticStart mailName
** 
** -p base=~/BUE/mailings/statics  -- Specifies where the mailing will be created in
** -p header=~/BUE/mailings/mohsenProfessional/common/content.mail  -- Mail header fields will be extracted from this -- Body will be ignored
** -p template=~/BUE/mailings/templates/static/enFa/generic  -- Starting point body as mailing.ttytex
** \$1 : Optional IIF Arg1 specifies the mailing name. If None, dateTag is used as name
** \$2 : Optional IIF Arg2 specifies the dateTag over-write name extention -- "" means just mailngName. If None, dateTag is appended to mailingName.
_EOF_
    }
    EH_assert [[ $# -le 2 ]]  # 0=dateTagIt 1=nameIt+datTag 2=nameIt+Qualifier

    local thisEmacsClient=$( vis_thisEmacsClient )  
    

    # Output base directory
    typeset baseDir="$( FN_absolutePathGet ~/BUE/mailings/statics )"
    if [ ! -z "${base}" ] ; then
        baseDir="$( FN_absolutePathGet ${base} )"
    fi

    # mailingName and mailingBaseDir
    typeset mailingBaseDir
    typeset mailingName
    typeset dateTag=$( DATE_nowTag ) 
    if [ $# -gt  0 ] ; then
        mailingName=$1
        if [ -z mailingName ] ; then
            mailingName=${dateTag}
            mailingBaseDir=${baseDir}/${mailingName}
        else
            mailingBaseDir=${baseDir}/${mailingName}-${dateTag}  # The specified name is also date tagged.
        fi
    else  # Which means $# == 0
        mailingName=${dateTag}
        mailingBaseDir=${baseDir}/${mailingName}
    fi

    if [ $# == 2 ] ; then
        if [ -z "$2" ] ; then
            mailingBaseDir=${baseDir}/${mailingName}
        else
            mailingBaseDir=${baseDir}/${mailingName}-${2}
        fi
    fi

    if [ -d  ${mailingBaseDir} ] ; then
        EH_problem "${mailingBaseDir} Already In Place -- Will Not Overwrite, Force It With:"
        ANT_raw "rm -r -f ${mailingBaseDir}"
        lpReturn
    else
        opDoRet mkdir -p ${mailingBaseDir}
    fi

    ### Mailing Template

    typeset templateBaseDir="/libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic"
    if [ ! -z "${template}" ] ; then
        templateBaseDir=${template}
    fi

    if [ ! -d ${templateBaseDir} ] ; then
        EH_problem "Missing Template BaseDir: ${templateBaseDir}"
        lpReturn 101
    fi

    ### headerFile

    typeset headerFile="$( FN_absolutePathGet /libre/ByStar/InitialTemplates/mailing/staticMailing/headers/blank.mail )"
    if [ ! -z "${header}" ] ; then
        headerFile="$( FN_absolutePathGet ${header} )"
    fi

    if [ ! -f ${headerFile} ] ; then
        EH_problem "Missing Header File: ${headerFile}"
        lpReturn 101
    fi

    ls -ldt ${mailingBaseDir}
    ls -ldt ${templateBaseDir}
    ls -ldt ${headerFile}

    inBaseDirDo ${templateBaseDir} eval "find . -print | grep -v CVS | egrep -v ~\$ | cpio -o | (cd ${mailingBaseDir}; cpio -imdv)"



#${G_myName} ${extraInfo} -p base=~/BUE/mailings/statics -p template=~/BUE/mailings/templates/static/enFa/generic -p header=~/BUE/mailings/mohsenProfessional/consulting/lookingForProjs/2013/content.mail -i staticStart mailingName

#~/BUE/mailings/templates/static/enFa/generic/mailingStatic/mailingName

    opDo eval "sed '/--text follows this line--/q' ${headerFile} > ${mailingBaseDir}/mailingStatic/content.mail"

    cat  << _EOF_ >> ${mailingBaseDir}/mailingStatic/content.mail
<#part type="text/html" disposition=inline>
<!--  [[elisp:(find-file "../mailing.ttytex")][Visit ../mailing.ttytex]]  -->
<!-- ####+BEGIN: bx:dblock:global:file-insert-process :file "../rel/${mailingName}-html/index.html" :load "./dblockProcess.el" :exec "bx:dblock:body-process"
-->
<!-- ####+END: -->
<#/part>
_EOF_

    if [ "${pdf}" == "pdf" ] ; then
        cat  << _EOF_ >> ${mailingBaseDir}/mailingStatic/content.mail
<#part type="application/pdf" filename="../rel/${mailingName}.pdf" disposition=attachment description="Pdf File">
<#/part>
_EOF_
    fi

    opDo eval "echo ${mailingName} > ${mailingBaseDir}/mailingStatic/mailingName"
    
    opDo ${thisEmacsClient} -n -e "(progn (find-file \"${mailingBaseDir}/mailing.ttytex\") (blee:ppmm:org-mode-content-list))"

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  IIF            :: vis_enFaGenericInitObsolete |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_enFaGenericInitObsolete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO [[elisp:(org-cycle)][| ]]  NOTYETs  ::  A pre made mailing base dir comes as a parameter  [[elisp:(org-cycle)][| ]]
*** Body templates comes in as a parameter -- So, enFa vs faEn and other form letters can be pre-made
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset dateTag=$( DATE_nowTag )
    typeset mailingBaseDir="$( FN_absolutePathGet ~/BUE/mailings/statics/${dateTag} )"
    local thisEmacsClient=$( vis_thisEmacsClient )  
    
    opDo mkdir -p ${mailingBaseDir}

    ls -ldt ${mailingBaseDir}

    inBaseDirDo /libre/ByStar/InitialTemplates/mailing/staticMailing/enFa/generic eval "find . -print | grep -v CVS | egrep -v ~\$ | cpio -o | (cd ${mailingBaseDir}; cpio -imdv)"

    echo "${thisEmacsClient} ${mailingBaseDir}/mailingEnFa.ttytex"

    lpReturn
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *End Of Editable Text*
_CommentEnd_

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
