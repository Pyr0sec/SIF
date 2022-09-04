# SIF
SIF (stray IP finder) produces a list of target's IPs that don't have a subdomain hosted on them. 📍

Sources
---
```
* shodan
* alienvault
* hackertarget
* threatcrowd
* securitytrails
* omnisint
```

Installation
---
```
git clone https://github.com/Pyr0sec/SIF
cd SIF
chmod +x setup.sh sif.sh
./setup.sh
```

> Note: Shodan Premium is required to run this script. To setup shodan-cli visit this link: https://cli.shodan.io/

Usage
---
```
./sif.sh
or
sudo ./sif.sh
```
 
Make sif.sh universal
---
```
cp <PATH TO FILE>/sif.sh /usr/bin/sif
sif

[Mostly work in Linux Systems]
```

Working
---
- Resolve all subdomains to IP addresses. Save IPs to list1.txt
- Go to http://shodan.io and search Ssl.cert.subject.CN:"domain.com"
- Save the IPs you get from http://shodan.io in list2.txt
- Remove all the list1.txt IPs from list2.txt
- Probe all IPs from list2.txt.
- That's it. You now have a list of target's IPs that don't have a subdomain hosted on them.

Screenshot
---
![image](https://user-images.githubusercontent.com/74669749/188251662-a94187c3-59e3-438e-a3a0-16315e9d9ed5.png)


Made with ❤ by me.
