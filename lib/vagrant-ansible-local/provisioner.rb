module VagrantPlugins
  module AnsibleLocal
    class Provisioner < Vagrant.plugin("2", :provisioner)

      def configure(root_config)
        playbook_path = Pathname.new(File.dirname(config.playbook)).expand_path(@machine.env.root_path)

        #folder_opts = {}
        #folder_opts[:nfs] = true if config.nfs
        #folder_opts[:owner] = "root" if !folder_opts[:nfs]

        # Share the playbook directory with the guest
        root_config.vm.synced_folder(playbook_path, config.guest_folder.to_s)
      end

      def provision
 #       ssh = @machine.ssh_info

        # Connect with Vagrant user (unless --user or --private-key are overidden by 'raw_arguments')
        #options = %W[--private-key=#{ssh[:private_key_path]} --user=#{ssh[:username]}]
        options = %W[--connection=local]

        # Joker! Not (yet) supported arguments can be passed this way.
        options << "#{config.raw_arguments}" if config.raw_arguments

        # Append Provisioner options (highest precedence):
        if config.extra_vars
          extra_vars = config.extra_vars.map do |k,v|
            v = v.gsub('"', '\\"')
            if v.include?(' ')
              v = v.gsub("'", "\\'")
              v = "'#{v}'"
            end

            "#{k}=#{v}"
          end
          options << "--extra-vars=\"#{extra_vars.join(" ")}\""
        end

#        options << "--inventory-file=#{self.setup_inventory_file}"
#        options << "--sudo" if config.sudo
#        options << "--sudo-user=#{config.sudo_user}" if config.sudo_user
        options << "#{self.get_verbosity_argument}" if config.verbose
#        options << "--ask-sudo-pass" if config.ask_sudo_pass
        options << "--tags=#{as_list_argument(config.tags)}" if config.tags
        options << "--skip-tags=#{as_list_argument(config.skip_tags)}" if config.skip_tags
        options << "--limit=#{as_list_argument(config.limit)}" if config.limit
        options << "--start-at-task=#{config.start_at_task}" if config.start_at_task

        # Assemble the full ansible-playbook command
        command = "export ANSIBLE_FORCE_COLOR=true\n"
        command += "export ANSIBLE_HOST_KEY_CHECKING=#{config.host_key_checking}\n"
        command += "export PYTHONUNBUFFERED=1\n"
        command += (%w(ansible-playbook) << (File.join(config.guest_folder, File.basename(config.playbook).to_s)) << options).flatten.join(' ')



        @machine.communicate.tap do |comm|
          # Execute it with sudo
          comm.execute(command, sudo: config.privileged) do |type, data|
            if [:stderr, :stdout].include?(type)
              @machine.env.ui.info(data, :new_line => false, :prefix => false)
            end
          end
        end
      end

      protected

      def get_verbosity_argument
        if config.verbose.to_s =~ /^v+$/
          # ansible-playbook accepts "silly" arguments like '-vvvvv' as '-vvvv' for now
          return "-#{config.verbose}"
        else
          # safe default, in case input strays
          return '-v'
        end
      end

      def as_list_argument(v)
        v.kind_of?(Array) ? v.join(',') : v
      end
    end
  end
end
