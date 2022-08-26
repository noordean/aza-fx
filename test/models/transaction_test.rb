require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = transactions(:one)
  end

  test 'valid user' do
    assert @transaction.valid?
  end

  test 'association to customer' do
    assert_equal @transaction.customer.name, 'John'
  end

  test 'validation' do
    @transaction.input_currency = 'GGG'
  
    assert_equal @transaction.valid?, false
    assert_equal(
      @transaction.errors[:input_currency].first,
      'is invalid. Currency should be one of USD, NGN, AED, EUR, GBP, GHS, JPY, KES, MAD, UGX, XOF, ZAR'
    )
  end
end
