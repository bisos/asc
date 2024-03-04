#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"

####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/dns/bin/bystarDnsAdmin.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:


. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDnsLib.sh

ItemsFiles=""
ItemsFiles="${ItemsFiles} ${opSiteControlBase}/${opRunSiteName}/mmaDnsImportItems.site"
ItemsFiles="${ItemsFiles} ${opSiteControlBase}/${opRunSiteName}/mmaDnsImportItems.other"

function vis_examples {
    typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_ 
EXAMPLES:
${doLibExamples} 
--- INFORMATION ---
${G_myName} -s all -a summary
--- OBSOLETE ---
${G_myName} -s vis_av_com -a setupCopyProcess
${G_myName} -s all -a setupCopyProcess
_EOF_
}


function vis_help {
 cat  << _EOF_ 

_EOF_
}

noArgsHook() {
  vis_examples
}


firstSubjectHook() {
  case ${action} in
    "summary")
               typeset -L10 f1="Domain Name" f2="Master"
               typeset -L50 f3="Slaves List"
               print "$f1$f2$f3"
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
typeset -L10 domainName=${iv_dnsImport_domainName}
typeset -L10 masterHostName=${iv_dnsImportMaster}
typeset -L50 slavesList=${iv_dnsImportSlavesList[@]}

  print "${domainName}${masterHostName}${slavesList}"
}


# function do_setupCopyProcess {
#   targetSubject=item_${subject}
#   subjectValidVerify

#   ${targetSubject}

#   if [ "X${iv_dnsImport_slaveHost}" != "X${opRunHostName}" ] ; then
#     echo "Skipped ${subject} -- This host (${opRunHostName}) is not slaveHost (${iv_dnsImport_slaveHost})"
#     return 1
#   fi
  
#   FN_dirCreateIfNotThere ${mmaDns_tinydnsDataDir}

#   FN_dirCreateIfNotThere ${mmaDns_tinydnsDataDir}/${iv_dnsImport_masterHostIp}

#   touch  ${mmaDns_tinydnsDataDir}/${iv_dnsImport_masterHostIp}/axfr.${iv_dnsImport_masterZone}
#   ls -l ${mmaDns_tinydnsDataDir}/${iv_dnsImport_masterHostIp}/axfr.${iv_dnsImport_masterZone}
# }

function do_schemaVerify {
  subjectValidatePrepare
  echo ${subject}
}

