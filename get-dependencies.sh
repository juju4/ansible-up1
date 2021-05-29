#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/geerlingguy.apache ] && git clone https://github.com/geerlingguy/ansible-role-apache $rolesdir/geerlingguy.apache
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx $rolesdir/geerlingguy.nginx
[ ! -d $rolesdir/juju4.harden_apache ] && git clone https://github.com/juju4/ansible-harden-apache $rolesdir/juju4.harden_apache
[ ! -d $rolesdir/juju4.harden_nginx ] && git clone https://github.com/juju4/ansible-harden-nginx $rolesdir/juju4.harden_nginx

## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.up1 ] && ln -s ansible-up1 $rolesdir/juju4.up1
[ ! -e $rolesdir/juju4.up1 ] && cp -R $rolesdir/ansible-up1 $rolesdir/juju4.up1

## don't stop build on this script return code
true
