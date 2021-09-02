#!/bin/bash

####+BEGIN: bx:bsip:bash:seed-spec :types "seedAdminDaemonSysV.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedAdminDaemonSysV.sh]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/bin/lcaPlone3Admin.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedAdminDaemonSysV.sh -l $0 "$@"
    exit $?
fi
####+END:

daemonName="plone3"
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

#. ${opBinBase}/lpCurrents.libSh
# . ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/lpParams.libSh


function G_postParamHook {
    # lpCurrentsGet

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

    #
    # NOTYET, needs to be copied 
    # as non-plain-text and also in each account ...
    #
    opDo chmod ugo+r /usr/local/Plone/zeocluster/adminPassword.txt 
}
