XWiki Playbook
==============

Ansible playbook to install XWiki Enterprise in the Apache Tomcat
container with PostgreSQL as Database backend.

## Prepare the AMI using Packer

```shell
packer build -on-error=ask -var-file=<project>-<workspace>.json  packer.json

```

## Provision the infrastructure using Terraform

```shell
export TF_VAR_xwiki_database_user_pass=<db_password>
export postfix_sasl_password=<postfix_sasl_password>
terraform workspace show
terraform plan -var-file=<project>-<workspace>.json
terraform apply -var-file=<project>-<workspace>.json

```

## Configure the provided infrastructure

```shell
cd ansible
ansible-playbook --become -i inventory-xwiki.mydomain.org \
                 --extra-vars=@../prod.json  \
                 -e "xwiki_database_user_pass=$TF_VAR_xwiki_database_user_pass" \
                 -e "postfix_sasl_password=$postfix_sasl_password" \
                 playbook.yml
```

## Testing

This playbook ships with a Vagrant file for testing purpouse. If you
want to take advantage of it, just install Vagrant and Virtualbox on
your machine and you should be able to setup a VM with XWiki up and
running by just issuing this shell command from the playbook
directory:

```shell
vagrant up

```

After that, you should be able to browse your XWiki instance at the
following url:

http://192.168.88.22:18080

Also, if you install the Vagrant landrush plugin, you can access your
instance by pointing your browser to this url:

http://xwiki.vagrant.test:18080

## Customization

In ``defaults.yml`` you can find defaults for variables you can
customize to, for example, change the XWiki or Java installed version.

You should also take a look at the ``host_vars/default`` file which
contains all the default values you must consider when using this
playbook in production.

Here is the list of these variables:

```yaml
servername: "xwiki.vagrant.test"
administrator_email: "root@example.org"
xwiki_mail_from: "no-reply@example.org"
xwiki_validation_key: ""
xwiki_encryption_key: ""
xwiki_database_user_pass: "mydatabasepassword"
postfix_hostname: "{{ servername }}"
postfix_relayhost: "smtp.example.org"
postfix_relayhost_port: "587"
postfix_sasl_user: "test"
postfix_sasl_domain: "example.org"
postfix_sasl_password: "mysasluserpassword"
postfix_tls_support: "yes"
bacula_password: "mybaculapassword"

xwiki_apache_service: false
xwiki_monitoring_service: false
xwiki_backup_service: false
xwiki_libreoffice_service: false
xwiki_firewall_service: false
xwiki_postfix_service: true
xwiki_clojure_scripting: true
```

To customize these variables, for example because you want to activate
optional services like Riemann and Collectd for monitoring, just copy
the ``host_vars/default`` into a new file in the same directory and
call it with the same name of the host you are going to configure.

For example if you have an hostname called "xwiki-mycompany" you can
override defaluts by creating a file called
``host_vars/xwiki-mycompany`` and customize variables in there as you
wish.

## License

GPLv3
