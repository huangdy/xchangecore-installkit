#!/bin/sh

echo INFO: Install OpenDJ
echo INFO: sudo unzip -d /opt OpenDJ-2.7.0-20131023.zip >> ../install.log
sudo unzip -d /opt OpenDJ-2.7.0-20131023.zip 2>&1 | tee -a ../install.log

read -p "Enter the password for OpenDJ's admin: " opendj_passwd
read -p "Enter the password for Core User: admin: " admin_passwd
read -p "Enter the password for Core User: xchangecore: " xc_passwd

echo INFO: Setup OpenDJ
echo INFO: sudo /opt/opendj/setup --cli --no-prompt --doNotStart -Z 636 -q --generateSelfSignedCertificate -N XCHANGECORE --adminConnectorPort 4444 -D "cn=Directory Manager" -w $opendj_passwd -b dc=xchangecore,dc=us -a >> ../install.log
sudo /opt/opendj/setup --cli --no-prompt --doNotStart -Z 636 -q --generateSelfSignedCertificate -N XCHANGECORE --adminConnectorPort 4444 -D "cn=Directory Manager" -w $opendj_passwd -b dc=xchangecore,dc=us -a 2>&1 | tee -a ../install.log

echo INFO: Starting OpenDJ
echo INFO: sudo /opt/opendj/bin/start-ds >> ../install.log
sudo /opt/opendj/bin/start-ds 2>&1 | tee -a ../install.log

echo INFO: Creating Admin and User Groups
echo INFO: cp conf/setup.ldif.orig conf/setup.ldif >> ../install.log
cp conf/setup.ldif.orig conf/setup.ldif 2>&1 | tee -a ../install.log

echo INFO: Replace all the replacements
echo INFO : rpl "%ADMINUSER%" admin conf/setup.ldif >> ../install.log
rpl "%ADMINUSER%" admin conf/setup.ldif 2>&1 | tee -a ../install.log
echo INFO: rpl "%ADMINPASS%" $admin_passwd conf/setup.ldif >> ../install.log
rpl "%ADMINPASS%" $admin_passwd conf/setup.ldif 2>&1 | tee -a ../install.log
echo INFO: rpl "%COREUSER%" xchangecore conf/setup.ldif >> ../install.log
rpl "%COREUSER%" xchangecore conf/setup.ldif 2>&1 | tee -a ../install.log
echo INFO: rpl "%COREPASS%" $xc_passwd conf/setup.ldif >> ../install.log
rpl "%COREPASS%" $xc_passwd conf/setup.ldif 2>&1 | tee -a ../install.log

echo INFO: modify the ldap using setup.ldif
echo INFO: sudo /opt/opendj/bin/ldapmodify -p 636 -D "cn=Directory Manager" -w $opendj_passwd -X -Z --noPropertiesFile -a -f conf/setup.ldif >> ../install.log
sudo /opt/opendj/bin/ldapmodify -p 636 -D "cn=Directory Manager" -w $opendj_passwd -X -Z --noPropertiesFile -a -f conf/setup.ldif 2>&1 | tee -a ../install.log

echo INFO: removed the setup.ldif
echo INFO: rm conf/setup.ldif >> ../install.log
rm conf/setup.ldif 2>&1 | tee -a ../install.log