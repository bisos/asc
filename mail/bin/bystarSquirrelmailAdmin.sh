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
*  /This File/ :: /bisos/asc/mail/bin/bystarSquirrelmailAdmin.sh 
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
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Status/Maintenance -- General TODO List
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

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh
. ${opBinBase}/lpParams.libSh

. ${opBinBase}/mmaWebLib.sh

# PRE parameters optional

typeset -t assignedUserIdNumber=""

# ./bystarHook.libSh
. ${opBinBase}/bystarHook.libSh
. ${opBinBase}/bystarInfoBase.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/opSyslogLib.sh

# PRE parameters
typeset -t RABE="MANDATORY"
typeset -t bystarUid="MANDATORY"

function G_postParamHook {
     lpCurrentsGet
     bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
     return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  #typeset acctsList=$( bystarBacsAcctsList )

  #oneBystarAcct=$( echo ${acctsList} | head -1 )
  oneBystarAcct=${currentBystarUid}

#$( examplesSeperatorSection "Section Title" )

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Full Actions" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i fullUpdate
$( examplesSeperatorChapter "Virtual Host Webmail Apache2 CONFIG  (webmail.xxx)" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  webmailVirDomStdout
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  webmailVirDomUpdate
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  webmailVirDomVerify
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  webmailVirDomShow
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  webmailVirDomDelete
$( examplesSeperatorChapter "DNS Updates" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dnsUpdate
$( examplesSeperatorChapter "Customizations" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i customizeAcctFromLine
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i logoUpdate
$( examplesSeperatorChapter "Partials" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i webmailBasePrep
$( examplesSeperatorChapter "DEACTIVATION ACTIONS" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i  fullDelete
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i  serviceDelete
$( examplesSeperatorChapter "Verification And Test" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i  visitUrl
_EOF_

  vis_examplesBxSvcLogInfo
}


noArgsHook() {
  vis_examples
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Full Actions
_CommentEnd_



function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    opDo vis_customizeAcctFromLine

    opDo vis_webmailBasePrep

    opDo vis_dnsUpdate

    # NOTYET, different for apache1
    #opDo ${G_myName} ${extraInfo} -p bystarUid=${bystarUid} -i  webmailVirDomUpdate
}


function vis_fullDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_serviceDelete

    opDoComplain vis_dnsDelete

    lpReturn
}


function vis_serviceDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    opDo vis_webmailVirDomDelete

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Dns Updates
_CommentEnd_



function vis_dnsUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  ANT_raw "webmail dns alias done in bystarQmailAdmin.sh"
}



function vis_dnsDelete {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    EH_problem "NOTYET"
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Webmail Apache2 Virtual Domains
_CommentEnd_


function vis_webmailVirDomStdout {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}

  opAcctInfoGet ${bystarUid}
  
  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}


  dateTag=`date +%y%m%d%H%M%S`

    webmailVirDomStdoutSpecific_BCA_DEFAULT () {
  cat  << _EOF_
# VirDom xxx

_EOF_

    }

    function webmailVirDomStdoutSpecific_DEFAULT_DEFAULT {

        #<VirtualHost ${thisIPAddress}>
        #<Directory /acct/subs/banan/1/mohsen/lcaApache2/webmail/squirrelmail>
        #Order Deny,Allow
        #Allow from all

        cat  << _EOF_
# VirtualHost for webmail.${cp_acctMainBaseDomain} Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName webmail.${cp_acctMainBaseDomain}
    ServerAdmin webmaster@${cp_acctMainBaseDomain}

    <Directory />
       Require all granted
    </Directory>

    DocumentRoot ${opAcct_homeDir}/lcaApache2/webmail/squirrelmail
    ErrorLog ${opAcct_homeDir}/lcaApache2/webmail/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/webmail/logs/access_log common

    <Directory ${opAcct_homeDir}/lcaApache2/webmail/squirrelmail>
      Options FollowSymLinks
      AllowOverride Limit Options FileInfo
    </Directory>
</VirtualHost>
_EOF_

    }
   
    bystarServiceSupportHookRun webmailVirDomStdoutSpecific

}


function vis_webmailVirDomUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
  
    thisConfigFile="/etc/apache2/sites-available/webmail.${cp_acctMainBaseDomain}.conf"

    FN_fileSafeKeep ${thisConfigFile}

    vis_webmailVirDomStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    #FN_fileSymlinkUpdate ${thisConfigFile} "/etc/apache2/sites-enabled/webmail.${cp_acctMainBaseDomain}"
    opDo a2ensite webmail.${cp_acctMainBaseDomain}.conf

    #opDo /etc/init.d/apache2 force-reload
    opDo service apache2 reload
}

function vis_webmailVirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  thisConfigFile="/etc/apache2/sites-available/webmail.${cp_acctMainBaseDomain}"

  typeset tmpFile=$( FN_tempFile )

  vis_webmailVirDomStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_webmailVirDomShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  thisConfigFile="/etc/apache2/sites-available/webmail.${cp_acctMainBaseDomain}"

  opDo ls -l ${thisConfigFile} 
}

function vis_webmailVirDomDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}
  
    opDo /bin/rm "/etc/apache2/sites-available/webmail.${cp_acctMainBaseDomain}" "/etc/apache2/sites-enabled/webmail.${cp_acctMainBaseDomain}"

    #opDo /etc/init.d/apache2 force-reload
}


