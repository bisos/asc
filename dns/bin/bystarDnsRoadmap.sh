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

function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- Information
${G_myName} -i modelAndTerminology
${G_myName} -i todos
${G_myName} -i help
${G_myName} -i howTos
${G_myName} -i pointersAndReferences
${G_myName} -i printPackage
${G_myName} -i printItems
_EOF_
}

function noArgsHook {
  vis_examples
}


function vis_todos {
 cat  << _EOF_
 
TODOs
=====

Short Term:
----------

Long Term:
---------

_EOF_
}


function vis_help {
  opRunEnvGet
 cat  << _EOF_


DESCRIPTION
     bystarDns is a set of consistent facilities
     on top of DJBDNS which enforces ByStar policies.


Layering
--------

    ---- On BACS ----

          bystarDnsAdmin.sh



    ----- Only On ZoneMasters -----

          bystarDnsZoneMasters.sh  --- Initializes the Zone Master
                                   --- Performs Imports based on Exporters Invokations


    ----- lcaService Layer ---

          mmaDnsServerHosts.sh  --- Configures Servers
           
    ----- BinsPrep Layer ----

           lcaDjbdnsSrcPkg.sh  --- Builds and installs from sources

           Obsoletes: lcaDjbdnsBinsPrep.sh lcaDjbdnsDebPkg.sh mmaDnsBinsPrep.sh

Libraries
---------

   bystarDnsDomain.libSh 
   
   mmaDnsLib.sh 

DnsZoneMasters Genesis Call Tree
--------------------------------

  bystarPlatformTop.sh
      bystarDnsZoneMasters.sh  -a fullUpdate



BACS Genesis Call Tree
----------------------





Basic DNS Scripts
-----------------

  mmaDns.sh              -- This File. General Orientation and Information

  mmaDnsLib.sh           -- To be included in all mmaDns scripts. 
                              General configuration parameters and
                              general useful functions go here

  mmaDnsBinsPrep.sh      -- Prepare binary files for djbDns
                         -- for relevant pltforms and versions
                         -- Install mmaDns binaries on opRunHostName

  mmaDnsServerHosts.sh   -- For subject host, configure qmail

  mmaDnsAdmin.sh         -- Start, stop and addNewAccounts

  mmaDnsImports.sh       -- Manipulate import zones

  opDomainContents.sh    -- Fill in the data for orig data servers
                         --

  opDomains.sh           -- List of all domains and pointers to the
                         -- content

  opNetNameServices.sh   -- /etc/hosts file generator and domain content 
                         -- basic ip address generation.


Basic DNS Items File
--------------------

Related Items Files:
       
          nedaIPAddrxxxxxItems.{priv0,pubC}

          opDomainItems.site

Basic Items Files:

           mmaDnsServerHostItems.site

           mmaDnsCopyItems.site

           mmaDnsCopyItems.other

----------


_EOF_

  exit 1
}

function vis_howTos {
 cat  << _EOF_
    A-1) How Do I install djbdns on my system?
       Follow the steps below.

       2) Install dns Binaries.
          mmaDnsBinsInstall.sh -i djbdnsFullInstall


       3) Specify basic  paramters (domain, ...)
         In ../siteControl/nedaPlus/mmaDnsListItems.main
         add an entry for your host. Then:

         mmaDnsHosts.sh -s ${opRunHostName} -a configure

       4) Verify and Monitor installation

         mmaDnsAdmin.sh -i fullReport

_EOF_
}


function vis_modelAndTerminology {
  opRunEnvGet
 cat  << _EOF_
 
   Terminology and Model:

   Qualifiers:
   -----------
        - local:    The scope is limited to this host only.
                    Accomplished using the 127.x.x.x address space.

        - net:      The scope is limited to this host only.
                    Accomplished using the network address space
                    (192.168.x.x, ....)

   Server Types:
   -------------

        - Resolving Server:  Runs some form of dnscache.

        - Orig Content Server: Runs tinydns and is the origin of data
                               and provides its data to CopyContentServers.

        - Copy Content Server: Runs tinydns and gets its data from 
                               some Orig Content Server.

        - Zone Xfer Server:  Runs axfrdns and provides zone data.


   Copying - Import/Export
   -----------------------

        We dont use "Primary" or "Secondary" terminology.

        We dont use "Master" or "Slave" terminology.

        We use Import and Export combined with 
        net{Orig,Copy}ContentServer

        A net{Orig,Copy}ContentServer when exposed to the 
        outside world can be considered Primary or Secondary.

        A localOrigContentServer can be exporting to multiple
        netCopyContentServers.

        Import and Export Methods are listed below:


  Import Methods: 
  ---------------

     sshPoll                  -- 
                              -- 

     ZoneXferGet:             -- Sets up what it takes to do periodic
                              -- axfr-get.


  Export Methods: 
  ---------------

     sshPush                  -- 
                              -- 


  Content Loading:
  ----------------

     mmaDnsEntry{type}{verb}  -- Takes domainName and HostName (mma)

     mmaDnsEntry{type}{verb}  -- Takes domainName and IpAddress

     type is one of:    {host,alias,mx,childns,...}

     verb is one of:    {show,update,delete}


  Exposed Content Servers
  -----------------------

    Combinations of netOrig and netCopy contentServers which 
    have been declared to higher zones (e.g. root servers).


  dnsSetup (Valid Values): 
  ------------------------

     localResolvingServer     -- local cache -- Just available to this host
                              -- runs dnscache on local 127.x address

     netResolvingServer       -- external cache -- net
                              -- runs dnscachex on network IP address

     localOrigContentServer   -- Orig Content Server -- Local Address
                              -- runs tinydns on local 127.x address

     netOrigContentServer     -- Orig Content Server -- Network Address
                              -- runs tinydns on network 192.168 address

     localCopyContentServer   -- Copy Content Server -- Local Address
                              -- runs tinydns on local 127.x address

     netCopyContentServer     -- Copy Content Server -- Network Address
                              -- runs tinydns on private 192.168 address

     netZoneXferServer:       -- Runs axfrdns and provides zone data.
                              -- Respond to zone transfer requests.

     netZoneXferGet:          -- Setup axfr-get polls



   Permitted Combinations
   ----------------------
        localResolvingServer with
                                netOrigContentServer
                               netCopyContentServer
                               netZoneXferServer

       netResolvingServer (privateResolvingServer or publicResolvingServer)
                               localOrigContentServer
                               localCopyContentServer
                               netZoneXferServer


   Conflicting Combinations
   ----------------------
        netResolvingServer and (netOrigContentServer or netCopyContentServer)
_EOF_
}


function vis_pointersAndReferences {
 cat  << _EOF_

Web draws a directed graph for a domain.
http://www.foobar.tm/dns/dnsbajaj.cgi


Life With DJBDns: http://
_EOF_
}

function vis_printPackage {
  opDoComplain nedaPrint.sh mmaDns.sh mmaDnsAdmin.sh mmaDnsLib.sh mmaDnsImports.sh  mmaDnsServerHosts.sh  mmaDnsBinsPrep.sh  
}

function vis_printItems {
  typeset filesToPrint=""
  typeset filesList="mmaDnsCopyItems.other mmaDnsCopyItems.site mmaDnsServerHostItems.site"

  typeset thisOne=""
  for thisOne in ${filesList} ; do
    filesToPrint="${filesToPrint} ${opSiteControlBase}/${opRunSiteName}/${thisOne}"
  done

  opDoComplain nedaPrint.sh ${filesToPrint}
}


