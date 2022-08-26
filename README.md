# README

## Setup
- `rails db:migrate`
- `rails db:seed`
  - Take note of the customer IDs in your terminal, for subsequent requests.
- `rails s`

## Endpoints
- `POST /api/v1/transactions`
  - payload example:
    ```ruby
    {
        "input_amount": 100,
        "input_currency": "USD",
        "output_amount": 68000,
        "output_currency": "NGN",
        "customer_id": 2
    }
    ```

  - response example:
    ```ruby
    {
        "id": 2,
        "input_currency": "USD",
        "input_amount": "100.0",
        "output_currency": "NGN",
        "output_amount": "68000.0",
        "customer_id": 2,
        "created_at": "2022-08-26T08:14:55.777Z",
        "updated_at": "2022-08-26T08:14:55.777Z"
    }
    ```

- `GET /api/v1/transactions`: This can have optional `per_page` and `page` params, defaults to 100 and 1 respectively.
  - response example:
    ```ruby
        [{
            "id": 1,
            "input_currency": "USD",
            "input_amount": "100.0",
            "output_currency": "NGN",
            "output_amount": "68000.0",
            "customer_id": 1,
            "created_at": "2022-08-26T08:14:36.064Z",
            "updated_at": "2022-08-26T08:14:36.064Z"
        }]
    ```

- `GET /api/v1/transactions/:transaction_id`
  - response example:
    ```ruby
        {
            "id": 1,
            "input_currency": "USD",
            "input_amount": "100.0",
            "output_currency": "NGN",
            "output_amount": "68000.0",
            "customer_id": 1,
            "created_at": "2022-08-26T08:14:36.064Z",
            "updated_at": "2022-08-26T08:14:36.064Z"
        }
    ```