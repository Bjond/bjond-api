require 'singleton'

module BjondIntegration
  class BjondAppConfig
    include Singleton

    attr_accessor :active_definition, :group_configuration_schema, :group_configuration, :encryption_key_name

    self.instance.encryption_key_name = 'APP_ENCRYPTION_KEY'
  end
end