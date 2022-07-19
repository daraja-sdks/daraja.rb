# frozen_string_literal: true

require_relative "./api/c2b"

module Daraja
  class Mpesa
    attr_writer :consumer_key, :consumer_secret, :environment, :cert_path, :initiator_password

    def self.app
      yield new(consumer_key: nil, consumer_secret: nil)
    end

    def initialize(consumer_key:, consumer_secret:, environment: "SANDBOX", password: "Safcom999!", cert_path: nil)
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
      @environment = environment
      @initiator_password = password
      @cert_path = cert_path
    end

    # def connection
    # 	base_url = @environment == "SANDBOX" ? ROUTES[:sandbox] : ROUTES[:production]
    # 	@connection = Faraday.new do |conn|
    # 		conn.base_url = base_url
    # 		conn.request :json
    # 		conn.response :json, {"Content-Type": "application/json"}
    # 	end
    # end

    def c2b
      yield Api::CustomerToBusiness.new({ token: get_auth_token, client: "@connection" })
    end

    private
      def get_auth_token
        "authorization_token"
      end
  end
end
