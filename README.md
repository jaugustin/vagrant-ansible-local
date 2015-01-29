# Vagrant Ansible Local

This Vagrant plugin allow provisioning your VM with ansible playbooks directly from the guest VM using --connection=local

## Installation

install this vagrant plugin by running

    vagrant plugin install vagrant-ansible-local

## requirement

Your vagrant box should have ansible installed on it, if it's not the case you could use to shell provisioner to install it.

## Usage

Configure your VagrantFile with the `ansibleLocal` provisioner:

    config.vm.provision :ansibleLocal, :playbook => "ansible/ansible.yml"
    
In case your ansible version is between 1.5 and 1.8 and you are running into an error message saying `ERROR: provided hosts list is empty`, you can either add anything to your `/etc/ansible/hosts` file or change the configuration of the provisioner:

    config.vm.provision :ansibleLocal, :playbook => "playbooks/playbook.yml", :raw_arguments => "-i 'localhost,'"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## TODO

* cleanup parameters
* auto build or mount `inventory-file` and prevent issue with non executable file mounted with 777
* add command for running ansible-playbook on demand
