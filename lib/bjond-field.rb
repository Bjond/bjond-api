require 'securerandom'

module BjondIntegration
  class BjondField
    attr_accessor :id, :json_key, :name, :description, :field_type, :event, :options
  end
end