function vis_webmailBasePrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}

  opAcctInfoGet ${bystarUid}

  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/webmail/squirrelmail
  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/webmail/logs

  squirrelmailTarFile="/var/osmt/distPkgs/all/squirrelmail.tar"
  if [ ! -f ${squirrelmailTarFile} ] ; then 
      opDoExit cd /usr/share/squirrelmail
      tar cf ${squirrelmailTarFile} .
  fi

  opDoExit cd ${opAcct_homeDir}/lcaApache2/webmail/squirrelmail

  opDo tar xf ${squirrelmailTarFile}

  vis_logoUpdate

  #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/webmail
  opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/webmail
  opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/webmail
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Custimzations: Logo And FromLine
_CommentEnd_


vis_logoUpdate () {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}

  destDir="/tmp/bystarLogo.$$"
  opDoExit mkdir -p ${destDir}
  
  logoGenLatex > ${destDir}/logo.tex

  opDo ls -l ${destDir}/logo.tex

  opDoExit cd ${destDir}

  opDo latex logo.tex
  opDo dvipng -x 1500 -o ${destDir}/logo.png ${destDir}/logo.dvi

  opDo ls -l ${destDir}/logo.png

  ANT_raw "gimp ${destDir}/logo.png"

  squirrelMailLogoFile="${opAcct_homeDir}/lcaApache2/webmail/squirrelmail/images/sm_logo.png"

  FN_fileSafeKeep ${squirrelMailLogoFile} ${squirrelMailLogoFile}.${dateTag}

  FN_fileSafeCopy ${destDir}/logo.png ${squirrelMailLogoFile}

  opDo /bin/rm -r -f ${destDir}

}

logoGenLatex () {
      opDoExit cat <<  _EOF_


\documentclass[11pt]{article}
\usepackage[usenames,dvipsnames]{color}
\usepackage{arabtex}

\setlength{\textwidth}{9cm}
\setlength{\topmargin}{-2cm}
\setlength{\textheight}{5cm}
\setlength{\oddsidemargin}{0.0cm}
\setlength{\evensidemargin}{0.0cm}

\parindent 0mm

\begin{document}

\pagestyle{empty}

\setfarsi \novocalize 
\vfill

\begin{minipage}[t]{3in}
\colorbox{Brown}{\makebox[2in]{\textcolor{black}{Neda Communications, Inc.}}}\\
\colorbox{Plum}{\makebox[2in]{\textcolor{black}{ByStar WebMail}}}\\
\colorbox{OliveGreen}{\makebox[2in]{\textcolor{black}{Your Libre Mail}}}\\
\end{minipage}

\end{document}


_EOF_
}

