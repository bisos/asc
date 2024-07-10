#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: lcaGenewebActions.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  seedActions.sh -l $0 "$@"
  exit $?
fi


function vis_examples {
    #oneDatabase=base
    #oneDatabase=banan
    oneDatabase=yuan-lo
#${visLibExamples}
 cat  << _EOF_
EXAMPLES:
--- Server BinsPrep ---
${G_myName} -e "Install - " -i runFunc apt-get install geneweb
${G_myName} -e "Install - " -i runFunc apt-get install gwtp
${G_myName} -e "Check Status" -i runFunc dpkg -l geneweb
${G_myName} -e "All Files" -i runFunc dpkg -L geneweb
--- Server Maniplation ---
${G_myName} -e "Stop " -i runFunc /etc/init.d/geneweb stop
${G_myName} -e "Start " -i runFunc /etc/init.d/geneweb start
${G_myName} -e "Check " -i runFunc ps -ef | grep -i gwd
${G_myName} -e "" -i cgiAccessMode
${G_myName} -e "Apache Proxy" -i redirectFrom2317To80
--- Web Client Testing ---
eoe-browser -remote "openurl(http://127.0.0.1:2317/base)"
eoe-browser -remote "openurl(http://127.0.0.1:2317/geneweb?m=DOC)"
--- Database Manipulation ---
${G_myName} -e "Database root dir" -i runFunc cd /var/lib/geneweb
${G_myName} -e "Create A new Database" -i runFunc gwc -o newBase
${G_myName} -e "Database root dir" -i runFunc chmod g+w /var/lib/geneweb/${oneDatabase}.gwb
--- Access Control  ---
${G_myName} -e "" -i runFunc echo "wizard_passwd=2adminlo" > /var/lib/geneweb/${oneDatabase}.gwf
${G_myName} -e "" -i runFunc echo "auth_file=${oneDatabase}.auth" >> /var/lib/geneweb/${oneDatabase}.gwf
${G_myName} -e "" -i runFunc echo "family:4seeinglo" > /var/lib/geneweb/${oneDatabase}.auth
--- GED Conversion  ---
gwb2ged /var/lib/geneweb/banan -o /tmp/banan.ged
--- Backup and Restore  ---
${G_myName} -e "Dump in text" -i runFunc gwu ${oneDatabase}.gwb > ${oneDatabase}.gw
${G_myName} -e "Restore from text" -i runFunc gwc -nc ${oneDatabase}.gw -o ${oneDatabase}
--- Logs and  ---
${G_myName} -e "Log Details" -i runFunc tail -300 /var/log/geneweb.log 
${G_myName} -e "Log Froms" -i runFunc grep -i from: /var/log/geneweb.log 
--- Help and Documentation ---
${G_myName} -e "GED Conversion" -i runFunc man ged2gwb
${G_myName} -e "GED Conversion" -i runFunc man gwb2ged
${G_myName} -e "Create DataBase" -i runFunc man gwc
${G_myName} -e "Daemon" -i runFunc man gwd
${G_myName} -e "Convert to text" -i runFunc man gwu
${G_myName} -e "Documentation/Help" -i runFunc man consang
_EOF_
}

noArgsHook() {
  vis_examples
}

function vis_help {
 cat  << _EOF_


_EOF_
}

function vis_cgiAccessMode {
 cat  << _EOF_
#!/bin/sh
#
# This is not a good way of running gwd. 
# Does not handle access control properly.
# See redirectFrom2317To80 as an alternative.
#
#
# Make sure apache has:
#ScriptAlias /cgi-bin/ "/usr/lib/cgi-bin/"	

GENEWEB_DBS=/var/lib/geneweb

cd ${GENEWEB_DBS}

/usr/bin/gwd -cgi 2> /dev/null
_EOF_
}

function vis_redirectFrom2317To80 {
 cat  << _EOF_
# VirtualHost for geneology.bymemory.net

<VirtualHost 192.168.0.2>
    ServerAdmin webmaster@geneology.example.net
    DocumentRoot /tmp/geneology.htdocs
    ServerName geneology.example.net
    ErrorLog /tmp/geneology.error_log
    CustomLog /tmp/geneology.error_log common


        ProxyPass / http://192.168.0.2:2317/
        ProxyPassReverse / http://192.168.0.2:2317/

</VirtualHost>

_EOF_
}
