#!/bin/bash

typeset RcsId="$Id: lcaGenewebSvcUse.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     seedSubjectHosts.sh -l $0 "$@"
     exit $?
fi

function vis_help {
  cat  << _EOF_


_EOF_
  return 0
}

. ${opBinBase}/mmaLib.sh

. ${opBinBase}/lpCurrents.libSh

# PRE parameters

function G_postParamHook {
    lpCurrentsGet

    return 0
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -i serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -i serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -i serviceSoftwareProfile showCmdLine -a fullUpdate
--- Service Config (update/verify/delete) ---
${G_myName} ${extraInfo} -i serviceConfig fullVerify
${G_myName} ${extraInfo} -i serviceConfig fullUpdate
${G_myName} ${extraInfo} -i serviceConfig showCmdLine -i fullUpdate
--- SERVER ACTIONS FULL ---
${G_myName} ${extraInfo} -i serviceDaemonType  # sysv, daemontools, other -- used to generate xxAdmin.sh
${G_myName} ${extraInfo} -i serviceDaemonList  # local, unix, ...
${G_myName} ${extraInfo} -i serviceFeatures  # local, unix, ...
=== Details with -- -T 7 ===
${G_myName} ${extraInfo} -i serviceFullInfo
=== More For Developers ===
${G_myName} ${extraInfo} -i examplesDev
_EOF_
}

function vis_examplesDev {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
--- SOFTWARE for Server Profile (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceSoftwareProfile showCmdLine -a fullUpdate
--- Service Config (update/verify/delete) ---
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig fullVerify
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig fullUpdate
${G_myName} ${extraInfo} -s ${opRunHostName} -a serviceConfig showCmdLine -i fullUpdate
_EOF_
}


noArgsHook() {
  vis_examples
}



function do_serviceSoftwareAssert {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "NOTYET"
}

function vis_serviceSoftwareProfile {
  EH_assert [[ $# -ge 1 ]]

  subject=${opRunHostName}

  do_serviceSoftwareProfile $@
}

function do_serviceSoftwareProfile {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "Software Service Profile For ${subject}"

  # NOTYET, untested - set binsPrepCmd in seedUserScript
  if [ "${binsPrepCmd}_" == "_" ] ; then
      binsPrepCmdBase=${G_myName%%SvcUse.sh}
      binsPrepCmd="${binsPrepCmdBase}BinsPrep.sh"
  fi

  cmdLineBase=""

    case ${iv_serviceHost_setup} in
      "server"|"client"|"fullServer")
        orderedSubjectsList=$( ${binsPrepCmd} -i orderedList )
        cmdLineBase="${binsPrepCmd} ${orderedSubjectsList}"
	;;

      "noService")
        cmdLineBase="echo ${G_myName}: noService -- BinsPrep skipped"
	#break
	;;

      *)
       EH_problem "Unknown:  ${iv_serviceHost_setup}"
       return 1  
       ;;
    esac

  case ${1} in
    "fullUpdate"|"fullVerify"|"fullDelete")
 	       opDo ${cmdLineBase} -a $1
	       ;;
    "showCmdLine")
              shift 
	      echo "${cmdLineBase} $@"
	       ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}

function vis_serviceConfig {
  EH_assert [[ $# -ge 1 ]]

  subject=${opRunHostName}

  do_serviceConfig $@
}


function do_serviceConfig {
  EH_assert [[ $# -ge 1 ]]

  subjectValidatePrepare

  ANT_raw "Service Configuration For ${subject}"

  # NOTYET, untested - set serviceConfigCmd in seedUserScript
  if [ "${serviceConfigCmd}_" == "_" ] ; then
      serviceConfigCmdBase=${G_myName%%SvcUse.sh}
      serviceConfigCmd="${serviceConfigCmdBase}Admin.sh"
  fi

  cmdLineBase=""

    case ${iv_serviceHost_setup} in
      "server"|"client"|"fullServer")
        cmdLineBase="${serviceConfigCmd}"
	;;

      "noService")
        cmdLineBase="echo ${G_myName}: noService -- BinsPrep skipped"
	break
	;;

      *)
       EH_problem "Unknown:  ${iv_serviceHost_setup}"
       return 1  
       ;;
    esac

  case ${1} in
    "fullUpdate"|"fullVerify"|"fullDelete")
 	       opDo ${cmdLineBase} -i $1
	       ;;
    "showCmdLine")
              shift 
	      echo "${cmdLineBase} $@"
	       ;;

    *)
       EH_problem "Unexpected Arg: $1"
       ;;
  esac
}



### ITEMS DESCRIPTION ###

function itemPre_serviceHost {
  iv_serviceHost_host=""

  iv_serviceHost_setup="noService"

  function iv_descriptionFunction {
cat << _EOF_
Undefined -- No iv_descriptionFunction for
_EOF_
}

}

function itemPost_serviceHost {
  EH_assert [[ "${iv_serviceHost_host}_" != "_" ]]	
}

function itemDefault_serviceHost {
  itemPre_serviceHost
  itemPost_serviceHost
}


function itemFamily_BACS {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}


function itemFamily_BISP {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="noService"

  itemPost_serviceHost
}


function itemFamily_BUE {
  itemPre_serviceHost

  iv_serviceHost_host="${opRunHostName}"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}


function item_bacs000Example {
  itemPre_serviceHost

  iv_serviceHost_host="bacs000Example"
  iv_serviceHost_setup="server"

  itemPost_serviceHost
}
