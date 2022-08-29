require "test_helper"

class Api::V1::TransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @transaction = transactions(:one)
    @customer_two = customers(:two)
    @params = {
      input_amount: 105.34,
      output_amount: 1005.34,
      input_currency: "USD",
      output_currency: "GHS",
      customer_id: @customer_two.id
    }
  end
  

  test "transaction create" do

    post api_v1_transactions_path(@params)

    assert_response :success
    assert_equal JSON.parse(response.body)['output_amount'], '1005.34'
  end

  test "transaction create: fails if currency is invalid" do
    @params[:output_currency] = 'NNN'

    post api_v1_transactions_path(@params)

    assert_response :unprocessable_entity
    assert_equal(
      JSON.parse(response.body)['error'],
      'Validation failed: Output currency is invalid. Currency should be one of USD, NGN, AED, EUR, GBP, GHS, JPY, KES, MAD, UGX, XOF, ZAR'
    )
  end

  test "transaction create: fails both currencies are the same" do
    @params[:output_currency] = 'USD'

    post api_v1_transactions_path(@params)

    assert_response :unprocessable_entity
    assert_equal(
      JSON.parse(response.body)['error'],
      'Validation failed: Input currency Input and Output currencies cannot be the same'
    )
  end

  test "transaction create: fails if amount is negative" do
    @params[:input_amount] = -2000

    post api_v1_transactions_path(@params)

    assert_response :unprocessable_entity
    assert_equal(
      JSON.parse(response.body)['error'],
      'Validation failed: Input amount must be greater than or equal to 0'
    )
  end

  test "transaction index" do
    get api_v1_transactions_path

    assert_response :success
    assert_equal JSON.parse(response.body).count, 2
    assert_equal JSON.parse(response.body)[0]['input_currency'], 'EUR'
    assert_equal JSON.parse(response.body)[1]['input_currency'], 'USD'
  end

  test "transaction index: invalid pagination param" do
    get "#{api_v1_transactions_path}?per_page=101&page=1"

    assert_response :unprocessable_entity
    assert_equal(
      JSON.parse(response.body)['error'],
      "The per_page parameter can't be more than 100"
    )
  end

  test "transaction show" do
    get api_v1_transaction_url(id: @transaction.id)

    assert_response :success
    assert_equal JSON.parse(response.body)['input_currency'], 'USD'
  end

  test "transaction update: Successful" do
    put api_v1_transaction_path(id: @transaction.id, input_amount: 5000.0)

    assert_response :success
    assert_equal JSON.parse(response.body)['input_amount'], '5000.0'
  end

  test "transaction UPDATE: fails both currencies are the same" do
    input_currency = @transaction.output_currency

    put api_v1_transaction_path(id: @transaction.id, input_currency: input_currency)

    assert_response :unprocessable_entity
    assert_equal(
      JSON.parse(response.body)['error'],
      'Validation failed: Input currency Input and Output currencies cannot be the same'
    )
  end
end