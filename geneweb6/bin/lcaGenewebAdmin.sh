#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaGenewebAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    $(dirname $0 )/seedAdminDaemonSysV.sh -l $0 $@
    exit $?
fi

daemonName="geneweb"
daemonControlScript="/etc/init.d/${daemonName}"

serviceDefaultFile="/etc/default/${daemonName}"

# /etc/courier-imap-ssl/
daemonConfigDir=""
daemonConfigFile=""

# /var/log/courier-imap-ssl/
daemonLogDir="/var/log/${daemonName}"
daemonLogFile="${daemonLogDir}/access.log"
daemonLogErrFile="${daemonLogDir}/error.log"

vis_help () {
  cat  << _EOF_
    ${daemonName}

    Based on the generic SysV init daemon Start/Stop/Restart.

   TODO:
_EOF_
}

. ${opBinBase}/lpCurrents.libSh

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
--- SERVER Status  ---
${G_myName} -e "Check " -i runFunc ps -ef | grep -i gwd
--- SERVER CONFIG Testing ---
lcaGenewebActions.sh  # Does more configuration and testing
_EOF_
  
  vis_examplesServerConfig

  vis_examplesLogInfo

}


noArgsHook() {
    vis_examples
}

#
# NOTE WELL: vis_serverConfigUpdate overwrites the seed
#

function vis_serverConfigUpdate {
    # seed Overwrite

    # opDo /etc/init.d/geneweb  restart
    return
}
