# frozen_string_literal: true

require "ostruct"

module Daraja
  class Object
    def initialize
      @attributes = OpenStruct.new()
    end

    def method_missing(method, *args, &block)
    end

    def respond_to_missing?
      true
    end
  end
end
