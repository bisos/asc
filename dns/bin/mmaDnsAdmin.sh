#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: mmaDnsAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    `dirname $0`/seedSubjectAction.sh -l $0 "$@"
    exit $?
fi

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
--- INSTALLATION VERIFICATION ---
mmaDnsBinsPrep.sh -i fullVerify
${G_myName} ${extraInfo} -i progAcctsShow
${G_myName} ${extraInfo} -i progAcctsUpdate
--- SERVER MANIPULATION ---
${serverProg} ${extraInfo} -s ${opRunHostName} -a fullVerify
${serverProg} ${extraInfo} -s ${opRunHostName} -a servicesList
${serverProg} ${extraInfo} -s ${opRunHostName} -a servicesShow all
${serverProg} ${extraInfo} -s ${opRunHostName} -a servicesStop all
${serverProg} ${extraInfo} -s ${opRunHostName} -a servicesStart all
${serverProg} ${extraInfo} -s ${opRunHostName} -a servicesRestart all
${serverProg} ${extraInfo} -i cacheRestart
--- DNS SERVER POPULATION ---
${serverProg} ${extraInfo} -i contentFullUpdate
--- Entry Manipulation ---
${G_myName} -i mmaDnsEntryHostShow    ${oneHostFqdn} ${oneServer}
${G_myName} -i mmaDnsEntryHostUpdate  ${oneHostFqdn} ${oneServer}
${G_myName} -i mmaDnsEntryHostDelete  ${oneHostFqdn} ${oneServer}
${G_myName} -i mmaDnsEntryAliasShow   ${oneHostFqdn} ${oneServer}
${G_myName} -i mmaDnsEntryAliasUpdate ${oneHostFqdn} ${oneServer}
${G_myName} -i mmaDnsEntryAliasDelete ${oneHostFqdn} ${oneServer}
--- Content Manipulation ---
${G_myName} -i runFunc mmaDnsContentNsAdd ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentNsShow ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentAliasShow   ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentAliasAdd    ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentAliasDelete ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentHostShow      ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentHostAdd    ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentHostDelete    ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentMxShow      ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentMxUpdate    ${oneHostFqdn} ${oneIpAddr}
${G_myName} -i runFunc mmaDnsContentMxDelete    ${oneHostFqdn} ${oneIpAddr}
--- VIEW LOGS ---
${G_myName} -n showRun -i showLogs
${G_myName} -n showOnly -i showLogCommands
_EOF_
}

function vis_help {
  echo "NOTYET"
  return 0
}


function noArgsHook {
  vis_examples
}


function vis_progAcctsShow {
    mmaDnsUsersAndGroupsInfo
}

function vis_progAcctsUpdate {
    mmaDnsUsersAndGroupsAdd
}

function vis_showLogs {
  typeset logsList=`mmaDnsServerHosts.sh -v -n showRun -i logsList`
  typeset thisOne=""

  for thisOne in ${logsList} ; do
    ANT_raw "LogFile: ${thisOne}"
    opDoComplain eval '(' tail -20 ${thisOne} '|' tai64nlocal ')'
  done
}

function vis_showLogCommands {
  typeset logsList=`mmaDnsServerHosts.sh -v -n showRun -i logsList`
  typeset thisOne=""

  for thisOne in ${logsList} ; do
    ANT_raw "tail -20 ${thisOne} | tai64nlocal"
  done
}



function vis_mmaDnsContentSelectServer {
  # Future mmaDnsContent Actions Apply to the selected server
  # $1 -- server name

    mmaDnsContentSelectServer $*
}

function vis_mmaDnsContentBuild {
    mmaDnsContentBuild $*
}

function vis_mmaDnsContentHostUpdate {
    mmaDnsContentHostAdd $*
}


function vis_mmaDnsContentMxUpdate {
  mmaDnsContentMxAdd $*
}

function vis_mmaDnsContentFullShow {
  echo "cat /etc/tinydns/root/data"
}


function vis_mmaDnsEntryAliasDelete {
    mmaDnsEntryAliasDelete $*
}

function vis_mmaDnsEntryAliasUpdate {
    mmaDnsEntryAliasUpdate $*
}

function vis_mmaDnsEntryMxUpdate {
    mmaDnsEntryMxUpdate $*
}

function vis_mmaDnsEntryMxDelete {
    mmaDnsEntryMxDelete $*
}
