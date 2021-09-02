#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPlone3Commands.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    seedActions.sh -l $0 "$@"
    exit $?
fi

vis_todo () {
  cat  << _EOF_

To /var/osmt/plone3Bldout/buildout.cfg  add the zope-conf-additional piece  from 
below in the instance section 

zope-conf-additional =
     <ftp-server>
         address 8021
     </ftp-server>

_EOF_
}



. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/lcaPloneLib.sh

function vis_examples {

  typeset oneSiteFqdn="first.last.1.byname.net"

  typeset oneUserName="zopemanager"
  typeset onePassword="zopemanager"

  typeset oneFolderPath="/someBase3/someDirPath3"
  typeset oneFilePath="index_html"

  typeset oneTitle="Some+Title"
  typeset oneDescription="Some+Description"

  typeset oneInputFile="/tmp/oneInputFile"

  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo="-h -v -n showOnly"

  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
    
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
======  File Manipulation Commands  =======
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneUploadFile
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneUploadHtmlAndPublish
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p inputFile="${oneInputFile}" -i ploneUploadHtml
======  
======  Zope/Plone Site Commands  ======
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteName="${oneFolderPath}"  -p title="${oneTitle}"  -p description="${oneDescription}" -i addPloneSite
======  Zope User Commands  ======
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlZope} -p role="Manager" -i addZopeUser
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlZope} -p role="Owner" -i addZopeUser
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p siteurl=${oneUrlZope} -i deleteZopeUser
======  Plone User Commands  ======
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager -p fullname=${oneFullname} -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlPlone} -i addPloneUser
==============  PLONE General COMMANDS ===============
${G_myName} ${extraInfo} -p adminUsername=zopemanager -p adminPasswd=zopemanager -p id="doc_item_id" -p siteurl=${oneUrlPlone} -i deleteObject
---  Object Import and Export ---
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p inputFile="/tmp/test.zexp" -p siteurl=${oneUrlPlone} -i importObject
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p inputFile="/tmp/test.zexp" -p siteurl=${oneUrlPlone} -p destDirectory="/portal_skins/custom" -i importObject
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p idName="contact_form" -p siteurl=${oneUrlPlone} -i exportObject
======  Folder Manipulation Commands  ======
---- Folder Create: Including All Sub Directories ---
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}"  -p title="${oneTitle}"  -p description="${oneDescription}" -i ploneFolderCreate
---- Folder Publish: Including All Sub Directories ----
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p title="${oneTitle}"  -p description="${oneDescription}" -i ploneFolderPublish
---- Folder Create+Publish  ----
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p title="${oneTitle}"  -p description="${oneDescription}" -i ploneFolderCreateAndPublish
---- Folder Create+Publish+AddDefaulIndexHtml  ----
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneFolderFullCreate
======  File Manipulation Commands  =======
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneUploadFile
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneUploadHtmlAndPublish
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p inputFile="${oneInputFile}" -i ploneUploadHtml
_EOF_
}

vis_help () {
  cat  << _EOF_

Common Characteristics
======================

Mandatory Parameters and Description:

   siteFqdn      - Base
   userName
   password

The above 3 can be dervied from BystarUID.

   siteFolder    - 
   sitePage      - Only Applies to file Commands
                 
   title         - 
   description   -

The above 7 should usually appear in the above order.

Based on the above,
  The following are derived as:
       baseUrl="http://${siteFqdn}"
       pathUrl="http://${siteFqdn}/${siteFolder}"
       fullUrl="http://${siteFqdn}/${siteFolder}/${sitePage}"

======  Folder Manipulation Commands  ======

${G_myName} -i ploneFolderCreate   -- Folder Publish: Including All Sub Directories
${G_myName} -i ploneFolderPublish
${G_myName}  -i ploneFolderCreateAndPublish -- Folder Create+Publish+AddDefaulIndexHtml:

======  File Manipulation Commands  =======
${G_myName}  -i ploneUploadHtmlAndPublish


Folder Manipulation
===================

     - Folder -- Means Just That Folder
     - FolderPlus -- The Folder and everything in it + SubDirs

     - Folder Publish + SubDirs
     - FolderCreateAndPublish + SubDirs + index_html

File Manipulation
=================

     - ploneUploadHtmlAndPublish

_EOF_
}

noArgsHook() {
    vis_examples
}

function  ploneCommandParametersValid {
    
  if [[ "${siteFqdn}_" == "_" ]] ; then 
    return 1
  fi

  # Home Plone Site
  baseUrl="http://${siteFqdn}"

  # End Folder
  pathUrl="http://${siteFqdn}/${siteFolder}"

  # Final Url
  fullUrl="http://${siteFqdn}/${siteFolder}/${sitePage}"

  return 0
}



function vis_ploneUploadFile {

    # Generally Used for Updates, 
    # Does not set title, description or publish

set -x
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  pftp -n ${siteFqdn} 8021 << _EOF_
  quote USER ${userName}
  quote PASS ${password}
  binary
  cd /${siteFqdn}${siteFolder}
  put ${inputFile} ${sitePage}
  bye
_EOF_

}




function vis_addPloneUser {

  typeset logfile="/tmp/createPloneUser.$$"
  
  typeset constructor="/register"
  typeset input="-d fullname=${fullname} -d username=${username} -d password=${password} -d confirm=${password} -d email=foo@bar.com"

  opDo zmi_login_and_action ${siteurl} ${adminUsername} ${adminPasswd} ${constructor} $input > ${logfile}

  integer usernameExist=`cat ${logfile} | grep "The login name you selected is already in use" | wc -l`

  if [[ ${usernameExist} -eq 0 ]]; then
    echo "...done"
  else
    echo "Problem: username already exists."
  fi

  /bin/rm ${logfile}
}

function vis_addZopeUser {

  #http://198.62.92.36:9673/payknettest/register
  typeset logfile="/tmp/createZopeUser.$$"

  typeset constructor="/acl_users/manage_users"
  typeset input="-d submit=Add -d name=${username} -d password=${password} -d confirm=${password} -d roles:list=${role}"

  opDo zmi_login_and_action ${siteurl} ${adminUsername} ${adminPasswd} ${constructor} $input > ${logfile}

  integer usernameExist=`cat ${logfile} | grep "A user with the specified name already exists" | wc -l`

  if [[ ${usernameExist} -eq 0 ]]; then
    echo "...done"
  else
    echo "Problem: username already exists."
  fi

  /bin/rm ${logfile}
}

function vis_deleteZopeUser {

  typeset logfile="/tmp/deleteZopeUser.$$"

  typeset constructor="/acl_users/manage_users"
  typeset input="-d submit=Delete -d names:list=${username} "

  opDo zmi_login_and_action ${siteurl} ${adminUsername} ${adminPasswd} ${constructor} $input > ${logfile}

  /bin/rm ${logfile}
}

function vis_addNewsItem_and_publish {

  ANT_raw "Add News Item"
  continueAfterThis
  
  typeset constructor="/invokeFactory"
  typeset input="-d type_name="News+Item" -d id=${id}"

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/setTitle"
  typeset input=" -d title="${title}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/edit"
  typeset input=" -d text=\"\`cat ${inputFile}\`\" -d description="${description}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/content_status_modify"
  typeset input=" -d workflow_action=publish "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}


function vis_deleteObject {

  typeset constructor="/manage_delObjects"
  typeset input="-d ids:list=${id}"
  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}


function do_manageUser {

    subjectValidatePrepare
    
    loadFeaturesConf ${itemFile}

    ANT_raw "About to create a site owner account"
    continueAfterThis

    opDo lcaPloneAdmin.sh -p adminUsername=${iv_zopeSrv_initialUser} -p adminPasswd=${iv_zopeSrv_initialPasswd}  -p username=${iv_bap_plone_siteOwner} -p password=${iv_bap_ai_currentPasswd} -p siteurl=${iv_zopeSrv_url} -p role="Manager" -i addZopeUser

  }


### NOTYET, need to use opDoAtAs to copy the input file to the import directory ####
### to be able to import a local file

function vis_importObject {

  ANT_raw "Import Object"
  continueAfterThis

  typeset templateFile_name=`FN_nonDirsPart ${inputFile}`
  # For now, make sure the file you want to import
  # need to be in /var/lib/zope2.7/instance/default/import
  # opDo cp ${inputFile} ${iv_zopeSrv_instanceDir}/import
  typeset destDir=/var/lib/zope2.7/instance/default/import
  opDo cp ${inputFile} ${destDir}

  if [[ "$destDirectory}_" == "_" ]] ; then
    typeset constructor="/manage_importObject "
  else
    typeset constructor="${destDirectory}/manage_importObject "
  fi

  typeset input="-d file=${templateFile_name}"
  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}

function vis_exportObject {

  ANT_raw "Export Object"
  continueAfterThis

  typeset constructor="/manage_exportObject "
  typeset input="-d id=${idName}"
  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

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

function vis_ploneSiteAdd {
#set -x
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

#${G_myName} -i loginAndDo user password http://198.62.92.160:8080 /manage_addProduct/CMFPlone/addPloneSite -d id=new1.com -d title=new1.com -d create_userfolder=1 -d description=desc+for+new1.com -d submit=+Add+Plone+Site+
#POST /manage_addProduct/CMFPlone/addPloneSite id=new1.com&title=new1.com&create_userfolder=1&description=desc+for+new1.com&submit=+Add+Plone+Site+

 opDo lcaPlone3UrlApi.sh ${user} ${passwd} ${url} /manage_addProduct/CMFPlone/addPloneSite \
     -d id=${siteName} \
     -d title=${title} \
     -d create_userfolder=1 \
     -d description=${description} \
     -d submit=+Add+Plone+Site+

 # NOTYET, Check the error code, if error, check the error values

}

function vis_ploneSiteDeleteObsoleted {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
NOTYET: Remains to be done.
Arg1= siteName

Manual Procedure:
  1) Hit http://localhost:8080/manage
  2) Enter admin and passwd
  3) Click on desired site
  4) Delete

Script: Subject the above to http capture and produce lcaPlone3UrlApi.sh params

