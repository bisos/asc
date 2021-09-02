#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: lcaMailfrontHosts.sh,v 1.2 2016-08-14 06:03:46 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedSubjectAction.sh"
SEED="
* /[dblock]/--Seed/: /opt/public/osmt/bin/seedSubjectAction.sh
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedSubjectAction.sh -l $0 "$@" 
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(org-cycle)][Fold]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(delete-other-windows)][(1)]]  | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] 
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

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
# http://www.thedjbway.org/qmailplus/mailfront.html

3 instances of mailfront are run.

The variations are:
   1) What modules are loaded -- All three have all same modules
   2) If tcpserver is run or if sslserver is run with which options.

sslserver with -n should do tls. sslserver is patched for tls.

But mailfront is not patched for tls

25/tcp   smtp         "inNetSmtp" "pubinsmtpd"
         Invoked by tcpserver

587/tcp  submission    "submitServerSmtp" "authsmtpd"
         Invoked by tcpserver
         Should 

465/tcp  smtps         "sslNetSmtp" "sslinsmtpd"
         Invoked by sslserver without "-n" ssl not tls.

TODO:

    - Cleanup run scripts not to use commandline options 
      but : separated options list same as commandline.

    - Upgrade to a version of mailfront that supports starttls.

    - Add ClamAV and spamassassin modules to mailfront

    - Generally cleanup the script.
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
. ${opBinBase}/mmaDaemontoolsLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh
. ${opBinBase}/mmaUcspiLib.sh

#setBasicItemsFiles mmaQmailNewHostItems
setBasicItemsFiles mmaQmailHostItems

allServicesList="submitServerSmtp  inNetSmtp sslNetSmtp"

opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
# ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}


# PRE parameters

function G_postParamHook {
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
apt-get -y install mailfront
--- INFORMATION ---
--- Server Software Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile verify
--- SERVER ACTIONS FULL ---
=== Details with -- -T 7 ===
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a configFullUpdate -e "services not included"
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceFullUpdate -e "assumes configFullUpdate has been done"
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullUpdate -e "everything"
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullDelete
--- SERVICES CONFIGURATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig submitServerSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig inNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesConfig sslNetSmtp
-- SERVICES ACTIVATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesEnable
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesDisable
${G_myName} ${extraInfo} -i  smtpDaemonEnable  submitServerSmtp
${G_myName} ${extraInfo} -i  smtpDaemonEnable  inNetSmtp
${G_myName} ${extraInfo} -i  smtpDaemonEnable  sslNetSmtp
${G_myName} ${extraInfo} -i  smtpDaemonDisable  submitServerSmtp
${G_myName} ${extraInfo} -i  smtpDaemonDisable  inNetSmtp
${G_myName} ${extraInfo} -i  smtpDaemonDisable  sslNetSmtp
--- SERVICES MANIPULATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesList
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesShow all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop inNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop sslNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStop submitServerSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart inNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart sslNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesStart submitServerSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart all
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart inNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart sslNetSmtp
${G_myName} ${extraInfo} -s ${opRunHostName} -a servicesRestart submitServerSmtp
--- QMAIL CONFIGURATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a configure
--- SSL Keys ---
${G_myName} ${extraInfo} -i sslKeysBaseDir; echo \$?
${G_myName} ${extraInfo} -i sslKeysGen
${G_myName} ${extraInfo} -i sslKeysDelete
${G_myName} ${extraInfo} -i sslKeysUpdate
--- SUBMIT/RELAY ACCESS CONTROL ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a submitServerAccessShow
${G_myName} ${extraInfo} -s ${opRunHostName} -a submitServerAllowList
${G_myName} ${extraInfo} -s ${opRunHostName} -a submitServerDenyList
--- LOGS AND REPORTS ---
mmaQmailAdmin.sh -h -n showRun -i showLogs
--- Devel Funcs ---
${G_myName} ${extraInfo} -i frontsmtpdRunStdout sslNetSmtp
${G_myName} ${extraInfo} -i frontsmtpdLogRunStdout sslNetSmtp
_EOF_
}

noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_


function servicePrep {
  EH_assert [[ $# -eq 1 ]]

  thisFeature=$1

  serviceName="NO_SERVICE"
  case ${thisFeature} in
      "submitServerSmtp")
                          serviceName="authsmtpd"
                          ;;

      "inNetSmtp")
                   serviceName="pubinsmtpd"
                   ;;

      "sslNetSmtp")
                   serviceName="sslinsmtpd"
                   ;;

    *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1  
       ;;
  esac

}


