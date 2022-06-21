#!/bin/bash
#!/bin/bash 

echo "mmaDaemonToolsAdmin.sh has been obsoleted by lcaDameonToolsAdmin.sh"

typeset RcsId="$Id: mmaDaemontoolsAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"


if [ "${loadFiles}X" == "X" ] ; then
  $( dirname $0)/seedActions.bash -l $0 "$@"
  exit $?
fi


. ${opBinBase}/lpErrno.libSh

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDaemontoolsLib.sh

. ${opBinBase}/lpReRunAs.libSh

function vis_examples {
    typeset oneService=tinydns
    typeset oneServiceLocation=/etc/tinydns
    typeset visLibExamples=`visLibExamplesOutput ${G_myName}`

    typeset extraInfo="-h -v -n showRun"
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- PROCESS STATUS ---
${G_myName} ${extraInfo} -i showProcs
${G_myName} ${extraInfo} -i killProcs
${G_myName} ${extraInfo} -i start
${G_myName} ${extraInfo} -i stop
--- SYSTEM INFORMATION ---
${G_myName} ${extraInfo} -i fullReport
${G_myName} ${extraInfo} -i fullVerify
${G_myName} ${extraInfo} -i fullUpdate
${G_myName} ${extraInfo} -i fullDelete
${G_myName} ${extraInfo} -i fullStop
${G_myName} ${extraInfo} -i fullStart
${G_myName} ${extraInfo} -i fullRestart
--- SERVICE DAEMON MANIPULATORS ---
${G_myName} ${extraInfo} -i mmaDaemonList
${G_myName} ${extraInfo} -i mmaDaemonShow ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonRunningVerify ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonVerify ${oneService} ${oneServiceLocation}
${G_myName} ${extraInfo} -i mmaDaemonUpdate ${oneService} ${oneServiceLocation}
${G_myName} ${extraInfo} -i mmaDaemonDelete ${oneService}
--- DAEMON OPERATORS ---
${G_myName} ${extraInfo} -i mmaDaemonHUP ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonRestart ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonStop ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonStart ${oneService}
${G_myName} ${extraInfo} -i mmaDaemonOnce ${oneService}
--- LOGS AND REPORTS ---
${G_myName} ${extraInfo} -i showLog
_EOF_
}

function vis_help {
  cat  << _EOF_
Human visibile administration and monitoring of
daemontools.
_EOF_
}

function noArgsHook {
    vis_examples
}

function vis_start {
  if [ "${opRunOsType}_" == "SunOS_" ] ; then
    opDoRet /etc/init.d/mma-daemontools start
  elif [ "${opRunOsType}_" == "Linux_" ] ; then
    opDoRet /etc/init.d/daemontools  start
  else
    EH_problem "Unsupported OS: ${opRunOsType}"
  fi
}

function vis_stop {
  if [ "${opRunOsType}_" == "SunOS_" ] ; then
    opDoRet /etc/init.d/mma-daemontools stop
  elif [ "${opRunOsType}_" == "Linux_" ] ; then
    opDoRet /etc/init.d/daemontools  stop
  else
    EH_problem "Unsupported OS: ${opRunOsType}"
  fi
}

function vis_fullVerify {
  vis_fullReport "$@"
}

function vis_fullUpdate {

  typeset -i procsNum=`pgrep  '^svscan$' | wc -l`
  if [[ "${G_forceMode}_" != "force_" ]] ; then
    if [ "${procsNum}_" = "1_" ] ; then
      ANT_raw "svscan Running -- No Action Taken"
      return 0
    fi
  fi
  
  vis_fullStop
  vis_stop
  vis_start
  vis_fullStart
  vis_fullReport

  pgrep -l '^svscan$'
}

function vis_fullDelete {
  if [[ "${G_forceMode}_" != "force_" ]] ; then
    ANT_raw "If you really want to $0, specify G_forceMode (-f)"
    return 0
  fi

  typeset daemonList=`mmaDaemonList`
  typeset thisOne
  for thisOne  in ${daemonList}; do
    mmaDaemonDelete ${thisOne}
  done
  vis_stop
  vis_fullReport
}

