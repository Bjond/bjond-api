require 'securerandom'

module BjondApi
  class BjondConsequence
    attr_accessor :id, :jsonKey, :name, :description, :webhook, :serviceId
  end
end