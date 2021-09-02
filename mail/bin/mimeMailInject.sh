#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: mimeMailInject.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

# Don't delete the line below. With KSH it makes things work. Puzzle. Mohsen.
echo " "

if [ "${loadFiles}X" == "X" ] ; then
    `dirname $0`/seedActions.sh -l $0 "$@"
    exit $?
fi

. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/mimeOutLib.sh

# PRE parameters

typeset -t envelopeAddr="_nil"
typeset -t fromAddr="_nil"
typeset -t toAddrList="_nil"
typeset -t ccAddrList="_nil"
typeset -t subjectLine="_nil"

function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
  typeset oneEmail="test@pinneke.tjandana.1.byname.net"
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- MIME GENERATION ---
${G_myName}  -i mimeGen /var/ssis/scanner/default-output/batch-05142003/SCN0001A.tif /var/ssis/scanner/default-output/batch-05142003/SCN0001B.tif

--- EMAIL QMAIL ---
${G_myName} -p envelopeAddr="${oneEmail}" -p fromAddr="${oneEmail}" -p toAddrList="office@pinneke.tjandana.1.byname.net" -p ccAddrList="pinneke@neda.com" -p subjectLine="Cannot_have_space" -i email_qmail /var/ssis/scanner/default-output/batch-05142003/*.tif

${G_myName}  -p toAddrList="office@pinneke.tjandana.1.byname.net" -i email_qmail /var/ssis/scanner/default-output/batch-05142003/SCN0001A.tif /var/ssis/scanner/default-output/batch-05142003/SCN0001B.tif

--- DMS Scanned ---
${G_myName} -p envelopeAddr="${oneEmail}" -p fromAddr="${oneEmail}" -p toAddrList="scanned@dms.ssis-inc.com" -p subjectLine="Cannot_have_space" -i email_qmail /opt/public/osmt/samples/tif/small.tif 

--- EMAIL BLAT ---
${G_myName} -p envelopeAddr="${oneEmail}" -p fromAddr="${oneEmail}" -p toAddrList="office@pinneke.tjandana.1.byname.net" -p ccAddrList="pinneke@neda.com" -p subjectLine="Ignore..." -i email_blat v:\\tmp\\batch-05142003\\*.tif

${G_myName}  -p toAddrList="office@pinneke.tjandana.1.byname.net" -i email_blat v:\\tmp\\batch-05142003\\SCN0001A.tif v:\\tmp\\batch-05142003\\SCN0001B.tif
_EOF_
}

function vis_help {
  echo "NOTYET"
  return 0
}

function noArgsHook {
  vis_examples
}

typeset qmailInject_setParams=""

function qmailInject_analyzeParams {

  EH_assert [[ "${toAddrList}_" != "_nil_" ]]
  qmailInject_setParams="${qmailInject_setParams} -p toAddrList="${toAddrList}""

  if [[ "${envelopeAddr}_" != "_nil_" ]] ; then
    qmailInject_setParams="${qmailInject_setParams} -p envelopeAddr="${envelopeAddr}""
  fi

  if [[ "${fromAddr}_" != "_nil_" ]] ; then
    qmailInject_setParams="${qmailInject_setParams} -p fromAddr="${fromAddr}""
  fi

  if [[ "${ccAddrList}_" != "_nil_" ]] ; then
    qmailInject_setParams="${qmailInject_setParams} -p ccAddrList="${ccAddrList}""
  fi
}

typeset blat_setParams=""

function blat_analyzeParams {
  
  EH_assert [[ "${toAddrList}_" != "_nil_" ]]
  blat_setParams="${blat_setParams} -to "${toAddrList}""

  if [[ "${envelopeAddr}_" != "_nil_" ]] ; then
    blat_setParams="${blat_setParams} -mailfrom "${envelopeAddr}""
  fi
  
  if [[ "${fromAddr}_" != "_nil_" ]] ; then
    blat_setParams="${blat_setParams} -from "${fromAddr}""
  fi

  if [[ "${ccAddrList}_" != "_nil_" ]] ; then
    blat_setParams="${blat_setParams} -cc "${ccAddrList}""
  fi

  if [[ "${subjectLine}_" != "_nil_" ]] ; then
    blat_setParams="${blat_setParams} -subject "${subjectLine}""
  fi
}


function vis_mimeGen {
  if [[ $# -eq 0 ]] ; then
    EH_problem "Please specify the attachment files."
    return 1
  fi

  typeset tmpFile="/tmp/mimeAttach.$$"
  touch ${tmpFile}

  typeset filesToSend=`ls $@`
  typeset oneFile
  for oneFile in ${filesToSend} ; do
    mimeBodyPart "$oneFile" >> ${tmpFile}
  done

  print "${tmpFile}"
}

function vis_email_qmail {

  if [[ $# -eq 0 ]] ; then
    EH_problem "Please specify the attachment files."
    return 1
  fi

  typeset tmpFile=`vis_mimeGen "$@"`

  mimeHeadersPartOut

  qmailInject_analyzeParams

  if [[ "${G_runMode}" == "showOnly" ]] ; then
    if [[ "${subjectLine}_" != "_nil_" ]] ; then
      mmaQmailInject.sh -n showOnly -p extraHeaders="${mimeHeaders}" -p envelopeSpecMethod="ARGUMENT" ${qmailInject_setParams} -p subjectLine="${subjectLine}" -p contentFile=${tmpFile} -i inject
    else
      mmaQmailInject.sh -n showOnly -p extraHeaders="${mimeHeaders}" -p envelopeSpecMethod="ARGUMENT" ${qmailInject_setParams} -p contentFile=${tmpFile} -i inject
    fi
  else
    if [[ "${subjectLine}_" != "_nil_" ]] ; then
      mmaQmailInject.sh -p extraHeaders="${mimeHeaders}" -p envelopeSpecMethod="ARGUMENT" ${qmailInject_setParams} -p subjectLine="${subjectLine}" -p contentFile=${tmpFile} -i inject
    else
      mmaQmailInject.sh -p extraHeaders="${mimeHeaders}" -p envelopeSpecMethod="ARGUMENT" ${qmailInject_setParams} -p contentFile=${tmpFile} -i inject
    fi
  fi

  #/bin/rm ${tmpFile}
}

function vis_email_blatNOTYET {

  if [[ $# -eq 0 ]] ; then
    EH_problem "Please specify the attachment files."
    return 1
  fi

  typeset tmpFile=`vis_mimeGen "$@"`

  mimeHeadersPartOut

  blat_analyzeParams

  C:/WINNT/system32/blat ${tmpFile} ${blat_setParams}

  /bin/rm ${tmpFile}
}

typeset attachment_set=""
function attachParams {

  typeset thisOneAttach
  for thisOneAttach in $* ; do
    attachment_set="${attachment_set} -attach ${thisOneAttach}"
  done
}

function vis_email_blat {

  if [[ $# -eq 0 ]] ; then
    EH_problem "Please specify the attachment files."
    return 1
  fi

  attachParams $*

  blat_analyzeParams

  opDoComplain C:/WINNT/system32/blat C:/temp/manifest.xml ${tmpFile} ${blat_setParams} ${attachment_set}

}