function vis_fullStop {
  typeset daemonList=`mmaDaemonList`
  typeset thisOne
  for thisOne  in ${daemonList}; do
    mmaDaemonStop ${thisOne}
  done
}

function vis_fullStart {
  typeset daemonList=`mmaDaemonList`
  typeset thisOne
  for thisOne  in ${daemonList}; do
    mmaDaemonStart ${thisOne}
  done
}

function vis_fullRestart {
  typeset daemonList=`mmaDaemonList`
  typeset thisOne
  for thisOne  in ${daemonList}; do
    mmaDaemonRestart ${thisOne}
  done
}

function vis_fullReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    vis_showProcs
    typeset daemonList=`mmaDaemonList`
    typeset thisOne
    for thisOne  in ${daemonList}; do
	mmaDaemonShow ${thisOne}
    done

    lpReturn
}



function vis_showProcs {
  typeset -i procsNum=`pgrep  '^svscan$' | wc -l`
  if [ "${procsNum}_" != "1_" ] ; then
    echo "Some Daemontools Processes Are Missing, ${procsNum}"
  else
    echo "All Daemontools Processes Running"
  fi
  pgrep -l '^svscan$'
}

function vis_killProcs {
  # NOTYET, This is not safe and right Just temporary
  #
  pkill 'daemontools-clean'
  
  vis_showProcs
}


function vis_showLog {
  if [ "${opRunOsType}_" == "SunOS_" ] ; then
    opDoComplain tail -50 /var/log/svscan/current 
  elif [ "${opRunOsType}_" == "Linux_" ] ; then
    opDoComplain tail -50 /var/log/svscan/current 
  else
    EH_problem "Unsupported OS: ${opRunOsType}"
  fi
}


function vis_mmaDaemonList {
  opDoComplain mmaDaemonList "$@"
}


function vis_mmaDaemonShow {
  opDoComplain mmaDaemonShow "$@"
}

function vis_mmaDaemonRunningVerify {
  opDoComplain mmaDaemonRunningVerify "$@"
}


function vis_mmaDaemonVerify {
  opDoComplain mmaDaemonVerify "$@"
}


function vis_mmaDaemonUpdate {
  opDoComplain mmaDaemonUpdate "$@"
}

function vis_mmaDaemonDelete {
  opDoComplain mmaDaemonDelete "$@"
}

function vis_mmaDaemonHUP {
  opDoComplain mmaDaemonHUP "$@"
}


function vis_mmaDaemonRestart {
  opDoComplain mmaDaemonRestart "$@"
}


function vis_mmaDaemonStop {
  opDoComplain mmaDaemonStop "$@"
}


function vis_mmaDaemonStart {
  opDoComplain mmaDaemonStart "$@"
}


function vis_mmaDaemonOnce {
  opDoComplain mmaDaemonOnce "$@"
}


#----- from daemontools-conf
# PATH=/command:$PATH
# SERVICE=/service

# . @HOME@/etc/conf
# . @HOME@/etc/functions

# usage() {
# cat <<EOF
# Usage: daemontools-conf [-h] [-l] [-t] <cmd> <type> <name>
#   where      -h: this help
#              -l: make log dir (make command)
#              -t: make Makefile for tcp.cdb (make command)
#           <cmd>: make | add | del | enable | disable | list | update
#          <type>: type of service (eg. dnscache, smtpd, clockspeed, etc)
#          <name>: name of service (eg. inner, local, outer, etc)
# EOF
# 	exit;
# }

# die() {
# 	echo $@ >&2
# 	exit 1
# }

