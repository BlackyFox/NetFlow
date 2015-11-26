#!/bin/sh

INSTALL_REP=TMP_REP

mkdir $INSTALL_REP
cd $INSTALL_REP
wget http://downloads.sourceforge.net/project/nfdump/stable/nfdump-1.6.13/nfdump-1.6.13.tar.gz
wget http://downloads.sourceforge.net/project/flex/flex-2.6.0.tar.gz
wget ftp://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz
wget ftp://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.gz
wget http://sourceforge.net/projects/net-snmp/files/net-snmp/5.7.3/net-snmp-5.7.3.tar.gz
wget ftp://ftp.netfilter.org/pub/iptables/iptables-1.4.21.tar.bz2

cp ipt-netflow22.tar.gz $INSTALL_REP

for f in *.tar.*
do 
	tar -xvf $f
done

echo "Updating collector (nfdump) to version 1.6.13"

#INSTALL M4
cd m4-1.4.17
./configure
make
make install
cd ..

#INSTALL FLEX
cd flex-2.6.0
./configure
make
make install
cd ..

#INSTALL BISON
cd bison-3.0.4
./configure
make
make install
cd ..

#INSTALL NFDUMP
cd nfdump-1.6.13
./configure --prefix=/usr/
make prefix=/usr/
make install prefix=/usr/
cd ..

echo "Updating ipt-netflow to version 2.1.36-g95fabbf"

#INSTALL IPTABLES
cd iptables-1.4.21
./configure --prefix=/usr/
make
make install
cd ..

#INSTALL SNMP
urpmi perl-devel
cd net-snmp-5.7.3
./configure --prefix=/usr/
make
make install
cd ..

#INSTALL netflow2.2
cd ipt-netflow22
./configure
make all install
depmod
cd ..

cd ..
rm -rf $INSTALL_REP

nfdump -V





