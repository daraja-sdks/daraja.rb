# frozen_string_literal: true

require_relative "daraja/version"

module Daraja
  autoload :Error, "daraja/error"
  autoload :Mpesa, "daraja/mpesa"
  autoload :Object, "daraja/object"
end
