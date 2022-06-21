#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

# http://www.thedjbway.org/qmailplus/mailfront.html

# (replace-string "ivd_qmailFile_locals" "ivd_qmailSendFile_locals" nil)

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"

####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"

####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedSubjectAction.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/opt/public/osmt/bin/seedSubjectAction.sh]] | 
"
FILE="
*  /This File/ :: /bisos/asc/mail/bin/lcaCvmHosts.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedSubjectAction.sh -l $0 "$@" 
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

localUnix does it 
But localQmail is not done.

How to determine which to add?
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
. ${bedrockBinBase}/mmaDaemontoolsLib.sh
. ${mailBinBase}/mmaQmailLib.sh
. ${dnsBinBase}/mmaDnsLib.sh
. ${mailBinBase}/mmaUcspiLib.sh

# . ${opBinBase}/lpCurrents.libSh



# PRE parameters

function G_postParamHook {
    # lpCurrentsGet

    # Parameters
    ENVDIR_ABS=$( which envdir )
    EH_assertContinue [[ "${ENVDIR_ABS}_" != "_" ]]
    
    return 0
}

# NOTYET, can be obtained from sysChar report
# opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
# ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}

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
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
___ BINS PREP ---
apt-get -y install cvm
--- INFORMATION ---
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile showCmdLine -a fullUpdate
--- SERVER ACTIONS FULL ---
=== Details with -- -T 7 ===
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a configFullUpdate -e "services not included"
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceFullUpdate -e "assumes configFullUpdate has been done"
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullUpdate -e "everything"
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullDelete
--- SERVICES CONFIGURATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig local-qmail
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSocketGet local-unix
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSocketGet local-qmail
-- SERVICES ACTIVATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesEnable local-unix local-qmail
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesEnable local-qmail
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesDisable local-unix local-qmail
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesDisable local-qmail
--- SERVICES MANIPULATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesList
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesShow all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart all
--- CVM CONFIGURATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a configure
---- TESTS  ----
cvm-testclient cvm-unix ${currentBystarUid} '' somePasswd
cvm-testclient cvm-unix ${currentBcaUid} '' somePasswd
cvm-testclient cvm-command:/usr/bin/cvm-unix ${currentBcaUid} '' jaebeico
cvm-testclient cvm-local:/tmp/CvmLocalUnix.socket ${currentBcaUid} '' jaebeico
cvm-testclient cvm-command:cvm-qmail main@service.librecenter.net ''
envdir /var/service/cvm-local-qmail/env cvm-testclient cvm-local:/tmp/CvmLocalQmail.socket main service.librecenter.net
--- COMMAND LINE EXAMPLES ---
vm-checkpassword cvm-command:/usr/local/bin/cvm-unix
cvm-checkpassword /usr/local/bin/cvm-unix
--- POINTERS and Documentation
http://thedjbway.org/qmailplus/cvm.html
_EOF_
}



noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_


function vis_doTheWork {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo vis_failExample
    EH_retOnFail

    lpReturn
}


function do_configure {
  opDo do_configFullUpdate
}

function do_fullVerify {
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? == 0 ]] ; then
    ${targetSubject}
  else
      doNothing
  fi
}

function do_fullUpdate {
#set -x
  subjectValidatePrepare

  do_servicesDisable local-unix local-qmail
  continueAfterThis
  
  do_configFullUpdate
  do_serviceFullUpdate
}

function do_serviceFullUpdate {
  subjectValidatePrepare

  do_servicesDisable local-unix local-qmail
  continueAfterThis

  do_servicesConfig all
  continueAfterThis

  do_servicesEnable local-unix local-qmail
  continueAfterThis

  do_servicesShow all

}

function do_configFullUpdate {
  targetSubject=item_${subject}

  subjectIsValid
  if [ $? == 0 ] ; then
    ${targetSubject}
  else
      doNothing
  fi
}


function do_fullDelete {
  EH_problem "NOTYET"
  return 1
}


#
#  SERVICES CONFIGURATION
#


function do_servicesConfig {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  continueAfterThis

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv="local-unix local-qmail"
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
      cvmDaemonConfig ${thisOne}
  done
}


function do_serviceSocketGet {
  EH_assert [[ $# -eq 1 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  case ${1} in
    "local-unix")
		  echo "/tmp/CvmLocalUnix.socket"
		  ;;
    "local-pwfile")
		  echo "/tmp/CvmLocalPwfile.socket"
		  ;;
    "local-qmail")
		  echo "/tmp/CvmLocalQmail.socket"
		  ;;
    *)
       EH_problem "Unknown:  ${1}"
       return 1  
       ;;
  esac
}


function cvmDaemonConfig {

  EH_assert [[ $# -eq 1 ]]


  case ${1} in
    "local-unix"|"local-pwfile"|"local-qmail")
				 doNothing
				 ;;
    *)
       EH_problem "Unknown:  ${1}"
       return 1  
       ;;
  esac

  baseServiceDir="/var/service/cvm-$1"
  

  #FN_dirSafeKeep ${baseServiceDir}
    
  opDoComplain mkdir -p ${baseServiceDir}
  #opDoComplain mkdir -p ${baseServiceDir}/log
    
  opDoComplain chmod +t ${baseServiceDir}

  m_myName=cvm-$1
   
  cvmDaemonRunStdout > ${baseServiceDir}/run

  opDoComplain chmod 755 ${baseServiceDir}/run

  opDo ls -l ${baseServiceDir}/run
}

