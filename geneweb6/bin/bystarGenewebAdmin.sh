#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bystarGenewebAdmin.sh,v 1.2 2016-07-27 04:26:59 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedActions.bash"
SEED="
* /[dblock]/--Seed/: /opt/public/osmt/bin/seedActions.bash
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(org-cycle)][Fold]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]]  | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] | 
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_



_CommentBegin_
*      ================
*      ################ CONTENTS-LIST ################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Status/Maintenance -- General TODO List
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/blee/bystarContinuum/genealogy/fullUsagePanel-en.org::Xref-Geneweb][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*
**      ====[[elisp:(org-cycle)][Fold]]====  This IIM enables creation of geneweb sites for SOs.
** TODO ====[[elisp:(org-cycle)][Fold]]==== Help/Tasks
    - Create Initial Database with passwd etc.

    - geneweb.first.1.last.byname.net
    - geneweb.1.last.byfamily.net
  
    - Create Link to it in plone  
**      ====[[elisp:(org-cycle)][Fold]]==== Design Notes
    - Based on bystarUid, create a new dataBase
             /var/lib/geneweb/sa-xxxx

    - Create a temp gedcom file in /tmp/
        vis_initialLoad
        
        The initial gedcom file is created by 
        hand entry into geneweb 
        Then the template is extracted with 
          gwb2ged -o sa-xxxx.ged sa-xxxx

    - Import the gedcom file into /var/lib/geneweb/sa-xxxx
      vis_initialLoad

          ged2gwb -o sa-xxxx /tmp/gedcomTmpInit

     - Setup Access Control Files

     - Setup DNS and apache Redirects   

_EOF_
}

function vis_describe { vis_moduleDescription; }

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh
. ${opBinBase}/lpParams.libSh

. ${opBinBase}/mmaWebLib.sh

# PRE parameters optional

typeset -t assignedUserIdNumber=""

# ./bystarHook.libSh
. ${opBinBase}/bystarHook.libSh
. ${opBinBase}/bystarInfoBase.libSh

