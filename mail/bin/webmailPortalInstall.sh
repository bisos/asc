#!/bin/bash
#!/bin/bash

typeset RcsId="$Id: webmailPortalInstall.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  seedMapVerModules.sh -l $0 "$@"
  exit $?
fi

typeset -t tomcatBaseDir="MANDATORY"

function itemPre_mapVer {
  iv_mapVerBase_cvsRoot="/usr/release"
  iv_mapVerVersion=""
  return
}

function itemPost_mapVer {
  return
}

function item_webmail {
  itemPre_mapVer

  iv_mapVer_moduleName=webmail
  iv_mapVerBase_cvsRoot="/usr/release"

    # /usr/release/public/portals/neda-1.1/WEB-INF/psml
  #
  function iv_mapVerCheckout {
    FN_dirCreatePathIfNotThere ${tomcatBaseDir}/webapps
    opDoComplain /bin/cp ${mmaPkgBase}/java-webmail/webmail.war ${tomcatBaseDir}/webapps
  }

  itemPost_mapVer
}

itemOrderedList=("webmail")


