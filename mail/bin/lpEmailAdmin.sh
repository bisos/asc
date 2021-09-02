#!/bin/osmtKsh
#!/bin/osmtKsh

#
# NON LIBRE COMPONENT
#

typeset RcsId="$Id: lpEmailAdmin.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
  seedActions.sh -l $0 "$@"
  exit $?
fi


function vis_examples {
#${visLibExamples}
 cat  << _EOF_
EXAMPLES:
--- INCOMING EMAIL  ---
mmaQmailHosts.sh
mmaQmailAdmin.sh
--- RBLs  ---
http://www.ladro.com/docs/dns/rblsmtpd.html
http://www.mxtoolbox.com/blacklists.aspx?AG=GBL&gclid=CNyNw-Xl6pACFQj7iAodKjDFdA
http://spamcop.net/w3m?action=checkblock&ip=198.62.92.0
--- External Tests ---
http://abuse.net/relay.html
apt-get install qmail vpopmail-bin spamassassin clamav ezmlm-idx courier-authdaemon courier-authchkpw courier-imap
_EOF_
}

noArgsHook() {
  vis_examples
}

function vis_help {
 cat  << _EOF_


_EOF_
}