# ./bystarLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/lpCurrents.libSh

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
$( examplesSeperatorChapter "Virtual Host Geneweb Apache2 CONFIG  (geneweb.xxx)" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomFileNameGet
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomStdout
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomUpdate
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomVerify
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomShow
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  srVirDomDelete
$( examplesSeperatorChapter "Virtual Host Geneweb Apache2 CONFIG  (geneweb.xxx)" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomFileNameGet
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomStdout
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomUpdate
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomVerify
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomShow
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  genewebVirDomDelete
$( examplesSeperatorChapter "apache2ConfEnable / apache2ConfDisable" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i apache2ConfEnable        
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i apache2ConfDisable
$( examplesSeperatorChapter "DNS Updates" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dnsUpdate
$( examplesSeperatorChapter "Partials" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i genewebBasePrep
$( examplesSeperatorChapter "Config File Customizations" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileStdout
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileNameGet
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileUpdate
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileVerify
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileShow
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i  configFileDelete
$( examplesSeperatorChapter "dbaseInitialContent for Bystar Account" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseFullUpdate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseCreate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseAccessControlVisible ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseAccessControlLimited ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseInitialContentUpdate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i dbaseInitialContentStdout ${oneBystarAcct}
$( examplesSeperatorChapter "BYSTAR HOME SYNC" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p dbase=banan -i genewebToBystarHome
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p dbase=banan -i genewebFromBystarHome
$( examplesSeperatorChapter "DEACTIVATION ACTIONS" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i  fullDelete
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i  serviceDelete
$( examplesSeperatorChapter "Access, Verification And Test" )
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

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    opDo vis_customizeAcctFromLine

    opDo vis_genewebBasePrep

    #opDo vis_configFileUpdate

    opDo vis_genewebVirDomUpdate

    #opDo vis_dnsUpdate
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

    opDo vis_genewebVirDomDelete

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Dns Updates
_CommentEnd_

function vis_dnsUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot
  #opDoRet mmaDnsServerHosts.sh -i hostIsOrigContentServer
  #opDoRet bystarAcctAnalyze ${bystarUid}
  #opDoRet mmaDnsEntryAliasUpdate geneweb.${cp_acctMainBaseDomain} ${opRunHostName}

  ANT_raw "NOTYET, geneweb dns alias"
}

function vis_dnsDelete {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    EH_problem "NOTYET"
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Geneweb Service Realization Apache2 Virtual Domains
_CommentEnd_


function vis_srVirDomFileNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
In Params:
  - BxSo
  - BxCapability
  - srName
  - virDom
Uniq name -- bxso.bxCapability.srName  -- sa-20000.geneweb.priv
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    echo "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}.conf"

    lpReturn
}



function vis_srVirDomStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    dateTag=`date +%y%m%d%H%M%S`

    cat  << _EOF_
# VirtualHost for geneweb.${cp_acctMainBaseDomain} Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName geneweb.${cp_acctMainBaseDomain}
    ServerAdmin webmaster@${cp_acctMainBaseDomain}

    <Directory />
       Require all granted
    </Directory>

    DocumentRoot ${opAcct_homeDir}/lcaApache2/geneweb/geneweb
    ErrorLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/access_log common

    <Directory ${opAcct_homeDir}/lcaApache2/geneweb/geneweb>
        Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        order allow,deny
        Allow from all
        AddHandler cgi-script cgi
        DirectoryIndex geneweb.cgi
    </Directory>

</VirtualHost>
_EOF_
}


function vis_srVirDomUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
  
    typeset thisConfigFile=$( vis_srVirDomFileNameGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_srVirDomStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    typeset siteConfigFile=$( FN_nonDirsPart ${thisConfigFile} )
    opDo a2ensite ${siteConfigFile}

    opDo service apache2 reload
}

function vis_srVirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  typeset thisConfigFile=$( configFileNameGet )

  typeset tmpFile=$( FN_tempFile )

  vis_srVirDomStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_genewebVirDomShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  typeset thisConfigFile=$( configFileNameGet )

  opDo ls -l ${thisConfigFile} 
}

function vis_srVirDomDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}
  
    opDo /bin/rm "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}" "/etc/apache2/sites-enabled/geneweb.${cp_acctMainBaseDomain}"

    #opDo /etc/init.d/apache2 force-reload
}


function vis_srA2VarBasePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    opAcctInfoGet ${bystarUid}

    opDo mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/geneweb
    EH_retOnFail

    opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/logs

    genewebTarFile="/var/osmt/distPkgs/all/geneweb.tar"
    if [ ! -f ${genewebTarFile} ] ; then 
	opDoExit cd /usr/share/geneweb
	tar cf ${genewebTarFile} .
    fi

    opDoExit cd ${opAcct_homeDir}/lcaApache2/geneweb/geneweb

    opDo tar xf ${genewebTarFile}

    #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/geneweb
    opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/geneweb
    opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
}


function vis_srA2ConfigBasePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    opAcctInfoGet ${bystarUid}

    opDo mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/geneweb
    EH_retOnFail

    opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/logs

    genewebTarFile="/var/osmt/distPkgs/all/geneweb.tar"
    if [ ! -f ${genewebTarFile} ] ; then 
	opDoExit cd /usr/share/geneweb
	tar cf ${genewebTarFile} .
    fi

    opDoExit cd ${opAcct_homeDir}/lcaApache2/geneweb/geneweb

    opDo tar xf ${genewebTarFile}

    #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/geneweb
    opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/geneweb
    opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Geneweb Vir Dom -- Original
_CommentEnd_


function vis_genewebVirDomStdout {
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

    genewebVirDomStdoutSpecific_BCA_DEFAULT () {
  cat  << _EOF_
# VirDom xxx

_EOF_
    }

    function genewebVirDomStdoutSpecific_DEFAULT_DEFAULT {

  cat  << _EOF_
# VirtualHost for geneweb.${cp_acctMainBaseDomain} Generated by ${G_myName} on ${dateTag}

<VirtualHost ${thisIPAddress}>
    ServerName geneweb.${cp_acctMainBaseDomain}
    ServerAdmin webmaster@${cp_acctMainBaseDomain}
    DocumentRoot ${opAcct_homeDir}/lcaApache2/geneweb/htdocs
    ErrorLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/access_log common

    RewriteEngine On							  
    ProxyPass / http://${thisIPAddress}:2317/
    ProxyPassReverse / http://${thisIPAddress}:2317/

        <Proxy *>
	        Order deny,allow
	        Allow from all
        </Proxy>
</VirtualHost>
_EOF_
    }
   
    bystarServiceSupportHookRun genewebVirDomStdoutSpecific

}


function vis_genewebVirDomUpdate {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  thisConfigFile="/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}"

    FN_fileSafeKeep ${thisConfigFile}

    vis_genewebBasePrep

    vis_genewebVirDomStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    #FN_fileSymlinkUpdate ${thisConfigFile} "/etc/apache2/sites-enabled/geneweb.${cp_acctMainBaseDomain}"
    opDo a2ensite  geneweb.${cp_acctMainBaseDomain}.conf

    opDo /etc/init.d/apache2 force-reload
}

function vis_genewebVirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  thisConfigFile="/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}"

  typeset tmpFile=$( FN_tempFile )

  vis_genewebVirDomStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_genewebVirDomShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  thisConfigFile="/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}"

  opDo ls -l ${thisConfigFile} 
}

function vis_genewebVirDomDelete {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
    
    ANT_raw "NOTYET"
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Geneweb Apache2 Virtual Domains
_CommentEnd_


function vis_genewebVirDomFileNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    echo "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}.conf"

    lpReturn
}



function vis_genewebVirDomStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    dateTag=`date +%y%m%d%H%M%S`

    genewebVirDomStdoutSpecific_BCA_DEFAULT () {
  cat  << _EOF_
# VirDom xxx

_EOF_

    }

    function genewebVirDomStdoutSpecific_DEFAULT_DEFAULT {

	cat  << _EOF_
# VirtualHost for geneweb.${cp_acctMainBaseDomain} Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName geneweb.${cp_acctMainBaseDomain}
    ServerAdmin webmaster@${cp_acctMainBaseDomain}

    <Directory />
       Require all granted
    </Directory>

    DocumentRoot ${opAcct_homeDir}/lcaApache2/geneweb/geneweb
    ErrorLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/geneweb/logs/access_log common

    <Directory ${opAcct_homeDir}/lcaApache2/geneweb/geneweb>
        Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        order allow,deny
        Allow from all
        AddHandler cgi-script cgi
        DirectoryIndex geneweb.cgi
    </Directory>

</VirtualHost>
_EOF_
    }
   
    bystarServiceSupportHookRun genewebVirDomStdoutSpecific
}


function vis_genewebVirDomUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
  
    typeset thisConfigFile=$( vis_genewebVirDomFileNameGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_genewebVirDomStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    typeset siteConfigFile=$( FN_nonDirsPart ${thisConfigFile} )
    opDo a2ensite ${siteConfigFile}

    opDo service apache2 reload
}

function vis_genewebVirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  typeset thisConfigFile=$( configFileNameGet )

  typeset tmpFile=$( FN_tempFile )

  vis_genewebVirDomStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_genewebVirDomShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
  
  typeset thisConfigFile=$( configFileNameGet )

  opDo ls -l ${thisConfigFile} 
}

