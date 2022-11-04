# frozen_string_literal: true

module Daraja
  module Api
    class STKPush
      attr_accessor :short_code, :amount, :phone_number, :callback_url, :account_ref, :lnm_passkey, :description, :transation_type

      def debug_assert
        raise "A short code has to be provided" if @short_code.nil?
        raise "An amount has to be provided" if @amount.nil?
        raise "A phone number must be provided" if @phone_number.nil?
        raise "Please provide your lipaNaMpesaPasskey" if @lnm_passkey.nil?
      end

      def initialize(app)
        @app = app
        # Set value defaults
        @transation_type = "CustomerPayBillOnline"
        @amount = 1
      end
    end
  end
end
