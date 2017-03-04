[![Build Status - Master](https://travis-ci.org/juju4/ansible-up1.svg?branch=master)](https://travis-ci.org/juju4/ansible-up1)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-up1.svg?branch=devel)](https://travis-ci.org/juju4/ansible-up1/branches)
# Up1, Client-side Encrypted Image Host ansible role

Ansible role to setup Up1, Client-side Encrypted Image Host
https://github.com/Upload/Up1

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.2

### Operating systems

Ubuntu 14.04, 16.04 and Centos7

## Example Playbook

Just include this role in your list.
For example

```
- hosts: all
  roles:
    - juju4.up1
```

## Variables

Check defaults/main.yml

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.up1
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.up1/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues

* systemd configuration is not working.
Up1 can be start interactively
```
# cd /var/www-up1/src/server && sudo -H -u www-up1 /usr/bin/nodejs /var/www-up1/src/server/server.js
```
Or /usr/bin/node with RHEL/CentOS.

* Data is stored in {{ up1_working_dir }}/i in encrypted form. Filename and mime-type are not visible from server.
Node server in itself has no default log.

* Currently no expiry option.
https://github.com/Upload/Up1/issues/19
An optional cron has been added as a workaround

* Currently, no upstart config for Trusty


## License

BSD 2-clause

