#!/bin/bash
#!/bin/bash 

typeset RcsId="$Id: lcaSpamAAdmin.sh,v 1.3 2018-01-08 00:22:47 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    /bisos/core/bsip/bin/seedAdminDaemonSysV.sh -l $0 $@
    exit $?
fi

#
# UBUMTU 1604 1804 Needs: systemctl enable spamassassin.service
#

daemonName="spamassassin"
daemonControlScript="/etc/init.d/${daemonName}"

serviceDefaultFile="/etc/default/${daemonName}"

# /etc/spamassassin/
daemonConfigDir="/etc/${daemonName}"
#daemonConfigFile="${daemonConfigDir}/local.cf"
daemonConfigFile="" # No Configuration 

# /var/log/mail.log  /var/log/mail.err
daemonLogTag="spamd"
daemonLogDir="/var/log"
daemonLogFile="${daemonLogDir}/mail.log"
daemonLogErrFile="${daemonLogDir}/mail.err"

vis_help () {
  cat  << _EOF_
    ${daemonName}

    Based on the generic SysV init daemon Start/Stop/Restart.

   TODO:

_EOF_
}

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/lpParams.libSh


function G_postParamHook {
    lpCurrentsGet

    # Nothing done in this case

  return 0
}


function vis_examples {
    typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
    extraInfo="-h -v -n showRun"
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
_EOF_

  vis_examplesFullService

  vis_examplesDaemonControl


 cat  << _EOF_
--- SERVER CONFIG BEGIN ---
--- SERVER CONFIG END ---
_EOF_
  
  vis_examplesServerConfig

  vis_examplesLogInfo

}


noArgsHook() {
    vis_examples
}

