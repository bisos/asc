#!/bin/bash

####+BEGIN: bx:bash:top-of-file :vc "cvs" :partof "bystar" :copyleft "halaal+brief"
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

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/seedMailingProc.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:

# {{{ Describe/Help/Info

function vis_describe {
    cat  << _EOF_
*      ================  DESCRIPTION
** Given a content.mail arrange for it to be mailed-out in various ways.
** Mailings operates in combination with Names and Distributions
*      ================  Primary Modules
**  /opt/public/osmt/bin/seedMailingProc.sh
**  /opt/public/osmt/bin/seedNameDistProc.sh
*      ================  Related Modules
**  /opt/public/osmt/bin/bystarMailingStart.sh
**  /opt/public/osmt/bin/bystarDistStart.sh
*      ================  Notable Libraries
*      ================  For Full Documentation ad Orientation and Model See  
** [[elisp:(find-file "/libre/ByStar/InitialTemplates/activeDocs/blee/mailCompose/mailings/fullUsagePanel-en.org")][This Activity]]
** [[elisp:(find-file "/libre/ByStar/InitialTemplates/activeDocs/blee/mailCompose/mailings/devStableAgenda.org")][Stable Dev Agenda]]
** [[elisp:(blee:find-file "/libre/ByStar/InitialTemplates/activeDocs/blee/mailCompose/mailings/devUnStableAgenda.org")][UnStable Dev Agenda]] 
*      ================  TODO List (org-mode)
####+BEGIN: bx:dblock:bnsm:agenda-list
*  #Agenda:  [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda List This]]    [[elisp:(bx:org:todo:this-file-otherWin)][ToDo List This]]
####+END:
** TODO Add a Dblock for agenda 
_EOF_
}

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/opDoAtAsLib.sh
# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

. ${opBinBase}/lcnObjectTree.libSh

. ${opBinBase}/bystarMailing.libSh

. ${opBinBase}/bystarHook.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh
# ./bystarHereAcct.libSh
. ${opBinBase}/bystarHereAcct.libSh


. ${opBinBase}/lpInBaseDirDo.libSh

. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# /opt/public/osmt/bin/bystarInfoBase.libSh 
. ${opBinBase}/bystarInfoBase.libSh

. ${opBinBase}/bisosCurrents_lib.sh

# PRE parameters

function G_postParamHook {
     return 0
}

# }}}

# {{{ Examples


