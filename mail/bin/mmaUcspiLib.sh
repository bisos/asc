#
#

# NOTYET 2022 Needs to be revisited
# . ${opLibBase}/opDoAsLib.sh



 
function mmaUcspiTcprulesCompile {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- srcFile
  # $2 -- cdbFile

  opDoComplain tcprules  $2 /tmp/$$.tmp < $1
  ls -l $1 $2
}

function mmaUcspiAllowAdd {
  EH_assert [[ $# -gt 2 ]]
  # $1 -- fileName
  # $2 -- ipAddr
  # $3 -- envVar1
  #

  if [[ ! -f $1 ]] ; then
    touch $1
  fi
  
  typeset exactLineRegExp="^$2:allow,$3"
  typeset exactLine="$2:allow,$3"

  if FN_lineIsInFile ${exactLineRegExp} ${1} ; then
    ANT_raw "$0: ${exactLine} -- Already in, skipped"
  else
      if [ "${3}_" == "_" ] ; then
	  echo "$2:allow" >> $1
      else
	  echo "$2:allow,$3" >> $1
      fi
  fi
}

function mmaUcspiAllowDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- fileName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^${2}:" ${1}
}

function mmaUcspiDenyAdd {
  EH_assert [[ $# -gt 2 ]]
  # $1 -- fileName
  # $2 -- ipAddr
  # $3 -- envVar1
  #

  if [[ ! -f $1 ]] ; then
    touch $1
  fi
  
  typeset exactLineRegExp="^$2:deny,$3"
  typeset exactLine="$2:deny,$3"

  if FN_lineIsInFile ${exactLineRegExp} ${1} ; then
    ANT_raw "$0: ${exactLine} -- Already in, skipped"
  else
    echo "$2:deny,$3" >> $1
  fi
}

function mmaUcspiDenyDelete {
  EH_assert [[ $# -eq 2 ]]
  # $1 -- fileName
  # $2 -- ipAddr

  FN_lineRemoveFromFile "^${2}:" ${1}
}

