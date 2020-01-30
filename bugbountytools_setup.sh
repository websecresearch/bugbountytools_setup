#!/bin/bash
export DEBIAN_FRONTEND=noninteractive;
echo "[*] Starting Install... [*]"
echo "[*] Upgrade installed packages to latest [*]"
echo -e "\nRunning a package upgrade...\n"
apt-get -qq update && apt-get -qq dist-upgrade -y
apt full-upgrade -y
apt-get autoclean

echo "[*] Install stuff I use all the time [*]"
echo -e "\nInstalling default packages...\n"
apt-get -y install build-essential checkinstall fail2ban gcc firefox git sqlite3 ruby ruby-dev git-core python-dev python-pip unzip jruby libbz2-dev libc6-dev libgdbm-dev libncursesw5-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev nikto nmap nodejs python-dev python-numpy python-scipy python-setuptools tk-dev unattended-upgrades wget curl
apt-get install -y xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps clang libdbus-1-dev libgtk2.0-dev libnotify-dev libgnome-keyring-dev libgconf2-dev libasound2-dev libcap-dev libcups2-dev libxtst-dev libxss1 libnss3-dev gcc-multilib g++-multilib libldns-dev

echo "[*] Install Chrome.[*]"
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
apt-get -f install -y
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb

echo "[*] Install Ruby[*]"
apt-get -qq install gnupg2 -y
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable --ruby
echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc

echo "[*] Install nodejs [*]"
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

echo "[*] Install PhantomJs[*]"
curl -L https://gist.githubusercontent.com/ManuelTS/935155f423374e950566d05d1448038d/raw/906887cbfa384d450276b87087d28e6a51245811/install_phantomJs.sh | sh

echo "[*] Install Casperjs[*]"
git clone git://github.com/n1k0/casperjs.git
cd casperjs
ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
cd ..

echo "[*] Making Bounty Scan Area.. [*]"
mkdir -p /home/tools/mass-bounty/
mkdir -p /home/tools/mass-bounty/angular-results/
mkdir -p /home/tools/mass-bounty/crlf-results/
mkdir -p /home/tools/mass-bounty/dirsearch-results/
mkdir -p /home/tools/mass-bounty/jexboss-results/
mkdir -p /home/tools/mass-bounty/tko-results/
mkdir -p /home/tools/mass-bounty/s3-results/

cd /home/tools/mass-bounty/

echo "[*] install Sublist3r[*]"
git clone https://github.com/Plazmaz/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt
cd ..

echo "[*] install crlf injection[*]"
git clone https://github.com/random-robbie/CRLF-Injection-Scanner.git
cd CRLF-Injection-Scanner
pip install colored eventlet
cd ..

echo "[*] pip install angularjs xss[*]"
git clone -b develop https://github.com/tijme/angularjs-csti-scanner.git
cd angularjs-csti-scanner
pip install -r requirements.txt
python setup.py install
wget "https://raw.githubusercontent.com/random-robbie/docker-dump/master/mass-angularjs-csti-scanner/mass-scan" -o /bin/mass-scan
wget "https://raw.githubusercontent.com/random-robbie/docker-dump/master/mass-angularjs-csti-scanner/scan" -o /bin/scan
chmod 777 /bin/scan
chmod 777 /bin/mass-scan
cd ..

echo "[*] install aquatone [*]"
gem install aquatone

echo "[*] dir search [*]"
git clone https://github.com/maurosoria/dirsearch.git
cd ..

echo "[*] dirsearch mass [*]" 
wget https://gist.githubusercontent.com/random-robbie/b8fad5cbff2c5dbcb3470b6cd0c6d635/raw/dirsearch_it.sh -O /bin/dirsearch
chmod 777 /bin/dirsearch


echo "[*] Go Buster [*]"
wget https://github.com/OJ/gobuster/archive/v1.3.tar.gz
tar xzvf v1.3.tar.gz
mv gobuster-1.3 go-buster
cd go-buster
wget https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/all.txt
go build
chmod 777 gobuster
cd ..

echo "[*] Mass DNS [*]"
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
make install
cd ..

echo "[*] Sub Brute [*]"
git clone https://github.com/TheRook/subbrute.git
cd..

echo "[*] S3 Bucket Checker [*]"
mkdir s3-bucket-check
cd s3-bucket-check
wget https://gist.githubusercontent.com/random-robbie/b452cc3e1aa99cfeba764e70b5a26dc8/raw/bucket_upload.sh
wget https://gist.githubusercontent.com/random-robbie/b0c8603e55e22b21c49fd80072392873/raw//bucket_list.sh
cd ..

echo "[*] Expired Domain Take Overs [*]"
git clone https://github.com/JordyZomer/autoSubTakeover.git
cd autoSubTakeover
pip install -r requirements.txt
cd ..



echo "[*]Finished Installing....[*]"