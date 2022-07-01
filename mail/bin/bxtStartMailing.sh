#!/bin/bash

####+BEGIN: bx:bash:top-of-file :vc "cvs" :partof "bystar" :copyleft "halaal+brief"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: bxtStartMailing.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
#  This is part of ByStar Libre Services. http://www.by-star.net
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal. 
# }}} DBLOCK-top-of-file
####+END:

####+BEGIN: bx:bsip:bash:seed-spec :types "seedMailingProc.sh"
# {{{ DBLOCK-seed-spec
if [ "${loadFiles}X" == "X" ] ; then
    /opt/public/osmt/bin/seedMailingProc.sh -l $0 "$@" 
    exit $?
fi
# }}} DBLOCK-seed-spec
####+END:

# {{{ Describe/Help/Info

function vis_describe {
    cat  << _EOF_


_EOF_
}

# }}}

# {{{ Examples

function vis_examples {

  #typeset extraInfo=""
  typeset extraInfo="-v -n showRun"

  sitePagesList=`echo ${sitePages}`

  typeset visLibExamples=`visLibExamplesOutput ${G_myName} ${extraInfo}`

  vis_startObjectGenExamples
}

# }}}


# {{{ Empty New Section


# }}}

####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: shellscript-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:

