class Transaction < ApplicationRecord
  VALID_CURRENCIES = %w[USD NGN AED EUR GBP GHS JPY KES MAD UGX XOF ZAR].freeze

  belongs_to :customer

  validates :input_amount,  numericality: { greater_than_or_equal_to: 0 }
  validates :output_amount,  numericality: { greater_than_or_equal_to: 0 }
  validates :input_currency, inclusion: { in: VALID_CURRENCIES, allow_nil: false }
  validates :output_currency, inclusion: { in: VALID_CURRENCIES, allow_nil: false }
end
