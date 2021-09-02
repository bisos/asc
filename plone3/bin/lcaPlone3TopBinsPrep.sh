#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" :partof "generic" :copyleft "none"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: lcaPlone3TopBinsPrep.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
# }}} DBLOCK-top-of-file
####+END:

# {{{ Authors:
# Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
# }}} 

####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedActions.bash"
# {{{ DBLOCK-seed-spec
if [ "${loadFiles}X" == "X" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
# }}} DBLOCK-seed-spec
####+END:

# {{{ Help/Info

function vis_describe {
    cat  << _EOF_
This is the top-level BinsPrep for Plone3.
It combines:
   ./lcaPlone3PkgRePub.sh        -- Assumes the publish has occured.   
   ./lcaPlone3SrcPkg.sh          -- Builds From Sources
   ./lcaPlone3InitdBinsPrep.sh   -- Installs /etc/init.d/plone3


_EOF_
}

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

# PRE parameters

function G_postParamHook {
     return 0
}

# }}}

# {{{ Examples

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
-----  EXAMPLES -------
${G_myName} ${extraInfo} -i  fullUpdate
_EOF_
}



noArgsHook() {
  vis_examples
}

# }}}

function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;

    opDo lcaPlone3SrcPkg.sh -h -v -n showRun  -i srcFullBuild

    opDo lcaPlone3InitdBinsPrep.sh -i  plone3InitUpdateAndRcInstall

    lpReturn
}




####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:

