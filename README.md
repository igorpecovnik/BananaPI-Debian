BananaPi Debian
================
![](http://www.igorpecovnik.com/wp-content/uploads/2014/09/bananapi-ssh.png)

Script to create an image of Debian for Banana PI.

![](http://www.igorpecovnik.com/wp-content/uploads/2014/09/bananapi.png)

Check build libraries:
https://github.com/igorpecovnik/lib

Download images, support and history
------------------
[http://www.igorpecovnik.com/2014/09/07/banana-pi-debian-sd-image/](http://www.igorpecovnik.com/2014/09/07/banana-pi-debian-sd-image/ "Download")

Thank you for your donation
------------------

[![Paypal donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CUYH2KR36YB7W)

![My bitcoin address](http://www.igorpecovnik.com/wp-content/uploads/2014/10/bitcoinigor.png)

17vT6hV83EQ6rizbWeasfy1tWEzFpzYqEE

Compilation steps
------------------
1. [Install Ubuntu 14.04 LTS](http://releases.ubuntu.com/14.04/) into your (virtual) PC
2. Login as root and execute:

```shell
sudo apt-get -y install git
cd ~
git clone https://github.com/igorpecovnik/BananaPI-Debian
chmod +x ./BananaPI-Debian/build.sh
cd ./BananaPI-Debian
sudo ./build.sh
```
3. Wait around 3h on a 10Mbit line and average desktop computer.
