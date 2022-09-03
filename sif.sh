#!/bin/bash

printf "\n\n${WHITE}[!] Enter domain (example: twitter.com , facebook.com) : ${BLUE}"
read -r url
printf "${BLUE}\n[*] Enumerating subdomains!\n"
curl -s "https://sonar.omnisint.io/subdomains/$url" | jq -r '.[]' > sub
lynx --dump  https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$url | jq -r ".subdomains[]" | sort -u > sub1
lynx --dump  https://securitytrails.com/list/apex_domain/$url | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | grep ".$site" | grep -v  "https://www.facebook.com" | grep -v "https://www.linkedin.com" | grep -v "https://status.securitytrails.io" | grep -v "https://docs.securitytrails.com" | sort -u > sub3
lynx --dump https://api.hackertarget.com/hostsearch/?q=$url |  sort -u >sub4
sort -u sub sub1 sub3 sub4  | uniq -u | tee subdomain >> /dev/null
printf "${BLUE}\n[*] Creating list!\n"
dig -f subdomain +short | sort -u >> ips.txt
egrep -v [a-zA-Z] ips.txt >> ip.txt
printf "${BLUE}\n[*] Shodan Dorking!\n"
shodan download ipss Ssl.cert.subject.CN:"$url"
shodan parse --fields ip_str --separator , ipss.json.gz > ip1.txt
grep -vf ip.txt ip1.txt > result.txt
printf "${BLUE}\n[*] Cleaning up!\n"
rm -rf sub sub1 sub3 sub4 ips.txt ipss.json.gz ip.txt ip1.txt
num=$( wc -l result.txt | uniq | awk '{print $1; exit}')
printf "${WHITE}\n[*] Found $num IPs for ${G}$url\n"
printf "${BLUE}\n[!] view the subdomain file containing all subdomains!\n"
printf "${BLUE}\n[!] Make sure to probe the result.txt for 200 alive status because some IPs might be dead!\n"
printf "${BLUE}\nMade with ♡ by Pyrosec!\n"
