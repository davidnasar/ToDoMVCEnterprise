# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "web" do |web|
    web.vm.provider 'docker' do |d|
      d.build_dir       = "."
      #d.image           = 'todomvc'
      d.name            = 'todomvc'
      d.create_args     = ['-i', '-t']
      d.remains_running = false
      d.ports           = ['3000:3000']
      d.has_ssh         = false
    end

    web.vm.synced_folder ".", "/data"
  end
end