function vis_genewebVirDomDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}
  
    opDo /bin/rm "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}" "/etc/apache2/sites-enabled/geneweb.${cp_acctMainBaseDomain}"

    #opDo /etc/init.d/apache2 force-reload
}


function vis_genewebBasePrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}

  opAcctInfoGet ${bystarUid}

  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/htdocs
  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/logs

  #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/geneweb
  opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/geneweb
  opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
}



function vis_genewebBasePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    opAcctInfoGet ${bystarUid}

    opDo mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/geneweb
    EH_retOnFail

    opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/geneweb/logs

    genewebTarFile="/var/osmt/distPkgs/all/geneweb.tar"
    if [ ! -f ${genewebTarFile} ] ; then 
	opDoExit cd /usr/share/geneweb
	tar cf ${genewebTarFile} .
    fi

    opDoExit cd ${opAcct_homeDir}/lcaApache2/geneweb/geneweb

    opDo tar xf ${genewebTarFile}

    #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/geneweb
    opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/geneweb
    opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
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

    opDo service apache2 restart
    opDo a2enconf geneweb
    opDo service apache2 reload
    ANT_raw "test it with something like http..."
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Config File Generate/Update
_CommentEnd_


function vis_configFileNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep
    echo "${bystarUidHome}/lcaApache2/geneweb/geneweb/geneweb_config.perl"

    lpReturn
}


function vis_configFileStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Create geneweb_config.perl in /acct/smb/com/tmo-son/lcaApache2/geneweb/geneweb
with the content below:
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset thisFunc="${G_thisFunc}"

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    #our \$projectroot = "${bystarUidHome}/gits/pub"; 

    cat  << _EOF_
# Config file for geneweb.${cp_acctMainBaseDomain} Generated ${G_myName}:${thisFunc} on ${dateTag} -- Do Not Hand Edit
#
our \$projectroot = "/var/lib/gitolite3/repositories/${bystarUid}/pub"; 
our \$site_name = "${cp_acctMainBaseDomain} Public Repos";
_EOF_

    lpReturn
}


function vis_configFileUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    typeset thisConfigFile=$( vis_configFileNameGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_configFileStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    opDo sudo service apache2 reload
}

function vis_configFileVerify {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    typeset thisConfigFile=$( vis_configFileNameGet )

    typeset tmpFile=$( FN_tempFile )

    vis_configFileStdout > ${tmpFile} 

    FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
    FN_fileRmIfThere ${tmpFile} 
}

function vis_configFileShow {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    typeset thisConfigFile=$( vis_configFileNameGet )

    opDo ls -l "${thisConfigFile}"
}