_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    describeF

    lpReturn
}



# function vis_ploneSiteCreate {
# #set -x
#   echo "configure virtual host monster in zmi"
#   typeset constructor="/manage_addProduct/SiteAccess/manage_addSiteRoot"
#   typeset input="-d base=http://${iv_name_fqdn} -d path=/"
#   item_bap_plone

#   opDo zmi_login_and_action ${iv_zopeSrv_url}/${iv_name_fqdn} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input 
# }


function vis_ploneFolderCreate {
#set -x
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  opDo lcaPloneAdmin.sh -p siteurl=${baseUrl} -p username=${userName} -p password=${password}  -p id="${siteFolder}"  -i createPloneFolder

 
  return

}


function vis_ploneFolderPublish {
#set -x
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  set -- $(IFS="/"; echo ${siteFolder})
  typeset listDir="$*"
  typeset oneDir
  typeset jobType="content_status_modify "
  typeset constructor="/"
  for oneDir in ${listDir} ; do
    typeset input=" -d workflow_action=publish "

    opDo zmi_login_and_action ${baseUrl} ${userName} ${password} ${constructor}/${oneDir}/${jobType} $input

    constructor="${constructor}/${oneDir}"
  done


  typeset constructor="${siteFolder}/content_status_modify "
  typeset input=" -d workflow_action=publish "

  typeset constructor="${siteFolder}/setTitle "
  typeset input=" -d title="${title}" "
  opDoComplain zmi_login_and_action ${baseUrl}${siteFolder} ${userName} ${password} ${constructor} $input

  return

}

function vis_ploneFolderCreateAndPublish {

#set -x

  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  opDo lcaPloneAdmin.sh -p siteurl=${baseUrl} -p username=${userName} -p password=${password}  -p id="${siteFolder}"  -i createPloneFolder

  vis_ploneFolderPublish

}



function vis_ploneFolderFullCreate {
#set -x

  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  opDo lcaPloneAdmin.sh -p siteurl=${baseUrl} -p username=${userName} -p password=${password}  -p id="${siteFolder}"  -i createPloneFolder

  vis_ploneFolderPublish

  typeset constructor="${siteFolder}/setTitle "
  typeset input=" -d title="${title}" "
  opDoComplain zmi_login_and_action ${baseUrl}${siteFolder} ${userName} ${password} ${constructor} $input


   opDo ${G_myName} -p siteFqdn=${siteFqdn} -p userName=${userName} -p password=${password} -p siteFolder="${siteFolder}" -p sitePage="index_html" -p title="${title}"  -p description="${description}" -p inputFile="${inputFile}" -i ploneUploadHtmlAndPublish
  
}



function vis_ploneUploadHtml {

    # Generally Used for Updates, 
    # Does not set title, description or publish

#set -x
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  #ANT_raw "Add Document"
  #continueAfterThis
  
  typeset constructor="/invokeFactory "
  typeset input=" -d type_name="Document" -d id=${sitePage}"

  opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input


  pftp -n ${siteFqdn} 8021 << _EOF_
  quote USER ${userName}
  quote PASS ${password}
  binary
  cd /${siteFqdn}${siteFolder}
  put ${inputFile} ${sitePage}
  bye
_EOF_

   typeset constructor="/${siteFilder}/${sitePage}/manage_edit"
   typeset input=" -d content_type=html "

   opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input

}





function vis_ploneUploadHtmlAndPublish {
  ploneCommandParametersValid
  EH_assert [[ $? -eq 0 ]]

  #ANT_raw "Add Document"
  #continueAfterThis
  
  typeset constructor="/invokeFactory "
  typeset input=" -d type_name="Document" -d id=${sitePage}"

  opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input


  pftp -n ${siteFqdn} 8021 << _EOF_
  quote USER ${userName}
  quote PASS ${password}
  binary
  cd /${siteFqdn}${siteFolder}
  put ${inputFile} ${sitePage}
  bye
_EOF_

   typeset constructor="/${siteFilder}/${sitePage}/manage_edit"
   typeset input=" -d content_type=html "

   opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input

  typeset constructor="/${sitePage}/setTitle "
  typeset input=" -d title="${title}" "

  opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input

  typeset constructor="/${sitePage}/setDescription "
  typeset input=" -d description="${description}" "

  opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input


 #  typeset constructor="/${id}/edit "
#   typeset input=" -d text=\"\`cat ${inputFile}\`\" -d text_format="html" "

#   opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${sitePage}/content_status_modify "
  typeset input=" -d workflow_action=publish "

  opDo zmi_login_and_action ${pathUrl} ${userName} ${password} ${constructor} $input

}


function vis_addNewsItem_and_publish {

  ANT_raw "Add News Item"
  continueAfterThis
  
  typeset constructor="/invokeFactory"
  typeset input="-d type_name="News+Item" -d id=${id}"

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/setTitle"
  typeset input=" -d title="${title}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/edit"
  typeset input=" -d text=\"\`cat ${inputFile}\`\" -d description="${description}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/content_status_modify"
  typeset input=" -d workflow_action=publish "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}
