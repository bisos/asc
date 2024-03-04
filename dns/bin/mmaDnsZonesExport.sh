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
. ${opBinBase}/mmaDaemontoolsLib.sh
. ${opBinBase}/mmaDnsLib.sh

typeset -t destHost="70.89.129.35"
typeset -t multiZonesName="extra.zones"

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo="-v -n showOnly"
  #typeset extraInfo=""
 cat  << _EOF_ 
EXAMPLES:
${G_myName} ${extraInfo} -p destHost="${destHost}" -p multiZonesName="${multiZonesName}" -i zonesExportFile data
${G_myName} ${extraInfo} -p destHost="${destHost}"  -i zonesExportPostProcess
_EOF_
}


function vis_help {
  cat  << _EOF_

_EOF_
}

noSubjectHook() {
  subject=all
}

noArgsHook() {
  vis_examples
}


function vis_zonesExportFile {
  EH_assert [[  $# -eq 1 ]]

   typeset exportFileName="$1"

   opDoComplain sudo -u dnsadmin scp -pq ${exportFileName} ${destHost}:${mmaDns_importBaseDir}/${multiZonesName}
}

 
function vis_zonesExportPostProcess {
  EH_assert [[  $# -eq 0 ]]

    opDoComplain sudo -u dnsadmin ssh ${destHost} ${opBinBase}/mmaDnsServerHosts.sh -i contentCombineData
}
