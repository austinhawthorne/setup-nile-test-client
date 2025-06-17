This shell script installs all the Nile demo and readiness scripts, and necessary dependenccies, in this Git onto a Raspberry Pi.  To setup your Pi run:

```
git clone https://github.com/austinhawthorne/setup-nile-test-client.git 
cd setup-nile-test-client
chmod +x setup-client.sh
sudo ./setup-client.sh
```

This will install all the Gits in your user's home directory as well as necessary dependencies..

Today this installs:

```
  rogue-dhcp-test
  loop-detector
  dot1x-test
  simple-mcast-test
  simple-airplay
  net-scan
  staticip-test
  nile-readiness-test
```