function cvmDaemonRunStdout {
    m_myName=cvmDaemonConfig


    CVM_QMAIL_ABS=$( which cvm-qmail )
    EH_assert [[ "${CVM_QMAIL_ABS}_" != "_" ]]

   
cat  << _EOF_
#!/bin/bash
#
# MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
# DO NOT HAND EDIT
#

exec 2>&1

here=\$( pwd )

serverType=unknown

grepLocalUnixOut=\$( echo \${here} | grep cvm-local-unix  )
grepLocalPwfileOut=\$( echo \${here} | grep cvm-local-pwfile )
grepLocalQmailOut=\$( echo \${here} | grep cvm-local-qmail )

if [ "\${grepLocalUnixOut}_" != "_" ] ; then
    serverType=localUnix
elif [ "\${grepLocalPwfileOut}_" != "_" ] ; then
    serverType=localPwfile
elif [ "\${grepLocalQmailOut}_" != "_" ] ; then
    serverType=localQmail
else
    echo "Bad Base Dir: \${here}"
    exit 1
fi


function envDirSetVar {
    # $1=var $2=val
    if [ ! -d ./env ] ; then
	mkdir ./env
    fi
    #if [ ! -r ./env/\$1 ] ; then
	echo \$2 > ./env/\$1
    #fi
}

case \${serverType} in
    "localUnix")

    CVM_SOCKET="/tmp/CvmLocalUnix.socket"

    echo "*** Starting cvm-local-unix service..."
    echo "*** configured for domain socket: \${CVM_SOCKET}"

    # CVM "unix" authentication (/etc/passwd)
    # **communicating on local domain socket**

    exec /usr/bin/cvm-unix cvm-local:\${CVM_SOCKET}

       ;;

    "localPwfile")

    CVM_SOCKET="/tmp/CvmLocalPwfile.socket"

    echo "*** Starting cvm-local-pwfile service..."
    echo "*** configured for domain socket: \${CVM_SOCKET}"

    # CVM "pwfile" authentication
    # **communicating on local domain socket**

    exec /usr/bin/cvm-pwfile NOTYET cvm-local:\${CVM_SOCKET}
       ;;

    "localQmail")

    CVM_SOCKET="/tmp/CvmLocalQmail.socket"

    echo "*** Starting cvm-local-qmail service..."
    echo "*** configured for domain socket: \${CVM_SOCKET}"

    # CVM "pwfile" authentication
    # **communicating on local domain socket**


    envDirSetVar QMAIL_ROOT '${qmailVarDir}'
    envDirSetVar CVM_LOOKUP_SECRET 'liamq321'

exec ${ENVDIR_ABS} ./env \\
    ${CVM_QMAIL_ABS}  cvm-local:\${CVM_SOCKET}

       ;;

    *)
       echo "Unknown serverType: ${serverType}"
       exit 1
       ;;
esac
_EOF_
}



function do_servicesList {
  EH_assert [[ $# -eq 0 ]]

  echo "local-unix local-qmail"
}

function subjectIsRunHost {
  if [[ "${subject}_" != "${opRunHostName}_" ]] ; then
    EH_problem "Remote not supported"
    return 1
  fi
  return 0
}

function do_servicesStop {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
      argv="$( do_servicesList )"
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Stop"
  done
}

function do_servicesStart {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  continueAfterThis

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
      argv="$( do_servicesList )"
  else
      argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Start"
  done
}

function do_servicesRestart {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv="local-unix local-qmail"
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Restart"
  done
}

function do_servicesShow {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
    argv="local-unix local-qmail"
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Show"
  done
}

function serviceAction {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
  # $1 -- "service"
  # $2 --  action
  EH_assert [[ $# -eq 2 ]]

  if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

  case ${1} in
    "local-unix")
		  mmaDaemon${2} cvm-local-unix
		  ;;
    "local-qmail")
		  mmaDaemon${2} cvm-local-qmail
		  ;;
    *)
       EH_problem "Unknown:  ${1}"
       return 1  
       ;;
  esac
}


function cvmDaemonEnable {
  EH_assert [[ $# -gt 0 ]]

  typeset thisOne=""
  for thisOne in $@ ; do
    opDo  mmaDaemonUpdate cvm-${thisOne}  /var/service/cvm-${thisOne}
  done
}


function cvmDaemonDisable {
  EH_assert [[ $# -gt 0 ]]

  typeset thisOne=""
  for thisOne in $@ ; do
    opDo mmaDaemonStop cvm-${thisOne}
    opDo mmaDaemonDelete cvm-${thisOne}
  done
}

#
# Server Enable/Disable
#

function do_servicesEnable  {

  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  cvmDaemonEnable $@
}


function do_servicesDisable  {

  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  typeset thisOne=""
  typeset thisFeature=""

  cvmDaemonDisable $@
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


function item_bacs0002 {
  itemPre_serviceHost

  iv_serviceHost_host="bacs0002"
  iv_serviceHost_setup="server"

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
  #iv_serviceHost_setup="noService"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}

function itemFamily_BUE {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  #iv_serviceHost_setup="noService"
  iv_serviceHost_setup="server"

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
