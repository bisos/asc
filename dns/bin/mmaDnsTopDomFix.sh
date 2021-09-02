#!/bin/osmtKsh

#topDomName="byname.net"
#origHostIpAddr="198.62.92.34"

topDomName="byname.com"
origHostIpAddr="198.62.92.33"

thisNsIpAddr="198.62.92.10"

egrep "^\.${topDomName}:${origHostIpAddr}" data

cp -p data data.save.$$
sed -e "s/^\.${topDomName}:${origHostIpAddr}/\.${topDomName}:${thisNsIpAddr}/" data > data.$$

diff data data.$$

mv data.$$ data

egrep "^\.${topDomName}:${thisNsIpAddr}" data 