function vis_configFileDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidCentralPrep

    typeset thisConfigFile=$( vis_configFileNameGet )

    opDo /bin/rm "${thisConfigFile}"

    #opDo /etc/init.d/apache2 force-reload
}



_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Access, Verfications and Tests
_CommentEnd_

function vis_visitUrl {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    bxUrl="geneweb.${cp_acctMainBaseDomain}"
 
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

    bxSvcLogDir="${bxHomeDir}/lcaApache2/geneweb/logs"
    bxSvcLogFile="${bxSvcLogDir}/access_log"
    bxSvcLogErrFile="${bxSvcLogDir}/error_log"

    lpReturn
}



_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== dbaseInitialContent for Bystar Account:
_CommentEnd_

function vis_dbaseFullUpdate {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}

  #opDo vis_dbaseCreate ${dbaseName}
  opDo vis_dbaseInitialContentUpdate ${dbaseName}
  opDo vis_dbaseAccessControlVisible ${dbaseName}

}


function vis_dbaseCreate {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    # First we create an empty dbase

    opDoExit cd /var/lib/geneweb
    opDo gwc -o ${dbaseName}
    opDo  chmod g+w /var/lib/geneweb/${dbaseName}.gwb
}



function vis_dbaseAccessControlVisible {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarHereAnalyzeAcctBagp

    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.gwf
    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.auth

    opDo eval "echo \"wizard_passwd=${bystarUidPasswdDecrypted}\" > /var/lib/geneweb/${dbaseName}.gwf"

    opDo chown -R geneweb /var/lib/geneweb/${dbaseName}.gwf
}


function vis_dbaseAccessControlLimited {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarHereAnalyzeAcctBagp

    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.gwf
    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.auth

    opDo eval "echo \"wizard_passwd=${bystarUidPasswdDecrypted}\" > /var/lib/geneweb/${dbaseName}.gwf"
    opDo eval "echo \"auth_file=${dbaseName}.auth\" >> /var/lib/geneweb/${dbaseName}.gwf"
    opDo eval "echo \"family:4family\" > /var/lib/geneweb/${dbaseName}.auth"

    opDo chown -R geneweb /var/lib/geneweb/${dbaseName}.gwf
}


function vis_dbaseInitialContentUpdate {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  dbaseName=$1

  G_abortIfNotRunningAsRoot

  typeset tmpFile="$( FN_tempFile ).ged"

  opDo eval "vis_dbaseInitialContentStdout ${dbaseName} > ${tmpFile}"

  opDo ls -l ${tmpFile}

  opDoExit cd /var/lib/geneweb

  #opDo ged2gwb -f -o ${dbaseName} ${tmpFile}
  opDo ged2gwb -o ${dbaseName} ${tmpFile}
}

function vis_dbaseInitialContentStdout {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  dbaseName=$1

   opDoRet bystarHereAnalyzeAcctBagp

      cat  << _EOF_ 
0 HEAD
1 SOUR GeneWeb
2 VERS 5.01
2 NAME gwb2ged
2 CORP INRIA
3 ADDR Domaine de Voluceau
4 CONT B.P 105 - Rocquencourt
4 CITY Le Chesnay Cedex
4 POST 78153
4 CTRY France
3 PHON +33 01 39 63 55 11
2 DATA sa-20000.gwb
1 DATE 27 JUL 2010
2 TIME 02:52:37
1 FILE ${dbaseName}.ged
1 GEDC
2 VERS 5.5
2 FORM LINEAGE-LINKED
1 CHAR UTF-8
0 @I3@ INDI
1 NAME ${cp_FirstName} /${cp_LastName}/
1 SEX M
1 DEAT
0 @F1@ FAM
0 TRLR
_EOF_
}

# }}}

# {{{ ByStar Home Backup/Restore To/From:

function vis_genewebToBystarHome {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
    EH_assert [[ "${dbase}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}

  opAcctInfoGet ${bystarUid}

  opDoExit cd /var/lib/geneweb

  opDo /etc/init.d/geneweb stop

  opDo eval "find . -print | grep -v CVS | grep ${dbase} | cpio -o | (cd ${opAcct_homeDir}/lcaGeneweb; cpio -imdv)"

  opDo /etc/init.d/geneweb start

  opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaGeneweb
}


function vis_genewebFromBystarHome {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
    EH_assert [[ "${dbase}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}

    opAcctInfoGet ${bystarUid}

    opDoExit cd ${opAcct_homeDir}/lcaGeneweb


    opDo /etc/init.d/geneweb stop

    opDo eval "find . -print | grep -v CVS | grep ${dbase} | cpio -o | (cd /var/lib/geneweb; cpio -imdv)"

    opDo chown -R geneweb /var/lib/geneweb

    opDo /etc/init.d/geneweb start
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Obsoleted Features
_CommentEnd_




####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ================ /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
