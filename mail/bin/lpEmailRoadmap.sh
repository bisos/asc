#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id"

echo "OBSOLETED BY: /libre/ByStar/InitialTemplates/activeDocs/bxServices/mailManage/roadmap/fullUsagePanel-en.org"

exit 1

if [ "${loadFiles}X" == "X" ] ; then
    seedActions.sh -l $0 "$@"
    exit $?
fi


function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- Information
${G_myName} -i todos
${G_myName} -i modelAndTerminology
${G_myName} -i help
${G_myName} -i howTos
${G_myName} -i pointersAndReferences
${G_myName} -i byEntityLayers
${G_myName} -i byEntityCallFlow
${G_myName} -i latexStdout
${G_myName} -i printPackage
${G_myName} -i printItems
${G_myName} -i partsList
_EOF_
}


function noArgsHook {
  vis_examples
}

function vis_todos {
 cat  << _EOF_
TO DOs
------

_EOF_
}


function vis_modelAndTerminology {
 cat  << _EOF_

   Neda Libre Platform Email Subsystem

   Based on Debian GNU/Linux qmail plus-plus

 Overview
 --------

     Part of LSIP
     ------------

     How To Obtain.


     Goals
     -----

        Highly Scalable
        ---------------

        Plug and Play
        -------------

        Robust and Secure
        -----------------

        Expandable
        ----------
          Best of Breed incorporation

     Approach and Policy
     -------------------

General Preference for std debian distribution packages.
Bystar is layered on top of Debian/Ubuntu.
qmail and all else is part of Debian/Ubuntu.

Versions -- Stable and testing.

        

     Big  Picture View
     -----------------

     lpEmailHosts.sh

     lcaQmailHosts.sh



 MTA Facilities
 ---------------

      qmail 1.03 ++

      MTA Anti-Spam Facilities
      ---------------

         - RLB
         - qrlbcheck
         - Reject at SMTP  (Priority 2)
         - spamGuard

         - qconfirm  --- http://smarden.org/qconfirm/ TODO -- 

qconfirm is an implementation of a delivery confirmation process for a mailing list or mail address. It is invoked by qmail-local through a dot-qmail file, and can reduce the amount of junk mail hitting a mailbox or the mailboxes of mailing list subscribers. qconfirm performs this delivery confirmation process either sender based or message based.

When used for a public mail address, not a mailing list, qconfirm is capable of detecting follow-ups on mail messages originated from this mail address, and doesn't request delivery confirmation is this case. qconfirm also is able to identify delivery confirmation requests from recipients of mail messages, and automatically confirms the delivery if desired. 


 Mail Submission and Injection
 -----------------------------

    SMTP Auth
    ---------

    Mail Submission Anti-Spam
    -------------------------

 
 Mail Delivery
 -------------


   Mail Delivery Anti-Spam
   -----------------------

 MailBox Facilities
 ------------------

   MaildirToMbox


 MailBox Remote Access
 ---------------------

      POP

      IMAP

      WebMail - Squirelmail
        sqwebmail


  User Agent Facilities
  ---------------------

      Vacation

      SpamAssasin

      qsecretary  (See qconfirm) vacation --

      Gnus

      Mozila

  Mailing List Facilities
  -----------------------

       ezmlm  

       mhonarc
  

  Mail Processing Facilities
  --------------------------

       mess822

  Mail Monitoring and Analysis
  ----------------------------

       qmailanalog
      

Related Peer Facilities
=======================
     web

Underlying Facilities
=====================

    daemontools
    ucspi
    tcpserver
    djbdns
    splogger
_EOF_

}


function vis_help {
 cat  << _EOF_
${G_myName} provides an overview of the bystar layer.
_EOF_
}

function vis_howTos {
 cat  << _EOF_

Fro Qmail See:

_EOF_
}


function vis_pointersAndReferences {
 cat  << _EOF_

 See Life with Qmail

 http://sylvestre.ledru.info/howto/howto_qmail_vpopmail.php

_EOF_
}

function vis_progsList {
 cat  << _EOF_
maildrop
mailbot
reformime
reformail
maildropfilter
clamscan
spamassassin
_EOF_
}

function vis_progsListLatex {
  vis_progsList | column
}


function vis_debPkgsList {
 cat  << _EOF_
qmail-src
clamav
spamassassin
_EOF_
}

function vis_debPkgsListLatex {
  vis_debPkgsList | column
}


function vis_latexStdout {

  listOfDesc=( "modelAndTerminology" "pointersAndReferences" "progsListLatex" "debPkgsListLatex" "howTos" "help")

  typeset thisOne=""
  for thisOne in ${listOfDesc[*]} ; do
    if [ "${thisOne}_" == "newpage_" ] ; then 
      print "\\\clearpage"
      continue
    fi
    echo "" 
    echo "\\subsubsection*{Extracted by ${G_myName} -i ${thisOne}}" 
    echo "\\begin{verbatim}" 
    echo "Description of ${G_myName} -- ${thisOne}" ; ${G_myName} -i ${thisOne}
    echo "\\end{verbatim}" 
  done
}



function vis_printPackage {
  typeset filesToPrint=""
  typeset filesList="\
 bystarRoadmap.sh\
"

  typeset thisOne=""
  for thisOne in ${filesList} ; do
    filesToPrint="${filesToPrint} ${opBinBase}/${thisOne}"
  done

  for thisOne in ${filesToPrint} ; do
    opDoComplain a2ps --print-anyway yes -s 2 ${thisOne}
  done

  #opDoComplain a2ps --print-anyway yes -s 2 lpEmailRoadmap.sh
}


