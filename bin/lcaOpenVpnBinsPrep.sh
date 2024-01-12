#!/bin/bash

####+BEGIN: bx:bsip:bash:seed-spec :types "seedSubjectBinsPrepDist.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/asc/bin/lcaOpenVpnBinsPrep.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedSubjectBinsPrepDist.sh -l $0 "$@"
    exit $?
fi
####+END:


#itemOrderedList=("openvpn" "tunneldigger")
itemOrderedList=( "openvpn" )


item_openvpn () {
  distFamilyGenerationHookRun binsPrep_openvpn
}

binsPrep_openvpn_DEFAULT_DEFAULT () {
    mmaThisPkgName="openvpn"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="apt"
}


item_tunneldigger () {
  distFamilyGenerationHookRun binsPrep_tunneldigger
}

binsPrep_tunneldigger_DEFAULT_DEFAULT () {
    mmaThisPkgName="tunneldigger"
    mmaPkgDebianName="${mmaThisPkgName}"
    mmaPkgDebianMethod="apt"
}
