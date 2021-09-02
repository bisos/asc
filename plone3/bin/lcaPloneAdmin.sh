#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: lcaPloneAdmin.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  seedActions.sh -l $0 "$@"
  exit $?
fi

. ${opBinBase}/lcaPloneLib.sh

function vis_examples {

  typeset oneUrlPlone="http://198.62.92.36:9673/payknettest"
  typeset oneUrlZope="http://198.62.92.36:9673"
  typeset oneFullname="\"Joe+User\""
  typeset oneUsername="joe"
  typeset onePassword="abcde" #minimum 5 characters
  #typeset extraInfo="-h -v -n showRun"
  typeset extraInfo="-h -v -n showOnly"

#${visLibExamples}
 cat  << _EOF_
EXAMPLES:
--- Server Maniplation ---
${G_myName} -e "Stop " -i runFunc /etc/init.d/zope  stop
${G_myName} -e "Start " -i runFunc /etc/init.d/zope start
${G_myName} -e "Check " -i runFunc ps -ef | grep -i zope
--- Zope Admin ---
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlZope} -p role="Manager" -i addZopeUser
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlZope} -p role="Owner" -i addZopeUser
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager  -p username=${oneUsername} -p siteurl=${oneUrlZope} -i deleteZopeUser
--- Plone Admin ---
${G_myName} ${extraInfo}  -p adminUsername=zopemanager -p adminPasswd=zopemanager -p fullname=${oneFullname} -p username=${oneUsername} -p password=${onePassword} -p siteurl=${oneUrlPlone} -i addPloneUser
==============  PLONE COMMANDS ===============
--- General Object Maniplation ---
${G_myName} ${extraInfo} -p adminUsername=zopemanager -p adminPasswd=zopemanager -p id="doc_item_id" -p siteurl=${oneUrlPlone} -i deleteObject
--- Folder Manipulation  ---
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager -p id="testingFolder/folder2/folder3/folder4" -p siteurl=${oneUrlPlone} -i createPloneFolder
--- File Manipulation ----
${G_myName} ${extraInfo} -p username=zope -p password=zope -p id="doc_item_id" -p title="Document+Test" -p inputFile="/tmp/test" -p description="Hello+World+Document" -p siteurl=${oneUrlPlone} -i addDoc_and_publish
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager -p title="Document+Test" -p inputFile="/tmp/test"  -p siteurl=www.freeprotocols.org -i addFile
---- External File Sync Tree ----
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager -p title="Document+Test" -p inputFile="/tmp/test"  -p siteurl=www.freeprotocols.org -i addExternalFile
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager -p id="testingFolder/folder2/folder3/folder4" -p siteurl=${oneUrlPlone} -i externalFileSyncTree
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager -p id="/content/generated/doc.free/neda/Records/0704281/LinuxFest" -p siteurl=http://www.neda.com -i externalFileSyncTree
--- News Item Manipulation ---
${G_myName} ${extraInfo} -p username=zope -p password=zope -p id="news_item_id" -p title="News+Item+test" -p inputFile="/tmp/test" -p description="Hello+World" -p siteurl=${oneUrlPlone} -i addNewsItem_and_publish
---  Object Import and Export ---
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p inputFile="/tmp/test.zexp" -p siteurl=${oneUrlPlone} -i importObject
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p inputFile="/tmp/test.zexp" -p siteurl=${oneUrlPlone} -p destDirectory="/portal_skins/custom" -i importObject
${G_myName} ${extraInfo} -p username=zopemanager -p password=zopemanager  -p idName="contact_form" -p siteurl=${oneUrlPlone} -i exportObject
_EOF_
}

noArgsHook() {
  vis_examples
}

function vis_help {
 cat  << _EOF_

login auto
http://ip:9673/sitename/login_form?__ac_name=xxx&__ac_password=xxx
http://ip:9673/sitename/logout

http://siteName/manage_main
http://siteName/plone_control_panel
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

function vis_addDoc_and_publish {

  ANT_raw "Add Document"
  continueAfterThis
  
  typeset constructor="/invokeFactory "
  typeset input=" -d type_name="Document" -d id=${id}"

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/setTitle "
  typeset input=" -d title="${title}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/setDescription "
  typeset input=" -d description="${description}" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/edit "
  typeset input=" -d text=\"\`cat ${inputFile}\`\" -d text_format="html" "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

  typeset constructor="/${id}/content_status_modify "
  typeset input=" -d workflow_action=publish "

  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}

function vis_addFile {

  typeset filename=`FN_nonDirsPart ${inputFile}`
  typeset fileType=`FN_extension ${inputFile}`

   case ${fileType} in 
     "pdf")
       contentType="application/pdf"
       ;;
     *)
	EH_problem "Unknown fileType: ${fileType}"
	exit
	;;
   esac
  
  pftp -n ${siteurl} 8021 <<EOF
  quote USER ${username}
   quote PASS ${password}
  binary
  cd ${siteurl}
  put ${inputFile} ${filename}
  bye
EOF

   typeset constructor="/${filename}/manage_edit"
   typeset input=" -d content_type="${contentType}" -d title=\"${title}\" "

   opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input 
}

function vis_addExternalFile {
  #curl --user zopemanager:zopemanager -k -i 198.62.92.36:9673/freeprotocols/manage_addProduct/ExternalFile/manage_addObjectViaGui -d id=testing1234 -d title="Something" -d target_filepath="/tmp/pdffile/xxx.pdf" -d action=Add


   typeset constructor="/manage_addProduct/ExternalFile/manage_addObjectViaGui"
   typeset input=" -d id=${id} -d title=\"${title}\" -d target_filepath=\"${inputFile}\" -d action=Add "

   opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input 
}

function vis_createPloneFolder {

  set -- $(IFS="/"; echo ${id})
  typeset listDir="$*"
  typeset oneDir
  typeset jobType="createObject"
  typeset constructor="/"
  for oneDir in ${listDir} ; do
    typeset input="-d type_name=Folder -d id=${oneDir}"
    opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor}/${jobType} $input
    constructor="${constructor}/${oneDir}"
  done

}

function vis_deleteObject {

  typeset constructor="/manage_delObjects"
  typeset input="-d ids:list=${id}"
  opDo zmi_login_and_action ${siteurl} ${username} ${password} ${constructor} $input

}


function vis_externalFileSyncTree {
    
  if [[ ! -d $id ]]; then 
    EH_problem "Missing $id"
    return 1
  fi

  treeFilesList=`find $id -print`

  for oneItem in ${treeFilesList} ; do

    if [[ -f ${oneItem} ]]; then
      dirName=`FN_dirsPart ${oneItem}`
      fileExtension=`FN_extension ${oneItem}`
      fileName=`FN_nonDirsPart ${oneItem}`

      if [[ "${fileName}_" == "accessPage.html_" ]] ; then
	opDo lcaPloneAdmin.sh -p username=zopemanager -p password=zopemanager -p id="${fileName}" -p title="AccessPage" -p inputFile="${oneItem}" -p description="" -p siteurl=${siteurl}${dirName} -i addDoc_and_publish
      elif [[ "${fileName}" != "${fileName%%-access.html}" ]] ; then
	opDo lcaPloneAdmin.sh -p username=zopemanager -p password=zopemanager -p id="${fileName}" -p title="${fileName}" -p inputFile="${oneItem}" -p description="" -p siteurl=${siteurl}${dirName} -i addDoc_and_publish
      else
	#opDo echo FILE: ${oneItem} ${fileName} ${fileExtension} ${dirName}
	opDo lcaPloneAdmin.sh -p username=zopemanager -p password=zopemanager -p title="${fileName}" -p inputFile="${oneItem}"  -p siteurl=${siteurl}${dirName} -p id="${fileName}" -i addExternalFile
      fi

    elif [[ -d ${oneItem} ]]; then
      #opDo echo DIR: ${oneItem}
      opDo lcaPloneAdmin.sh -p username=zopemanager -p password=zopemanager -p id="${oneItem}" -p siteurl=${siteurl} -i createPloneFolder
      opDo cd ${oneItem}
    else
      EH_problem "Not a file or directory"
      opDo ls -l ${oneItem}
    fi

  done
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
