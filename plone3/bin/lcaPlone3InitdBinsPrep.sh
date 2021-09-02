#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" :partof "generic" :copyleft "none"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: lcaPlone3InitdBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"
# }}} DBLOCK-top-of-file
####+END:

# {{{ Authors:
# Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
# }}} 

####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedActions.bash"
# {{{ DBLOCK-seed-spec
if [ "${loadFiles}X" == "X" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
# }}} DBLOCK-seed-spec
####+END:

# {{{ Help/Info

function vis_describe {
    cat  << _EOF_

_EOF_
}

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh

. ${opBinBase}/lpReRunAs.libSh

# PRE parameters

function G_postParamHook {
     return 0
}

# }}}

# {{{ Examples

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
-----  EXAMPLES -------
${G_myName} ${extraInfo} -i  fullUpdate  # Same as plone3InitUpdateAndRcInstall
${G_myName} ${extraInfo} -i  plone3InitUpdateAndRcInstall
--- Plone3 init.d File Generation ---
${G_myName} ${extraInfo} -i  plone3InitStdout
${G_myName} ${extraInfo} -i  plone3InitUpdate
${G_myName} ${extraInfo} -i  plone3InitVerify
${G_myName} ${extraInfo} -i  plone3InitShow
${G_myName} ${extraInfo} -i  plone3InitDelete
--- Plone3 init.d Installation ---
${G_myName} ${extraInfo} -i  plone3UpdateRcInstall
${G_myName} ${extraInfo} -i  plone3UpdateRcRemove
_EOF_
}



noArgsHook() {
  vis_examples
}

# }}}

function vis_fullUpdate {
    EH_assert [[ $# -eq 0 ]]
    opDo vis_plone3InitUpdateAndRcInstall
}



function vis_plone3InitUpdateAndRcInstall {
    EH_assert [[ $# -eq 0 ]]

    opDo vis_plone3InitUpdate
    opDo vis_plone3UpdateRcInstall

}

function vis_plone3InitStdout {
    EH_assert [[ $# -eq 0 ]]

  cat  << _EOF_
#!/bin/sh
# /etc/init.d/plone
# Startup script for Plone installed with the
# Unified Installer - ZEO
#
# description: Zope, a web application server
# this works as is for a default universal plone linux install
#
#
#
#
#
#

RETVAL=0

# list zeo clients in the list below
zeoclients="client1 client2"

# this is for the default install path for 3.5.5.
clusterpath="/usr/local/Plone/zeocluster"
prog="ZEOServer"

start() {
    echo -n \$"Starting \$prog: "
    output=\$( \${clusterpath}/bin/plonectl zeoserver start )
    # the return status of zopectl is not reliable, we need to parse
    # its output via substring match
    if echo \$output | grep -q "start"; then
            # success
            echo success
            RETVAL=0
    elif echo \$output | grep -q "daemon process already running"; then
            # success
            echo process already running
            RETVAL=0
    else
            # failed
            echo failure
            RETVAL=1
    fi
    for client in \$zeoclients
        do
            echo -n \$"Starting \$client: "
            output=\$( \${clusterpath}/bin/plonectl \${client} start )
            # the return status of zopectl is not reliable, we need to parse
            # its output via substring match
            if echo \$output | grep -q "start"; then
                # success
                # touch /var/lock/subsys/zope\${client}
                echo success
                RETVAL=0
            elif echo \$output | grep -q "daemon process already running"; then
                # success
                echo process already running
                RETVAL=0
            else
                # failed
                echo failure
                RETVAL=1
            fi
        done
        return \$RETVAL
}

stop() {

for client in \$zeoclients
    do
       echo -n \$"Stopping \$client: "
       output=\$( \${clusterpath}/bin/plonectl \${client} stop )
       # the return status of zopectl is not reliable, we need to parse
        # its output via substring match
        if echo \$output | grep -q "stop" || echo \$output | grep -q "daemon manager not running" ; then
            # success
            # rm /usr/local/Plone/zeocluster/var/\${client}/\${client}.lock
            echo success
            RETVAL=0
        else
            # failed
            echo failure
            RETVAL=1
        fi
    done
    echo -n \$"Stopping \$prog: "
    output=\$( \${clusterpath}/bin/plonectl zeoserver stop )
    # the return status of zopectl is not reliable, we need to parse
    # its output via substring match
    if echo \$output | grep -q "stop" || echo \$output | grep -q "daemon manager not running"; then
            # success
            echo success
            RETVAL=0
    else
            # failed
            echo failure
            RETVAL=1
    fi
        return \$RETVAL
}

restart() {
   stop
   start
}

case "\$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
	echo Status:
	echo -n \$"Plone "
	output=\$( \${clusterpath}/bin/plonectl zeoserver status )
	echo \$output

	for client in \$zeoclients
	do
                echo -n \$"Plone "
		# echo "Zope Client" \$client
		output=\$( \${clusterpath}/bin/plonectl \${client} status )
		echo \$output
	done
	;;
  restart)
    restart
    ;;
  *)
    echo \$"Usage: \$0 {start|stop|status|restart}"
    RETVAL=2
esac

exit \$RETVAL
_EOF_

}

thisConfigFile="/etc/init.d/plone3"


function vis_plone3InitUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    FN_fileSafeKeep ${thisConfigFile}

    opDo eval vis_plone3InitStdout '>' ${thisConfigFile}

    opDo chmod ugo+x ${thisConfigFile}
    opDo chmod g-w ${thisConfigFile}

    opDo ls -l ${thisConfigFile}
}

function vis_plone3InitVerify {
  EH_assert [[ $# -eq 0 ]]

  typeset tmpFile=$( FN_tempFile )

  vis_plone3InitStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_plone3InitShow {
    EH_assert [[ $# -eq 0 ]]
  
    opDo ls -l ${thisConfigFile} 
}

function vis_plone3InitDelete {
    EH_assert [[ $# -eq 0 ]]
    
    ANT_raw "NOTYET"
}

#
#
#

vis_plone3UpdateRcInstall() {
    opDo sudo update-rc.d plone3 defaults 
}


vis_plone3UpdateRcRemove() {
    opDo sudo update-rc.d -f plone3 remove
}




####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:

