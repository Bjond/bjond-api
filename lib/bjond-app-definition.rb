require 'securerandom'

module BjondIntegration
  class BjondAppDefinition
    attr_accessor :id, :author, :name, :description, :rootEndpoint, :configURL, :iconURL, :rootEndpoint, :integrationEvents, :integrationConsequences

    def initialize()
      self.id = SecureRandom.uuid
    end
  end
end