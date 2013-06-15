#!/bin/sh
echo '#####################################'
echo '# MacPorts Installer'
echo '#####################################'
IFS='.'
set -- $VER

if test "$VER" ;then
	echo "MacPorts Version = $1.$2.$3"
else
	echo "[error] : Please set VER arg"
	echo "e.g."
	echo "curl http://path.to/macports.sh | env VER=2.1.3 sh"
	echo "env VER=2.1.3 ./macports.sh"
	exit
fi

if test -f /opt/local/bin/port;then
  echo "[warn]  : MacPorts was already installed."
  echo "[info]  : /opt/local/bin/port"
  exit;
fi

cd /tmp
if test -f "MacPorts-${VER}.tar.bz2";then
	echo "Already exists MacPorts-${VER}.tar.bz2"
	rm -fr "/tmp/MacPorts-${VER}"
else
	echo "curl -O https://distfiles.macports.org/MacPorts/MacPorts-${VER}.tar.bz2"
	curl -O "https://distfiles.macports.org/MacPorts/MacPorts-${VER}.tar.bz2"
fi

tar zxfv "MacPorts-${VER}.tar.bz2"
cd "MacPorts-${VER}"
./configure
make
echo "sudo make install"
sudo make install
echo 'export PATH=/opt/local/bin:/opt/local/sbin:$PATH' >> ~/.bash_profile
cd ..
rm -fr "/tmp/MacPorts-${VER}"
sudo /opt/local/bin/port -v selfupdate
