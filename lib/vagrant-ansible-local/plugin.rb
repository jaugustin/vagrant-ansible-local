require "vagrant"

module VagrantPlugins
  module AnsibleLocal
    class Plugin < Vagrant.plugin("2")
      name "ansible_local"
      description <<-DESC
      Provides support for provisioning your virtual machines with
      Ansible playbooks directly from the guest VM using --connection=local.
      DESC

      config(:ansibleLocal, :provisioner) do
        require File.expand_path("../config", __FILE__)
        Config
      end

      provisioner(:ansibleLocal) do
        require File.expand_path("../provisioner", __FILE__)
        Provisioner
      end
    end
  end
end
