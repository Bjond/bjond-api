require 'securerandom'

module BjondApi
  class BjondField
    attr_accessor :id, :jsonKey, :name, :description, :fieldType, :event, :options, :codeType, :identifier, :persist, :dataType, :unit
  end
end