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


function vis_help {
 cat  << _EOF_

byStar Model
============

  Information Base
  ----------------

  bystarDnsInfoAdmin.sh 
  

  Public Resolvers
  ----------------
  198.62.92.20
  198.62.92.21
  70.xx

  LibreCenter DNS Servers Cluster
  -------------------------------
  a.ns.LibreCenter.net  198.
  b.ns.LibreCenter.net  198.

  ByStar DNS Servers Cluster
  ---------------------
  a.ns.by-star.net   198.
  b.ns.by-star.net   70.

  Reverse IPs for all of 198 go into =001.a.librecenter.net  Where ".a." represents 198.62.92.

  Supported Factory DNS Servers Cluster
  -------------------------------------
  c.ns.by-star.net     198.
  d.ns.by-star.net     70.

  ByName, ByMemory, ByAlias, ByWhere, BySmb

  Trial Factory DNS Servers Cluster
  -------------------------------------
  z.ns.by-star.net     198.
  y.ns.by-star.net     198.

_EOF_
}


. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaDnsLib.sh


function vis_examples {
  typeset extraInfo="-v -n showRun"
  #typeset extraInfo=""
  typeset oneServer=${opRunHostName}
  typeset oneIpAddr="192.168.0.10"
  typeset oneHostFqdn="my.byname.com.intra"
  typeset serverProg="mmaDnsServerHosts.sh"

  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- See Also ---
bystarDnsReport.sh  -i dnsSeeAlso
--- All ByStar Domains   ---
${G_myName} -i bystarDomainsList  
${G_myName} -i bystarDomainsList  | xargs -n 1 lcaDnsReport.sh -h -v -n showRun -i zoneServersList 
${G_myName} -i bystarDomainsList  | xargs -n 1 lcaDnsReport.sh -h -v -n showRun -i zoneServersList  | grep -i worldnic
${G_myName} -i bystarDomainsList  | xargs -n 1 lcaDnsReport.sh -h -v -n showRun -i zoneServersList  | grep -i 198.62.92.155
---
${G_myName} -i bystarDomainsList  | xargs -n 1 lcaDnsReport.sh -h -v -n showRun -i zoneServersArrayStdout
--- DNS Public/Available Resolvers ---
${G_myName} -i dnsResolversPublicList
_EOF_
}

function vis_dnsSeeAlso {
    cat  << _EOF_
--- DNS and Domains -- See Also ---
/libre/ByStar/InitialTemplates/activeDocs/bxServices/dnsManage/fullUsagePanel-en.org
bystarDnsAdmin.sh              # For each buid zone export prep etc.
bystarDnsInfoAdmin.sh          # dnsZoneAssign
bystarDnsReport.sh             # List Of All Domain -- DnsDiag through lcaDnsReport.sh
bystarDnsResolvAdmin.sh        # adjust /etc/resolv.conf + dnsCache adjust per buid
bystarDnsRoadmap.sh            # To be obsoleted by dnsManage/fullUsagePanel-en.org
bystarDnsZoneMasters.sh        # Not buid specific -- zoneInfoAdd bynumber.net
lcaDnsReport.sh                # Dns Diagnostics
mmaDnsAdmin.sh                 # mmaDnsEntryAliasShow -- Overlap with mmaDnsServerHosts.sh
mmaDnsImports.sh               # Obsoleted
mmaDnsServerHosts.sh           # servicesStartStop -- Overlap with mmaDnsAdmin.sh  
mmaDnsTopDomFix.sh             # Obsoleted -- root/data cleanser 
mmaDnsZonesExport.sh           # Obsoelted 
_EOF_
}


function vis_help {
  echo "NOTYET"
  return 0
}



function noArgsHook {
  vis_examples
}



function vis_bystarDomainsList {
 cat  << _EOF_
by-star.com
by-star.net
byalias.com
byalias.net
byartist.net
byartist.org
byauthor.net
bybinary.org
bycontent.com
bycontent.net
bycontent.org
byentity.com
byentity.net
byentity.org
byevent.com
byevent.net
byfamily.net
byhookup.net
byinteraction.com
byinteraction.net
byleaks.org
bylookup.net
bymemory.com
bymemory.net
bymemory.org
byname.com
byname.net
bynumber.com
bynumber.net
bysearch.org
bysmb.com
bysmb.net
bysmb.org
bysource.org
bytopic.org
bywhere.com
bywhere.net
emsd.org
esro.org
forsmb.com
forsmb.net
freeprotocols.org
halaalsoftware.com
halaalsoftware.net
halaalsoftware.org
librecenter.com
librecenter.net
libreroot.net
libreservices.net
libreservices.org
libresite.org
mailmeanywhere.org
neda.com
payk.com
payk.net
persoarabic.net
persoarabic.org
romard.com
romardrealestate.com
romardrealty.com
romeitalianpizza.net
romeitalianpizza.org
vorde.org
_EOF_
}



function vis_dnsResolversPublicList {
 cat  << _EOF_
SpeakEasy:
64.8.192.9
Comcast:
68.87.69.146
68.87.85.98
_EOF_
}

