#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" :partof "generic" :copyleft "none"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: lcaPlone3SrcPkgBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
# }}} DBLOCK-top-of-file
####+END:

# {{{ Authors:
# Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
# }}} 

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/bin/lcaPlone3SrcPkgBinsPrep.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:

# {{{ Help/Info

function vis_describe {
    cat  << _EOF_
TODO:
    - Add the concept of externalSrc in contrast to src
    - Create a  externalSrcPkgObtain
                externalSrcPkgRePublish
                externalSrcPkgVerify
                externalSrcPkgReObtain


    General Model:
  externalSrcPkg --> srcPkg ---> builtPkg ---> binPkgPublish ---> BinsPrep


  This is meant to run in two parts:

    1) srcBuild and install on every ByStar Host

http://plone.org/products/plone/releases/3.3.6

http://plone.org/documentation/manual/installing-plone


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

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh

. ${opBinBase}/distHook.libSh

. ${opBinBase}/mmaLib.sh
# . ${opBinBase}/mmaBinsPrepLib.sh

. ${opBinBase}/lpReRunAs.libSh


# PRE parameters

function G_postParamHook {
     return 0
}

# }}}

# {{{ Examples

function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
  typeset extraInfo="-h -v -n showRun -p uid=lsipusr"

  visLibExamplesOutput ${G_myName} 
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- Get Needed packages for buidling  ---
--- GENERATE BINARIES FROM SOURCES ---
${G_myName} ${extraInfo} -i srcFullBuild
${G_myName} ${extraInfo} -i srcSetup
${G_myName} ${extraInfo} -i srcPkgUntar
${G_myName} ${extraInfo} -i srcBuild
--- Binary Pkg MANIPULATORS  ---
${G_myName} ${extraInfo} -i srcPkgName
${G_myName} ${extraInfo} -i srcPkgFileName
${G_myName} ${extraInfo} -i srcPkgLocalPath
${G_myName} ${extraInfo} -i srcPkgPublish
${G_myName} ${extraInfo} -i srcPkgVerify
${G_myName} ${extraInfo} -i srcPkgObtain
${G_myName} -h -v -n showRun -p uid=root -i srcPkgInstall
${G_myName} -h -v -n showRun -p uid=root -i srcPkgFullUpdate   # srcPkgObtain + srcPkgInstall
--- Binary Pkg MANIPULATORS  ---
${G_myName} ${extraInfo} -i acctsSetup
--- FULL SERVICE ---
${G_myName} ${extraInfo} -i fullUpdate # srcPkgObtain + srcPkgPublish
_EOF_
}


noArgsHook() {
  vis_examples
}

# }}}

pkgRePubAgent="lcaPlone3PkgRePub.sh"
srcPkgName="Plone3-UnifiedInstaller"

#
# srcPkg
#

vis_srcPkgName() {
  EH_assert [[ $# -eq 0 ]]

  echo ${srcPkgName}
}

vis_srcPkgRePubName() {
  EH_assert [[ $# -eq 0 ]]

  #${pkgRePubAgent} -i pkgRePubName
  ${pkgRePubAgent} -i prpName basePkg    
}

vis_srcPkgLocalPath () {
   EH_assert [[ $# -eq 0 ]]
   #${pkgRePubAgent} -i pkgRePubLocalPath
   ${pkgRePubAgent} -i prpLocalPath   basePkg   
}

vis_srcPkgBuildBaseDir () {
   EH_assert [[ $# -eq 0 ]]
   typeset thisSrcPkgName=$( vis_srcPkgName )
   echo "/libre/var/srcPkgs/${thisSrcPkgName}"
}


function vis_srcPkgObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #opDo ${pkgRePubAgent} -h -v -n showRun -i pkgRePubBxObtain
    opDo ${pkgRePubAgent} -h -v -n showRun -i prpBxObtain   basePkg

    # wget http://www.bybinary.org/republish/debian/11/all/Plone-3.3.5-UnifiedInstaller.tgz
    # wget http://www.bybinary.org/republish/ubuntu/1804/all/Plone-3.3.5-UnifiedInstaller.tgz
}


function vis_srcFullBuild {

    opDoAfterPause vis_srcSetup

    opDoAfterPause vis_srcPkgObtain

    opDoAfterPause vis_srcPkgUntar

    opDoAfterPause vis_acctsSetup

    opDoAfterPause vis_srcBuild

}

function vis_srcSetup {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    sudo apt-get -y install build-essential
    sudo apt-get -y install libssl-dev
    sudo apt-get -y install libxml2-dev

    sudo apt-get -y install libjpeg62-dev
    #sudo apt-get -y install libreadline5-dev
    sudo apt-get -y install libreadline-gplv2-dev libreadline-gplv2-dev:i386 lib64readline-gplv2-dev:i386

    sudo apt-get -y install wv
    sudo apt-get -y install poppler-utils
}


function vis_srcPkgUntar {
    typeset srcBuildBaseDir=$( vis_srcPkgBuildBaseDir )
    opDo mkdir -p ${srcBuildBaseDir}
    opDoExit cd ${srcBuildBaseDir}

    thisPkgFileName=$( vis_srcPkgLocalPath )

    opDo tar xfz ${thisPkgFileName}
    
    opDo ls -ld ${srcBuildBaseDir}
}



function vis_srcBuild {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    typeset srcBuildBaseDir=$( vis_srcPkgBuildBaseDir )

    typeset thisBaseBuildLoc=$( FN_prefix $( vis_srcPkgRePubName ) )

    inBaseDirDo ${srcBuildBaseDir}/Plone-3.3.5-UnifiedInstaller  ./install.sh zeo
    #inBaseDirDo ${srcBuildBaseDir}/${thisBaseBuildLoc} ./install.sh zeo

    opDo chmod ugo+r /usr/local/Plone/zeocluster/adminPassword.txt 
}


function vis_acctsSetup {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDo opAcct_systemNoLoginNoHomeCreate plone
    opDo opAcct_systemNoLoginNoHomeCreate zeo

    lpReturn
}



function vis_fullUpdate {
    opDo vis_srcFullBuild
}



####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:
