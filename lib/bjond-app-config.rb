require 'singleton'

module BjondIntegration
  class BjondAppConfig
    include Singleton

    attr_accessor :active_definition
  end
end