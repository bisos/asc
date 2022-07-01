#!/bin/bash


typeset RcsId="$Id: lcnMailMsgOutProc.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  `dirname $0`/seedActions.sh -l $0 "$@"
  exit $?
fi


# PRE parameters
typeset -t msg=""
typeset -t fileSizeLimit=500000
#typeset -t scanWith="spamA+clamAV"
typeset -t scanWith="spamA"

function G_postParamHook {
  msg=$( FN_absolutePathGet "${msg}" )
  set -- $(IFS="+"; echo ${scanWith})
  scanWithList="$*"
}

function vis_examples {
 typeset extraInfo="-h -v -n showRun"
 typeset visLibExamples=`visLibExamplesOutput ${G_myName}`

 typeset oneMboxMail="/opt/public/osmt/samples/email/html.inMail"
 typeset oneFileSizeLimit=500000
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- History and Credits  ---
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i injectMsg
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -p envelopeAddr="" -i injectMsg
--- Msg: Test/Report ---
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc isLargerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc isSmallerThanFileSize ${oneFileSizeLimit}
${G_myName} ${extraInfo} -p msg=${oneMboxMail} -i testMsgFunc grepFor -i mohsen
=== Misc ===
_EOF_
}

noArgsHook() {
  vis_examples
}

function vis_help {
 cat  << _EOF_

This is all incomplete.

Other funcs generate a message.
Then they pass it to injectMsg.

All that injectMsg does is:
 - Extract the info from the "msg"
 - Add default from.
 - Add default envelop.

 formail which is part of procmail.
 reformail which is part of  dpkg -L courier-maildrop
/usr/share/man/man1/mailbot.1.gz
/usr/share/man/man1/maildrop.1.gz
/usr/share/man/man1/makemime.1.gz
/usr/share/man/man1/reformail.1.gz
/usr/share/man/man1/reformime.1.gz

TODO BEGIN: 

TODO END:


_EOF_
}



function vis_testMsgFunc {
  EH_assert [[ $# -gt 0 ]]
  EH_assert opParamIsSet msg


  ANT_raw "Scanning with $@ message ${msg}"

  $@
  retVal=$?
  thisFileSize=$( FN_fileSize ${msg} )
  if [ "${retVal}" == "0" ]; then
      ANT_raw "  MATCH : ${msg} : ${thisFileSize}"
  else
      ANT_raw "NO MATCH: ${msg} : ${thisFileSize}"
  fi
}

