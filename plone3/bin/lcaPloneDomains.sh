#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPloneDomains.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
     seedSubjectAction.sh -l $0 $@
     exit $?
fi

. ${opBinBase}/lcaPloneLib.sh
. ${opBinBase}/mmaWebLib.sh
. ${opBinBase}/mmaDnsLib.sh
. ${opBinBase}/opAcctLib.sh

typeset -t itemFile=""

#setBasicItemsFiles lcaPloneDomainItems


function G_postParamHook {

  if [  "${itemFile}_" != "_" ] ; then
    ItemsFiles=${itemFile}
  fi

}

function vis_examples {
  typeset options="-h -v -n showRun"
  typeset oneDom="ploneDom_payknet_test"
  typeset oneItemFile="/acct/bymemory/ma-57000/NSP/ploneFeatures.nsp"
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
  typeset oneTemplateFile="~/temp.zexp"

  cat  << _EOF_
EXAMPLES:
${doLibExamples} 
--- INFORMATION ---
${G_myName} -s all -a summary
--- Create domain using item file in the siteControl
${G_myName} ${options} -s ${oneDom} -a addPortalSite
--- Using BAP ---
${G_myName} ${options} -p itemFile=${oneItemFile} -p templateFile=${oneTemplateFile} -s bap_full -a fullUpdate
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a manageUser
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a addPortalSite
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a configure_virtual_domain
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a create_custom_logo
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a deactivate_logo
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a upload_custom_logo  /acct/bymemory/ma-57000/plone/logo.png 
=======
${G_myName} ${options} -p itemFile=${oneItemFile} -s bap_full -a upload_custom_logo thisFileName
_EOF_
}

vis_help () {
  cat  << _EOF_
NOTYET
_EOF_

  exit 1
}

noSubjectHook() {
  return 0
}
 
noArgsHook() {
  vis_examples
}

function do_fullUpdate {

   subjectValidatePrepare
    
  loadFeaturesConf ${itemFile}

  opDo do_manageUser
  opDo do_addPortalSite
  opDo do_configure_virtual_domain
  #opDo do_create_custom_logo

  if [[ "${iv_bap_gallery_fqdn}_" != "_" ]] ; then

    opDo mmaGalleryAdmin.sh -p domFQDN=${iv_bap_gallery_fqdn} -p galleryBaseDir="~${iv_bap_ai_acctType}-${iv_bap_ai_number}" -i addGallery
  fi

}

function do_manageUser {

    subjectValidatePrepare
    
    loadFeaturesConf ${itemFile}

    ANT_raw "About to create a site owner account"
    continueAfterThis

    opDo lcaPloneAdmin.sh -p adminUsername=${iv_zopeSrv_initialUser} -p adminPasswd=${iv_zopeSrv_initialPasswd}  -p username=${iv_bap_plone_siteOwner} -p password=${iv_bap_ai_currentPasswd} -p siteurl=${iv_zopeSrv_url} -p role="Manager" -i addZopeUser

  }

function do_addPortalSite {

  subjectValidatePrepare
  loadFeaturesConf ${itemFile}
  
  ANT_raw "About to create a plone site at ${iv_zopeSrv_url}/${iv_name_fqdn}"
  continueAfterThis

  if [[ "${templateFile}_" == "_" ]] ; then
    typeset templateFile="/opt/public/osmt/sysConfigInput/zope2.7/bymemory.template.zexp"
  fi
  
  typeset templateFile_name=`FN_nonDirsPart ${templateFile}`
  opDo cp ${templateFile} ${iv_zopeSrv_instanceDir}/import
  
  typeset constructor="/manage_importObject"
  typeset input="-d file=${templateFile_name}"
  opDo zmi_login_and_action ${iv_zopeSrv_url} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input
  
  typeset templateFile_name_prefix=${templateFile_name%.zexp}
  if [[ "${templateFile_name_prefix}_" != "${iv_name_fqdn}_" ]] ; then
    
    typeset constructor="/manage_renameObject"
    typeset input="-d id=${templateFile_name_prefix} -d new_id=${iv_name_fqdn}"
    opDo zmi_login_and_action ${iv_zopeSrv_url} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input
  fi 

}

