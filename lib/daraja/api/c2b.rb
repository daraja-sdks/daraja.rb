# frozen_string_literal: true

module Daraja
  module Api
    class CustomerToBusiness
      attr_writer :short_code, :amount, :phone_number, :confirmation_url, :validation_url, :payment_type, :account_number,
                  :cancel_if_unreachable

      def debug_assert
        raise "A short code has to be provided" if @short_code.nil?
        raise "An amount has to be provided" if @amount.nil?
        raise "A phone number must be provided" if @phone_number.nil?
      end

      def initialize(app)
        @app = app
        @payment_type = "CustomerPayBillOnline"
        @response_type = "Cancelled"
      end

      def simulate
        debug_assert

        # TODO: Use faraday to send request
        token = @app[:token]
        conn = @app[:client]

        body = conn.post(ROUTES[:c2bsimulate], {
          ShortCode: @short_code,
          CommandID: @payment_type || "CustomerPayBillOnline",
          Amount: @amount,
          Msisdn: @phone_number,
          BillRefNumber: @account_number || "account"
        }, {
          Authorization: "Bearer #{token}"
        }).body

        puts body
      end

      def register_urls
        # TODO: implement
      end
    end
  end
end
