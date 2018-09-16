# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/precise64'
  config.vm.hostname = 'manga-dev-box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
  config.vm.synced_folder './', "/vagrant_data", :create => true, :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775,fmode=775']

  config.ssh.forward_agent = true
end