function do_summary {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  typeset -L10 v1=${iv_qmailHost}
  typeset -L20  v2=${iv_qmailSetup}
  typeset -L20  v3=${iv_qmailHost_mainDomRef}
  typeset -L80  v4=${iv_qmailHost_VirDomsRefList[@]}

  print "${v1}${v2}${v3}${v4}"
}


function do_serviceSoftwareProfile {
  EH_assert [[ $# -eq 1 ]]
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  
  ANT_raw "Software Profile For ${subject}"

  softwareProfile=""

  for thisFeature in ${iv_qmailSetup} ; do
    case ${thisFeature} in
      "submitServerSmtp"|"inNetSmtp"|"sslNetSmtp")
        softwareProfile="qmailIsp"
        break
        ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1  
       ;;
    esac
  done

  if [ "${softwareProfile}_" == "_" ] ; then
    ANT_raw "No Service"
    echo ""
    if [ "$1_" != "tag_" ] ; then
      echo "NoService"
    fi
    return
  fi

  case ${1} in
    "update"|"verify"|"delete")
              echo "lcaMailfrontBinsPrep.sh -s ${softwareProfile} -a $1"
               ;;
    "tag")
              echo "${softwareProfile}"
               ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}

function gcf_qmailSmtpd {
  #  QMAIL-SMTPD control files

    #set -x

  continueAfterThis

  # rcpthosts
  ivd_qmailSmtpdFile_rcpthosts="${iv_qmailAcceptDestinedTo}"

  if [ "${ivd_qmailSmtpdFile_rcpthosts}X" != "_DONT_X" ] ; then
    TM_trace 7 "ivd_qmailSmtpdFile_rcpthosts=${ivd_qmailSmtpdFile_rcpthosts}"
    echo "${ivd_qmailSmtpdFile_rcpthosts}" > ${qmailControlBaseDir}/rcpthosts
    opDo chmod 644 ${qmailControlBaseDir}/rcpthosts
  fi
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
    itemPre_qmailHost
    itemPost_qmailHost
  fi

  #mmaQmailAdmin.sh -i fullReport
  opDo mmaQmailAdmin.sh -i showProcs
}


function do_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
    
    subjectValidatePrepare
    
    opDoAfterPause do_servicesDisable

    opDoAfterPause do_configFullUpdate
    opDoAfterPause do_serviceFullUpdate
}

function do_serviceFullUpdate {
  subjectValidatePrepare

  do_servicesDisable
  continueAfterThis

  do_servicesConfig all
  continueAfterThis

  do_servicesEnable
  continueAfterThis

  do_servicesShow all

}

function do_configFullUpdate {
  targetSubject=item_${subject}

  subjectIsValid
  if [ $? == 0 ] ; then
    ${targetSubject}
  else
    itemPre_qmailHost
    itemPost_qmailHost
  fi

  continueAfterThis

  #set -x

  # NOTYET, verify that the daemons have been stopped.
  #opDo lcaQmailAdmin.sh -i stop


  do_itemActions

  #opDo lcaQmailAdmin.sh -i start
}


function do_fullDelete {
  EH_problem "NOTYET"
  return 1
}


