require 'singleton'

module BjondIntegration
  class BjondAppConfig
    include Singleton

    attr_accessor :active_definition, :group_configuration_schema, :group_configuration
  end
end