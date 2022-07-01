#!/bin/bash

echo "Obsoleted By lcaSquirrelmailSvcUse.sh and lcaSquirrelmailManage.sh"

exit

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


####+BEGIN: bx:bsip:bash:seed-spec :types "seedSubjectHosts.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedSubjectHosts.sh]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/lcaSquirrelmailHosts.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectHosts.sh -l $0 "$@" 
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
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]

http://www.howtoforge.com/virtual-users-and-domains-with-postfix-courier-mysql-and-squirrelmail-ubuntu-14.04-lts-p5
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
  typeset extraInfo="-v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- INFORMATION ---
${G_myName} -s all -a summary
${G_myName} -s ${opRunHostName} -a describe
${G_myName} -s ${opRunHostName} -a serverType
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile showCmdLine -a fullUpdate
--- FULL SERVER MANIPULATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullDelete
--- SERVER CONFIG  ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serverConfig
--- ADMIN and MISC ---
apt-get -y install squirrelmail
apt-get -y install libapache-mod-php4
Run /usr/sbin/squirrelmail-configure as root to configure/upgrade config.
sudo /usr/sbin/squirrelmail-configure
http://127.0.0.1/squirrelmail/src/configtest.php
--- LOGS ---
${G_myName} ${extraInfo} -i showLog
grep ovpn /var/log/syslog
_EOF_
}


noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_


function vis_apacheSetup {
 cat  << _EOF_
    Watch for these in /etc/apache/httpd.conf
783,784c783,784
<     AddType application/x-httpd-php3 .php3
<     AddType application/x-httpd-php3-source .phps
---
>     #AddType application/x-httpd-php3 .php3
>     #AddType application/x-httpd-php3-source .phps
788,789c788,789
<     AddType application/x-httpd-php .php
<     AddType application/x-httpd-php-source .phps
---
>     #AddType application/x-httpd-php .php
>     #AddType application/x-httpd-php-source .phps
_EOF_
}

# Alias /squirrelmail /usr/local/squirrelmail/www

# Options None
# AllowOverride None
# DirectoryIndex index.php
# Order Allow,Deny
# Allow from All

#
# WORKS BELOW
#

# Alias /squirrelmail /usr/share/squirrelmail

# <Location /squirrelmail>
#     Order Deny,Allow
#     Deny from all
#     Allow from all
#     #Allow from 127.0.0.1 10.0.0.0/24  # IP address you permit

# </Location>



function do_serverConfig {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    subjectValidatePrepare
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


serverSetup_UBUNTU_DEFAULT () {
    FN_fileSymlinkSafeMake /etc/squirrelmail/apache.conf /etc/apache2/conf-available/squirrelmail.conf
    opDo service apache2 restart
    opDo a2enconf squirrelmail
    opDo service apache2 reload
    ANT_raw "test it with something like http://198.62.92.153/squirrelmail/src/login.php"
}


function do_fullVerify {
  targetSubject=item_${subject}

  subjectIsValid

  if [[ $? != 0 ]] ; then
    print -- "Skipped -- ${subject} is not configured."
    return 0
  fi
  
  if [[ "${subject}_" != "${opRunHostName}_" ]] ; then
    echo "Wrong Machine -- Re-run this script on ${subject}"
    return 1
  fi
}


function do_fullUpdate {
  targetSubject=item_${subject}

  subjectIsValid

  if [[ $? != 0 ]] ; then
    print -- "Skipped -- ${subject} is not configured."
    return 0
  fi
  
  if [[ "${subject}_" != "${opRunHostName}_" ]] ; then
    echo "Wrong Machine -- Re-run this script on ${subject}"
    return 1
  fi

  do_serverConfig
  #do_dnsUpdate
}


function do_fullDelete {
  targetSubject=item_${subject}

  subjectIsValid

  if [[ $? != 0 ]] ; then
    print -- "Skipped -- ${subject} is not configured."
    return 0
  fi
  
  if [[ "${subject}_" != "${opRunHostName}_" ]] ; then
    echo "Wrong Machine -- Re-run this script on ${subject}"
    return 1
  fi

  do_dnsDelete
}


function vis_showLog {
    opDo grep ovpn /var/log/syslog.0
    opDo grep ovpn /var/log/syslog
}



function do_schemaVerify {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  print "NOTYET"
  exit 1
}


### ITEMS FILE ###

function itemPre_serviceHost {
  iv_serviceHost_host=""

  iv_serviceHost_setup="noService"

  function iv_descriptionFunction {
cat << _EOF_
Undefined -- No iv_descriptionFunction for
_EOF_
}

}

function itemPost_serviceHost {
  EH_assert [[ "${iv_serviceHost_host}_" != "_" ]]      
}

function itemDefault_serviceHost {
  itemPre_serviceHost
  itemPost_serviceHost
}


function itemFamily_BACS {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}


function itemFamily_BISP {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="noService"

  itemPost_serviceHost
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