# uidcheck 0 || die 'Only root can run djbdns-conf.'
# while test "$#" != "0"; do
# 	test "$1" = "-h" -o "$1" = "--help" && usage
# 	if test "$1" = "-l"; then LOG=1; shift
# 	elif test "$1" = "-t"; then TCP=1; shift
# 	elif test -z "$CMD"; then CMD=$1; shift
# 	elif test -z "$TYPE"; then TYPE=$1; shift
# 	elif test -z "$NAME"; then NAME=$1; shift
# 	fi
# done
# test -z "$CMD" -o "$CMD" != "list" -a \( -z "$TYPE" -o -z "$NAME" \) && usage

# BASEDIR="$TYPE-$NAME"

# test -d $CONFDIR || mkdir -p $CONFDIR

# case $CMD in

# 	add)
# 		test ! -d "$CONFDIR/$BASEDIR" && die "$BASEDIR does not exists"
# 		ln -s "$CONFDIR/$BASEDIR" $SERVICE 2>/dev/null || die "$BASEDIR is already in services"
# 		echo "$BASEDIR service added"
# 		if test ! -L "$ETC/$TYPE"; then
# 			echo "Creating symlink from $CONFDIR/$BASEDIR to $ETC/$TYPE"
# 			ln -s "$CONFDIR/$BASEDIR" "$ETC/$TYPE" 2>/dev/null
# 		fi
# 		;;

# 	del)
# 		test -L "$SERVICE/$BASEDIR" || die "$BASEDIR is not in services already"
# 		if test -L $ETC/$TYPE; then
# 			origbase=`linkname $SERVICE/$BASEDIR`
# 			origetc=`linkname $ETC/$TYPE`
# 			if test "$origbase" = "$origetc"; then
# 				echo "Deleting $ETC/$TYPE link"
# 				rm $ETC/$TYPE
# 			fi
# 		fi
# 		rm "$SERVICE/$BASEDIR" && echo "$BASEDIR service deleted"
# 		test -d "$CONFDIR/$BASEDIR/log" && svc -dx $CONFDIR/$BASEDIR/log
# 		svc -dx $CONFDIR/$BASEDIR
# 		;;

# 	make)
# 		mkdir -p $CONFDIR/$BASEDIR
# 		touch "$CONFDIR/$BASEDIR/down"
# 		if test "$LOG" = "1"; then
# 			mkdir $CONFDIR/$BASEDIR/log
# 			touch $CONFDIR/$BASEDIR/log/down
# 			ln -s $SHARED/logrun $CONFDIR/log/run
# 		fi
# 		test "$TCP" = "1" && ln -s $SHARED/tcpmakefile $CONFDIR/Makefile
# 		echo "$CONFDIR/$BASEDIR"
# 		;;

# 	enab*)	test -L "$SERVICE/$BASEDIR" || die "$BASEDIR is not supervised yet."
# 		test -f "$SERVICE/$BASEDIR/down" || die "$BASEDIR was not disabled."
# 		rm -f "$SERVICE/$BASEDIR/down" "$SERVICE/$BASEDIR/log/down"
# 		test -d "$SERVICE/$BASEDIR/log" && svc -u $SERVICE/$BASEDIR/log
# 		svc -u $SERVICE/$BASEDIR
# 		echo "$BASEDIR enabled."
# 		;;

# 	disab*)	test -L "$SERVICE/$BASEDIR" || die "$BASEDIR is not supervised yet."
# 		test -f "$SERVICE/$BASEDIR/down" && die "$BASEDIR was disabled already."
# 		touch "$SERVICE/$BASEDIR/down" "$SERVICE/$BASEDIR/log/down"
# 		svc -d $SERVICE/$BASEDIR
# 		test -d "$SERVICE/$BASEDIR/log" && svc -d $SERVICE/$BASEDIR/log
# 		echo "$BASEDIR disabled."
# 		;;

# 	list)
# 		test -z "$TYPE" && $TYPE="*"
# 		test -z "$NAME" && $NAME="*"
# 		for i in "$HOMEDIR/$TYPE-$NAME"; do
# 			echo `basename $i`
# 		done
# 		;;

# 	*)	echo "Unknown command $CMD."
# 		usage
# 		exit 1
# 		;;
# esac
