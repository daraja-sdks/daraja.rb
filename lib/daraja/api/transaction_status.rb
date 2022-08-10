# frozen_string_literal: true

module Daraja
  module Api
    class TransactionStatus
      attr_writer :phone_number, :transaction_id

      def initialize(app)
        @app = app
      end
    end
  end
end
