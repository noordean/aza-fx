class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :input_currency
      t.decimal :input_amount, precision: 30, scale: 2
      t.string :output_currency
      t.decimal :output_amount, precision: 30, scale: 2
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
