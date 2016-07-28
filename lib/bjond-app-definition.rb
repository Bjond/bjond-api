require 'securerandom'

module BjondApi
  class BjondAppDefinition
    attr_accessor :id, :author, :name, :description, :rootEndpoint, :configURL, :iconURL, :rootEndpoint, :integrationEvent, :integrationConsequence

    def initialize()
      self.id = SecureRandom.uuid
    end
  end
end