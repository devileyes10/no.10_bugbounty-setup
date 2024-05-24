#!/bin/bash
# Author: No.10

#----------------Check if the script is executed with root privileges
if [ "${UID}" -eq 0 ]
then
    echo ""; echo -e "\e[32m\e[1mOK. The script will install the tools.\e[0m\e[39m"; echo "";
else
    echo ""; echo -e "\e[91m\e[1mRoot privileges are required\e[0m\e[39m"; echo "";
    exit
fi


#----------------Update the packages
echo -e "\e[93m\e[1m----> Updating all Packages";
sudo apt -y update && sudo apt -y upgrade
echo -e "\e[32mDone!";
sleep 1.5
clear;

#----------------Create directories for tools
echo -e "\e[93m\e[1m----> Create directories for tools (/opt/ulti & /opt/wordlists)";
mkdir /opt/ulti
mkdir /opt/wordlists

#----------------Install neccessary library
echo -e "\e[93m\e[1m----> Installing essential and useful library";
sudo apt install -y libcurl4-openssl-dev libssl-dev libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev libldns-dev
sudo apt install -y git jq rename xargs p7zip-full
echo -e "\e[32mDone!";
sleep 1.5

#----------------Install any programing env
echo -e "\e[93m\e[1m----> Installing any programing env";
# Install Ruby
sudo apt install -y ruby-full
# Install Go lang
sudo snap install go --classic
export export GOPATH=$HOME/go && export PATH=$GOPATH/bin:$PATH;
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$GOPATH/bin:$PATH' >> ~/.bash_profile
# Install Python3 and its libraries
sudo apt install -y python3 python3-pip python-pip python-dnspython python-setuptools build-essential libssl-dev libffi-dev python-dev virtualenv
# Install Python 2.7
cd /opt
wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
tar -zxvf Python-2.7.18.tgz
cd Python-2.7.18/
./configure
make
sudo make install
sudo wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
sudo python2.7 get-pip.py
echo -e "\e[32mDone!";
sleep 1.5

#----------------Install Network Scanner
# 
echo -e "\e[93m\e[1m----> Installing network scanner";
sudo apt install -y nmap

#----------------Install Web security tools
echo -e "\e[93m\e[1m----> Installing web security recon ultilities";
# FFUF
sudo apt-get install -y ffuf
# Amass
sudo snap install amass
# Chaos
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
# Truffle
cd /opt/ulti
git clone https://github.com/trufflesecurity/trufflehog.git
cd trufflehog; go install
# Nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
# httpx
snap install httpx
# wpscan
gem install wpscan
# waybackurl
go install github.com/tomnomnom/waybackurls@latest
# Lazyrecon
cd /opt/ulti
git clone https://github.com/nahamsec/lazyrecon.git
# github subdomains
go install github.com/gwen001/github-subdomains@latest
# sqlmap
apt install sqlmap
# graphqlmap
cd /opt/ulti
git clone https://github.com/swisskyrepo/GraphQLmap
cd GraphQLmap
python3 setup.py install
#waybackrobots
go install github.com/vodafon/waybackrobots@latest

#----------------Install wordlist
echo -e "\e[93m\e[1m----> Gathering the wordlists";
# OneListForAll
cd /opt/wordlists
git clone https://github.com/six2dez/OneListForAll.git
cat dict/apache* > dict/apache_long.txt
cat dict/api* > dict/api_long.txt
cat dict/dotfiles* > dict/dotfiles_long.txt
cat dict/nginx* > dict/nginx_long.txt
cat dict/php* > dict/php_long.txt
cat dict/subdomains* > dict/subdomains_long.txt
cat dict/words* > dict/words_long.txt
cat dict/xml* > dict/xml_long.txt
./olfa.sh
# seclists
cd /opt/wordlists
git clone https://github.com/danielmiessler/SecLists.git
cp -r SecLists seclists
rm -r SecLists
cd seclists/Discovery/DNS
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
# get orwagodfather
cd /opt/wordlists
git clone https://github.com/orwagodfather/WordList.git
cp -r WordList orwagodfather-worldlist
rm -r WordList
# get my own wordlist
cd /opt/wordlists
git clone https://github.com/App0x1e/devileyes-wordlists


echo -e "\e[92mDone! Mission Completed!\e[0m\e[39m"; echo "";