function do_configure_virtual_domain {

  subjectValidatePrepare
  loadFeaturesConf ${itemFile}

  echo "add virdom for ${iv_name_fqdn}"

  typeset destConfFile="${apacheBaseDir}/servers/${opRunHostName}/conf/httpd.conf"

  EH_assert [[ -f ${destConfFile} ]]

  FN_lineAddToFile "LoadModule proxy_module" "LoadModule proxy_module /usr/lib/apache/1.3/libproxy.so" ${destConfFile}

  FN_lineAddToFile "AddModule mod_proxy.c" "AddModule mod_proxy.c" ${destConfFile}
 
  typeset templateFile="${opSysConfigInputBase}/${mmaWeb_apacheRevision}/${opRunOsType}/httpd.conf-init-tail-noGallery.noending"
 
  typeset hostIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`

  opAcctInfoGet ${iv_bap_ai_acctType}-${iv_bap_ai_number}
  typeset webDom_baseDir="${opAcct_homeDir}/lcaPlone"
  opDo FN_dirCreatePathIfNotThere ${webDom_baseDir}/htdocs
  opDo FN_dirCreatePathIfNotThere ${webDom_baseDir}/logs

  integer retVal=0
  FN_lineIsInFile "${iv_name_fqdn}" ${destConfFile} || retVal=$?
  if [[ ${retVal} -ne 0 ]] ; then
    cat   ${templateFile} | sed -e "s:@webSrv_domainHosted@:${iv_name_fqdn}:" \
     -e "s:@domainName@:${iv_name_fqdn}:" \
     -e "s:@baseDomainDir@:${webDom_baseDir}:" \
     -e "s:@webSrv_ipAddress@:${hostIPAddress}:" >> ${destConfFile}

    cat  << _EOF_ >> ${destConfFile}

        ProxyPass / ${iv_zopeSrv_url}/${iv_name_fqdn}/
        ProxyPassReverse / ${iv_zopeSrv_url}/${iv_name_fqdn}/
        ProxyPass /misc_ ${iv_zopeSrv_url}/misc_
        ProxyPass /p_ ${iv_zopeSrv_url}/p_

</VirtualHost>

_EOF_
  fi

  opDo FN_dirCreatePathIfNotThere ${opAcct_homeDir}/web/htdocs
  opDo FN_dirCreatePathIfNotThere ${opAcct_homeDir}/web/logs
  opDo FN_dirCreatePathIfNotThere ${opAcct_homeDir}/web/cgi-bin

  opDo mmaWebDomains.sh -p opClusterName=${opRunClusterName} -p opHostName=${opRunHostName} -p opDomainName=web.${iv_number_fqdn} -p baseDir="${opAcct_homeDir}/web" -p withGallery=yes -i addVirtualDomainInConfigFile

  if [[ "${iv_bap_ai_acctType}_" == "ea_" ]] ; then
    opDo mmaWebDomains.sh -p opClusterName=${opRunClusterName} -p opHostName=${opRunHostName} -p opDomainName=${iv_bap_ai_domainName}.bysmb.${iv_bap_ai_tld} -p baseDir="${opAcct_homeDir}/web" -p withGallery=yes -i addVirtualDomainInConfigFile
  fi

  echo "configure virtual host monster in zmi"
  typeset constructor="/manage_addProduct/SiteAccess/manage_addSiteRoot"
  typeset input="-d base=http://${iv_name_fqdn} -d path=/"
  item_bap_plone

  opDo zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 

}

function do_create_custom_logo {

  echo "Create custom logo"
  
  subjectValidatePrepare
  loadFeaturesConf ${itemFile}

  typeset logo="In Memory of ${iv_bap_sid_FirstName} ${iv_bap_sid_LastName}"


  opDo cd /tmp
  opDo latexFilters.sh -v -n showRun -p outFile=logo -i outPng "${logo}"

  pftp -n ${iv_zopeSrv_ip} 8021 <<EOF
  quote USER ${iv_bap_plone_siteOwner}
   quote PASS ${iv_bap_ai_currentPasswd}
  cd /${iv_name_fqdn}/portal_skins/custom
  binary
  put logo.png
  bye
EOF

   typeset constructor="/portal_skins/custom/manage_renameObject"
   typeset input="-d id=logo.png -d new_id=logo.jpg"

    # NOTYET, Rename Fails if .jpg exists
    # NOTYET, Should first be removed.
    #opDo zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} /portal_skins/custom/manage_deleteObject -d id=logo.jpg
  

   opDo zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
  
}

function do_upload_custom_logo {

  echo "Create custom logo"

  echo fileNameis $1

  typeset thisDir=`dirname $1`
  typeset thisFile=`basename $1`

  subjectValidatePrepare
  loadFeaturesConf ${itemFile}


  ANT_raw "pftping $1 to /${iv_name_fqdn}/portal_skins/custom/logo.png -- pftp -n ${iv_zopeSrv_ip} 8021"
  cd ${thisDir}
  #pftp -n ${iv_zopeSrv_ip} 8021 <<EOF
  pftp -n ${iv_name_fqdn} 8021 <<EOF
  quote USER ${iv_bap_plone_siteOwner}
  quote PASS ${iv_bap_ai_currentPasswd}
  cd /${iv_name_fqdn}/portal_skins/custom
  binary
  put ${thisFile} logo.png
  bye
EOF

   typeset constructor="/portal_skins/custom/manage_renameObject"
   typeset input="-d id=logo.jpg -d new_id=$$.jpg"


   #opDoComplain zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
   opDoComplain zmi_login_and_action ${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
 

   constructor="/portal_skins/custom/manage_renameObject"
   input="-d id=logo.png -d new_id=logo.jpg"


   #opDoComplain zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
   opDoComplain zmi_login_and_action ${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
  
}

function do_deactivate_logo {

  echo "Deactivate logo"

    subjectValidatePrepare
  loadFeaturesConf ${itemFile}


   typeset constructor="/portal_skins/custom/manage_renameObject"
   typeset input="-d id=logo.jpg -d new_id=$$.jpg"


   opDoComplain zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
  
}

