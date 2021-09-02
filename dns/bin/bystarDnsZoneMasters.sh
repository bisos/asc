#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: bystarDnsZoneMasters.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"


if [ "${loadFiles}X" == "X" ] ; then
     `dirname $0`/seedSubjectAction.sh -l $0 "$@"
     exit $?
fi

function vis_help {
  cat  << _EOF_

This facility is somewhat unique as a bystarXxx.

In that it is not bystarUid specific.

It uses the /libre/ByStar/InfoBase/ZoneSvc/ to find
which zones is this host masters for.

find /libre/ByStar/InfoBase/ZoneSvc -print | grep -i ipAdd | xargs grep 198.62.92.161

Based on that we know what zones combineData should include.

_EOF_
}

. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDaemontoolsLib.sh
. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/lpParams.libSh

# ../siteControl/nedaPlus/mmaDnsServerHostItems.site
#setBasicItemsFiles mmaDnsServerHostItems
if [[ "${BASH_VERSION}X" != "X" ]] ; then
    . /opt/public/osmt/siteControl/nedaPlus/mmaDnsServerHostItems.site.bash
else
    . /opt/public/osmt/siteControl/nedaPlus/mmaDnsServerHostItems.site.ksh
fi


opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
# ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo="-v -n showOnly"
  #typeset extraInfo=""
    typeset doLibExamples=`doLibExamplesOutput ${G_myName} ${extraInfo}`
 cat  << _EOF_ 
EXAMPLES:
${doLibExamples} 
--- See Also ---
bystarDnsReport.sh  -i dnsSeeAlso
--- INFORMATION ---
${G_myName} ${extraInfo} -s all -a summary
${G_myName} ${extraInfo} -s ${opRunHostName} -a describe
--- ByStar Anchor Domains Served By This Zone Master ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a bystarAnchorDomains
--- Zone Info Locate ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoLocate bynumber.net
${G_myName} -s ${opRunHostName} -a bystarAnchorDomains | lpEach.sh -i prepend "dom=" | lpXparamsApply.sh -i xparamsProg ${G_myName}  -s ${opRunHostName} -a zoneInfoLocate '\${dom}'
${G_myName} -s ${opRunHostName} -a bystarAnchorDomains | xargs -n 1 ${G_myName}  -s ${opRunHostName} -a zoneInfoLocate 
--- Zone Info Add ---
${G_myName} -s ${opRunHostName} -a bystarAnchorDomains | xargs -n 1 ${G_myName}  -s ${opRunHostName} -a zoneInfoAdd
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bynumber.net
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bynumber.com
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd nedaPlus._other.net #ipAddr
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd trial._other.net #ipAddr
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd committed._other.net #ipAddr
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd librecenter._other.net #ipAddr
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bysmb.net  # SLD
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bysmb.com  # SLD
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd libresite.org  # SLD
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd byname.net
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd byname.com
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bymemory.net
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd bymemory.com
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd byalias.net
${G_myName} ${extraInfo} -s ${opRunHostName} -a zoneInfoAdd byalias.com
--- SERVER ACTIONS FULL ---
${G_myName} ${extraInfo} -i zonesPlusData /etc/tinydns/import/librecenter.net 
${G_myName} ${extraInfo} -i zonesMinusData /etc/tinydns/import/librecenter.net 
${G_myName} ${extraInfo} -i zonesRebuildData
--- SERVER ACTIONS FULL ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullDelete
${G_myName} ${extraInfo} -s ${opRunHostName} -a fullCleanAll
--- LOCATE SERVERS -- RESOLV.CONF ---
${G_myName} ${extraInfo} -i origContentServerFind ${opRunDomainName}
--- DNS POPULATION ---
${G_myName} ${extraInfo} -i dataNsToHere /etc/tinydns/root/data
${G_myName} ${extraInfo} -i contentCombineData
${G_myName} ${extraInfo} -i contentOrigHostNamesUpdate
${G_myName} ${extraInfo} -i contentOrigServicesUpdate
---  PREP ---
${G_myName} ${extraInfo} -i sshAcceptPrep
--- REMOTELY INVOKED ---
sudo -u dnsadmin ssh shoosh ${opBinBase}/${G_myName} -i contentCombineData
sudo -u dnsadmin ssh shoosh ${opBinBase}/${G_myName} -i contentAction Alias Add name addr
--- MISC ACTIONS ---
${G_myName} ${extraInfo} -i isValidDomainName badbad.com
_EOF_
}

