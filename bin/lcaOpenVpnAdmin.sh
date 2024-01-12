#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: lcaOpenVpnAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     seedSubjectAction.sh -l $0 "$@"
     exit $?
fi

. ${opBinBase}/mmaLib.sh
# ./mmaLayer3Lib.sh 
. ${opBinBase}/mmaLayer3Lib.sh

. ${opBinBase}/lpCurrents.libSh

# PRE parameters

function G_postParamHook {
    lpCurrentsGet
    
    secretStaticKeyFile=/opt/public/osmt/siteControl/nedaPlus/secretOpenVpn.key
    
    return 0
}


# ./mursL3Params.libSh 
. ${opBinBase}/mursL3Params.libSh

thisHostParams=$( ListFuncs | egrep "^${opRunHostName}Params$" )

if [ "${thisHostParams}_" == "_" ] ;   then
    EH_problem  "${G_myName} not supported on ${opRunHostName}"
    exit 1
else
    ${thisHostParams}
fi

netParam_intExtNets

parIntPriv0IPAddr=$( givenInterfaceGetIPAddr ${priv0Interface} )
parIntMursIPAddr=$( givenInterfaceGetIPAddr ${mursInterface} )

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset verboseLevel="--verb 5"
  #typeset verboseLevel=""
 cat  << _EOF_
EXAMPLES:
--- NOTE: NOTE: OBSOLETED BY:  lcaOpenVpnHosts.sh ---
Running With ${opRunHostName}Params -- role=${role} ${initiatorIpAddr}
${doLibExamples}
___ BINS PREP ---
apt-get -y install openvpn
apt-get -y install tunneldigger
--- INFORMATION ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a info
--- VERIFY PREREQUISITES ---
ls -l /dev/net/tun
OLD-mknod /dev/net/tun c 10 200
modprobe tun
--- KEY GENERATION / Processing ---
openvpn --genkey --secret ${secretStaticKeyFile}
ls -l  ${secretStaticKeyFile}
cat ${secretStaticKeyFile}
--- OPENING THE FIREWALL ---
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A INPUT -p udp --dport 1194 -j ACCEPT
==== INITIATOR ROLE ====
--- INITIATOR STATIC KEY ---
openvpn --remote ${responderIpAddr} --dev tun1 --ifconfig ${localTunnelAddr} ${remoteTunnelAddr} ${verboseLevel} --secret ${secretStaticKeyFile}
ping ${remoteTunnelAddr}
--- INITIATOR PUBLIC KEY ---
openvpn --remote ${responderIpAddr} --dev tun1 --ifconfig ${localTunnelAddr}  ${remoteTunnelAddr} ${verboseLevel} --secret ${secretStaticKeyFile}
ping ${remoteTunnelAddr}
==== INITIATOR ROLE ====
--- RESPONDER STATIC KEY ---
openvpn --dev tun1 --ifconfig ${localTunnelAddr} ${remoteTunnelAddr} ${verboseLevel} --secret ${secretStaticKeyFile}
ping ${remoteTunnelAddr}
--- RESPONDER PUBLIC KEY ---
openvpn --dev tun1 --ifconfig ${localTunnelAddr} ${remoteTunnelAddr} ${verboseLevel} --secret ${secretStaticKeyFile}
ping ${remoteTunnelAddr}
==== SERVER WITH MULTIPLE CLIENTS ====

---- ROUTING ---
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -A FORWARD -i tun+ -j ACCEPT
route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
--- POINTERS and Documentation
--- NOTE: NOTE: OBSOLETED BY:  lcaOpenVpnHosts.sh ---
_EOF_
}


function vis_help {
  cat  << _EOF_

_EOF_
  return 0
}

noArgsHook() {
  vis_examples
}


function do_exampleTask {
  EH_assert [[ $# -eq 1 ]]
  targetSubject=item_${subject}
  subjectValidVerify
  ${targetSubject}
  
  ANT_raw "Software Profile For ${subject}"


  case ${1} in
    "update"|"verify"|"delete")
	      echo "lcaCvmBinsPrep.sh -s ${softwareProfile} -a $1"
	       ;;
    "tag")
	      echo "${softwareProfile}"
	       ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}



function vis_configure {
  opDo do_configFullUpdate
}

