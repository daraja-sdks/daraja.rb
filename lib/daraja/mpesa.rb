# frozen_string_literal: true

require "base64"
require "faraday"
require "faraday_middleware"
require_relative "api/c2b"
require_relative "routes"

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
      @last_token_time = 0

      base_url = @environment == "SANDBOX" ? ROUTES[:sandbox] : ROUTES[:production]
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = base_url
        conn.request :json
        conn.response :json, content_type: "application/json"
      end

      yield(self) if block_given?
    end

    def c2b
      yield Api::CustomerToBusiness.new(get_builder_cfg)
    end

    def stk_push
      yield Api::STKPush.new(get_builder_cfg)
    end
    

    private
      def get_auth_token
        if (Time.now.to_i - @last_token_time) < 3599
          @latest_token
        else
          creds = Base64.urlsafe_encode64("#{@consumer_key}:#{@consumer_secret}").chomp
          body = @connection.get(ROUTES[:oauth], {}, { Authorization: "Basic #{creds}" }).body
          token = body["access_token"]

          @latest_token = token
          @last_token_time = Time.now.to_i

          token
        end
      end

      def get_builder_cfg
        { token: get_auth_token, client: @connection }
      end

      def generate_credential
      end
  end
end
