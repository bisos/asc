# NOTYET

# MOHSEN Review Comments:
# - Add EH_assert for all functions.
# - Instead of "^$1" do "^$1[ \t]" -- space or tab
#

if [ "${opRunOsType}_" == "SunOS_" ] ; then
  opInetdFile="/etc/inetd.conf"
elif [ "${opRunOsType}_" == "Linux_" ] ; then
  opInetdFile="/etc/inetd.conf"
else
  EH_problem "Unsupported OS: ${opRunOsType}"
fi

function opInetdHUP {
  opDoComplain pkill -HUP inetd
}

function opInetdLineShow {
  EH_assert [[ $# -eq 1 ]]
  # $1 -- serviceName

  opDoComplain egrep "^$1" ${opInetdFile}
}

function opInetdLineVerify {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- serviceName
  # $2 -- Line

  typeset lineShow=`opInetdLineShow $1`

  if [[ -z ${lineShow} ]] ; then
    ANT_raw "Service '$1' is not available."
    return 1
  else
    if [[ `print ${lineShow}` == "$2" ]] ; then
      ANT_raw "Service '$1' is verified."
      return 0
    else
      ANT_raw "Service '$1' is not verified."
      return 1
    fi
  fi

}

function opInetdLineUpdate {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- serviceName
  # $2 -- Line

  integer thisRetVal=0
  opInetdLineVerify $1 "$2" || thisRetVal=$?

  if [[ ${thisRetVal} -ne 0 ]] ; then
    opInetdLineDelete $1
    FN_lineAddToFile "^$1"  "$2" ${opInetdFile}
  fi
}

function opInetdLineDelete {
  EH_assert [[ $# -eq 1 ]]
  # $1 -- serviceName

  opDoComplain FN_lineRemoveFromFile "^$1" ${opInetdFile}
}


