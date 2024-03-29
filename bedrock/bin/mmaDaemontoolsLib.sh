#


. ${opBinBase}/distHook.libSh

daemontoolsServiceBaseDir_DEFAULT_DEFAULT () {

if [ "${opRunOsType}_" == "SunOS_" ] ; then
  mmaDaemon_servicesBaseDir="/service"
elif [ "${opRunOsType}_" == "Linux_" ] ; then
  # /var/lib/svscan
  mmaDaemon_servicesBaseDir="/etc/service"
else
  EH_problem "Unsupported OS: ${opRunOsType}"
fi

}

daemontoolsServiceBaseDir_DEBIAN_11 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_DEBIAN_LENNY () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_DEBIAN_SQUEEZE () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_DEBIAN_7 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_UBUNTU_910 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1004 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_UBUNTU_1010 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1104 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1110 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1204 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1210 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_UBUNTU_1310 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1404 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_1604 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}


daemontoolsServiceBaseDir_UBUNTU_1804 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

daemontoolsServiceBaseDir_UBUNTU_2004 () {
  mmaDaemon_servicesBaseDir="/etc/service"
}

  distFamilyGenerationHookRun daemontoolsServiceBaseDir



function mmaDaemonList {
  EH_assert [[ $# -eq 0 ]]

  typeset filesList=`echo ${mmaDaemon_servicesBaseDir}/*`
  if [[ "${filesList}" = "${mmaDaemon_servicesBaseDir}/*" ]] ; then
    return 0
  fi
  typeset thisOne
  for thisOne  in ${filesList} ; do
    FN_nonDirsPart ${thisOne}
    ANV_raw "${thisOne}"
  done
  return 0
}

function mmaDaemonShow {
  # $1-$# -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDo svstat ${mmaDaemon_servicesBaseDir}/${thisOne}
      opDoComplain svok ${mmaDaemon_servicesBaseDir}/${thisOne}
    fi
  done
}


function mmaDaemonHUP {
  # $1 -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDoComplain svc -h ${mmaDaemon_servicesBaseDir}/${thisOne}
      ANV_raw "$0: ${mmaDaemon_servicesBaseDir}/${thisOne}"
    fi
  done
}


function mmaDaemonRestart {
  # $1 -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDoComplain svc -t ${mmaDaemon_servicesBaseDir}/${thisOne}
    fi
  done
}


function mmaDaemonStop {
  # $1 -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDoComplain svc -d ${mmaDaemon_servicesBaseDir}/${thisOne}
    fi
  done
}


function mmaDaemonStart {
  # $1 -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDoComplain svc -u ${mmaDaemon_servicesBaseDir}/${thisOne}
    fi
  done
}


function mmaDaemonOnce {
  # $1 -- daemonName
  EH_assert [[ $# -gt 0 ]]
  typeset thisOne=""
  for thisOne in "$@" ; do
    if [[ ! -d ${mmaDaemon_servicesBaseDir}/${thisOne} ]] ; then 
      ANT_raw "${mmaDaemon_servicesBaseDir}/${thisOne} Does not exist. $0 skipped"
      continue
    else
      opDoComplain svc -o ${mmaDaemon_servicesBaseDir}/${thisOne}
    fi
  done
}

function mmaDaemonVerify {
  # $1 -- daemonName
  # $2 -- serviceLocation
  EH_assert [[ $# -eq 2 ]]
  if [[ ! -d ${mmaDaemon_servicesBaseDir}/${1} ]] ; then 
    ANT_raw "${mmaDaemon_servicesBaseDir}/${1} Does not exist. $0 skipped"
    return 1
  else
    opDo svstat ${mmaDaemon_servicesBaseDir}/${1}
    opDoComplain svok ${mmaDaemon_servicesBaseDir}/${1}
    typeset curSvsLoc=`FN_fileSymlinkEndGet ${mmaDaemon_servicesBaseDir}/${1}`
    if [[ "${curSvsLoc}_" != "${2}_" ]] ; then
      EH_problem "expected $2 Got: ${curSvsLoc}"
      return 1
    else
      ANT_raw "$2 verified"
      return 0
    fi
  fi
}


function mmaDaemonRunningVerify {
  EH_assert [[ $# -eq 1 ]]

  daemonName=${1}

  if [[ ! -d ${mmaDaemon_servicesBaseDir}/${daemonName} ]] ; then 
    ANT_raw "${mmaDaemon_servicesBaseDir}/${daemonName} does not exist. $0 Failed"
    return 100
  fi

  if svok ${mmaDaemon_servicesBaseDir}/${daemonName}  ; then 
    ANT_raw "svok: ${mmaDaemon_servicesBaseDir}/${daemonName}"
  else
    ANT_raw "supervise not running for ${mmaDaemon_servicesBaseDir}/${daemonName}. $0 Failed"  
    return 100
  fi

  if  svstat ${mmaDaemon_servicesBaseDir}/${daemonName} | grep ": up" ; then 
    ANT_raw "svstat: ${mmaDaemon_servicesBaseDir}/${daemonName} is up"
  else
    ANT_raw "svstat: ${mmaDaemon_servicesBaseDir}/${daemonName} is down"
    return 100
  fi
}


function mmaDaemonUpdate {
  # $1 -- daemonName
  # $2 -- serviceLocation
  EH_assert [[ $# -eq 2 ]]

  integer gotVal=0

  mmaDaemonVerify "$@" || gotVal=$?
  if [[ ${gotVal} = 0 ]] ; then
    return 0
  fi
  mmaDaemonDelete $1
  FN_fileSymlinkSafeMake ${2} ${mmaDaemon_servicesBaseDir}/${1}

  mmaDaemonStart $1
}

function mmaDaemonDelete {
  # $1 -- daemonName
  EH_assert [[ $# -eq 1 ]]

  if [[ -d ${mmaDaemon_servicesBaseDir}/${1} ]] ; then 
    mmaDaemonStop ${1}
    opDoComplain /bin/rm ${mmaDaemon_servicesBaseDir}/${1} || return $?
  elif [[ -h ${mmaDaemon_servicesBaseDir}/${1} ]] ; then
      EH_problem "Not Directory -- But Symlink being removed"
      opDoComplain /bin/rm ${mmaDaemon_servicesBaseDir}/${1} || return $?
  else
    ANT_raw "${mmaDaemon_servicesBaseDir}/${1} Does not exist. $0 skipped"
  fi

  return 0
}


function vis_svcDaemonList {
    opDoComplain mmaDaemonList "$@"
}


function vis_svcDaemonShow {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonShow "$@"
}

function vis_svcDaemonRunningVerify {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonRunningVerify "$@"
}


function vis_svcDaemonVerify {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonVerify "$@"
}


function vis_svcDaemonUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonUpdate "$@"
}

function vis_svcDaemonDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonDelete "$@"
}

function vis_svcDaemonHUP {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonHUP "$@"
}


function vis_svcDaemonRestart {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonRestart "$@"
}


function vis_svcDaemonStop {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonStop "$@"
}


function vis_svcDaemonStart {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonStart "$@"
}


function vis_svcDaemonOnce {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    #EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDoComplain mmaDaemonOnce "$@"
}
