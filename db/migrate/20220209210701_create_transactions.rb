class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.decimal :amount_deposited
      t.integer :currency_deposited_id
      t.decimal :amount_pay_back
      t.integer :currency_pay_back_id
      t.datetime :transaction_date
      t.timestamps
    end
  end
end

