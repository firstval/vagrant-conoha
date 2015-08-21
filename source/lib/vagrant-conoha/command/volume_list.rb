require 'vagrant-conoha/command/openstack_command'

module VagrantPlugins
  module ConoHa
    module Command
      class VolumeList < OpenstackCommand
        def self.synopsis
          I18n.t('vagrant_openstack.command.volume_list_synopsis')
        end

        def cmd(name, argv, env)
          fail Errors::NoArgRequiredForCommand, cmd: name unless argv.size == 0
          volumes = env[:openstack_client].cinder.get_all_volumes(env)

          rows = []
          volumes.each do |v|
            attachment = "#{v.instance_id} (#{v.device})" unless v.instance_id.nil?
            rows << [v.id, v.name, v.size, v.status, attachment]
          end
          display_table(env, ['Id', 'Name', 'Size (Go)', 'Status', 'Attachment (instance id and device)'], rows)
        end
      end
    end
  end
end
