require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = customers(:one)
  end

  test 'valid user' do
    assert @customer.valid?
  end

  test 'association to transaction' do
    assert_equal @customer.transactions.first.input_currency, 'USD'
  end
end
