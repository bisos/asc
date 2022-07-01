#!/bin/bash
#!/bin/bash

typeset RcsId="$Id: lcaVpopmailAdmin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  seedActions.sh -l $0 "$@"
  exit $?
fi

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh

# PRE parameters optional

. ${opBinBase}/bystarHook.libSh

# ./bxo_lib.sh
. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

# PRE parameters
typeset -t RABE="MANDATORY"
typeset -t bystarUid="MANDATORY"

function G_postParamHook {
     bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
     return 0
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  typeset acctsList=$( bystarBacsAcctsList )

  oneBystarAcct=$( echo ${acctsList} | head -1 )

 cat  << _EOF_
EXAMPLES:
${visLibExamples}
---- BINSPREP  ----

---- SERVER SETUP  ----
${G_myName} ${extraInfo} -i serverSetup
---- MySql Config ----
lcaMySqlAdmin.sh ${extraInfo} -i vpopmailSetup vpopmailuser  Notyet4Passwd
---- FULL  ----
${G_myName} ${extraInfo} -i fullUpdate
_EOF_
}


noArgsHook() {
  vis_examples
}


function vis_fullUpdate {
    vis_customizeAcctFromLine
}

function vis_serverSetup {
  EH_assert [[ $# -eq 0 ]]

  G_abortIfNotRunningAsRoot

  vpopmailMysqlFile=""

  typeset thisDateTag=`date +%y%m%d%H%M%S`
  FN_fileSafeCopy ${squirrelmailPrefFile} ${squirrelmailPrefFile}.${thisDateTag}
    
  FN_textReplace "^full_name=.*" "full_name=${cp_FirstName} ${cp_LastName}" ${squirrelmailPrefFile}
  FN_textReplace "^email_address=.*" "email_address=${cp_MasterAcctMailName1}\@${cp_master_MainDomain}" ${squirrelmailPrefFile}

  opDo ls -l ${squirrelmailPrefFile}
}



function vis_acctDnsUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet bystarAcctAnalyze ${bystarUid}
}

