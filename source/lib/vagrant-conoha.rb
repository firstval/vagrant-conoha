require 'pathname'

require 'vagrant-conoha/plugin'
require 'vagrant-conoha/logging'

module VagrantPlugins
  module ConoHa
    lib_path = Pathname.new(File.expand_path('../vagrant-conoha', __FILE__))
    autoload :Errors, lib_path.join('errors')

    # This initializes the i18n load path so that the plugin-specific
    # translations work.
    def self.init_i18n
      I18n.load_path << File.expand_path('locales/en.yml', source_root)
      I18n.reload!
    end

    def self.init_logging
      Logging.init
    end

    # This returns the path to the source of this plugin.
    #
    # @return [Pathname]
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end
