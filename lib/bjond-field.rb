require 'securerandom'

module BjondApi
  class BjondField
    attr_accessor :id, :jsonKey, :name, :description, :fieldType, :event, :options
  end
end