require 'securerandom'

module BjondIntegration
  class BjondConsequence
    attr_accessor :id, :json_key, :name, :description, :webhook, :service_id
  end
end