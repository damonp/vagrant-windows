# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

# Vagrant Chef-Solo Provisioning
HOST_PUB_IP  = '10.10.11.10'
HOST_PRIV_IP = '10.10.12.10'
HOST_BOX = 'win2008r2'
HOST_NAME = 'win2008r2.dev'

Vagrant.configure("2") do |config|

  config.vm.define HOST_BOX
  config.vm.box = "windows_2008_r2_dev"
  # config.vm.define "vagrant-windows-2008-r2"
  # config.vm.box = "alexshd/windows_2008_r2_virtualbox"

  # Admin user name and password
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.communicator = "winrm"

  config.vm.guest = :windows
  config.windows.halt_timeout = 15

  config.vm.hostname = HOST_NAME
  config.vm.network :private_network, ip: HOST_PUB_IP
  config.vm.network :private_network, ip: HOST_PRIV_IP

  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # config.vm.synced_folder '../BCG', '/vagrant/BCG'
  # config.vm.synced_folder './', '/vagrant'

  config.vm.network :forwarded_port, guest: 5985, host: 25985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 23389, id: "rdp", auto_correct: true
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true

  config.vm.provider :virtualbox do |v, override|
    v.gui = true
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--vram", 32]
    v.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--audio", "none"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--usb", "off"]
    v.customize ['modifyvm', :id, '--cpuexecutioncap', 80]
  end

  # windows_auto_run 'BGINFO' do
  #   program 'C:/Sysinternals/bginfo.exe'
  #   args    '\'C:/Sysinternals/Config.bgi\' /NOLICPROMPT /TIMER:0'
  #   not_if  { Registry.value_exists?(AUTO_RUN_KEY, 'BGINFO') }
  #   action  :create
  # end

  # Join AD domain
  # windows_ad_domain "AD" do
  #   action :join
  #   domain_pass "Passw0rd"
  #   domain_user "Administrator"
  # end

  # Create computer HOST_NAME in the Computers OU
  # windows_ad_computer HOST_NAME do
  #   action :create
  #   domain_name "AD"
  #   ou "computers"
  # end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    # chef.data_bags_path = 'data_bags'
    chef.roles_path = 'roles'

    # Roles
    # chef.add_role 'sql_server'
    # chef.add_role 'opsviz'

    # Recipes
    # chef.add_recipe('windows_network')
    # chef.add_recipe('windows-hostname')
    # chef.add_recipe('windows_firewall')

    # Software Installs
    # chef.add_recipe('firefox')
    chef.add_recipe('putty')
    # chef.add_recipe('chocolatey')

    # chef.add_recipe('sql_server')

    chef.json = {
      set_fqdn: HOST_NAME,
      id: HOST_NAME,
      interfaces: [
        {
          name:     "Local network",
          # mac:      "00:AC:21:BC:F0:E0",
          address:  HOST_PUB_IP,
          # netmask:  "255.255.255.0",
          # gateway:  "10.10.11.1",
          'dns-nameservers' => "8.8.8.8,8.8.4,4",
          # 'dns-search' => "domain.dev"
        },
        {
          name:     "Private network",
          # mac:      "00:AC:21:BC:F0:E0",
          address:  HOST_PRIV_IP,
          # netmask:  "255.255.255.0",
          # gateway:  "10.10.12.1",
          'dns-nameservers' => "8.8.8.8,8.8.4,4",
          # 'dns-search' => "domain.dev"
        }
      ]
    }
  end

end
