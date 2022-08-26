module Api
  module V1
    class TransactionsController < ApplicationController
      include PaginationHandler
      include ExceptionHandler

      def create
        transaction = Transaction.create!(transaction_params)

        render json: transaction, status: :created
      end

      def index
        limit, offset = pagination_params
        transactions = Transaction.limit(limit).offset(offset)

        render json: transactions, status: :ok
      end

      def show
        transaction = Transaction.find(id: params[:id])
        render json: transaction, status: :ok
      end

      private

      def transaction_params
        params.permit(
          :customer_id,
          :input_amount,
          :output_amount,
          :input_currency,
          :output_currency
        )
      end
    end
  end
end