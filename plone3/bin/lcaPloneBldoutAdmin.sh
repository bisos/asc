#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPloneBldoutAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    $(dirname $0 )/seedAdminDaemonSysV.sh -l $0 $@
    exit $?
fi

daemonControlScript="/etc/init.d/ploneBldout"
daemonName="ploneBldout"

daemonConfigDir=""
daemonConfigFile="/etc/ploneBldout.conf"

daemonLogDir=""
daemonLogFile="/var/osmt/plone3Bldout/var/log/instance-Z2.log"
daemonLogErrFile="/var/osmt/plone3Bldout/var/log/instance.log"

vis_help () {
  cat  << _EOF_
    ${daemonName}

    Based on the generic SysV init daemon Start/Stop/Restart.

   TODO:
       - Use Live HTTP Headers on firefox - go to generate post
       - Figure ExternalFile
       - Do a daemon

_EOF_
}

. ${opBinBase}/lpCurrents.libSh


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
--- SERVER CONFIG  ---
${G_myName} ${extraInfo} -i instanceStart
${G_myName} ${extraInfo} -i instanceStop
${G_myName} ${extraInfo} -i zopeCtlAddUser
${G_myName} ${extraInfo} -i init_dStdout
${G_myName} ${extraInfo} -i init_dConfig 
http://127.0.0.1:8080
_EOF_
  
  vis_examplesServerConfig

  vis_examplesLogInfo

}


noArgsHook() {
    vis_examples
}

function vis_instanceStart {
    opDo /var/osmt/plone3Bldout/bin/instance start
    #/acct/employee/lsipusr/ploneBuildout/bin/instance start
}


function vis_instanceStop {
    opDo /var/osmt/plone3Bldout/bin/instance stop
    #/acct/employee/lsipusr/ploneBuildout/bin/instance stop
}


function vis_zopeCtlAddUser {
    opDo /var/osmt/plone3Bldout/parts/instance/bin/zopectl adduser user passwd
    #/acct/employee/lsipusr/ploneBuildout/parts/instance/bin/zopectl adduser user passwd
}

function vis_init_dStdout {
    cat  << _EOF_

#!/bin/bash
#
# lcaPloneBldout          Configure lcaPloneBldout 
#
# Version:      \$Revision: 1.1.1.1 $
### BEGIN INIT INFO
# Provides:          lcaPloneBldout
# Required-Start:    \$network
# Required-Stop:     \$network
# Default-Start:     2 3 5 
# Default-Stop:	     0 6 
# Description: Starts lcaPloneBldout
# short-description: lcaPloneBldout 
### END INIT INFO

#includes lsb functions 
source /lib/lsb/init-functions

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LCAPLONEBLDOUT="/opt/public/osmt/bin/lcaPloneBldoutAdmin.sh"
NAME=lcaPloneBldout
DESC="Web Service"

test -x \$LCAPLONEBLDOUT || exit 0

umask 0077

unset ENABLED
FAST=yes
CACHE=no
OPTIONS=
unset DOMAINS
[ -r /etc/default/lcaPloneBldout ] && source /etc/default/lcaPloneBldout

if [ "\$ENABLED" != "yes"  ]; then
    if [ "\$VERBOSE" != no ]; then
        if [ -z "\$ENABLED" ]; then
            echo "Not starting lcaPloneBldout - run 'dpkg-reconfigure lcaPloneBldout' to enable it"
        else
            echo "Not starting lcaPloneBldout - edit /etc/default/lcaPloneBldout to enable it"
        fi
    fi
    exit 0
fi


case "\$1" in
    start)
        log_daemon_msg "Starting \$DESC" "\$NAME"
        su lsipusr -c "\$LCAPLONEBLDOUT -i instanceStart"
        log_end_msg 0
        ;;
    stop)
        log_daemon_msg "Stopping \$DESC" "\$NAME"
        su lsipusr -c "\$LCAPLONEBLDOUT -i instanceStop"
        log_end_msg 0  
        ;;
    reload|restart|force-reload)
        log_action_begin_msg "Reloading \$DESC configuration..."
        su lsipusr -c "\$LCAPLONEBLDOUT -i instanceStop"
        su lsipusr -c "\$LCAPLONEBLDOUT -i instanceStart"
        log_action_end_msg 0
        ;;
    *)
        N=/etc/init.d/\$NAME
        log_action_msg "Usage: \$N {start|stop|restart|reload|force-reload}"
        exit 1
        ;;
esac

exit 0

_EOF_
}


function vis_defaultStdout {
    cat  << _EOF_
# configuration for /etc/init.d/lcaPloneBldout 

# Enable ferm on bootup?
ENABLED=yes

_EOF_
}




function vis_init_dConfig {
    EH_assert [[ $# -eq 0 ]]

    typeset serviceName=lcaPloneBldout

    FN_fileSafeKeep /etc/init.d/lcaPloneBldout

    vis_defaultStdout > /etc/default/lcaPloneBldout
    vis_init_dStdout > /etc/init.d/lcaPloneBldout

    opDo chmod 775 /etc/init.d/lcaPloneBldout
    opDo chmod 644 /etc/default/lcaPloneBldout

    opDo ls -l /etc/init.d/lcaPloneBldout /etc/default/lcaPloneBldout

    FN_fileSymlinkSafeMake /etc/init.d/${serviceName}  /etc/rc0.d/K89${serviceName}
    FN_fileSymlinkSafeMake /etc/init.d/${serviceName}  /etc/rc2.d/S89${serviceName}
    FN_fileSymlinkSafeMake /etc/init.d/${serviceName}  /etc/rc3.d/S89${serviceName}
    FN_fileSymlinkSafeMake /etc/init.d/${serviceName}  /etc/rc4.d/S89${serviceName}
}

