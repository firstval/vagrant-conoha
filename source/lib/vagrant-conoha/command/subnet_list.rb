require 'vagrant-conoha/command/openstack_command'

module VagrantPlugins
  module ConoHa
    module Command
      class SubnetList < OpenstackCommand
        def self.synopsis
          I18n.t('vagrant_openstack.command.subnet_list_synopsis')
        end

        def cmd(name, argv, env)
          fail Errors::NoArgRequiredForCommand, cmd: name unless argv.size == 0
          rows = []
          env[:openstack_client].neutron.get_subnets(env).each do |subnet|
            rows << [subnet.id, subnet.name, subnet.cidr, subnet.enable_dhcp, subnet.network_id]
          end
          display_table(env, ['Id', 'Name', 'CIDR', 'DHCP', 'Network Id'], rows)
        end
      end
    end
  end
end
