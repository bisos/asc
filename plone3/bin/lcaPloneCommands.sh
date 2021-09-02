#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPloneCommands.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    seedActions.sh -l $0 "$@"
    exit $?
fi

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
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i ploneUploadHtmlAndPublish
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p inputFile="${oneInputFile}" -i ploneUploadHtml
======  Generate IFRAME Input File  =======
${G_myName} ${extraInfo} -i iframeGenBasic http://www.neda.com
${G_myName} ${extraInfo} -i iframeGenPlusFullPointer http://www.neda.com 
${G_myName} ${extraInfo} -i iframeGenPlusFullPointer http://www.neda.com > ${oneInputFile}
===== Generate REDIRECT Input File ======
${G_myName} ${extraInfo} -i redirectGenBasic http://www.neda.com 2
--- Generate Common HTML Input File ---
${G_myName} ${extraInfo} -i testGenBasic > ${oneInputFile}
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


inputFile     
=========

Support for Generation of the following common input files is provided:

For Iframe Commands inputFile becomes top Text.

For Redirect Commands inputFile becomes WaitWhileWeTranasferYou ...


======  Folder Manipulation Commands  ======

${G_myName} -i ploneFolderCreate   -- Folder Publish: Including All Sub Directories
${G_myName} -i ploneFolderPublish
${G_myName}  -i ploneFolderCreateAndPublish -- Folder Create+Publish+AddDefaulIndexHtml:

======  File Manipulation Commands  =======
${G_myName}  -i ploneUploadHtmlAndPublish

======  Generate IFRAME Input File  =======
${G_myName} -i iframeGenBasic http://www.neda.com
${G_myName} -i iframeGenPlusFullPointer http://www.neda.com 

===== Generate REDIRECT Input File ======
${G_myName} -i redirectGenBasic http://www.neda.com 2
${G_myName} -i testGenBasic 


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


function vis_iframeGenBasic {

  iframeDest=$1

   cat  << _EOF_

</p><p>
<iframe src="${iframeDest}" height="500" width="100%">
If you can see this, your browser doesn't 
understand IFRAME.  However, we'll still <a href=${iframeDest}>link</a>you to the file.
</iframe></p>

_EOF_

}

function vis_iframeGenPlusFullPointer {

  iframeDest=$1

   cat  << _EOF_

You can also access this information in 
<a href="${iframeDest}">Full Page</a> format.
<br><br>
</p><p>
<iframe src="${iframeDest}" height="500" width="100%">
If you can see this, your browser doesn't 
understand IFRAME.  However, we'll still <a href=${iframeDest}>link</a> you to the file.
</iframe></p>

_EOF_
}

function vis_redirectGenBasic {

  redirectDest=$1
  redirectTimeOut=$2

   cat  << _EOF_

<script language="JavaScript">
<!-- Begin
window.location="${redirectDest}";
// End -->
</script>

<noscript>
It appears that your browser does not support JavaScript.
Click <a href="${redirectDest}">here</a> to go to the file.
</noscript>

_EOF_
}

function vis_testGenBasic {

   cat  << _EOF_

33333

Common HTML File Such As Under Construction 
With Any and ALL Symbols

       <;;;ll^%$<

_EOF_
}
