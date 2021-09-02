#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: mmaDnsZonesExport.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

# Don't delete the line below. With KSH it makes things work. Puzzle. Mohsen.
echo " "

if [ "${loadFiles}X" == "X" ] ; then
  `dirname $0`/seedActions.sh -l $0 "$@"
  exit $?
fi

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
