Banana-PI-Debian
================

<img src="http://www.igorpecovnik.com/wp-content/uploads/2014/09/bananapi-ssh.png" alt="cubox-login" width="640" height="412">

Scripts to create an Image of Debian for Banana PI 

Check build libraries:
https://github.com/igorpecovnik/lib

Images, manual and history:
http://www.igorpecovnik.com/2014/09/07/banana-pi-debian-sd-image/

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CUYH2KR36YB7W"><img style="padding:0;" width=74 height=21  src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate!" / border="0"></a>

Bitcoin:
17vT6hV83EQ6rizbWeasfy1tWEzFpzYqEE

Installation steps
------------------
1. <a href=http://releases.ubuntu.com/14.04/>Install Ubuntu 14.04 LTS</a> into your (virtual) PC
2. Login as root and execute:

```shell
sudo apt-get -y install git
cd ~
git clone https://github.com/igorpecovnik/BananaPI-Debian
chmod +x ./BananaPI-Debian/build.sh
cd ./BananaPI-Debian
sudo ./build.sh
```
Whole process takes 2-3h on a 10Mbit line and average desktop computer.
