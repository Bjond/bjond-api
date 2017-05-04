require 'singleton'

module BjondApi
  class BjondAppConfig
    include Singleton

    attr_accessor :active_definition, :group_configuration_schema, :group_configuration, :encryption_key_name, :user_configuration_schema

    self.instance.encryption_key_name = 'APP_ENCRYPTION_KEY'

    def configure_group(config, bjond_registration, group_id)
      puts '[ App group configuration method not implemented. This can be set via BjondAppConfig.instance.configure_group ]'
    end

    def get_group_configuration(bjond_registration, group_id)
      puts '[ get_group_configuration method not implemented. This can be set via BjondAppConfig.instance.get_group_configuration ]'
    end

    def get_user_configuration(bjond_registration)
      puts '[ get_user_configuration method not implemented. This can be set via BjondAppConfig.instance.get_user_configuration ]'
    end
  end
end