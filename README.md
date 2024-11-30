[![Actions Status - Master](https://github.com/juju4/ansible-up1/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-up1/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-up1/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-up1/actions?query=branch%3Adevel)

# Up1, Client-side Encrypted Image Host ansible role

Ansible role to setup Up1, Client-side Encrypted Image Host
https://github.com/Upload/Up1

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.7-10

### Operating systems

Ubuntu 20.04, 22.04, 24.04.

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

* systemd configuration is not working on Xenial.
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

* Reverseproxy configuration: only nginx tested. Apache config for reference.

## Alternative options

* https://github.com/freedomofpress/securedrop/
* https://github.com/timvisee/send
* https://github.com/ldidry/lufi
* https://bitwarden.com/blog/bitwarden-send-how-it-works/

## License

BSD 2-clause
