#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: lcaQmailPatchesPkgRePub.sh,v 1.3 2020-02-03 01:28:40 lsipusr Exp $"
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal. 
# }}} DBLOCK-top-of-file
####+END:

####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedPkgRePub.sh"
# {{{ DBLOCK-seed-spec
if [ "${loadFiles}X" == "X" ] ; then
    /opt/public/osmt/bin/seedPkgRePub.sh -l $0 "$@" 
    exit $?
fi
# }}} DBLOCK-seed-spec
####+END:

# {{{ NOTES/Status:

function vis_describe {  cat  << _EOF_

_EOF_
}

# }}}


function examplesHookPostNot {
  cat  << _EOF_
----- POST HOOK ADDITIONS -------
${G_myName} -i pkgRePubObtainInstructions
_EOF_
}


function vis_pkgRePubObtainInstructions {
  cat  << _EOF_
Go There and Do That.
_EOF_
}


#
# pkgRePubParameters
#

vis_pkgRePubParameters() {
  EH_assert [[ $# -eq 0 ]]
  distFamilyGenerationHookRun pkgRePubParameters
}

pkgRePubParameters_UBUNTU_2004 () { pkgRePubParameters_commonUbuntu; }
pkgRePubParameters_UBUNTU_1804 () { pkgRePubParameters_commonUbuntu; }
pkgRePubParameters_UBUNTU_1604 () { pkgRePubParameters_commonUbuntu; }
pkgRePubParameters_UBUNTU_1404 () { pkgRePubParameters_commonUbuntu; }
pkgRePubParameters_UBUNTU_1310 () { pkgRePubParameters_commonUbuntu; }

pkgRePubParameters_commonUbuntu () {
    # 
    pkgRePubName="qmail-1.03.isp.patch"
    # 
    pkgRePubSrcStableUrl="http://jeremy.kister.net/code/qmail-1.03.isp.patch"
    #
    pkgRePubArchType=all    # all or i386
    #
    pkgRePubDistDests=("localDist")    # or ("localDist" "currentDist")
}

pkgRePubParameters_DEBIAN_7 () { pkgRePubParameters_commonDebian; }

pkgRePubParameters_commonDebian () {
    opDo pkgRePubParameters_commonUbuntu;
}

pkgRePubParameters_DEFAULT_DEFAULT () {
      EH_problem "No Handler Found for ${opRunDistFamily}/${opRunDistGeneration}"
}

vis_pkgRePubParameters


####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:
