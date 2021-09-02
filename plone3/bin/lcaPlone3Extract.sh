#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: lcaPlone3Extract.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    seedActions.sh -l $0 "$@"
    exit $?
fi

vis_todo () {
  cat  << _EOF_

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
${G_myName} ${extraInfo} -p siteFqdn=${oneSiteFqdn} -p userName=${oneUserName} -p password=${onePassword} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i extractTree
_EOF_
}

vis_help () {
  cat  << _EOF_

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



function vis_extractTree {

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