function vis_examples {

  #typeset extraInfo=""
  typeset extraInfo="-v -n showRun"

  sitePagesList=`echo ${sitePages}`

  typeset visLibExamples=`visLibExamplesOutput ${G_myName} ${extraInfo}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
---  Documentation / How-To / Information ---
${G_myName} ${extraInfo}  -i describe
${G_myName} ${extraInfo}  -i howTo
${G_myName} ${extraInfo}  -i bystarAcctPathInfo 
${G_myName} ${extraInfo}  -i bystarAcctPathInfo bystarSiteFqdn
${G_myName} ${extraInfo}  -i objectLocalInfo
--- Recurse Dirs ---
${G_myName} ${extraInfo}  -i treeRecurse bystarAcctPathInfo
find  . -type f -print | egrep 'mailingProc.sh$' | bx-dblock -h -v -n showRun -i dblockUpdateFiles
${G_myName} ${extraInfo}  -i treeRecurse startObjectUpdateUnder
${G_myName} ${extraInfo}  -i treeRecurse fullUpdate
${G_myName} ${extraInfo}  -i treeRecurse objectAutoLoad
${G_myName} ${extraInfo}  -i treeRecurse objectLocalPrep     # Generate Lisp Code
${G_myName} ${extraInfo}  -i treeRecurse objectValidate
${G_myName} ${extraInfo}  -i treeRecurse clean
${G_myName} ${extraInfo}  -i treeRecurse fullClean
--- FULL MANIPULATORS ---
${G_myName} ${extraInfo}  -i fullUpdate
${G_myName} ${extraInfo}  -i fullClean
${G_myName} ${extraInfo}  -i clean
--- LOCAL GENERATIONS/CREATIONS -- INITIAL OBJECTS ---
${G_myName} ${extraInfo} -i startObjectGen html path
${G_myName} ${extraInfo} -i startObjectUpdateInCwd
${G_myName} ${extraInfo} -i emacsClientFiles content.mail 
bx-dblock   ${extraInfo} -i dblockUpdateFiles mailingProc.sh content.mail
${G_myName} ${extraInfo} -i startObjectGenExamples
--- Mailing LOCAL PREPS (Generate Lisp Code -- Create HTML content) ---
${G_myName} ${extraInfo} -i objectLocalInfo
${G_myName} ${extraInfo} -i objectLocalPrep      # Generate Lisp Code
${G_myName} ${extraInfo} -i objectLocalClean
${G_myName} ${extraInfo} -i objectLocalFullClean
--- Mailing Object Update  ---
${G_myName} ${extraInfo} -i objectUpdate         # Update Htmls
${G_myName} ${extraInfo} -i objectExecute        # Execute this mailing with blank To:
${G_myName} ${extraInfo} -f -i objectExecute     # Execute this mailing with mbatch
${G_myName} ${extraInfo} -i objectLoad           # Load The Lisp Code
${G_myName} ${extraInfo} -i objectAutoLoad       # Load subject to excludeFromAutoload
${G_myName} ${extraInfo} -i objectLoadAndExecute # objectLoad + objectExecute
${G_myName} ${extraInfo} -i objectValidate       # 
--- DEVELOPMENT MODE ---
${G_myName} ${extraInfo} -i objectFeaturesExamples
${G_myName} ${extraInfo} -i treeFacilitiesExamples
${G_myName} ${extraInfo} -i topLevelInitialSetups
${G_myName} ${extraInfo} -i devTools
${G_myName} ${extraInfo} -i initialTemplatesDevelopment
${G_myName} ${extraInfo} -i bleePanelEntry
_EOF_

cat  << _EOF_
--- Object Specific Examples ---
_EOF_
vis_objectExamplesMenu 2> /dev/null

hookRun "examplesHookPost"
}


function vis_objectFeaturesExamples {
  #typeset extraInfo=""
  typeset extraInfo="-v -n showRun"

  sitePagesList=`echo ${sitePages}`

cat  << _EOF_
--- Setup Object Features (From Local Do To Remote) ---
${G_myName} ${extraInfo} -i setupLayoutLeftPortlets
${G_myName} ${extraInfo} -i setupLayoutRightPortlets
${G_myName} ${extraInfo} -i setupExcludeFromNavigation
${G_myName} ${extraInfo} -i setupPubState
${G_myName} ${extraInfo} -i performLayoutLeftPortlets all
${G_myName} ${extraInfo} -i performLayoutRightPortlets all
${G_myName} ${extraInfo} -i performExcludeFromNavigation present
${G_myName} ${extraInfo} -i performPubState retract
${G_myName} ${extraInfo} -i performPubState publish
${G_myName} ${extraInfo} -i localLayoutLeftPortlets all
${G_myName} ${extraInfo} -i localLayoutRightPortlets all
${G_myName} ${extraInfo} -i localExcludeFromNavigation present
${G_myName} ${extraInfo} -i localPubState retract
_EOF_

}


function vis_startObjectGenExamples {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: Menu for Starting New Objects
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

cat  << _EOF_
--- Initial / Start-Up Preparations ---
${G_myName} ${extraInfo} -i topTreeRecurseAutoLoad
${G_myName} ${extraInfo} -i recurseAutoLoadStartTop
--- LOCAL GENERATIONS/CREATIONS -- INITIAL OBJECTS ---
**** nativeNode ****
${G_myName} ${extraInfo} -i startObjectGen nativeNode path        # A collection of leaves
**** auxNode ****
${G_myName} ${extraInfo} -i startObjectGen auxNode path           # intermediate to node
**** auxLeaf ****
${G_myName} ${extraInfo} -i startObjectGen auxLeaf path           # ignorable leaf
**** text ****
${G_myName} ${extraInfo} -i startObjectGen text path              # text body to-be-edited-as-text 
**** html ****
${G_myName} ${extraInfo} -i startObjectGen html path              # html body to-be-edited-as-html 
**** htmlLcnt ****
${G_myName} ${extraInfo} -i startObjectGen htmlLcnt path          # html body to-be-edited-as-latex (lcnt) 
**** lcntHtml ****
${G_myName} ${extraInfo} -i startObjectGen lcntHtml path          # html body to-be-included from lcnt
**** htmlPubLcnt ****
${G_myName} ${extraInfo} -i startObjectGen htmlPubLcnt path       # html body to-be-copied from LCNT
**** Custom ****
${G_myName} ${extraInfo} -i startObjectGen custom path
**** General ****
${G_myName} ${extraInfo} -i emacsClientFiles pageTitle content.html seeAlso.info subDirs.info
${G_myName} ${extraInfo} -i dblockUpdateFile mailingProc.sh
**** Transition Facilities ****
${G_myName} ${extraInfo} -i startObjectUpdateInCwd  # Auto Detect
${G_myName} ${extraInfo} -i startObjectUpdateInCwd custom  # for old dirs when objectType is not there
_EOF_

}


function vis_initialTemplatesDevelopment {
  #typeset extraInfo=""
  typeset extraInfo="-v -n showRun"

  typeset thisProcFile="./mailingProc.sh"
  typeset initialTemplateProcFile="/libre/ByStar/InitialTemplates/mailing/starts/mailingProc.sh"

cat  << _EOF_
---- Initial Templates Development ----
diff ${thisProcFile} ${initialTemplateProcFile}
cp ${thisProcFile} ${initialTemplateProcFile}
cp ${initialTemplateProcFile} ${thisProcFile} 
_EOF_
}


function vis_devTools {
  #typeset extraInfo=""
  typeset extraInfo="-v -n showRun"

  sitePagesList=`echo ${sitePages}`

cat  << _EOF_
--- FOR DEVELOPERS  ---
---  INFORMATION  ---
${G_myName} ${extraInfo}  -i bystarAcctPathInfo
--- Recurse Dirs ---
tidy -- Verify and Correct HTML input -- NOTYET
${G_myName} ${extraInfo}  -e "linklint" -i dirsRecurse pagesVerify all
${G_myName} ${extraInfo}  -i dirsRecurse bystarAcctPathInfo
--- LOCAL CREATIONS -- INITIAL Pages/Folders/CONTENT ---
${G_myName} ${extraInfo} -e "created index_html/content skeleton" -i initialIndexContentGen
tidy content.html > contentTidy.html
${G_myName} ${extraInfo} -e "creates the plobeProc.sh" -i ploneProcGen
--- LOCAL UPDATES ---
${G_myName} ${extraInfo} -i subFoldersHtmlGen
${G_myName} ${extraInfo} -i seeAlsoHtmlGen
--- fvSet File Variable Set ---
${G_myName} ${extraInfo} -i fvSet contentProcessing  none   #  none | std | lcnt
${G_myName} ${extraInfo} -i fvGet contentProcessing
--- PLONE SITE - Folder Create ---
${G_myName} ${extraInfo} -i folderFullCreate
--- Setup Object Features (From Local Do To Remote) ---
${G_myName} ${extraInfo} -i setupLayoutLeftPortlets
${G_myName} ${extraInfo} -i setupLayoutRightPortlets
${G_myName} ${extraInfo} -i setupExcludeFromNavigation
--- PLONE SITE - Page Update ---
${G_myName} ${extraInfo} -e "Runs linklint on the page" -i pagesVerify all
--- Transition -- Conversion ---
gnuhtml2latex -H content.html
--- LOCAL LISTINGS ---
${G_myName} ${extraInfo} -i effectiveSitePages
${G_myName} ${extraInfo} -i effectiveSiteFolders
${G_myName} ${extraInfo} -i listFoldersHere .
${G_myName} ${extraInfo} -i listPagesHere .
${G_myName} ${extraInfo} -i isFolderHere .
${G_myName} ${extraInfo} -i isPageHere .
_EOF_
}


function topProcessorExamples {
    bystarAcctPathAnalyze $( pwd )    # Setsup bystarUid, bystarUidHome ...
cat  << _EOF_
--- Top Processor Examples ---
${G_myName} ${extraInfo} -i reBuildInitialFullUpdate   # initialBaseSetup + initialUpdateAll
${G_myName} ${extraInfo} -i reBuildFullUpdate          # reBuildBaseSetup + reBuildUpdateAll
${G_myName} ${extraInfo} -i reBuildBaseSetup           # Make the symlinks and baseAssembles for .gened
${G_myName} ${extraInfo} -i reBuildInitialUpdateAll    # Generate the ploneSite from scratch
${G_myName} ${extraInfo} -i reBuildUpdateAll           # Generate ALL of the ploneSite from scratch
---
${G_myName} ${extraInfo} -i reBuildUpdateHomePlus      # Rebuilds Home and homeSlider and mob
${G_myName} ${extraInfo} -i reBuildUpdateSiteSpecific  # Rebuilds What is Site Specific
${G_myName} ${extraInfo} -i reBuildUpdateCommonTop     # Rebuilds Top Common Part
${G_myName} ${extraInfo} -i reBuildUpdateCommonBottom  # Rebuilds Bottom Common Part
${G_myName} ${extraInfo} -i reBuildUpdateCommonAll     # Rebuilds What is Site Specific
---
${G_myName} ${extraInfo} -i initialLibrary             # Does lcntList Upload first
--- Clean For VC Upload (load, update) ---
${G_myName} ${extraInfo} -i cleanForVcUpload    # Delete symlinks and remove .gened
--- Version Control ---
${G_myName} ${extraInfo} -i vcUpdate
---- Initial Templates Development ----
diff ./mailingProc.sh  /libre/ByStar/InitialTemplates/lcaPlone/NewInitialContentTree/Base/Poly/DEFAULT/mailingProc.sh.start 
cp ./mailingProc.sh  /libre/ByStar/InitialTemplates/lcaPlone/NewInitialContentTree/Base/Poly/DEFAULT/mailingProc.sh.start 
cp /libre/ByStar/InitialTemplates/lcaPlone/NewInitialContentTree/Base/Poly/DEFAULT/mailingProc.sh.start  ./mailingProc.sh  
_EOF_
 return
}



noArgsHook() {
  vis_examples
}

# }}}

# {{{ HowTo

function vis_howTo {
  cat  << _EOF_

See: /libre/ByStar/InitialTemplates/activeDocs/blee/bystarContinuum/ploneProc/fullUsagePanel-en.org

_EOF_
}
# }}}

# {{{ Misc

function vis_fvSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO Needs to be generelized
_EOF_
    }
    EH_assert [[ $# -eq 2 ]]

    fileVarName="$1"
    fileVarValue="$2"
    
    # NOTYET, objectType and fileVarName range specific validation 

    opDo eval echo "${fileVarValue}" \> "${fileVarName}"
 
    lpReturn
}


function vis_fvGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    fileVarName="$1"

    if [ -f "${fileVarName}" ] ; then
        opDo cat "${fileVarName}"
        lpReturn 0
    else
        ANV_cooked "Missing ${fileVarName}, should become objectType specific and detect defaults"
        lpReturn 101
    fi
    
    lpReturn
}

function vis_topTreeRecurseAutoLoad {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    inBaseDirDo  ~/BUE/mailings     mailingProc.sh  -i treeRecurse objectAutoLoad
}


function vis_recurseAutoLoadStartTop {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    inBaseDirDo  ~/BUE/mailings/start     mailingProc.sh  -i treeRecurse objectAutoLoad
}


# {{{ Global Parameters

# NOTYET, should this be renamed to pageType
typeset -A webContentTypeEnum=([link]=link [html]=html)
typeset    webContentTypeFileName="contentType"

# }}}

function vis_notApplicable_method_pubState {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    describeF
    lpReturn
}

function vis_notApplicable_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    describeF
    lpReturn
}

function vis_notApplicable_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    describeF
    lpReturn
}


function vis_notImplemented_method_prePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    describeF
    lpReturn
}


function vis_notImplemented_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    describeF
    lpReturn
}

# }}}

# {{{ Object Definition (nativeNode)

typeset -A object_nativeNode=(
    [startGen]=vis_nativeNode_method_startGen
    [startUpdate]=vis_nativeNode_method_startUpdate
    [varsPrep]=vis_nativeNode_method_varsPrep
    [info]=vis_nativeNode_method_info
    [prePrep]=vis_nativeNode_method_prePrep
    [prep]=vis_nativeNode_method_prep
    [update]=vis_nativeNode_method_update
    [clean]=vis_nativeNode_method_clean
    [fullUpdate]=vis_nativeNode_method_fullUpdate
    [fullClean]=vis_nativeNode_method_fullClean
    [pubState]=vis_nativeNode_method_pubState
    [examplesMenu]=vis_nativeNode_method_examplesMenu
    [validate]=vis_nativeNode_method_validate
)

function vis_nativeNode_method_startGen {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate/Start initial nativeNodes for each named in \$*
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    # $@ ignored
      
    opDo vis_nativeNode_method_startUpdate
 
    lpReturn
}

function commonStartFiles_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    function importFile {
        local fileName="$1"
        if [ -f "${fileName}" ] ; then
            ANT_raw "${fileName}  Already exists -- Doing Nothing"
        else
            opDo cp /libre/ByStar/InitialTemplates/mailing/starts/${fileName} ${fileName}
            opDo vis_dblockUpdateFile ${fileName}
        fi
    }

    opDo importFile Panel.org
    opDo importFile dblockProcess.el

    #opDo chmod 775 ${fileName}

    if [ -f mailingProc.sh ] ; then
        ANT_raw "mailingProc.sh  Already exists -- Doing Nothing"
    else
        opDo cp /libre/ByStar/InitialTemplates/mailing/starts/mailingProc.sh mailingProc.sh
        opDo vis_dblockUpdateFile mailingProc.sh
        opDo chmod 775 mailingProc.sh
    fi

    if [ -f Notes.org ] ; then
        ANT_raw "Notes.org  Already exists -- Doing Nothing"
    else
        opDo cp /libre/ByStar/InitialTemplates/mailing/starts/Notes.org Notes.org
        opDo vis_dblockUpdateFile Notes.org
    fi

    lpReturn
}


function vis_nativeNode_method_startUpdate {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    vis_nodeThereTag ${cwd} "mailingProc.sh"

    opDo commonStartFiles_startUpdate

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_raw "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[nativeNode]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    lpReturn
}

function vis_nativeNode_method_varsPrep {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_nativeNode_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_nativeNode_method_prep {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_nativeNode_method_update {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a nativeNode on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
    
    lpReturn
}

function vis_nativeNode_method_load {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a nativeNode on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
 
    opDo vis_nativeNode_method_update

    opDo vis_nativeNode_method_execute
   
    lpReturn
}


function vis_nativeNode_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a nativeNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_nativeNode_method_varsPrep

    printf "bluegriffon file://${here}/content.html\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}


function vis_nativeNode_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    doNothing
}

function vis_nativeNode_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    doNothing
}


# }}}

# {{{ Object Definition (auxNode)

typeset -A object_auxNode=(
    [startGen]=vis_auxNode_method_startGen
    [startUpdate]=vis_auxNode_method_startUpdate
    [varsPrep]=vis_auxNode_method_varsPrep
    [info]=vis_auxNode_method_info
    [prePrep]=vis_auxNode_method_prePrep
    [prep]=vis_auxNode_method_prep
    [update]=vis_auxNode_method_update
    [clean]=vis_auxNode_method_clean
    [fullUpdate]=vis_auxNode_method_fullUpdate
    [fullClean]=vis_auxNode_method_fullClean
    [pubState]=vis_auxNode_method_pubState
    [examplesMenu]=vis_auxNode_method_examplesMenu
    [validate]=vis_auxNode_method_validate
)

function vis_auxNode_method_startGen {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate/Start initial auxNodes for each named in \$*
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    # $@ ignored
      
    opDo vis_auxNode_method_startUpdate
 
    lpReturn
}

function vis_auxNode_method_startUpdate {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    vis_nodeThereTag ${cwd} "mailingProc.sh"

    opDo commonStartFiles_startUpdate

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_raw "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[auxNode]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    lpReturn
}

function vis_auxNode_method_varsPrep {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxNode_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxNode_method_prep {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxNode_method_update {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a auxNode on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
    
    lpReturn
}

function vis_auxNode_method_load {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a auxNode on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
 
    opDo vis_auxNode_method_update

    opDo vis_auxNode_method_execute
   
    lpReturn
}


function vis_auxNode_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_auxNode_method_varsPrep

    printf "bluegriffon file://${here}/content.html\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}


function vis_auxNode_method_pubState {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}


# }}}

# {{{ Object Definition (auxLeaf)

typeset -A object_auxLeaf=(
    [startGen]=vis_auxLeaf_method_startGen
    [startUpdate]=vis_auxLeaf_method_startUpdate
    [varsPrep]=vis_auxLeaf_method_varsPrep
    [info]=vis_auxLeaf_method_info
    [prePrep]=vis_auxLeaf_method_prePrep
    [prep]=vis_auxLeaf_method_prep
    [update]=vis_auxLeaf_method_update
    [load]=vis_auxLeaf_method_load
    [clean]=vis_auxLeaf_method_clean
    [fullUpdate]=vis_auxLeaf_method_fullUpdate
    [fullClean]=vis_auxLeaf_method_fullClean
    [pubState]=vis_auxLeaf_method_pubState
    [execute]=vis_auxLeaf_method_execute
    [examplesMenu]=vis_auxLeaf_method_examplesMenu
    [validate]=vis_auxLeaf_method_validate
)

function vis_auxLeaf_method_startGen {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate/Start initial auxLeafs for each named in \$*
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    # $@ ignored

    opDo vis_auxLeaf_method_startUpdate

    lpReturn
}

function vis_auxLeaf_method_startUpdate {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    vis_leafThereTag ${cwd} "mailingProc.sh"

    opDo commonStartFiles_startUpdate

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_raw "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[auxLeaf]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    lpReturn
}

function vis_auxLeaf_method_varsPrep {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxLeaf_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxLeaf_method_prep {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_auxLeaf_method_update {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a auxLeaf on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
    
    lpReturn
}

function vis_auxLeaf_method_load {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a auxLeaf on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
 
    opDo vis_auxLeaf_method_update

    opDo vis_auxLeaf_method_execute
   
    lpReturn
}


function vis_auxLeaf_method_execute {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxLeaf  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_auxLeaf_method_varsPrep
}

function vis_auxLeaf_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_auxLeaf_method_varsPrep

    printf "bluegriffon file://${here}/content.html\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}

function vis_auxLeaf_method_validate {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_auxLeaf_method_varsPrep

    printf "bluegriffon file://${here}/content.html\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}


function vis_auxLeaf_method_pubState {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}

# }}}

# {{{ Object Definition (basic)

typeset -A object_basic=(
    [startGen]=vis_basic_method_startGen
    [startUpdate]=vis_basic_method_startUpdate
    [varsPrep]=vis_basic_method_varsPrep
    [info]=vis_basic_method_info
    [prePrep]=vis_basic_method_prePrep
    [prep]=vis_basic_method_prep
    [update]=vis_basic_method_update
    [load]=vis_basic_method_load
    [clean]=vis_basic_method_clean
    [fullUpdate]=vis_basic_method_fullUpdate
    [fullClean]=vis_basic_method_fullClean
    [pubState]=vis_basic_method_pubState
    [execute]=vis_basic_method_execute
    [examplesMenu]=vis_basic_method_examplesMenu
    [validate]=vis_basic_method_validate
)

function vis_basic_method_startGen {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate/Start initial folders for each named in \$*
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    typeset thisMailingName=$1
  
    opDo vis_basic_method_startUpdate ${thisMailingName}

    lpReturn
}

function vis_basic_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    typeset thisMailingName="$1"

    vis_leafThereTag ${cwd} "mailingProc.sh"

    opDo commonStartFiles_startUpdate

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[basic]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    if [ -f ${moMailingNameFileName} ] ; then
        ANT_cooked "${moMailingNameFileName} Already exists -- Doing Nothing"
    else
        if [ "${thisMailingName}" == "path" ] ; then
            opDo eval echo "${mailingNamePath}" \> ${moMailingNameFileName}
        else
            opDo eval echo "${thisMailingName}" \> ${moMailingNameFileName}
        fi
    fi

    if [ -f ${moExcludeFromAutoloadFileName} ] ; then
        ANT_cooked "${moExcludeFromAutoloadFileName} Already exists -- Doing Nothing"
    else
        opDo eval echo "${moExcludeFromAutoloadEnum[default]}" \> ${moExcludeFromAutoloadFileName}
    fi

    if [ -f ${moContentMailFileName} ] ; then
        ANT_cooked "${moContentMailFileName} Already exists -- Doing Nothing"
    else
        opDo vis_mailContent_startGen
    fi

    # Now with everything in place in the mailingBaseDir generate the mailing lisp code.

    opDo vis_basic_method_prep

    lpReturn
}

function vis_mailContent_headerStartGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    fv_mailingName=$( cat ./mailingName )

    cat  << _EOF_ > ${moContentMailFileName}
To: 
Subject: To Be Specified
From: Mohsen BANAN <desk@mohsen.1.banan.byname.net>
X-Envelope: envelop@mohsen.1.banan.byname.net
X-MailingName: ${fv_mailingName}
--text follows this line--
_EOF_
}

function vis_mailContent_headerStartGenDblock {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    fv_mailingName=$( cat ./mailingName )

    cat  << _EOF_ > ${moContentMailFileName}
To: 
From: Mohsen BANAN <desk@mohsen.1.banan.byname.net>
####+BEGIN: bx:dblock:global:file-insert-process :file "/dev/null" :load "./dblockProcess.el" :exec "bx:dblock:subject-process"

####+END:
X-Envelope: envelop@mohsen.1.banan.byname.net
X-MailingName: ${fv_mailingName}
--text follows this line--
_EOF_
}


function vis_mailContent_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    typeset objectType=$( cat ./objectType )

    case ${objectType} in
        "basic")
            opDo vis_mailContent_headerStartGen
            cat  << _EOF_ >> ${moContentMailFileName}

Basic Body Goes Here.
_EOF_
            ;;
        "text")
            opDo vis_mailContent_headerStartGen
            cat  << _EOF_ >> ${moContentMailFileName}

Text Body Goes Here.
_EOF_
            ;;
        "html")
            opDo vis_mailContent_headerStartGenDblock
            cat  << _EOF_ >> ${moContentMailFileName}
<#part type="text/html" disposition=inline>
<!-- ####+BEGIN: bx:dblock:global:copy-file :source "${cwd}/mailBodyStart.html" :destination "${cwd}/mailBodyEdit.html" -->
<!-- ####+END: -->
<!-- ####+BEGIN: bx:dblock:global:file-insert-process :file "${cwd}/mailBodyEdit.html" :load "./dblockProcess.el" :exec "bx:dblock:body-process"  -->
<!-- ####+END: -->
_EOF_
            ;;
        "htmlLcnt")
            opDo vis_mailContent_headerStartGen
            cat  << _EOF_ >> ${moContentMailFileName}
<#part type="text/html" disposition=inline>
<!-- ####+BEGIN: bx:dblock:global:file-insert-process :file "${cwd}/mailBody.html" :load "/dev/null" :exec  "org-dblock-bx-strip-begin-end" -->
<!-- ####+END: -->
_EOF_
            # Used To Be: <!-- ####+BEGIN: bx:dblock:global:file-insert :file "${cwd}/mailLcnt/heveaHtml-mailLcnt/index.html" -->
            ;;
        
        "lcntHtml")
            opDo vis_mailContent_headerStartGen
            cat  << _EOF_ >> ${moContentMailFileName}
<#part type="text/html" disposition=inline>
<!--  [[elisp:(find-file "../mailLcnt.ttytex")][Visit ../mailLcnt.ttytex]]  -->
<!-- ####+BEGIN: bx:dblock:global:file-insert-process :file "../rel/mailLcnt-html/index.html" :load "./dblockProcess.el" :exec "bx:dblock:body-process"  -->
<!-- ####+END: -->
<#/part>
<#/part>
<#part type="application/pdf" filename="../rel/mailLcnt.pdf" disposition=attachment>
<#/part>
_EOF_
            ;;
        
        "htmlPubLcnt")
            opDo vis_mailContent_headerStartGen
            cat  << _EOF_ >> ${moContentMailFileName}
<#part type="text/html" disposition=inline>
<!-- ####+BEGIN: bx:dblock:global:file-insert-process :file "${cwd}/mailBody.html" :load "/dev/null" :exec  "org-dblock-bx-strip-begin-end" -->
<!-- ####+END: -->
_EOF_
            ;;
        
        *)
            EH_problem "Unexpected objectType=${objectType} -- Processing Skipped"
            lpReturn 1
            ;;
    esac

    lpReturn
}



function vis_basic_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Read in file variables in this base directory.
_EOF_
    }

    EH_assert [[ $# -eq 0 ]]

    if [ -f excludeFromAutoload ] ; then
        fv_excludeFromAutoload=$( cat excludeFromAutoload ) 
    else
        fv_excludeFromAutoload="true"
    fi

    if [ -f mailingName ] ; then
        fv_mailingName=$( cat mailingName ) 
    else
        fv_mailingName="${mailingNamePath}"
    fi

    lpReturn
}

function vis_basic_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_basic_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Asuumes that the mailing base dir has been set up.
Creates lisp file for it.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}
 
    opDo vis_basic_method_varsPrep

    destFilePath=${cwd}/generated-mailing.el

    FN_fileSafeKeep ${destFilePath}

    templateFile="/libre/ByStar/InitialTemplates/mailing/templates/msend-mailing-template.el"

    cat  > ${destFilePath}  << _EOF_
;;;
;;; RCS: \$Id
;;;
;;; This is a Machine Generated File through: ${G_myName} vis_basic_method_prep
;;; based on: ${templateFile}
;;;
_EOF_

    
    cat   ${templateFile} | sed -e "s%@thisMailingName@%${fv_mailingName}%g" \
        -e "s%@thisMailingBaseDir@%${cwd}%g" >> ${destFilePath}

    opDo ls -ld ${destFilePath}

    lpReturn
}

function vis_basic_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
#Processes mailing information. Updates content.mail
Load the lisp file.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}
 
    ANT_cooked "Not Applicable -- No Action Taken"

    lpReturn
}

function vis_basic_method_load {
    G_funcEntry
    function describeF {  cat  << _EOF_
Create a folder on remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    if [ -f ${here}/custom-mailing.el ] ; then
        opDo emacsclient -e "(load-file \"${here}/custom-mailing.el\")"
    elif [ -f ${here}/generated-mailing.el ] ; then
        opDo emacsclient -e "(load-file \"${here}/generated-mailing.el\")"
    else
        EH_problem "Missing custom-mailing.el or generated-mailing.el"
    fi
    
    lpReturn
}




function vis_basic_method_execute {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a folder  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_basic_method_varsPrep

    if [[ "${G_forceMode}_" == "force_" ]] ; then
        opDo emacsclient -e "(bxms-batch-from-base-to-to \"${here}\")"
    else
        opDo emacsclient -e "(bxms-compose-from-base-to-blank \"${here}\")"
    fi
}

function vis_basic_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_basic_method_varsPrep > /dev/null
    
    printf "bluegriffon file://${here}/content.html\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"
}

function vis_basic_method_validate {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )

    ANT_cooked "folder=${here} -- See its index_html"
}


function vis_basic_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    vis_basic_method_varsPrep

    ANT_raw "===== ##### Cleaning: ${here} ##### ====="

    opDo FN_safeKeepsClean generated-mailing.el
}

function vis_basic_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}


# }}}

# {{{ Object Definition (text)

typeset -A object_text=(
    [startGen]=vis_text_method_startGen
    [startUpdate]=vis_text_method_startUpdate
    [varsPrep]=vis_text_method_varsPrep
    [info]=vis_text_method_info
    [prePrep]=vis_text_method_prePrep
    [prep]=vis_text_method_prep
    [update]=vis_text_method_update
    [load]=vis_text_method_load
    [clean]=vis_text_method_clean
    [fullUpdate]=vis_text_method_fullUpdate
    [fullClean]=vis_text_method_fullClean
    [pubState]=vis_text_method_pubState
    [execute]=vis_text_method_execute
    [examplesMenu]=vis_text_method_examplesMenu
    [validate]=vis_text_method_validate
)

function vis_text_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[text]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_text_method_startUpdate "$@"

    lpReturn
}

function vis_text_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    opDo vis_basic_method_startUpdate "$@"

    lpReturn
}


function vis_text_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_varsPrep "$@"

    lpReturn
}

function vis_text_method_info {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_info  "$@"
}

function vis_text_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_text_method_prep_basic  "$@"
}

function vis_text_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_text_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentUpdate ./content.mail
}

function vis_text_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}

function vis_text_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_text_method_examplesMenu {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_text_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType )\n"

}

function vis_text_method_validate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}



function vis_text_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}

function vis_text_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_text_method_clean
}


# }}}

# {{{ Object Definition (html)

typeset -A object_html=(
    [startGen]=vis_html_method_startGen
    [startUpdate]=vis_html_method_startUpdate
    [varsPrep]=vis_html_method_varsPrep
    [info]=vis_html_method_info
    [prePrep]=vis_html_method_prePrep
    [prep]=vis_html_method_prep
    [update]=vis_html_method_update
    [load]=vis_html_method_load
    [clean]=vis_html_method_clean
    [fullUpdate]=vis_html_method_fullUpdate
    [fullClean]=vis_html_method_fullClean
    [execute]=vis_html_method_execute
    [examplesMenu]=vis_html_method_examplesMenu
    [validate]=vis_html_method_validate
)

function vis_html_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[html]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_html_method_startUpdate "$@"

    lpReturn
}

function vis_html_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    opDo vis_basic_method_startUpdate "$@"

    if [ -f mailBodyStart.html ] ; then
        ANT_cooked "mailBodyStart.html  Already exists -- Doing Nothing"
    else
        opDo cp /libre/ByStar/InitialTemplates/mailing/starts/mailBodyStart-en.html ./mailBodyStart.html
    fi

    if [ -f dblockProcess.el ] ; then
        ANT_cooked "dblockProcess.el  Already exists -- Doing Nothing"
    else
        opDo cp /libre/ByStar/InitialTemplates/mailing/starts/dblockProcess.el ./dblockProcess.el
    fi

    lpReturn
}


function vis_html_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_varsPrep "$@"

    lpReturn
}

function vis_html_method_info {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_info  "$@"
}

function vis_html_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_html_method_prep_basic  "$@"
}

function vis_html_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_html_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentUpdate ./content.mail
}

function vis_html_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}

function vis_html_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_html_method_examplesMenu {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_html_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType )\n"

}

function vis_html_method_validate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}



function vis_html_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}

function vis_html_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_html_method_clean
}


# }}}

# {{{ Object Definition (htmlLcnt)

typeset -A object_htmlLcnt=(
    [startGen]=vis_htmlLcnt_method_startGen
    [startUpdate]=vis_htmlLcnt_method_startUpdate
    [varsPrep]=vis_htmlLcnt_method_varsPrep
    [info]=vis_htmlLcnt_method_info
    [prePrep]=vis_htmlLcnt_method_prePrep
    [prep]=vis_htmlLcnt_method_prep
    [update]=vis_htmlLcnt_method_update
    [load]=vis_htmlLcnt_method_load
    [clean]=vis_htmlLcnt_method_clean
    [fullUpdate]=vis_htmlLcnt_method_fullUpdate
    [fullClean]=vis_htmlLcnt_method_fullClean
    [pubState]=vis_folder_method_pubState
    [execute]=vis_htmlLcnt_method_execute
    [examplesMenu]=vis_htmlLcnt_method_examplesMenu
    [validate]=vis_htmlLcnt_method_validate
)

function vis_htmlLcnt_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
First set the objectType, then do the update based on basicUpdate.
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[htmlLcnt]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_htmlLcnt_method_startUpdate "$@"

    lpReturn
}

function vis_htmlLcnt_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    opDo vis_basic_method_startUpdate "$@"

    opDo vis_hereLcntInitialGen

    lpReturn
}

function vis_htmlLcnt_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_varsPrep "$@"

    lpReturn
}


function vis_htmlLcnt_method_info {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_info  "$@"
}

function vis_htmlLcnt_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_htmlLcnt_method_prep_basic  "$@"
}

function vis_htmlLcnt_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_htmlLcnt_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentUpdate ./content.mail
}


function vis_htmlLcnt_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}



function vis_htmlLcnt_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_htmlLcnt_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_htmlLcnt_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType )\n"

}

function vis_htmlLcnt_method_validate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
}



function vis_htmlLcnt_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
    inBaseDirDo  ./mailLcnt lcntProc.sh  -i  fullClean
}

function vis_htmlLcnt_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_htmlLcnt_method_clean

}


typeset -A object_lcntHtml=(
    [startGen]=vis_lcntHtml_method_startGen
    [startUpdate]=vis_lcntHtml_method_startUpdate
    [varsPrep]=vis_lcntHtml_method_varsPrep
    [info]=vis_lcntHtml_method_info
    [prePrep]=vis_lcntHtml_method_prePrep
    [prep]=vis_lcntHtml_method_prep
    [update]=vis_lcntHtml_method_update
    [load]=vis_lcntHtml_method_load
    [clean]=vis_lcntHtml_method_clean
    [fullUpdate]=vis_lcntHtml_method_fullUpdate
    [fullClean]=vis_lcntHtml_method_fullClean
    [pubState]=vis_folder_method_pubState
    [execute]=vis_lcntHtml_method_execute
    [examplesMenu]=vis_lcntHtml_method_examplesMenu
    [validate]=vis_lcntHtml_method_validate
)

function vis_lcntHtml_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[lcntHtml]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_lcntHtml_method_startUpdate "$@"

    lpReturn
}

function vis_lcntHtml_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    typeset thisMailingName=$1
  
    opDo vis_basic_method_startUpdate ${thisMailingName}

    lpReturn
}

function vis_lcntHtml_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_varsPrep "$@" 2> /dev/null

    lpReturn
}


function vis_lcntHtml_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_lcntHtml_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_lcntHtml_method_prep_basic  "$@"

    lpReturn
}

function vis_lcntHtml_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_lcntHtml_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentPubUpdate ./content.mail
}


function vis_lcntHtml_method_publish {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_lcntHtml_method_varsPrep

    opDo vis_lcntHtml_method_update
}


function vis_lcntHtml_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}



function vis_lcntHtml_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_lcntHtml_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_lcntHtml_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType ) mailingName=$( cat mailingName )\n"

}

function vis_lcntHtml_method_validate {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_lcntHtml_method_varsPrep

    printf "${G_myName} ${extraInfo} -i filesListUpload ./moreFilesList\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}

function vis_lcntHtml_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}

function vis_lcntHtml_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}


typeset -A object_htmlPubLcnt=(
    [startGen]=vis_htmlPubLcnt_method_startGen
    [startUpdate]=vis_htmlPubLcnt_method_startUpdate
    [varsPrep]=vis_htmlPubLcnt_method_varsPrep
    [info]=vis_htmlPubLcnt_method_info
    [prePrep]=vis_htmlPubLcnt_method_prePrep
    [prep]=vis_htmlPubLcnt_method_prep
    [update]=vis_htmlPubLcnt_method_update
    [load]=vis_htmlPubLcnt_method_load
    [clean]=vis_htmlPubLcnt_method_clean
    [fullUpdate]=vis_htmlPubLcnt_method_fullUpdate
    [fullClean]=vis_htmlPubLcnt_method_fullClean
    [pubState]=vis_folder_method_pubState
    [execute]=vis_htmlPubLcnt_method_execute
    [examplesMenu]=vis_htmlPubLcnt_method_examplesMenu
    [validate]=vis_htmlPubLcnt_method_validate
)

function vis_htmlPubLcnt_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[htmlPubLcnt]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_htmlPubLcnt_method_startUpdate "$@"

    lpReturn
}

function vis_htmlPubLcnt_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    typeset thisMailingName=$1
  
    opDo vis_basic_method_startUpdate ${thisMailingName}

    if [ -f lcntControllingDoc ] ; then
        ANT_cooked "lcntControllingDoc Already exists -- Doing Nothing"
    else
        opDo eval echo "Unspecified" \> lcntControllingDoc
    fi

    if [ -f lcntControllingDocForm ] ; then
        ANT_cooked "lcntControllingDocForm Already exists -- Doing Nothing"
    else
        opDo eval echo "emailContentEnFa" \> lcntControllingDocForm
    fi

    if [ -f lcntContentsReplacement ] ; then
        ANT_cooked "lcntContentsReplacement Already exists -- Doing Nothing"
    else
        opDo eval echo "Unspecified" \> lcntContentsReplacement
    fi

    lpReturn
}

function vis_htmlPubLcnt_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_varsPrep "$@" 2> /dev/null

    if [ -f lcntControllingDoc ] ; then
        fv_lcntControllingDoc=$( cat lcntControllingDoc ) 
    else
        fv_lcntControllingDoc="Unspecified"
    fi

    if [ -f lcntControllingDocForm ] ; then
        fv_lcntControllingDocForm=$( cat lcntControllingDocForm ) 
    else
        fv_lcntControllingDocForm="Unspecified"
    fi

    if [ -f lcntContentsReplacement ] ; then
        fv_lcntContentsReplacement=$( cat lcntContentsReplacement ) 
    else
        fv_lcntContentsReplacement="Unspecified"
    fi

    lpReturn
}


function vis_htmlPubLcnt_method_info {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpReturn
}

function vis_htmlPubLcnt_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_htmlPubLcnt_method_prep_basic  "$@"

    lpReturn
}

function vis_htmlPubLcnt_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_htmlPubLcnt_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentPubUpdate ./content.mail
}


function vis_htmlPubLcnt_method_publish {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_htmlPubLcnt_method_varsPrep

    opDo vis_htmlPubLcnt_method_update
}


function vis_htmlPubLcnt_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}



function vis_htmlPubLcnt_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_htmlPubLcnt_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_htmlPubLcnt_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType ) mailingName=$( cat mailingName )\n"

    printf "lcntControllingDoc=${fv_lcntControllingDoc} lcntControllingDocForm=${fv_lcntControllingDocForm} lcntContentsReplacement=${fv_lcntContentsReplacement}\n"
    
    printf "lcnLcntSelect.sh ${fv_lcntControllingDoc}\n"
}

function vis_htmlPubLcnt_method_validate {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_htmlPubLcnt_method_varsPrep

    printf "${G_myName} ${extraInfo} -i filesListUpload ./moreFilesList\n"
    printf "bystarUid=${bystarUid} objectType=$( cat objectType )  http://${bystarSiteFqdn}${mailingPath}\n"

}

function vis_htmlPubLcnt_method_clean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}

function vis_htmlPubLcnt_method_fullClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
}



function vis_filesListUpload {
    G_funcEntry
    function describeF {  cat  << _EOF_
From Current Directory.
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset thisFilesList="$1"
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_htmlPubLcnt_method_varsPrep

    if [ ! -f "${thisFilesList}" ] ; then
        EH_problem "Missing ${thisFilesList}"
        lpReturn 101
    fi

    fv_thisFilesList=$( cat ${thisFilesList} )

    if [ -z "${fv_thisFilesList}" ] ; then
        EH_problem "Empty ${thisFilesList} -- Skipped"
        lpReturn 
    fi

    for thisFile in ${fv_thisFilesList} ; do
        opDo bystarPlone3Features.sh -p bystarUid=${bystarUid} -i uploadFileToFolder "${thisFile}" "${fv_siteFolder}"
    done
}


typeset -A object_custom=(
    [startGen]=vis_custom_method_startGen
    [startUpdate]=vis_custom_method_startUpdate
    [varsPrep]=vis_custom_method_varsPrep
    [info]=vis_custom_method_info
    [prePrep]=vis_custom_method_prePrep
    [prep]=vis_custom_method_prep
    [update]=vis_custom_method_update
    [load]=vis_custom_method_load
    [clean]=vis_custom_method_clean
    [fullUpdate]=vis_custom_method_fullUpdate
    [fullClean]=vis_custom_method_fullClean
)

function vis_custom_method_startGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
First set the objectType, then do the update based on basicUpdate.
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[custom]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    opDo vis_custom_method_startUpdate "$@"

    lpReturn
}

function vis_custom_method_startUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    typeset thisMailingName="$1"

    vis_leafThereTag ${cwd} "mailingProc.sh"

    opDo commonStartFiles_startUpdate

    if [ -f ${moObjectTypeFileName} ] ; then
        ANT_cooked "${moObjectTypeFileName}  Already exists -- Doing Nothing"
    else
        thisObjectType=${moObjectTypeEnum[basic]}
        opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
    fi

    if [ -f ${moMailingNameFileName} ] ; then
        ANT_cooked "${moMailingNameFileName} Already exists -- Doing Nothing"
    else
        if [ "${thisMailingName}" == "path" ] ; then
            opDo eval echo "${mailingNamePath}" \> ${moMailingNameFileName}
        else
            opDo eval echo "${thisMailingName}" \> ${moMailingNameFileName}
        fi
    fi

    if [ -f ${moExcludeFromAutoloadFileName} ] ; then
        ANT_cooked "${moExcludeFromAutoloadFileName} Already exists -- Doing Nothing"
    else
        opDo eval echo "${moExcludeFromAutoloadEnum[default]}" \> ${moExcludeFromAutoloadFileName}
    fi

    if [ -f ${moContentMailFileName} ] ; then
        ANT_cooked "${moContentMailFileName} Already exists -- Doing Nothing"
    else
        opDo vis_mailContent_startGen
    fi

    destFilePath=${cwd}/custom-mailing.el

    FN_fileSafeKeep ${destFilePath}

    cat  > ${destFilePath}  << _EOF_
;;;
;;; RCS: \$Id
;;;
;;; Blank starting point custom mailing.
;;;
;;; This is a Machine Generated File through: ${G_myName} vis_basic_method_prep
;;; based on: ${templateFile}
;;;
_EOF_


    opDo ls -ld ${destFilePath}


    lpReturn
}

function vis_custom_method_varsPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    vis_basic_method_varsPrep "$@"

    lpReturn
}


function vis_custom_method_info {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_info  "$@"
}

function vis_custom_method_prep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_custom_method_prep_basic  "$@"
}

function vis_custom_method_prep_basic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )
    bystarAcctPathAnalyze ${cwd}

    opDo vis_basic_method_prep

    lpReturn
}


function vis_custom_method_update {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_mailContentUpdate ./content.mail
}

function vis_custom_method_publish {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }

    opDo doNothing
}


function vis_custom_method_load {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_load "$@"

    lpReturn
}



function vis_custom_method_execute {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }

    opDo vis_basic_method_execute "$@"
}

function vis_custom_method_examplesMenu {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    opDo vis_custom_method_varsPrep

    printf "bystarUid=${bystarUid} objectType=$( cat objectType )\n"

}

function vis_custom_method_validate {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_page_method_validate
}



function vis_custom_method_clean {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_basic_method_clean
    inBaseDirDo  ./mailLcnt lcntProc.sh  -i  fullClean
}

function vis_custom_method_fullClean {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Usage: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_custom_method_clean
}


# }}}

# {{{ PathAnalyze

function bystarAcctPathAnalyze {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
This is a temporary fix -- bystarAcctPathAnalyzeDo should be revisited.
_EOF_
    }

    typeset here=$( pwd )

    pushd ${here} > /dev/null
    bystarAcctPathAnalyzeDo "$@"
    popd > /dev/null
}


function bystarAcctPathAnalyzeDo {
#set -x
 baseDir=$1

 cd $baseDir
 baseDir=$( pwd -P )

 pathToArray ${baseDir}

 set ${pathArray[@]}

 integer count=0
 integer acctBaseIndex=0
 relPath=""
 mailingPath="NIL"
 for thisElem in ${pathArray[@]} ; do
   if [[ "${thisElem}_" == "Mailings_" || 
         "${thisElem}_" == "mailings_" || 
         "${thisElem}_" == "Mailing_"  ]] ; then
     acctBaseIndex=${count}
     #echo ${relPath} Got IT
     bystarAcctBase=`FN_dirsPart ${relPath}`
     #echo bystarAcctBase=${bystarAcctBase}
     bystarUid=$( FN_nonDirsPart ${bystarAcctBase} )
     mailingPath="TRUE"
   fi
   #echo ${thisElem}
   #echo ${count}
   count=`expr $count + 1`
   relPath="${relPath}/${thisElem}"
   if [[ ${mailingPath}_ != "NIL_" ]] ; then
    if [[ ${mailingPath}_ == "TRUE_" ]] ; then
      mailingPath=""
      mailingNamePath=""
    else
      # if [ "${thisElem}_" == "index_html_" ] ; then 
      #           doNothing
      #elif [ "${thisElem}_" != "Home_" ] ; then 
      if [ "${thisElem}_" != "Home_" ] ; then 
          mailingPath="${mailingPath}/${thisElem}"
          if [ -z ${mailingNamePath} ] ; then
              mailingNamePath="${thisElem}"
          else
              mailingNamePath="${mailingNamePath}-${thisElem}"
          fi
      fi
    fi
   fi
    #echo ${relPath}
 done

 mailingPath=$( FN_dirsPart ${mailingPath} )

 #echo mailingPath=${mailingPath}
    
 contentEndPath=${pathArray[${#pathArray[@]}-1]}

 #echo contentEndPath=${contentEndPath}
 
 if [ -f ${bystarAcctBase}/NSP/bystarUid ] ; then
    bystarUid=$( cat ${bystarAcctBase}/NSP/bystarUid )

    bystarPasswd=`cat ${bystarAcctBase}/NSP/bystarPasswd`
    bystarAcctType=`cat ${bystarAcctBase}/NSP/bystarAcctType`

    bystarSiteFqdn=`cat ${bystarAcctBase}/plone/siteFqdn`

 elif [ -f ${bystarAcctBase}/BAGP/acctUid:dr ] ; then
    bystarUid=$( cat ${bystarAcctBase}/BAGP/acctUid:dr )

    fileParamsLoadVarsFromBaseDir  ${bystarAcctBase}/BAGP

    bystarServiceSupportHookParamsSet ${cp_ServiceType} ${cp_ServiceSupportType}

    function acctBasePasswdGet {
        # DUPLICATES bystarAcctAdmin.sh should stay in sync
        # bystarPasswd=$( bystarAcctAdmin.sh -p bystarUid="${bystarUid}" -i acctPasswdGet )
        EH_assert [[ $# -eq 0 ]]

        thisKey=$( STR_toLower ${cp_ServiceType} )
        #ANT_raw decryptedPasswd=$(  echo ${cp_currentPasswd}  | gcipher -C Vigenere -k ${thisKey} - )
        decryptedPasswd=$(  echo ${cp_currentPasswd}  | gcipher -C Vigenere -k ${thisKey} - )

        echo ${decryptedPasswd}
    }

    #bystarPasswd=$( bystarDevelopers.sh -p bystarUid="${bystarUid}" -i acctPasswdGet )
    bystarPasswd=$( acctBasePasswdGet )
    #bystarAcctType=${cp_acctPrefix}
    RbaeDriveParams
    # This is temporary -- NOTYET, IMPORTANT/URGENT to fix 090219
    bystarSiteFqdn=${acctPloneBaseDomain}
 else
    EH_problem "Bad Config: ${bystarAcctBase}"

 fi
}

function vis_bystarAcctPathInfo {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -le 1 ]]

    bystarAcctPathAnalyze $( pwd )

    if [ $#  -eq 1 ] ; then 
        typeset thisParam=$1
        
        eval echo '$'${thisParam}
    else
        echo contentEndPath=${contentEndPath}
        if [ "${mailingPath}_" == "_" ] ; then
            echo mailingPath="/ -- ROOT"
        else
            echo mailingPath=${mailingPath}
        fi

        if [ "${mailingNamePath}_" == "_" ] ; then
            echo mailingNamePath="/ -- ROOT"
        else
            echo mailingNamePath=${mailingNamePath}
        fi

        echo bystarAcctBase=${bystarAcctBase}
        echo bystarUid=${bystarUid}
        echo bystarPasswd=${bystarPasswd}
        echo bystarAcctType=${bystarAcctType}

        echo bystarSiteFqdn=${bystarSiteFqdn}
    fi
}

# }}}

# {{{ prepThisAndThat


#
# 
#


function vis_subFoldersHtmlGen {
  #EH_assert [[ $# -eq 0 ]]

  # Outputs to index_html/subDirs.html

  if [ ! -d index_html ] ; then
    EH_problem "Missing index_html"
    return 1
  fi

  typeset empty
  empty=TRUE

  for thisOne in $( vis_effectiveSiteFolders ) ; do
    # thre could be spaces or \n in there
    empty=FALSE
  done
  
  if [ "${empty}_" == "TRUE_" ] ; then
    ANT_raw "No SubDirs, Skipped"
    return 1
  fi

  typeset here=`pwd`
  bystarAcctPathAnalyze ${here}
  
 
  function foldersHtmlHead {
 cat   << _EOF_
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>
<BODY>
<div id="tabs">
<b>Sub Topics:</b>
  <ul>
_EOF_
  }

  function foldersHtmlTail {
 cat   << _EOF_
  </ul>
</div><br><br><br
</BODY>
</HTML>
_EOF_
  }


  function subFoldersHtmlEmit {
    foldersHtmlHead


    for thisFolder in $( vis_effectiveSiteFolders ) ; do
    
      typeset thisTitle=`cat ${thisFolder}/index_html/pageTitle`
      typeset thisDescription=`cat ${thisFolder}/index_html/pageDescription`
    
      if [ "${thisDescription}_" = "_" ] ; then
        thisDescription=${thisTitle}
      fi

      cat   << _EOF_
   <li><a href="${thisFolder}" title="${thisTitle}"><span>${thisDescription}</span></a></li>
_EOF_

    done

    foldersHtmlTail
   }

   if [ -d index_html ] ; then
     subFoldersHtmlEmit > index_html/subDirs.html
   else
     EH_problem "Missing index_html directory"
     return 1
   fi

   opDo ls -l index_html/subDirs.html
}

function vis_seeAlsoHtmlGen {

  # Outputs to index_html/seeAlso.html


  typeset here=`pwd`
  bystarAcctPathAnalyze ${here}
 
  function seeAlsoHtmlHead {
##<p></p><div id="tabsC">
    cat   << _EOF_
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>
<BODY>
<div id="tabsC">
<b>See also:</b>
  <ul>
_EOF_
  }

  function seeAlsoHtmlTail {
    cat   << _EOF_
  </ul>
</div><br>
</BODY>
</HTML>
_EOF_
  }

  function seeAlsoHtmlEmit {
    thisPage=$1

    seeAlsoHtmlHead

    if [ -s ./seeAlso.info ] ; then
        cat  ./seeAlso.info |
        while read thisLine ; do

            thisTitle=`echo ${thisLine} | cut -d '&' -f 1`
            thisDescription=`echo ${thisLine} | cut -d '&' -f 2`
            thisUrl=`echo ${thisLine} | cut -d '&' -f 3`
          
            if [ "${thisDescription}_" = "_" ] ; then
                thisDescription=${thisTitle}
            fi

            cat   << _EOF_
  <li><a href="${thisUrl}" title="${thisTitle}"><span>${thisDescription}</span></a></li>
_EOF_

        done
    else
        EH_problem "Missing ./seeAlso.info -- Skipped"
    fi
    
    seeAlsoHtmlTail
  }
  


  ANT_raw seeAlsoHtmlEmit . output ./seeAlso.html
  seeAlsoHtmlEmit . > ./seeAlso.html
  opDo ls -l ./seeAlso.html

}


# }}}

# {{{ Object Method Dispatchers


function vis_startObjectGen {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate object info  and file-var-parameters in current working directory.
\$1 is objectType. REST are parameters that apply to objectType.
_EOF_
    }

    EH_assert [[ $# -ge 1 ]]

    typeset here=$( pwd )

    bystarAcctPathAnalyze ${here}

    thisObjectType=$1
    shift
    #opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=${thisObjectType}"
        lpReturn
    fi
    
    startGenFunc=$( eval echo '$'{object_${thisObjectType}[startGen]} )

    opDo ${startGenFunc} ${@}

    lpReturn
}


function vis_startObjectUpdateInCwd {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate file-var-parameters in current working directory.
\$1 (optional) is objectType. If no \$1 then objectType is determined from content of cwd.
Primarily a transitional facility.
_EOF_
    }

    EH_assert [[ $# -le 1 ]]

    typeset here=.

    bystarAcctPathAnalyze ${here}

    if [ $# -eq 1 ] ; then
        thisObjectType=$1

        if [ -f ${moObjectTypeFileName} ] ; then
            currentObjectType=$( cat ${moObjectTypeFileName} )
            if [ "${thisObjectType}" != "${currentObjectType}" ] ; then
                EH_problem "objectType Mis-Match -- ${thisObjectType} != ${currentObjectType}"
                EH_retOnFail
            fi
        else
            opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
        fi
    else
        if [ -f ${moObjectTypeFileName} ] ; then
            thisObjectType=$( cat ${moObjectTypeFileName} )
        else
            thisObjectType=$( vis_objectTypeInCwdGuess )
            opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
        fi
    fi

    startUpdateFunc=$( eval echo '$'{object_${thisObjectType}[startUpdate]} )

    opDo ${startUpdateFunc} path

    #opDo vis_plone3ProcUpgrade

    lpReturn

}

function vis_objectTypeInCwdGuess {
     G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Try to guess what type of object is here. Used by transitional facilities.
Primarily a transitional facility.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #typeset cwd=$( pwd )
    #bystarAcctPathAnalyze ${cwd}

    typeset thisObjectType=${moObjectTypeEnum[nativeNode]}

    # NOTYET -- Try to better determine

    echo ${thisObjectType}

    lpReturn
}


function vis_mailingProcRenew {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    FN_fileSafeKeep  mailingProc.sh

    opDo cp /libre/ByStar/InitialTemplates/mailing/starts/mailingProc.sh mailingProc.sh
    opDo vis_dblockUpdateFile mailingProc.sh
    opDo chmod 775 mailingProc.sh
}

function vis_objectLoadAndExecute {
     G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Based on objectType update from local to remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_objectLoad

    opDo vis_objectExecute

    lpReturn
}

function vis_objectUpdate {
     G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Based on objectType update from local to remote.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi
    
    updateFunc=$( eval echo '$'{object_${thisObjectType}[update]} )

    opDo ${updateFunc} "${@}"

    lpReturn
}

function vis_objectExecute {
     G_funcEntry
    function describeF {  cat  << _EOF_
Based on objectType Load from local to remote.
Load usually means Update+Surrounding/Priv
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi
    
    updateFunc=$( eval echo '$'{object_${thisObjectType}[execute]} )

    opDo ${updateFunc} "${@}"

    lpReturn
}


function vis_objectExamplesMenu {
     G_funcEntry
    function describeF {  cat  << _EOF_
Based on objectType 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd} 

    prepObjectVarsInCwd #  > /dev/null

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi
    
    updateFunc=$( eval echo '$'{object_${thisObjectType}[examplesMenu]} )

    opDo ${updateFunc} "${@}"

    lpReturn
}

function vis_objectValidate {
     G_funcEntry
    function describeF {  cat  << _EOF_
Based on objectType 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd} 

    prepObjectVarsInCwd  > /dev/null 2> /dev/null

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi
    
    updateFunc=$( eval echo '$'{object_${thisObjectType}[validate]} )

    opDo ${updateFunc} "${@}"

    lpReturn
}


function vis_objectLoad {
     G_funcEntry
    function describeF {  cat  << _EOF_
Based on objectType Load from local to remote.
Load usually means Update+Surrounding/Priv
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi
    
    updateFunc=$( eval echo '$'{object_${thisObjectType}[load]} )

    opDo ${updateFunc} "${@}"

    lpReturn
}

function vis_objectAutoLoad {
     G_funcEntry
    function describeF {  cat  << _EOF_
Based on objectType Load from local to remote.
Load usually means Update+Surrounding/Priv
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=$1"
        lpReturn
    fi

    if [  "${fv_excludeFromAutoload}" == "true" ] ; then
        ANT_raw "excludeFromAutoload=true -- Excluded -- Skipped"
    else
        if [ "${thisObjectType}" != "nativeNode" ] ; then
            updateFunc=$( eval echo '$'{object_${thisObjectType}[load]} )
            opDo ${updateFunc} "${@}"
        fi
    fi

    lpReturn
}


function prepObjectVarsThere {
#set -x
  EH_assert [[ $# -eq 1 ]]

  thisPage=$1

  if [ -d ${thisPage} ] ; then
    pageName=${thisPage}
    opDo cd ${thisPage}

    prepObjectVarsInCwd "${moObjectTypeEnum[page]}"
  else
    EH_problem "Missing ${thisPage} -- skipped"
    return 1
  fi

  return 0
}

function prepObjectVarsInCwd {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Read contents of cwd file-vars into shell variables. 
\$1 (optional) is objectType. If no \$1 then objectType is determined from content of cwd.
_EOF_
    }

    cwd=$( pwd )

    EH_assert [[ $# -le 1 ]]

    if [ $# -eq 1 ] ; then
        thisObjectType=$1

        if [ -f ${moObjectTypeFileName} ] ; then
            currentObjectType=$( cat ${moObjectTypeFileName} )
            if [ "${thisObjectType}" != "${currentObjectType}" ] ; then
                EH_problem "objectType Mis-Match -- ${thisObjectType} != ${currentObjectType}"
                EH_retOnFail
            fi
        fi
    else
        if [ -f ${moObjectTypeFileName} ] ; then
            thisObjectType=$( cat ${moObjectTypeFileName} )
        else
            EH_problem "Missing ${moObjectTypeFileName}"
            EH_retOnFail
        fi
    fi

    varsPrepFunc=$( eval echo '$'{object_${thisObjectType}[varsPrep]} ) 

    #opDo ${varsPrepFunc} "${@}" 
    ${varsPrepFunc} "${@}" 

    lpReturn
}



function vis_objectLocalInfo {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
This function is incomplete. It needs to be developed along with the init function.
NOTYET. DoWhenNeeded.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # prepThisPage ${thisPage}
    ANT_raw "file://${here}/${thisPage}/${pageContentFileName}"

    EH_assert [[ $# -le 1 ]]

    typeset here=.

    bystarAcctPathAnalyze ${here}

    if [ $# -eq 1 ] ; then
        thisObjectType=$1

        if [ -f ${moObjectTypeFileName} ] ; then
            currentObjectType=$( cat ${moObjectTypeFileName} )
            if [ "${thisObjectType}" != "${currentObjectType}" ] ; then
                EH_problem "objectType Mis-Match -- ${thisObjectType} != ${currentObjectType}"
                EH_retOnFail
            fi
        else
            opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
        fi
    else
        if [ -f ${moObjectTypeFileName} ] ; then
            thisObjectType=$( cat ${moObjectTypeFileName} )
        else
            # NOTYET -- Try to better determine
            thisObjectType=${moObjectTypeEnum[page]}
            opDo eval echo "${thisObjectType}" \> "${moObjectTypeFileName}"
        fi
    fi

    infoFunc=$( eval echo '$'{object_${thisObjectType}[info]} )

    opDo ${infoFunc} "${@}"

    opDo ls -d *

    lpReturn
}


function vis_objectLocalPrep {

    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    # Validate specified objectType
    thisEnumObjectType="${moObjectTypeEnum[${thisObjectType}]}"
    if [ -z "${thisEnumObjectType}" ] ; then
        EH_problem "Invalid objectType=${thisObjectType}"
        lpReturn
    fi
    
    prepFunc=$( eval echo '$'{object_${thisObjectType}[prep]} )

    opDo ${prepFunc} "${@}"

    lpReturn
}



function vis_startObjectUpdateUnder {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Foreach in effectiveSitePages apply vis_startObjectUpdateInCwd
_EOF_
    }
    typeset thisOne=""
    typeset currentDir=$( pwd )

    # print "%%%%% ${currentDir} %%%%%"

    for thisOne in $( vis_effectiveSitePages ) ; do
        opDoComplain cd ${currentDir}/${thisOne} || continue
        print "%%%%%% ${currentDir}/${thisOne} %%%%%"
    
        opDo vis_startObjectUpdateInCwd
    done
}


function vis_initialPageContentGen {

  hookRun "buildHookPre"

  bystarAcctPathAnalyze `pwd`
  

  #initialFile=index_initial.html

  case ${contentEndPath} in 
    "Resume")
              cat   << _EOF_
   My Resume ;;; Is This and That
_EOF_
         ;;
      *)
        cat  << _EOF_
<html>
<head>
<title>${pageName}</title>
</head>
<body>

<p>
Non Specific Initial Page Content. To be edited.

</body>
</html>
_EOF_
         ;;
    esac
}


function vis_initialIndexContentGen {

  hookRun "buildHookPre"

  bystarAcctPathAnalyze `pwd`
  

  #initialFile=index_initial.html

  case ${contentEndPath} in 
    "Resume")
              cat   << _EOF_
   My Resume ;;; Is This and That
_EOF_
         ;;
      *)
        cat  << _EOF_
<html>
<head>
<title>${pageName}</title>
</head>
<body>

<p>
Non Specific Initial Index Content. To be edited.

</body>
</html>
_EOF_
         ;;
    esac
}

# }}}

# {{{ Full Operations

#
# Full Manipulators
#

function vis_fullUpdate {
    typeset here=$( pwd )

    opDo vis_objectLocalPrep

    opDoExit cd ${here}

    opDo vis_objectLoad
}


function vis_fullClean {
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    hookRun "fullCleanHook"

    fullCleanFunc=$( eval echo '$'{object_${thisObjectType}[fullClean]} )

    opDo ${fullCleanFunc} 

}

#
# LOCAL UPDATES
#

function vis_fullPrep {
    opDo vis_contentFilePrep $*
  opDo vis_subFoldersHtmlGen $*
  opDo vis_seeAlsoHtmlGen $*
  #
  # NOTYET
}


function vis_clean {
    EH_assert [[ $# -eq 0 ]]

    typeset cwd=$( pwd )

    bystarAcctPathAnalyze ${cwd}

    prepObjectVarsInCwd

    hookRun "cleanHook"

    cleanFunc=$( eval echo '$'{object_${thisObjectType}[clean]} )

    #opDo ${cleanFunc} 
    ${cleanFunc} 
}



# }}}

# {{{ lcnPlone3Gens.sh Specific Functions

function vis_emacsClientFiles {
    EH_assert [[ $# -gt 0 ]]

    typeset thisOne=""

    for thisOne in ${*} ; do
        #( emacsclient -e "(find-file \"LCNT-INFO/${thisOne}\")"  &     wait $! )
        emacsclient "${thisOne}"
    done
}


function vis_dblockUpdateFile {  # NOTYET, to be obsoleted by bx-dblock -i dblockUpdateFiles
    EH_assert [[ $# -gt 0 ]]

    typeset thisOne=""

    for thisOne in ${*} ; do
        opDo bx-dblock -i dblockBlankFiles "${thisOne}"
        opDo bx-dblock -i dblockUpdateFiles "${thisOne}"
        #emacsclient -e "(org-dblock-bx-blank-then-update-file \"${thisOne}\")"
    done
}


# }}}

# {{{ EffectiveSite Pages/Folders

function vis_effectiveSitePages {
  EH_assert [[ $# -eq 0 ]]

  opDo vis_effectiveLeaves
}


function vis_effectiveSiteFolders {
  EH_assert [[ $# -eq 0 ]]

  opDo vis_effectiveNodes
}

# }}}

# {{{ Absolute Path Generators

function vis_initialFolderThere {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
\$1: is "there" -- location where initial pages should be created.
shift - \$*: is list of pages to create initial environment for.
_EOF_
    }

    EH_assert [[ $# -eq 2 ]]

    typeset here=$1
    typeset thisFolder=$2

    bystarAcctPathAnalyze ${here}
 
    opDoExit  pushd ${here}
    
    if [[ -d ${thisFolder} ]] ; then
        EH_problem "${thisFolder} Already exists"
        lpReturn 101
    fi

    opDo vis_startObjectGen folder ${thisFolder}

    opDo popd
}

function vis_initialPageThere {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate initial pages at \$1 for each named in REST.
\$1: is "there" -- location where initial pages should be created.
shift - \$*: is list of pages to create initial environment for.
_EOF_
    }

#set -x
    EH_assert [[ $# -eq 2 ]]

    typeset here=$1
    typeset thisPage=$2

    bystarAcctPathAnalyze ${here}
  
    opDoExit  pushd ${here}
 
    if [[ -d ${thisPage} ]] ; then
      EH_problem "${thisPage} Already exists"
      lpReturn 101
    fi

    vis_startObjectGen page ${thisPage}
    
    opDo popd
}

# }}}

# {{{ Top Level Processors

#

function vis_reBuildInitialFullUpdate {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_reBuildBaseSetup

    opDo vis_reBuildInitialUpdateAll
}



function vis_reBuildFullUpdate {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_reBuildBaseSetup

    opDo vis_reBuildUpdateAll
}


function vis_reBuildBaseSetup {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    bystarAcctPathAnalyze $( pwd ) 

    opDo bystarPlone3Initial.sh -h -v -n showRun -p bystarUid=${bystarUid} -i linkToInitialContentTree

    opDo bystarPlone3Initial.sh -h -v -n showRun -p bystarUid=${bystarUid} -i baseAssembleContentTreeBody 
}


function vis_reBuildInitialUpdateAll {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_rebuildModeSet "initialBuilding"

    opDo vis_reBuildUpdateAll
 
    opDo vis_rebuildModeSet "built"
}



function vis_reBuildUpdateAll {
    G_funcEntry
    function describeF {  cat  << _EOF_
Update means, do to remote the latest local.
The order is important. We want to make sure that we get
the desired order in the left navigation.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset here=$( pwd )

    opDo vis_reBuildUpdateHomePlus

    opDo vis_reBuildUpdateCommonTop

    opDo vis_reBuildUpdateSiteSpecific

    opDo vis_reBuildUpdateCommonBottom
}


function vis_cleanForVcUpload {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo mailingProc.sh.gened -i cleanForVcLoad

    opDo mailingProc.sh -v -n showRun  -i treeRecurse fullClean

    lpReturn
}

# }}}

# {{{ To Be Absorbed


function vis_htmlContentPrep {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset prefaceFile="bystar-ecosystemRevCollaborate.preface"

    FN_fileRmIfThere ${prefaceFile}

    opDo bystarLcntProc.sh -h -v -n showRun  -i lcntFullUpdate ${controllingPlpc}

    # 
    processedContent="$( bystarLcntProc.sh -p lcntParam=docModulePath -i lcntParamGet ${controllingPlpcNu} )/emailContentEnFa/index.html"

    if [ ! -s "${processedContent}" ] ; then 
        EH_problem "Missing ${processedContent}"
        lpReturn 101
    fi

    opDo /opt/public/osmt/bin/elispFilterHtml.sh -v -n showRun  -i deTitle ${processedContent}

    cat  << _EOF_  > ${prefaceFile}
<#part type="text/html" disposition=inline>
_EOF_

    
    if [ -z "${ContentsReplacement}" ] ; then
        opDo eval "cat  ${processedContent} >> ${prefaceFile}"
    else
        opDo eval "cat  ${processedContent} | sed  's:--SEC ANCHOR --.Contents./H2:--SEC ANCHOR -->${ContentsReplacement}</H2:'>> ${prefaceFile}"
    fi

    opDo ls -l $( pwd )/${prefaceFile}

    lpReturn
}


function vis_htmlContentClean {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Describe: No Actions.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    describeF
}


function vis_hereLcntInitialGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if [ -d mailLcnt ] ; then
        ANT_cooked "./mailLcnt in place -- processing skipped"
        lpReturn 1
    fi

    opDo mkdir ./mailLcnt
    
    inBaseDirDo  ./mailLcnt lcnLcntGens.sh -n showRun -p cntntRawHome=. -p srcForms="mailLcnt" -p lcntNu=00000 -p srcLangs="en+fa" -i baseFullStart 

    opDo cp /lcnt/lgpc/bystar/SOURCE-INFO/templates/mailLcnt-headSectionInsert.html ./mailLcnt/headSectionInsert.html

    lpReturn
}


function vis_hereLcntPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    typeset cwd=$( pwd )

    if [ ! -d ./mailLcnt ] ; then
        ANT_cooked "Missing ./mailLcnt -- Skiping It"
        lpReturn 0
    fi

    inBaseDirDo ./mailLcnt lcntProc.sh -i build mailLcnt.ttytex

    # 
    processedContent="${cwd}/mailLcnt/heveaHtml-mailLcnt/index.html"

    if [ ! -s "${processedContent}" ] ; then 
        EH_problem "Missing ${processedContent}"
        lpReturn 101
    fi

    typeset processedContentMailBody="${cwd}/mailBody.html"

    opDo cp ${processedContent} ${processedContentMailBody}

    opDo /opt/public/osmt/bin/elispFilterHtml.sh -v -n showRun  -i deTitle ${processedContentMailBody}

    lpReturn
}

function vis_hereLcntClean {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    inBaseDirDo  ./mailLcnt lcntProc.sh  -i  fullClean

    opDo FN_safeKeepsClean IntroAndMeetingReq-note.preface
    
    lpReturn
}

function vis_prefaceHereLcntInitialGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset prefaceFile="$1"
    typeset cwd=$( pwd -P )

    opDo FN_fileSafeKeep ${prefaceFile}

    cat  << _EOF_  > ${prefaceFile}
<#part type="text/html" disposition=inline>
<!-- ####+BEGIN: bx:dblock:global:insert-file :types "${cwd}/mailBody.html" -->
<!-- ####+END: -->
_EOF_

    # Used To Be <!-- ####+BEGIN: bx:dblock:global:insert-file :types "${cwd}/mailLcnt/heveaHtml-mailLcnt/index.html" -->

    lpReturn
}

function vis_mailContentDblock {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset mailContentFile="$1"

    opDo bx-dblock -i dblockBlankFiles ${mailContentFile}
    opDo bx-dblock -i dblockUpdateFiles ${mailContentFile}

    lpReturn
}


function vis_mailContentDblockObsoleted {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset mailContentFile="$1"
    typeset tmpFile=$( FN_tempFile )

    opDo cp ${mailContentFile} ${tmpFile}.html

    opDo bx-dblock -i dblockUpdateFiles ${tmpFile}.html

    opDo mv ${tmpFile}.html ${mailContentFile}

    lpReturn
}

function vis_mailContentUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset mailContentFile="$1"

    opDo vis_hereLcntPrep

    opDo vis_mailContentDblock ${mailContentFile}

    lpReturn
}

function vis_mailContentPubUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset mailContentFile="$1"

    opDo vis_pubLcntPrep

    opDo vis_mailContentDblock ${mailContentFile}
}

function vis_pubLcntPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_htmlPubLcnt_method_varsPrep
    
    if [ "${fv_lcntControllingDoc}" == "Unspecified" ] ; then
        EH_problem "Unspecified lcntControllingDoc"
        lpReturn 101
    fi

    if [ "${fv_lcntControllingDocForm}" == "Unspecified" ] ; then
        EH_problem "Unspecified lcntControllingDocForm"
        lpReturn 101
    fi

    typeset htmlBodyFile="./mailBody.html"

    FN_fileRmIfThere ${htmlBodyFile}

    opDo bystarLcntProc.sh -h -v -n showRun  -i lcntFullUpdate ${fv_lcntControllingDoc}

    # 
    processedContent="$( bystarLcntProc.sh -p lcntParam=docModulePath -i lcntParamGet ${fv_lcntControllingDoc} )/${fv_lcntControllingDocForm}/index.html"

    if [ ! -s "${processedContent}" ] ; then 
        EH_problem "Missing ${processedContent}"
        lpReturn 101
    fi

    opDo /opt/public/osmt/bin/elispFilterHtml.sh -v -n showRun  -i deTitle ${processedContent}
  
    if [ -z "${fv_lcntContentsReplacement}" ] ; then
        opDo eval "cat  ${processedContent} >> ${htmlBodyFile}"
    else
        opDo eval "cat  ${processedContent} | sed  's:--SEC ANCHOR --.Contents./H2:--SEC ANCHOR -->${fv_lcntContentsReplacement}</H2:'>> ${htmlBodyFile}"
    fi

    opDo ls -l $( pwd )/${htmlBodyFile}

    lpReturn
}


# }}}

function vis_bleePanelEntry {
    G_funcEntry
    function describeF {  cat  << _EOF_
For a auxNode  pubState excludeFromNav
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    
    typeset here=$( pwd )
    bystarAcctPathAnalyze ${here}

    prepObjectVarsInCwd # 2> /dev/null

    printf '***    ========      '
    printf "$( pwd )/content.mail\n"

    printf '****   ====  '
    printf "___ bystarUid=${bystarUid}  ---  objectType=$( cat objectType )  ---  mailingName=$( cat mailingName )\n"

    printf '****   ====  '
    printf "$( pwd )/Notes.org\n"

    if [ -f ${here}/custom-mailing.el ] ; then
        printf '****   ====  '
        printf '[[elisp:(load-file '
        printf "\"$( pwd )/custom-mailing.el\")]]\n"
    elif [ -f ${here}/generated-mailing.el ] ; then
        printf '****   ====  '
        printf '[[elisp:(load-file '
        printf "\"$( pwd )/generated-mailing.el\")]]\n"
    else
        EH_problem "Missing custom-mailing.el or generated-mailing.el"
    fi

    printf '****   ====  '
    printf "[[elisp:(bxms-compose-$( cat mailingName ) 1)]]        -- Compose\n"

    printf '****   ====  '
    printf "[[elisp:(bxms-web-url-$( cat mailingName ))]]          -- Catch's Firefox's send-link url\n"

    printf '****   ====  '
    printf "[[elisp:(bxms-web-mailto-$( cat mailingName ))]]       -- Catch's Firefox's mailto:\n"

    printf '****   ====  '
    printf "[[elisp:(bxms-bbdb-compose-$( cat mailingName ) 1)]]   -- Compose To: Selected BBDB\n"
    printf '****   ====  '
    printf "[[elisp:(bxms-bbdb-compose-$( cat mailingName ) 4)]]   -- Compose To: Each one in BBDB Buffer\n"

    printf '****   ====  '
    printf "[[elisp:(bxms-bbdb-batch-$( cat mailingName ) 1)]]     -- Send To: Selected BBDB\n"
    printf '****   ====  '
    printf "[[elisp:(bxms-bbdb-batch-$( cat mailingName ) 4)]]     -- Send To: Each one in BBDB Buffer\n"

    printf '****   ====  '
    printf "[[elisp:(bxms-bbdb-toall-$( cat mailingName ) 1)]]     -- Compose To: ALL in BBDB Buffer\n"
}


# {{{ Un Used Functions

function vis_mailContent_bodyGetUnused {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO Clean this up some more in vis_mailContent_bodyGetUnused
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    sed -n '/--text follows this line--/,$p' < ./content.mail | sed '1d' > ./body.mail

    opDo ls -l ./body.mail

    lpReturn
}

# }}}


####+BEGIN: bx:dblock:org:parameters  :types "agenda"
#+STARTUP: lognotestate
#+SEQ_TODO: TODO WAITING DELEGATED | DONE DEFERRED CANCELLED
#+TAGS: @desk(d) @home(h) @work(w) @withInternet(i) @road(r) call(c) errand(e)
####+END:

#+CATEGORY: WebSites

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

