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
*  /This File/ :: /bisos/asc/mail/bin/lcaSquirrelmailManage.sh 
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

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/servicesManage/bxWebMail/fullUsagePanel-en.org::Xref-BxWebSquirrelmail-SA][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*

_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh


. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDnsLib.sh
# ./mmaLayer3Lib.sh 
. ${opBinBase}/mmaLayer3Lib.sh

. ${opBinBase}/bisosCurrents_lib.sh


# PRE parameters

function G_postParamHook {
    lpCurrentsGet
    return 0
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "apache2Conf (Stdout/Update)" )
${G_myName} ${extraInfo} -i apache2ConfStdout         
${G_myName} ${extraInfo} -i apache2ConfUpdate         # SafeKeep configFile and replace with ConfigStdout
${G_myName} ${extraInfo} -i apache2ConfVerify         # diff configFile vs ConfigStdout
${G_myName} ${extraInfo} -i apache2ConfShow           # ls -l configFile
$( examplesSeperatorChapter "apache2ConfEnable / apache2ConfDisable" )
${G_myName} ${extraInfo} -i apache2ConfEnable        
${G_myName} ${extraInfo} -i apache2ConfDisable
$( examplesSeperatorChapter "Interactive Configuration" )
Run /usr/sbin/squirrelmail-configure as root to configure/upgrade config.
sudo /usr/sbin/squirrelmail-configure
Which edits /etc/squirrelmail/config.php -- Hand edit in comparison with /etc/squirrelmail/config_default.php
(manual-entry "squirrelmail-configure")
$( examplesSeperatorChapter "Web Access" )
http://127.0.0.1/squirrelmail/src/configtest.php
$( examplesSeperatorChapter "Logs" )
${G_myName} ${extraInfo} -i showLog
_EOF_
#$( examplesSeperatorSection "Section Title" )
}


noArgsHook() {
  vis_examples
}



_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== apache2Conf  (Stdout, Update, Show, Verify)
_CommentEnd_


thisConfigFile="/etc/squirrelmail/apache.conf"

function vis_apache2ConfStdout {

# Alias /squirrelmail /usr/local/squirrelmail/www

# Options None
# AllowOverride None
# DirectoryIndex index.php
# Order Allow,Deny
# Allow from All


  cat  << _EOF_
Alias /squirrelmail /usr/share/squirrelmail

<Location /squirrelmail>
    Order Deny,Allow
    Deny from all
    Allow from all
    #Allow from 127.0.0.1 10.0.0.0/24  # IP address you permit

</Location>
_EOF_
}


function vis_apache2ConfUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
  
    FN_fileSafeKeep ${thisConfigFile}

    vis_apache2ConfStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    #opDo /etc/init.d/apache2 force-reload
}

function vis_apache2ConfVerify {
  typeset tmpFile=$( FN_tempFile )

  vis_apache2ConfStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_apache2ConfShow {
    opDo ls -l ${thisConfigFile} 
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== apache2ConfEnable / apache2ConfDisable
_CommentEnd_



function vis_apache2ConfEnable {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    distFamilyGenerationHookRun serverSetup
}

serverSetup_DEBIAN_DEFAULT () {
    FN_fileSymlinkSafeMake /etc/squirrelmail/apache.conf /etc/apache/conf.d/squirrelmail.conf 
    ANT_raw "test it with something like http://198.62.92.153/squirrelmail/src/login.php"
}

serverSetup_DEBIAN_LENNY () {
    FN_fileSymlinkSafeMake /etc/squirrelmail/apache.conf /etc/apache2/conf.d/squirrelmail.conf 
    ANT_raw "test it with something like http://198.62.92.153/squirrelmail/src/login.php"
}


serverSetup_DEBIAN_SQUEEZE () {
    FN_fileSymlinkSafeMake /etc/squirrelmail/apache.conf /etc/apache2/conf.d/squirrelmail.conf 
    ANT_raw "test it with something like http://198.62.92.153/squirrelmail/src/login.php"
}


function serverSetup_UBUNTU_DEFAULT {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    FN_fileSymlinkSafeMake /etc/squirrelmail/apache.conf /etc/apache2/conf-available/squirrelmail.conf
    opDo service apache2 restart
    opDo a2enconf squirrelmail
    opDo service apache2 reload
    ANT_raw "test it with something like http://198.62.92.153/squirrelmail/src/login.php"
}



_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Full Actions
_CommentEnd_


function vis_fullUpdate {

  vis_serverConfig
  #vis_dnsUpdate
}


function vis_fullDelete {

  vis_dnsDelete
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Logs
_CommentEnd_

function vis_showLog {
    opDo grep ovpn /var/log/syslog.0
    opDo grep ovpn /var/log/syslog
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
