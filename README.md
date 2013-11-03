# Vagrant Ansible Local

This Vagrant plugin allow provisioning your VM with ansible playbooks directly from the guest VM using --connection=local

## Installation

install this vagrant plugin by running (won't work yet)

    vagrant plugin install vagrant-ansible-local

## Usage

Configure your VagrantFile with the `ansibleLocal` provisioner:

    config.vm.provision :ansibleLocal, :playbook => "ansible/ansible.yml"

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
