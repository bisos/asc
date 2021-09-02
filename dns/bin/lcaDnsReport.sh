#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" :partof "generic" :copyleft "none"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: lcaDnsReport.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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

function vis_help {
    cat  << _EOF_
This is meant to be completely Passive -- Used For Diagnosis and Information.
_EOF_
}

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh

# PRE parameters

function G_postParamHook {
     return 0
}

# }}}

# {{{ Examples

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- See Also ---
bystarDnsReport.sh  -i dnsSeeAlso
---- Domain Servers List ----
echo "romeitalianpizza.net byname.net" | xargs -n 1 ${G_myName} ${extraInfo} -i zoneServersList 
${G_myName} ${extraInfo} -i zoneServersList byname.net
${G_myName} ${extraInfo} -i zoneServersList persoarabic.org
${G_myName} ${extraInfo} -i zoneServersArrayStdout byname.net
${G_myName} ${extraInfo} -i zoneServersArrayStdout persoarabic.org
whois persoarabic.org
dnsq ns byname.net a.gtld-servers.net
dnsq ns emsd.org a0.org.afilias-nst.info
---- Domain Diagnostics ----
${G_myName} ${extraInfo} -i diagDnsqr byname.net
${G_myName} ${extraInfo} -i diagDnsq byname.net
${G_myName} ${extraInfo} -i diagDnstrace byname.net
${G_myName} ${extraInfo} -i diagPingServers byname.net
${G_myName} ${extraInfo} -i diagFull byname.net
--- DJBDNS DIAGNOSTICES ---
http://cr.yp.to/djbdns/debugging.html
dnsip www.neda.com
dnsname 198.62.92.134
dnsmx 198.62.92.134
dnsqr any byname.net
dnsq any byname.net 198.62.92.1
cd /etc/tinydns/root; tinydns-get ns example.com
cd /etc/tinydns/root; tinydns-get any example.com ipAddr
--- Other Resoling Agents ---
host www.example.com
echo "dig -x 198.62.92.10"
echo "dig www.neda.com"
apt-get install fpdns
fpdns 198.62.92.1  # fingerPrint revision
${G_myName} -i hints  
_EOF_
}


noArgsHook() {
  vis_examples
}

# }}}

bystarDomains="neda.com byname.net"

typeset -A dnsVerifiers=(
    [dnsqr]=vis_diagDnsqr
    [dnsq]=vis_diagDnsq
    [ping]=vis_diagPingServers
)


function vis_diagDnsqr {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   #typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   opDo dnsqr any $1

   lpReturn
}

function vis_diagDnsq {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   for (( i=0;i<=100;i++ )) ; do
       if [ -z "${nsParsed[ns_name_${i}]}" ] ; then
           printf "\n"
           break
       fi
       opDo dnsq any $1 ${nsParsed[ns_ipAddr_${i}]} &
   done

   lpReturn
}

function vis_diagDnstrace {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
 dnstrace any www.aol.com a.root-servers.net > AOL &
 dnstracesort < AOL | less
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   for (( i=0;i<=100;i++ )) ; do
       if [ -z "${nsParsed[ns_name_${i}]}" ] ; then
           printf "\n"
           break
       fi
   done

   lpReturn
}


function vis_diagPingServers {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   for (( i=0;i<=100;i++ )) ; do
       if [ -z "${nsParsed[ns_name_${i}]}" ] ; then
           printf "\n"
           break
       fi
       opDo ping -c 3 ${nsParsed[ns_ipAddr_${i}]} &
   done

   lpReturn
}


function vis_diagFull {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   thisIndex=1
   echo ${nsParsed[ns_ipAddr_${thisIndex}]}


   for i in "${!dnsVerifiers[@]}"
   do
       #echo "key  : $i"
       opDo ${dnsVerifiers[$i]} $1
   done

   lpReturn
}


function vis_zoneServersList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

   typeset -A nsParsed=$( vis_zoneServersArrayStdout $1 )

   printf "${nsParsed[ns_zoneName]}:"

   for (( i=0;i<=100;i++ )) ; do
       if [ -z "${nsParsed[ns_name_${i}]}" ] ; then
           printf "\n"
           break
       fi
       printf  "${nsParsed[ns_name_${i}]}:${nsParsed[ns_ipAddr_${i}]}:"
   done

   lpReturn
}


function vis_zoneServersArrayStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset tmpFile=/tmp/${G_myName}.$$

    fqdn=${1}
    fqdnToArray ${fqdn}

    set ${fqdnArrayReverse[@]}

    case ${fqdnArrayReverse[0]} in
        "org"|"ORG")
            #opDo eval dnsq ns ${fqdn} a0.org.afilias-nst.info \> ${tmpFile}
            dnsq ns ${fqdn} a0.org.afilias-nst.info > ${tmpFile}
            ;;
        "net"|"com")
            #opDo eval dnsq ns ${fqdn} a.gtld-servers.net \> ${tmpFile}
            dnsq ns ${fqdn} a.gtld-servers.net > ${tmpFile}
            ;;
        *)
            EH_problem ""
            return
            ;;
    esac



    echo "("
    echo "[ns_zoneName]=${fqdn}"

    typeset thisLine=""
    typeset thisIndex=0

    typeset additionalResults=$( grep additional: ${tmpFile} )

    if [ ! -z "${additionalResults}" ] ; then
        grep additional: ${tmpFile} | 
        while read  thisLine  ; do
            typeset thisServerName=$( echo ${thisLine} | cut -d ' ' -f 2 )
            typeset thisServerIpAddr=$( echo ${thisLine} | cut -d ' ' -f 5 )
            echo "[ns_name_${thisIndex}]=${thisServerName}"     
            echo "[ns_ipAddr_${thisIndex}]=${thisServerIpAddr}"
            ((thisIndex++))
        done
    else
        grep authority: ${tmpFile} |
        while read  thisLine  ; do
            typeset thisServerName=$( echo ${thisLine} | cut -d ' ' -f 5 )
            typeset thisServerIpAddr=$( dnsip ${thisServerName} )
            #opDo dnsip ${thisServerName}  # NOTYET, What to do when you get multiple
            echo "[ns_name_${thisIndex}]=${thisServerName}"     
            echo "[ns_ipAddr_${thisIndex}]=${thisServerIpAddr}"
            ((thisIndex++))
        done
    fi

        echo ")"

    lpReturn
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



function vis_hints {

  echo "dnstrace a www.vis-av.com a.root-servers.net > /tmp/t1"
  echo "sleep 300"
  echo "dnstracesort < /tmp/t1"

  echo "http://www.DNSreport.com"
  echo "http://www.checkdns.net"
  echo "http://www.dnsstuff.com"

  return 0
}


vis_dnsDiag() {
  # $* -- Domain to process

  if [ $# -eq 0 ] ; then
    echo "Specify argument"
    return 1
  fi

  echo "dnsip $*"
  dnsip $*

  echo "dnsqr a $*"
  dnsqr a $*

  #echo "dnsq a $* shoosh"
  #dnsq  a $* 127.53.0.2

#
# dnstrace a network-surveys.cr.to a.root-servers.net > /root/NSC &
# sleep 300
# dnstracesort < /root/NSC | less
#


  return 0
}



####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: shellscript-mode
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:
