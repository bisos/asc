#!/bin/osmtKsh
#!/bin/osmtKsh

# NOTYET
#
# This depends on mh -- apt-get nmh should go some where
#

# Don't delete the line below. With KSH it makes things work. Puzzle. Mohsen.
echo " "

typeset RcsId="$Id: mmaFaxMailBot.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     `dirname $0`/seedActions.sh -l $0 "$@"
    exit $?
fi

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh
. ${opBinBase}/mmaWebLib.sh


# PRE parameters
typeset -t acctName="MANDATORY"


function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- Send a Basic Fax Message ---
cat /etc/motd | ${G_myName} -p acctName=sa-20051 -i sendBasic
cat /etc/motd | ${G_myName} -v -n showRun -i sendBasic
_EOF_
}


function vis_help {
  cat  << _EOF_

_EOF_
}

function noArgsHook {
    vis_examples
}



function vis_sendBasic {
  set -x
  if [[ "${acctName}_" == "_" ]] ; then
    EH_problem "acctName does not exist and/or does not belong in ${opRunHostName}."
    return 1
  else
    opAcctInfoGet ${acctName}

    if [[ "${G_verbose}_" == "verbose_" ]] ; then
      echo "opAcct_homeDir=${opAcct_homeDir}"
    fi
  fi

  from=$SENDER
  to="$EXT@$HOST2"

  # When invoked by qmail, generated dirs are 700
  umask 22

  typeset myTmp="${opAcct_homeDir}/tmp"

  mkdir -p ${myTmp}

  tmpFile=${myTmp}/$$.inMail
    #echo "${G_myName}" > ${tmpFile}
    #echo "${acctName}" >> ${tmpFile}
    #echo "To is ${to}" >> ${tmpFile}
    #echo "From is ${from}" >> ${tmpFile}

  
  cat >> ${tmpFile}

  ftmp=${myTmp}/mhs$$
  rm -rf $ftmp.d
  mkdir $ftmp.d
  cd $ftmp.d
  export PATH=/usr/bin/mh:${PATH}
  mhstore + -auto -file ${tmpFile} -noverbose 2>/dev/null

  typeset outFiles=""

  typeset allFiles=`ls $ftmp.d/*`

  for finp in $allFiles
  do
    tipo=$(file -b $finp)
    case "$tipo" in
      HTML\ *)
               /usr/bin/htmldoc --webpage -t ps $finp > ${finp}.ps
               outFiles="${outFiles} ${finp}.ps"
               ;;
      PDF\ *) 
              outFiles="${outFiles} $finp"
              ;;
      ASCII\ *) 
              enscript -o ${finp}.ps $finp 2>/dev/null
               outFiles="${outFiles} ${finp}.ps"
              ;;
      PostScript\ *)
                     outFiles="${outFiles} $finp"
                     ;;
      TIFF\ *)
                     outFiles="${outFiles} $finp"
                     ;;
      *)
         EH_problem "Unknown File Type"
         ;;
    esac
  done

    # NOTYET
    # Parse from and to and envelope and 
    # capture and validate phone number
    # Sumbit to sendfax

  typeset thisTo=`print $EXT  | cut -d "-" -f2`
  opDoComplain sendfax -D -n -f "$from" -d "$thisTo" ${outFiles}
  #opDoComplain /usr/bin/sendfax -D -f "$from" -d "$thisTo" ${outFiles}

    # Clean-up -- Comment out for debugging
  #rm -rf $ftmp.d
  #/bin/rm ${tmpFile}
}