noSubjectHook() {
  subject=all
}

noArgsHook() {
  vis_examples
}


function do_zoneInfoLocate {
  EH_assert [[ $# -eq 1 ]]
  subjectValidatePrepare

 fqdn=${1}
 fqdnToArray ${fqdn}

 set ${fqdnArrayReverse[@]}

 zoneBase="/libre/ByStar/InfoBase/ZoneSvc"

 for thisElem in ${fqdnArrayReverse[@]} ; do
   zoneBase="${zoneBase}/${thisElem}"
   shift
 done

 zoneBase="${zoneBase}/_Zone/dnsContent"

 #echo ${zoneBase}
 
  #if [ ! -d ${zoneBase} ] ; then
      #opDoExit mkdir -p ${zoneBase}/0
  #fi

  opDoExit pushd ${zoneBase}

  opDo pwd
   
  zoneList=$( ls | grep -v CVS | sort )

  if [ "${zoneList}_" == "_" ] ; then
      thisDir=0
  else
      for thisDir in ${zoneList} ; do
          opDo eval "find ${zoneBase}/${thisDir} -type f -print  | grep -v CVS | xargs ls -l"
      done
  fi
  
  popd

}




function do_zoneInfoAdd {
  EH_assert [[ $# -eq 1 ]]
  subjectValidatePrepare

 fqdn=${1}
 fqdnToArray ${fqdn}

 set ${fqdnArrayReverse[@]}

 zoneBase="/libre/ByStar/InfoBase/ZoneSvc"

 for thisElem in ${fqdnArrayReverse[@]} ; do
   zoneBase="${zoneBase}/${thisElem}"
   shift
 done

 zoneBase="${zoneBase}/_Zone/dnsContent"

 #echo ${zoneBase}
 
  #if [ ! -d ${zoneBase} ] ; then
      #opDoExit mkdir -p ${zoneBase}/0
  #fi

  opDoExit cd ${zoneBase}
   
  zoneList=$( ls | grep -v CVS | grep -v 'a' | sort )

  if [ "${zoneList}_" == "_" ] ; then
      thisDir=0
  else
      for thisDir in ${zoneList} ; do
          ipAddr=$( cat ${thisDir}/ipAddr )
          if [ "${iv_dnsContentServer[ipAddr]}_" = "${ipAddr}_" ] ; then
              ANT_raw "Found ${ipAddr} at ${zoneBase}/${thisDir} -- No Action Taken"
              return
          fi
      done
  fi

  nextNu=$( expr $thisDir +  1 )

  opDoExit mkdir ${nextNu}
  opDoExit cd ${nextNu}


  echo "dnsadmin" > ./acct
  echo "dnsadmin" > ./passwd
  echo "${iv_dnsContentServer[ipAddr]}" > ./ipAddr

  opDo chown -R lsipusr:employee .

  opDo sudo -u lsipusr ${opBinBase}/lcaCvsAdmin.sh -i newAddDirPath ${zoneBase}/${nextNu}

  # NOTYET, do the cvs add

  opDo ls -l $( pwd )/*
  

}



firstSubjectHook() {
  case ${action} in
    "summary")
               typeset -L20 f1="DNS Srvr Name" f2="Setup"
               print "$f1$f2"
               echo "----------------------------------------------------"
       ;;
    *)

       return
       ;;
  esac

}

lastSubjectHook() {
  case ${action} in
    "summary")
               echo "----------------------------------------------------"
       ;;
    *)
       return
       ;;
  esac
}


function do_summary {
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  typeset -L10 dnsHost=${iv_dnsHost} 
  typeset dnsSetup=${iv_dnsSetup}
  print "${dnsHost}${dnsSetup}"
}


function do_fullVerify {
  subjectValidatePrepare
  #   
  mmaDnsUsersAndGroupsAdd
  opDoRet mmaDnsBinsPrep.sh -i fullVerify || return 

  ANT_raw "Verifying That Needed Processes Are Running"
  #vis_showProcs
  do_servicesShow all
  #ANT_raw "Verifying That Needed Directories Are In Place -- NOTYET"
  #ANT_raw "Verifying That no directory that is not needed is in place -- NOTYET"

  #verify that resolv.conf is same as would be generated.
}


function do_fullUpdate {
  subjectValidatePrepare

  # Setup passwd for dnsadmin
  # ssh setup for dnsadmin

  # create /etc/tinydns/import and ownership

  # become the right /libre/ByStar/InfoBase/ZoneSvc/net/_other/based on bacsid

}


function do_fullDelete {
  subjectValidatePrepare
  do_servicesStop all
  do_serverDisable
}

function do_bystarAnchorDomains {
  subjectValidatePrepare

  for thisOne in ${iv_dnsContentServer[bystarAnchorDomains]} ; do
      echo "${thisOne}"
  done
}



function vis_contentActionPerformerPrep  {  
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}
   
  opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -p remoteUser=dnsadmin -p remoteHost=${1}  -i authorizedKeysUpdate
}


function hostIsOrigContentServerForZone {
  # $1 specifies a zone to be checked if is kept at this origContentServer
  EH_assert [[ $# -eq 1 ]]
  integer retVal=1
  typeset thisOne=""

  for thisOne in ${iv_dnsContentServer.domainsOrigList[@]} ; do
    #print ${thisOne}
    if [[ "${thisOne}_" == "${1}_" ]] ; then 
      ANV_raw "${iv_dnsHost} ${thisOne}"
      retVal=0
      break
    fi
  done
  return ${retVal}
}


function vis_sshAcceptPrep {

    # Make sure permissions are right
    #
    # Makesure account has a shell 
    #
        opDoComplain mmaSshAdmin.sh -p localUser=dnsadmin -i userKeyUpdate

}


function vis_zonesPlusData  {
  EH_assert [[ $# -gt 0 ]]

  FN_fileSafeCopy ${mmaDns_tinydnsDataFile} ${mmaDns_tinydnsDataFile}.${dateTag}

  opDo cp ${mmaDns_tinydnsDataFile}  ${mmaDns_tinydnsDataFileCombined}

  for zoneFile in ${@} ; do
      if [[ ! -f ${zoneFile} ]] ; then
          EH_problem "${zoneFile} Missing -- skipped"
          continue
      fi

      opDoComplain eval "( cat ${zoneFile} >> ${mmaDns_tinydnsDataFileCombined} )"
  done

    

  opDo mv ${mmaDns_tinydnsDataFileCombined} ${mmaDns_tinydnsDataFile}

  mmaDnsContentBuild

  opDo ls -l ${mmaDns_tinydnsDataFile}
}

function vis_zonesRebuildData  {
  EH_assert [[ $# -eq 0 ]]

  FN_fileSafeCopy ${mmaDns_tinydnsDataFile} ${mmaDns_tinydnsDataFile}.${dateTag}

  opDo cp /dev/null  ${mmaDns_tinydnsDataFileCombined}

  if [ -f /etc/tinydns/origContent/data.origZones  ] ; then
      opDoComplain eval "( cat /etc/tinydns/origContent/data.origZones >> ${mmaDns_tinydnsDataFileCombined} )"
  fi

  if [ ! -d /etc/tinydns/import ] ; then
      opDoExit mkdir -p /etc/tinydns/import
  fi

  opDoExit cd /etc/tinydns/import
   
  zoneFilesList=$( ls | grep -v CVS |  sort )

  for zoneFile in ${zoneFilesList} ; do
      if [[ ! -f ${zoneFile} ]] ; then
          EH_problem "${zoneFile} Missing -- skipped"
          continue
      fi

      opDoComplain eval "( cat ${zoneFile} >> ${mmaDns_tinydnsDataFileCombined} )"
  done

  vis_dataNsToHere ${mmaDns_tinydnsDataFileCombined} > ${mmaDns_tinydnsDataFile}

  mmaDnsContentBuild

  opDo ls -l ${mmaDns_tinydnsDataFile}
}


function vis_dataNsToHere  {
  EH_assert [[ $# -eq 1 ]]
#set -x
  subject=${opRunHostName}

  targetSubject=item_${subject}
  subjectIsValid
  if [[ $? != 0 ]] ; then
    ANT_raw "$0: noService - Skipped"
    return 1
  fi

  ${targetSubject}


  #FN_fileSafeCopy ${mmaDns_tinydnsDataFile} ${mmaDns_tinydnsDataFile}.${dateTag}

  #${opNetCfg_ipAddr}
  
  # NOTYET, put the sed line in opDo eval

  opDo lpParamsBasicGet

  #sed -e "s/\(^\..*:\)\([0-9].*:\)\([a-z]:\)\(.*$\)/\1${lpDnsEntryIpAddr}:\3\4/" $1
  sed -e "s/\(^\..*:\)\([0-9].*:\)\([a-z]:\)\(.*$\)/\1${iv_dnsContentServer[ipAddr]}:\3\4/" $1

}

