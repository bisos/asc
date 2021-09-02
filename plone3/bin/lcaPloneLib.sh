function loadFeaturesConf {

  typeset itemFile="$1"

  . ${itemFile}

  typeset oneFeature
  for oneFeature in ${iv_featuresList[@]}; do
    item_bap_${oneFeature}
  done

  . ${opSiteControlBase}/nedaPlus/lcaZopeServerItems.site
    item_${iv_bap_zope_server_ref}

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