function do_servicesConfig {
  EH_assert [[ $# -gt 0 ]]
  subjectValidatePrepare

  opDoRet subjectIsRunHost || return $?

  continueAfterThis

  typeset argv=""
  if [[ "$1_" = "all_" ]] ; then
   argv=${allServicesList}
  else
    argv="$@"
  fi

  #
  # NOTYET, this is being done externally as it is interactive. 
  #  Also, there may be a better place to run vis_sslKeysGen
  #
  #opDo vis_sslKeysGen

  typeset thisOne=""
  #mailEngine submitServerSmtp fullServer
  for thisOne in ${argv} ; do
    smtpdDaemonConfig ${thisOne}                            
  done
}

# Parameters
SOFTLIMIT_ABS=`which softlimit`
EH_assert [[ "${SOFTLIMIT_ABS}_" != "_" ]]

TCPSERVER_ABS=`which tcpserver`
EH_assert [[ "${TCPSERVER_ABS}_" != "_" ]]

SSLSERVER_ABS=`which sslserver`
EH_assert [[ "${SSLSERVER_ABS}_" != "_" ]]

SETUIDGID_ABS=`which setuidgid`
EH_assert [[ "${SETUIDGID_ABS}_" != "_" ]]

ENVUIDGID_ABS=`which envuidgid`
EH_assert [[ "${ENVUIDGID_ABS}_" != "_" ]]

MULTILOG_ABS=`which multilog`
EH_assert [[ "${MULTILOG_ABS}_" != "_" ]]

RBLSMTPD_ABS=`which rblsmtpd`
EH_assert [[ "${RBLSMTPD_ABS}_" != "_" ]]

ENV_ABS=`which env`
EH_assert [[ "${ENV_ABS}_" != "_" ]]

ENVDIR_ABS=`which envdir`
EH_assert [[ "${ENVDIR_ABS}_" != "_" ]]

MAILFRONT_ABS=`which mailfront`
EH_assert [[ "${MAILFRONT_ABS}_" != "_" ]]

MAILFRONT_CMD="${MAILFRONT_ABS} smtp qmail check-fqdn counters mailrules relayclient cvm-validate qmail-validate add-received patterns accept-sender"

# smtpfront-qmail does not work on Lenny
SMTPFRONT_QMAIL_ABS=$( which smtpfront-qmail )
EH_assertContinue [[ "${SMTPFRONT_QMAIL_ABS}_" != "_" ]]


#
#  STDOUTs
#


function frontsmtpdRunStdout {

    m_myName=frontsmtpd

   cvmLocalUnixSocket=$( lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a serviceSocketGet local-unix )
   EH_assert [[ "${cvmLocalUnixSocket}_" != "_" ]]

   cvmLocalQmailSocket=$( lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a serviceSocketGet local-qmail )
   EH_assert [[ "${cvmLocalQmailSocket}_" != "_" ]]

cat  << _EOF_
#!/bin/bash
#
# MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
# DO NOT HAND EDIT
#

exec 2>&1

here=\$( pwd )

serverType=unknown

grepAuthSmtpdOut=\$( echo \${here} | grep authsmtpd  )
grepPubSmtpdOut=\$( echo \${here} | grep pubinsmtpd )
grepSslSmtpdOut=\$( echo \${here} | grep sslinsmtpd )

if [ "\${grepAuthSmtpdOut}_" != "_" ] ; then
    serverType=authsmtpd
elif [ "\${grepPubSmtpdOut}_" != "_" ] ; then
    serverType=pubinsmtpd
elif [ "\${grepSslSmtpdOut}_" != "_" ] ; then
    serverType=sslinsmtpd
else
    echo "Bad Base Dir: \${here}"
    exit 1
fi


QMAILDUID=\`id -u qmaild\`
NOFILESGID=\`id -g qmaild\`
LOCAL=\`head -1 ${qmailVarDir}/control/me\`

CONLIMIT=29
IPADDR=0

# 50 Meg
LimitSizeMem=50000000

# 100 Meg
LimitSizeFile=100000000

function envDirSetVar {
    # \$1=var \$2=val
    if [ ! -d ./env ] ; then
        mkdir ./env
    fi
    #if [ ! -r ./env/\$1 ] ; then
        echo \$2 > ./env/\$1
    #fi
}

envDirSetVar QMAILHOME "${qmailVarDir}"
envDirSetVar DATABYTES '50000000'
envDirSetVar MAXRCPTS  '50'

#setup_envdir PATTERNS "${qmailVarDir}/control/badmimes"
#


if [ -z "\$QMAILDUID" -o -z "\$NOFILESGID" -o -z "\$LOCAL" ]; then
    echo QMAILDUID, NOFILESGID or LOCAL is unset in
    echo \${here}/run
    exit 1
fi

if [ ! -f ${qmailVarDir}/control/rcpthosts ]; then
    echo "No ${qmailVarDir}/control/rcpthosts!"
    echo "Refusing to start SMTP listener because it'll create an open relay"
    exit 1
fi

case \${serverType} in
    "authsmtpd")
        PORT=587      #rfc2476 "submission"
        
       ## standard mailfront plugins, less 'cvm-validate', plus 'require-auth':
       ## (note: 'require-auth' is placed before 'accept-sender')
       PLUGINS_ARGS="check-fqdn counters mailrules relayclient qmail-validate add-received patterns require-auth accept-sender"

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'


echo "*** Starting qmail-authsmtpd..."
echo "*** using plugins_args: \${PLUGINS_ARGS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m \${LimitSizeMem} -f \${LimitSizeFile} \\
          ${TCPSERVER_ABS} -v -PR \\
          -U \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \\
          \${PORT} \\
             ${MAILFRONT_ABS} smtp qmail \${PLUGINS_ARGS}
       ;;

    "pubinsmtpd")

       PORT=25
       ## standard mailfront plugins in standard order:
       PLUGINS_ARGS="check-fqdn counters mailrules relayclient cvm-validate qmail-validate add-received patterns accept-sender"

       envDirSetVar CVM_LOOKUP 'cvm-local:${cvmLocalQmailSocket}'
       envDirSetVar CVM_LOOKUP_SECRET 'liamq321'

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'

echo "*** Starting qmail-pubinsmtpd..."
echo "*** using plugins_args: \${PLUGINS_ARGS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m \${LimitSizeMem} -f \${LimitSizeFile} \\
          ${TCPSERVER_ABS} -v -PR \\
          -U \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \\
          \${PORT} \\
             ${RBLSMTPD_ABS} -B -t 300 \\
             -r bl.spamcop.net -r zen.spamhaus.org \\
                ${MAILFRONT_ABS} smtp qmail \${PLUGINS_ARGS}
       ;;

    "sslinsmtpd")
       PORT=465

       ## standard mailfront plugins in standard order:
       PLUGINS_ARGS="check-fqdn counters mailrules relayclient cvm-validate qmail-validate add-received patterns accept-sender"

       envDirSetVar CVM_LOOKUP 'cvm-local:${cvmLocalQmailSocket}'
       envDirSetVar CVM_LOOKUP_SECRET 'liamq321'

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'

        # Set these three
        SSL_USER=ssl
        SSL_GROUP=ssl
        SSL_DIR=${qmailVarDir}/ssl
        # The rest are set based on the above three

        # Enable UCSPI-TLS
        envDirSetVar UCSPITLS 1

       envDirSetVar SSL_CHROOT \$SSL_DIR

       envDirSetVar CERTFILE \$SSL_DIR/cert

       envDirSetVar KEYFILE \$SSL_DIR/key

       envDirSetVar DHFILE \$SSL_DIR/dhparam

       SSL_UID=\$( id -u \$SSL_USER )
       if [ $? -ne 0 ]; then echo "No such user \$SSL_USER" >&2; exit; fi
       envDirSetVar SSL_UID \$SSL_UID

       SSL_GID=\$( id -g \$SSL_GROUP )
       if [ $? -ne 0 ]; then echo "No such group \$SSL_GROUP" >&2; exit; fi
       envDirSetVar SSL_GID \$SSL_GID


echo "*** Starting qmail-sslinsmtpd..."
echo "*** using plugins_args: \${PLUGINS_ARGS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m \${LimitSizeMem} -f \${LimitSizeFile} \\
          ${SSLSERVER_ABS} \\
          -e \\
          -R \\
          -v \\
          -l 0 \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \\
          \${PORT} \\
                ${MAILFRONT_ABS} smtp qmail \${PLUGINS_ARGS}
       ;;


    *)
       echo "Unknown serverType: ${serverType}"
       exit 1
       ;;
esac
_EOF_
}


function frontsmtpdLogRunStdout {
    m_myName=frontsmtpdLog

cat  << _EOF_
#!/bin/sh
#
# MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
# DO NOT HAND EDIT
#

here=\$( pwd )

serverType=unknown

grepAuthSmtpdOut=\$( echo \${here} | grep authsmtpd  )
grepPubSmtpdOut=\$( echo \${here} | grep pubinsmtpd )
grepSslSmtpdOut=\$( echo \${here} | grep sslinsmtpd )

if [ "\${grepAuthSmtpdOut}_" != "_" ] ; then
    serverType=authsmtpd
elif [ "\${grepPubSmtpdOut}_" != "_" ] ; then
    serverType=pubinsmtpd
elif [ "\${grepSslSmtpdOut}_" != "_" ] ; then
    serverType=sslinsmtpd
else
    echo "Bad Base Dir: \${here}"
    exit 1
fi

exec 2>&1

case \${serverType} in
    "authsmtpd")
                   exec ${SETUIDGID_ABS} qmaill ${MULTILOG_ABS} t s1000000 n2000 /var/log/qmail/authsmtpd
                   ;;

    "pubinsmtpd")
                 exec ${SETUIDGID_ABS} qmaill ${MULTILOG_ABS} t s1000000 n2000 /var/log/qmail/pubinsmtpd
                 ;;

    "sslinsmtpd")
                 exec ${SETUIDGID_ABS} qmaill ${MULTILOG_ABS} t s1000000 n2000 /var/log/qmail/sslinsmtpd
                 ;;

    *)
       echo "Unknown serverType: ${serverType}"
       exit 1
       ;;
esac
_EOF_
}

function vis_frontsmtpdRunStdout {
  EH_assert [[ $# -eq 1 ]]

  opDoRet servicePrep $1

  case ${serviceName} in
    "authsmtpd"|"pubinsmtpd"|"sslinsmtpd")
                              doNothing
                              ;;
    "NO_SERVICE")
                  return
                  ;;
    *)
       EH_problem "Unknown:  ${serviceName}"
       return 1  
       ;;
  esac

  frontsmtpdRunStdout
}

function vis_frontsmtpdLogRunStdout {
  EH_assert [[ $# -eq 1 ]]

  opDoRet servicePrep $1

  case ${serviceName} in
    "authsmtpd"|"pubinsmtpd"|"sslinsmtpd")
                              doNothing
                              ;;
    "NO_SERVICE")
                  return
                  ;;
    *)
       EH_problem "Unknown:  ${serviceName}"
       return 1  
       ;;
  esac

  frontsmtpdLogRunStdout
}

function smtpdDaemonConfig {
  EH_assert [[ $# -eq 1 ]]

  opDoRet servicePrep $1

  case ${serviceName} in
    "authsmtpd"|"pubinsmtpd"|"sslinsmtpd")
                              doNothing
                              ;;
    "NO_SERVICE")
                  return
                  ;;
    *)
       EH_problem "Unknown:  ${serviceName}"
       return 1  
       ;;
  esac

  baseServiceDir="${qmailVarDir}/supervise/qmail-${serviceName}"
  
  #FN_dirSafeKeep ${baseServiceDir}
    
  opDoComplain mkdir -p ${baseServiceDir}
  opDoComplain mkdir -p ${baseServiceDir}/log
    
  opDoComplain chmod +t ${baseServiceDir}

  FN_fileSafeKeep ${baseServiceDir}/run

  frontsmtpdRunStdout > ${baseServiceDir}/run

  opDoComplain chmod 755 ${baseServiceDir}/run

  opDo ls -l ${baseServiceDir}/run

  FN_fileSafeKeep ${baseServiceDir}/log/run

  frontsmtpdLogRunStdout > ${baseServiceDir}/log/run

  opDoComplain chmod 755 ${baseServiceDir}/log/run

  opDo ls -l ${baseServiceDir}/log/run

  #
  # Now do the /var/log setups
  # 

  baseServiceLogDir="/var/log/qmail/${serviceName}"

  opDoComplain mkdir -p ${baseServiceLogDir}
  opDoComplain chown qmaill ${baseServiceLogDir}
  opDoComplain chgrp -R qmail ${baseServiceLogDir}
}


function do_servicesList {
  EH_assert [[ $# -eq 0 ]]
  do_serverType
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
    argv=${allServicesList}
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
    argv=${allServicesList}
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
    argv=${allServicesList}
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
    argv=${allServicesList}
  else
    argv="$@"
  fi

  typeset thisOne=""
  for thisOne in ${argv} ; do
    serviceAction  "${thisOne}" "Show"
  done
}

qmailSmtpdVirgin="true"
qmailAuthSmtpdVirgin="true"
qmailSslSmtpdVirgin="true"

function serviceAction {
  # $1 -- "service"
  # $2 --  action
  EH_assert [[ $# -eq 2 ]]

  opDoRet servicePrep $1

  case ${1} in
    "submitServerSmtp")
        if [[ "${qmailAuthSmtpdVirgin}_" == "true_" ]] ; then
          qmailAuthSmtpdVirgin="false"
          mmaDaemon${2} qmail-${serviceName}
          mmaDaemon${2} qmail-${serviceName}/log
        fi
        ;;

    "sslNetSmtp")
        if [[ "${qmailSslSmtpdVirgin}_" == "true_" ]] ; then
          qmailSslSmtpdVirgin="false"
          mmaDaemon${2} qmail-${serviceName}
          mmaDaemon${2} qmail-${serviceName}/log
        fi
        ;;

    "inNetSmtp")
        if [[ "${qmailSmtpdVirgin}_" == "true_" ]] ; then
          qmailSmtpdVirgin="false"
          mmaDaemon${2} qmail-${serviceName}
          mmaDaemon${2} qmail-${serviceName}/log
        fi
        ;;

    *)
       EH_problem "Unknown:  ${1}"
       return 1  
       ;;
  esac
}



function vis_smtpDaemonEnable {
  EH_assert [[ $# -eq 1 ]]

  opDoRet servicePrep $1

  opDo mmaDaemonUpdate qmail-${serviceName}  ${qmailVarDir}/supervise/qmail-${serviceName}
}


function vis_smtpDaemonDisable {
  EH_assert [[ $# -eq 1 ]]

  opDoRet servicePrep $1

  opDo mmaDaemonStop qmail-${serviceName} qmail-${serviceName}/log
  opDo mmaDaemonDelete qmail-${serviceName}
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

  typeset thisOne=""
  typeset thisFeature=""

  for thisFeature in ${allServicesList} ; do

    case ${thisFeature} in
      "submitServerSmtp")
        vis_smtpDaemonEnable submitServerSmtp

        do_submitServerAllowList
        do_submitServerDenyList
        ;;

      "inNetSmtp")
        vis_smtpDaemonEnable inNetSmtp
        ;;

      "sslNetSmtp")
        vis_smtpDaemonEnable sslNetSmtp
        ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1  
       ;;
    esac
  done
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

  for thisFeature in ${allServicesList} ; do
    case ${thisFeature} in
      "submitServerSmtp")
        vis_smtpDaemonDisable submitServerSmtp
        ;;

      "inNetSmtp")
        vis_smtpDaemonDisable inNetSmtp
        ;;

      "sslNetSmtp")
        vis_smtpDaemonDisable sslNetSmtp
        ;;

      *)
       EH_problem "Unknown:  ${thisFeature}"
       return 1  
       ;;
    esac
  done
}

function do_submitServerAccessShow {
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  if LIST_isIn "submitServerSmtp" "${allServicesList}" ; then
    doNothing
  else
    EH_problem "Not a submitServerSmtp - echo ${allServicesList}"
    return 1
  fi

  opDoComplain cat /etc/tcp.smtp

  opDoComplain cat /etc/tcprules/smtp

  opDoComplain cat /etc/tcprules/authsmtp

}



function do_submitServerAllowList {
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  typeset thisOne=""

  if [ ! -d /etc/tcprules ] ; then
     opDo mkdir /etc/tcprules
  fi    

  for thisOne in ${iv_qmailSubmitServerAllowList[@]} ; do
    opDoComplain mmaUcspiAllowAdd /etc/tcprules/smtp ${thisOne} RELAYCLIENT=\"\"
  done

  opDo FN_fileRmIfThere /etc/tcprules/authsmtp

  opDoComplain mmaUcspiAllowAdd /etc/tcprules/authsmtp '' ''

  mmaUcspiTcprulesCompile /etc/tcprules/smtp /etc/tcprules/smtp.cdb
  mmaUcspiTcprulesCompile /etc/tcprules/authsmtp /etc/tcprules/authsmtp.cdb
}



function do_submitServerDenyList {
  targetSubject=item_${subject}

  subjectIsValid
  if [[ $? != 0 ]] ; then
    EH_problem "Invalid Subject: ${targetSubject}"
    return 1
  fi

  ${targetSubject}

  typeset thisOne=""

  for thisOne in ${iv_qmailSubmitServerDenyList[@]} ; do
    echo ${thisOne}
  done
}


function vis_sslKeysBaseDir {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    typeset qmailSslBaseDir="${qmailVarDir}/ssl"

    echo "${qmailSslBaseDir}"

    if [ -d "${qmailSslBaseDir}" ] ; then
        lpReturn 0
    else
        lpReturn 1
    fi
}


function vis_sslKeysDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset thisFunc=${G_thisFunc}

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    typeset sslBaseDir=$( vis_sslKeysBaseDir )

    if ! vis_sslKeysBaseDir > /dev/null ; then
        EH_problem "Missing ${sslBaseDir} -- Skipped No Action Taken"
        lpReturn 127
    fi

    #

    ANT_raw "${thisFunc}: About To Remove ${sslBaseDir}"

    opDo FN_dirSafeKeep "${sslBaseDir}"
    opDo /bin/rm -r -f "${sslBaseDir}"

    lpReturn
}


function vis_sslKeysUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]


    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    typeset sslBaseDir=$( vis_sslKeysBaseDir )

    #echo AAA
    if vis_sslKeysBaseDir ; then
        #echo BB
        opDo vis_sslKeysDelete
    else
        ANT_raw "Missing ${sslBaseDir} -- Will Generate It"
    fi

    #echo CC
    opDo vis_sslKeysGen

    lpReturn
}


function vis_sslKeysGen {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    typeset sslBaseDir=$( vis_sslKeysBaseDir )

    if vis_sslKeysBaseDir > /dev/null ; then
        EH_problem "${sslBaseDir} Already In Place -- Perhaps Run sslKeysUpdate instead"
        lpReturn 127
    fi

    opDo mkdir ${sslBaseDir}
    opDo chown root ${sslBaseDir}
    opDo chmod 700 ${sslBaseDir}
    opDoExit cd ${sslBaseDir}

    opDo umask 077

    opDo openssl req -new -x509 -keyout key.enc -out cert -days 3650

    # Sign it? Remove Passwd
    opDo openssl rsa -in key.enc -out key

    opDo openssl dhparam -out dhparam 1024

    opDo groupadd ssl
    opDo useradd -g ssl -d ${qmailVarDir} ssl

    opDo umask 022
}


#
##  JUNK YARD
#


function frontsmtpdRunStdoutOLD {

    m_myName=frontsmtpd

   cvmLocalUnixSocket=$( lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a serviceSocketGet local-unix )
   EH_assert [[ "${cvmLocalUnixSocket}_" != "_" ]]

   cvmLocalQmailSocket=$( lcaCvmHosts.sh -h -v -n showRun -s ${opRunHostName} -a serviceSocketGet local-qmail )
   EH_assert [[ "${cvmLocalQmailSocket}_" != "_" ]]

cat  << _EOF_
#!/bin/bash
#
# MACHINE GENERATED with ${G_myName} and ${m_myName} on ${dateTag}
# DO NOT HAND EDIT
#

exec 2>&1

here=\$( pwd )

serverType=unknown

grepAuthSmtpdOut=\$( echo \${here} | grep authsmtpd  )
grepPubSmtpdOut=\$( echo \${here} | grep pubinsmtpd )
grepSslSmtpdOut=\$( echo \${here} | grep sslinsmtpd )

if [ "\${grepAuthSmtpdOut}_" != "_" ] ; then
    serverType=authsmtpd
elif [ "\${grepPubSmtpdOut}_" != "_" ] ; then
    serverType=pubinsmtpd
elif [ "\${grepSslSmtpdOut}_" != "_" ] ; then
    serverType=sslinsmtpd
else
    echo "Bad Base Dir: \${here}"
    exit 1
fi


QMAILDUID=\`id -u qmaild\`
NOFILESGID=\`id -g qmaild\`
LOCAL=\`head -1 ${qmailVarDir}/control/me\`

CONLIMIT=29
IPADDR=0
PORT=587     #rfc2476 "submission"

HOSTNAME=NOTYET

function envDirSetVar {
    # $1=var $2=val
    if [ ! -d ./env ] ; then
        mkdir ./env
    fi
    #if [ ! -r ./env/\$1 ] ; then
        echo \$2 > ./env/\$1
    #fi
}

envDirSetVar QMAILHOME "${qmailVarDir}"
envDirSetVar DATABYTES '50000000'
envDirSetVar MAXRCPTS  '50'

#setup_envdir PATTERNS "${qmailVarDir}/control/badmimes"
#


if [ -z "\$QMAILDUID" -o -z "\$NOFILESGID" -o -z "\$LOCAL" ]; then
    echo QMAILDUID, NOFILESGID or LOCAL is unset in
    echo \${here}/run
    exit 1
fi

if [ ! -f ${qmailVarDir}/control/rcpthosts ]; then
    echo "No ${qmailVarDir}/control/rcpthosts!"
    echo "Refusing to start SMTP listener because it'll create an open relay"
    exit 1
fi

case \${serverType} in
    "authsmtpd")
        PORT=587
        
       ## standard mailfront plugins, less 'cvm-validate', plus 'require-auth':
       ## (note: 'require-auth' is placed before 'accept-sender')
       PLUGINS="check-fqdn:counters:mailrules:relayclient:qmail-validate:add-received:patterns:require-auth:accept-sender"

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'


echo "*** Starting qmail-authsmtpd..."
echo "*** using plugins: \${PLUGINS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m 3000000 -f 10000000 \\
          ${TCPSERVER_ABS} -v -PR \\
          -U \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \${PORT} \\
             ${MAILFRONT_CMD}
       ;;

    "pubinsmtpd")

       PORT=25
       ## standard mailfront plugins in standard order:
       PLUGINS="check-fqdn:counters:mailrules:relayclient:cvm-validate:qmail-validate:add-received:patterns:accept-sender"
       # Union of the two
       #PLUGINS="check-fqdn:counters:mailrules:relayclient:cvm-validate:qmail-validate:add-received:patterns:require-auth:accept-sender"


       envDirSetVar CVM_LOOKUP 'cvm-local:${cvmLocalQmailSocket}'
       envDirSetVar CVM_LOOKUP_SECRET 'liamq321'

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'

echo "*** Starting qmail-pubinsmtpd..."
echo "*** using plugins: \${PLUGINS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m 3000000 -f 10000000 \\
          ${TCPSERVER_ABS} -v -PR \\
          -U \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \${PORT} \\
             ${RBLSMTPD_ABS} -B -t 300 \\
             -r bl.spamcop.net -r zen.spamhaus.org \\
                ${MAILFRONT_CMD}

#  ${SMTPFRONT_QMAIL_ABS} - On Debian:Lenny bash crashes so mailfron is run directly
#smtp ${RBLSMTPD_ABS} -r relays.ordb.org -r bl.spamcop.net -r cbl.abuseat.org -r list.dsbl.org -r zen.spamhaus.org
       ;;

    "sslinsmtpd")

       PORT=465
       ## standard mailfront plugins in standard order:
       #PLUGINS="check-fqdn:counters:mailrules:relayclient:cvm-validate:qmail-validate:add-received:patterns:accept-sender"
       # Union of the two
       #PLUGINS="check-fqdn:counters:mailrules:relayclient:cvm-validate:qmail-validate:add-received:patterns:require-auth:accept-sender"


       envDirSetVar CVM_LOOKUP 'cvm-local:${cvmLocalQmailSocket}'
       envDirSetVar CVM_LOOKUP_SECRET 'liamq321'

       envDirSetVar CVM_SASL_LOGIN 'cvm-local:${cvmLocalUnixSocket}'


        # Set these three
        SSL_USER=ssl
        SSL_GROUP=ssl
        SSL_DIR=${qmailVarDir}/ssl
        # The rest are set based on the above three

        # Enable UCSPI-TLS
        envDirSetVar UCSPITLS 1

       envDirSetVar SSL_CHROOT \$SSL_DIR

       envDirSetVar CERTFILE \$SSL_DIR/cert

       envDirSetVar KEYFILE \$SSL_DIR/key

       envDirSetVar DHFILE \$SSL_DIR/dhparam

       SSL_UID=\$( id -u \$SSL_USER )
       if [ $? -ne 0 ]; then echo "No such user \$SSL_USER" >&2; exit; fi
       envDirSetVar SSL_UID \$SSL_UID

       SSL_GID=\$( id -g \$SSL_GROUP )
       if [ $? -ne 0 ]; then echo "No such group \$SSL_GROUP" >&2; exit; fi
       envDirSetVar SSL_GID \$SSL_GID


echo "*** Starting qmail-sslinsmtpd..."
echo "*** using plugins: \${PLUGINS}"

exec ${ENV_ABS} - LOGLEVEL=3\\
  ${ENVDIR_ABS} ./env \\
     ${ENVUIDGID_ABS} qmaild \\
        ${SOFTLIMIT_ABS} -m 9000000 -f 10000000 \\
          ${SSLSERVER_ABS} \\
          -e \\
          -R \\
          -v \\
          -l 0 \\
          -c \${CONLIMIT} \\
          -x /etc/tcprules/authsmtp.cdb \\
          \${IPADDR} \\
          \${PORT} \\
                ${MAILFRONT_CMD}

       ;;


    *)
       echo "Unknown serverType: ${serverType}"
       exit 1
       ;;
esac
_EOF_
}


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ######[[elisp:(org-cycle)][Fold]]###### /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
