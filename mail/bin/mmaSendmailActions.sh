#!/bin/osmtKsh
#!/bin/osmtKsh 

typeset RcsId="$Id: mmaSendmailActions.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    `dirname $0`/seedActions.sh -l $0 $@
    exit $?
fi

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo="-h"
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- ACTIONS ---
${G_myName} ${extraInfo} -i sendmailDefunct
${G_myName} ${extraInfo} -i sendmailStop
${G_myName} ${extraInfo} -i sendmailProgsDefunctMake
${G_myName} ${extraInfo} -i sendmailInitDefunctMake
_EOF_
}
    
function vis_help  {
  echo "sendmail is used in a generic way -- it also includes exim and all other than qmail"

  echo "sendmailDefunct -- no args, make the existing sendmail dis-functional and get it out of the way."
  echo "sendmailDefunct -- Calls sendmailProgsDefunctMake and sendmailInitDefunctMake"
  echo ""

  echo "sendmailProgsDefunctMake -- no args, make dis-functional sendmail program and library files"
  echo "sendmailInitDefunctMake -- no args, make dis-functional sendmail files in init.d related directories"

  exit 1
}

function noArgsHook {
    vis_examples
}

dateTag=`date +%y%m%d%H%M%S`

function vis_sendmailStop {
    continueAfterThis

  G_abortIfNotSupportedOs
  G_abortIfNotRunningAsRoot

  case ${opRunOsType} in
    'SunOS')
             echo "Stopping the currently running sendmail"
             opDo /etc/init.d/sendmail stop
             ;;
    'Linux')
             #echo "Skipping stopping sendmail"
             if [[ -f /etc/init.d/exim4 ]] ; then
               opDo /etc/init.d/exim4 stop
             else
               ANT_raw "No /etc/init.d/exim4, skipped"
             fi
             ;;
    *)
       uname -a
       echo "$0 not Suported on ${opRunOsType}"
       exit
  esac
}


function vis_sendmailDefunct {
  continueAfterThis

  G_abortIfNotSupportedOs
  G_abortIfNotRunningAsRoot

  vis_sendmailStop
  vis_sendmailProgsDefunctMake
  vis_sendmailInitDefunctMake
}

# Now, Let's take care of all the standard 
# Run time start and stop files and make them unused

function vis_sendmailProgsDefunctMake {
    continueAfterThis

  case ${opRunOsType} in
    'SunOS')
     case ${opRunOsRev} in
       '5.8')
       FN_fileDefunctMake /usr/lib/sendmail /usr/lib/notused.sendmail.${dateTag}
       #FN_fileDefunctMake /usr/lib/sendmail.mx /usr/lib/notused.sendmail.mx.${dateTag}
       FN_fileDefunctMake  /usr/bin/mailq /usr/bin/notused.mailq.${dateTag}
       FN_fileDefunctMake  /usr/bin/newaliases /usr/bin/notused.newaliases.${dateTag}
       FN_dirDefunctMake /etc/mail /etc/notused.mail.${dateTag}
       ;;
       *)
          uname -a
          echo "$0 not Suported on ${osRev}"
          exit
     esac
     ;;
    'Linux')
         FN_fileDefunctMake /usr/sbin/sendmail  /usr/sbin/notused.sendmail.${dateTag}
         FN_fileDefunctMake /usr/lib/sendmail /usr/lib/notused.sendmail.${dateTag}
         FN_fileDefunctMake  /usr/bin/mailq /usr/bin/notused.mailq.${dateTag}
         FN_fileDefunctMake  /usr/bin/newaliases /usr/bin/notused.newaliases.${dateTag}
            # /etc/cron.d/exim 
         FN_fileDefunctMake  /etc/cron.d/exim  /etc/cron.d/notused.exim.${dateTag}

         ANT_raw "Qmail Installation Will Replace These Later"
     ;;
    *)
       uname -a
       echo "$0 not Suported on ${opRunOsType}"
       exit
  esac
}


function vis_sendmailInitDefunctMake {
    continueAfterThis

  case ${opRunOsType} in
    'SunOS')
      case ${opRunOsRev} in
      '5.8')
         FN_fileDefunctMake /etc/init.d/sendmail /etc/init.d/notused.sendmail.${dateTag}
          FN_fileDefunctMake /etc/rc2.d/S88sendmail /etc/rc2.d/notused.S88sendmail.${dateTag}
          FN_fileDefunctMake /etc/rc0.d/K36sendmail /etc/rc0.d/notused.K36sendmail.${dateTag}
          FN_fileDefunctMake /etc/rc1.d/K36sendmail /etc/rc1.d/notused.K36sendmail.${dateTag}
          FN_fileDefunctMake /etc/rcS.d/K36sendmail /etc/rcS.d/notused.K36sendmail.${dateTag}
          ;;
        # NOTYET, Linux to be added
        *)
          uname -a
          echo "$0 not Suported on ${osRev}"
          exit
      esac
      ;;
   'Linux')
     case ${opRunOsRev} in
       '2.4.12')
         echo "Skipped: Linux has no sendmail init.d files to defunct"
         ;;
       *)
          FN_fileDefunctMake /etc/init.d/exim4  /etc/init.d/notused.exim4.${dateTag}
          #find /etc/rc[0-9].d -print | grep -i exim
          FN_fileDefunctMake /etc/rc0.d/K20exim4 /etc/rc0.d/notused.K20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc1.d/K20exim4 /etc/rc1.d/notused.K20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc6.d/K20exim4 /etc/rc6.d/notused.K20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc2.d/S20exim4 /etc/rc2.d/notused.S20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc3.d/S20exim4 /etc/rc3.d/notused.S20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc4.d/S20exim4 /etc/rc4.d/notused.S20exim4.${dateTag}
          FN_fileDefunctMake /etc/rc5.d/S20exim4 /etc/rc5.d/notused.S20exim4.${dateTag}
          ;;
     esac
     ;;
    *)
      uname -a
        echo "$0 not Suported on ${opRunOsType}"
        exit
  esac
}

