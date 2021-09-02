#

function ploneUrlApiTextPrep {

  function expandStar {
cat << _EOF_ | sed -e 's/\*/Star/g'
${lcnt_shortTitle}
_EOF_
}
 

  plusShortTitle=`expandStar | sed -e 's/ /+/g`

}