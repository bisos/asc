#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPlone3UrlApi.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    $( dirname $0 )/seedActions.sh -l $0 "$@"
    exit $?
fi


vis_help () {
  cat  << _EOF_

lcaPlone3UrlApi.sh  user passwd url zmiVerb zmiArgs
lcaPlone3UrlApi.sh  -p show=pw  user passwd url zmiVerb zmiArgs

lcaPlone3UrlApi.sh  -i examples


_EOF_
}


. ${opBinBase}/lpCurrents.libSh

# PRE parameters
typeset -t acctTypePrefix=""
typeset -t bystarUid="MANDATORY"

function G_postParamHook {
    lpCurrentsGet
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  # NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset oneSubject="qmailAddr_test"
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
${G_myName} user passwd url zmiVerb zmiArgs
${G_myName} ${extraInfo} user  passwd url zmiVerb zmiArgs
${G_myName} -p show=pw  user passwd url zmiVerb zmiArgs
${G_myName} ${extraInfo} -p show=pw  user passwd url zmiVerb zmiArgs
--- Create a Site ---
${G_myName} -i loginAndDo user password http://198.62.92.160:8080 /manage_addProduct/CMFPlone/addPloneSite -d id=new1.com -d title=new1.com -d create_userfolder=1 -d description=desc+for+new1.com -d submit=+Add+Plone+Site+
POST /manage_addProduct/CMFPlone/addPloneSite id=new1.com&title=new1.com&create_userfolder=1&description=desc+for+new1.com&submit=+Add+Plone+Site+


--- Add a user ---
_EOF_
}

noArgsHook() {
    vis_loginAndDo $*
  #vis_examples
}

noSubjectHook() {
  return 0
}


function vis_fullAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

}


function vis_loginAndDo {
#set -x

  typeset url="$3"
  typeset username="$1"
  typeset passwd="$2"
  shift 3
  typeset action="$*"
  typeset logFile="/tmp/zmiAutoLogin.$$"

  # NOTYET, make verbosity run time
  #set -x
  echo curl --user ${username}:${passwd} -k -i -o ${logFile} ${url}/${action}
  eval curl --user ${username}:${passwd} -k -i -o ${logFile} ${url}/${action} >/dev/null 2>&1

  opDo ls -l  ${logFile}
  return $?

  #opDo ls -l  ${logFile}
  #cat ${logFile}
  #/bin/rm ${logFile}

}


function zmi_login_and_action {

  typeset url="$1"
  typeset username="$2"
  typeset passwd="$3"
  shift 3
  typeset action="$*"
  typeset logFile="/tmp/zmiAutoLogin.$$"

  # NOTYET, make verbosity run time
  #set -x
  eval curl --user ${username}:${passwd} -k -i -o ${logFile} ${url}/${action} >/dev/null 2>&1

  return $?
  #opDo ls -l  ${logFile}
  #cat ${logFile}
  #/bin/rm ${logFile}

}


function plone_autoLogin {

  typeset url="$1"
  typeset username="$2"
  typeset passwd="$3"

  ${url}/login_form?__ac_name=${username}&__ac_password=${passwd}

}

function plone_autoLogout {

  typeset url="$1"
  ${url}/logout

}