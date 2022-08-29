class Transaction < ApplicationRecord
  VALID_CURRENCIES = %w[USD NGN AED EUR GBP GHS JPY KES MAD UGX XOF ZAR].freeze

  belongs_to :customer

  validates :input_amount,  numericality: { greater_than_or_equal_to: 0 }
  validates :output_amount,  numericality: { greater_than_or_equal_to: 0 }
  validates :input_currency, inclusion: {
    in: VALID_CURRENCIES,
    message:  "is invalid. Currency should be one of #{VALID_CURRENCIES.join(", ")}",
    allow_nil: false
  }
  validates :output_currency, inclusion: {
  in: VALID_CURRENCIES,
    message:  "is invalid. Currency should be one of #{VALID_CURRENCIES.join(", ")}",
    allow_nil: false
  }

  before_validation :ensure_valid_currencies

  private

  def ensure_valid_currencies
    if (input_currency == output_currency)
      errors.add(:input_currency, :blank, message: "Input and Output currencies cannot be the same")
    end
  end
end
