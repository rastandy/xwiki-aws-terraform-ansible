# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  # Ensure we use our vagrant private key
  config.ssh.insert_key = false
  config.ssh.private_key_path = '~/.vagrant.d/insecure_private_key'

  # Setup DNS name with landrush plugin
  if Vagrant.has_plugin?("landrush")
    config.landrush.enabled = true
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    # v.cpus = 2
  end

  config.vm.define 'xwiki' do |machine|
    machine.vm.box = "bento/ubuntu-18.04"
    # machine.vm.box = "bento/centos-7.2"
    #machine.vm.box = "ubuntu/precise64"
    #machine.vm.box = "debian/jessie64"
    #machine.vm.box = "debian/wheezy64"
    #machine.vm.box = "chef/centos-7.1"
    #machine.vm.box = "chef/centos-6.6"

    machine.vm.synced_folder "~/.m2/repository", "/maven-repo"

    machine.vm.network :private_network, ip: '192.168.88.22'
    # machine.vm.network "forwarded_port", host_ip: "127.0.0.1", guest: 5432, host: 15432
    machine.vm.hostname = 'xwiki.vagrant.test'
    machine.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'playbook.yml'
      ansible.sudo = true
      # ansible.inventory_path = 'vagrant-inventory'
      ansible.host_key_checking = false
      ansible.raw_arguments  = ["--extra-vars=@test_vars.yml"]
    end
  end
end