function vis_customizeAcctFromLine {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}


  # /var/lib/squirrelmail/data/ca-16001.pref
  squirrelmailPrefFile="/var/lib/squirrelmail/data/${bystarUid}.pref"

  # Normally It It There
  if [ ! -f ${squirrelmailPrefFile} ] ; then
      cat  << _EOF_ > ${squirrelmailPrefFile} 
show_html_default=0
sort=0
javascript_on=1
hililist=a:0:{}
full_name=Firstname LastName
email_address=local@example.com
prefix_sig=0
_EOF_
  fi

  typeset thisDateTag=`date +%y%m%d%H%M%S`
  FN_fileSafeCopy ${squirrelmailPrefFile} ${squirrelmailPrefFile}.${thisDateTag}
    


bystarTypeSpecific_BCA_DEFAULT () {
  opDo masterAcctBagpLoad

  FN_textReplace "^full_name=.*" "full_name=${cp_FirstName} ${cp_LastName}" ${squirrelmailPrefFile}
  #FN_textReplace "^email_address=.*" "email_address=${cp_MasterAcctMailName1}\@${cp_master_MainDomain}" ${squirrelmailPrefFile}
  FN_textReplace "^email_address=.*" "email_address=${cp_BcaTag}\@${cp_master_acctMainBaseDomain}" ${squirrelmailPrefFile}
}

bystarTypeSpecific_DEFAULT_DEFAULT () {
  FN_textReplace "^full_name=.*" "full_name=${cp_FirstName} ${cp_LastName}" ${squirrelmailPrefFile}
  #FN_textReplace "^email_address=.*" "email_address=main\@${cp_acctFactoryBaseDomain}" ${squirrelmailPrefFile}
  FN_textReplace "^email_address=.*" "email_address=main\@${cp_acctMainBaseDomain}" ${squirrelmailPrefFile}
}

  bystarServiceSupportHookRun bystarTypeSpecific $*

  # NEEDED in Debian Squeeze
  opDo chown www-data:www-data ${squirrelmailPrefFile}

  opDo ls -l ${squirrelmailPrefFile}
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Verfications and Tests
_CommentEnd_

function vis_visitUrl {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    bxUrl="webmail.${cp_acctMainBaseDomain}"

    #opDo find_app.sh "firefox"

    opDo bx-browse-url.sh -i openUrlNewTab http://${bxUrl}
 
    echo http://${bxUrl}

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Log Files
_CommentEnd_


function bxSvcLogParamsObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Expects $1 as ${bystarUidHome}
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset bxHomeDir="$1"

    bxSvcLogDir="${bxHomeDir}/lcaApache2/webmail/logs"
    bxSvcLogFile="${bxSvcLogDir}/access_log"
    bxSvcLogErrFile="${bxSvcLogDir}/error_log"

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Obsoleted Features
_CommentEnd_


function vis_webmailVirDomApache1Update {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}


  typeset destConfFile="${apacheBaseDir}/servers/${opRunHostName}/conf/httpd.conf"

  EH_assert [[ -f ${destConfFile} ]]

  if FN_lineIsInFile "webmail.${cp_acctMainBaseDomain}" ${destConfFile}  ; then 
    EH_problem "Already in -- webmail.${cp_acctMainBaseDomain} -- skipped"
    return 101
  fi

  FN_fileSafeCopy ${destConfFile} ${destConfFile}.${dateTag}

  vis_webmailVirDomStdout 2> /dev/null >> ${destConfFile}

}


function vis_webmailVirDomApache1Stdout {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  opDoRet bystarAcctAnalyze ${bystarUid}

  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}

    cat  << _EOF_

# VirtualHost for webmail.${cp_acctMainBaseDomain}

<VirtualHost ${opNetCfg_ipAddr}>
    DocumentRoot /usr/share/squirrelmail/
    ServerName webmail.${cp_acctMainBaseDomain}
</VirtualHost>

_EOF_
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
