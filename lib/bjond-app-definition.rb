require 'securerandom'

module BjondIntegration
  class BjondAppDefinition
    attr_accessor :id, :author, :name, :description, :config_url, :icon_url, :rootEndpoint, :integrationEvents, :integrationConsequences

    def initialize()
      self.id = SecureRandom.uuid
    end
  end
end