class Transaction < ApplicationRecord
	belongs_to :customer
	belongs_to :currency_deposited, class_name: "Currency"
	belongs_to :currency_pay_back, class_name: "Currency"
  delegate :first_name,:last_name,:email,  to: :customer, allow_nil: true
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :paid
    state :cancelled
    event :approving do
      transitions from: %i[pending cancelled], to: :paid
    end
    event :cancelling do
      transitions from: %i[pending], to: :cancelled
    end
  end

	def to_api_json
		return false if customer.nil?
  	{ 'id': id, 'Customer': customer&.customer_details,'AmountDeposited': amount_deposited.round(2), 'Currency Deposited ': currency_deposited.code, 'Amount PayBack': amount_pay_back.round(2), 'Currency PayBack': currency_pay_back.code ,  'Transaction Date': transaction_date.strftime('Deposited at %m/%d/%Y %I:%M %p'), state: state} 
	end

	def amount_pay_back_to_customers
		currency_deposit = Currency.find_by_id currency_deposited_id 
		currency_pay_back = Currency.find_by_id currency_pay_back_id 
		amount_pay_back = (currency_deposit && currency_pay_back) ? Concurrency.convert(amount_deposited, currency_deposit.code, currency_pay_back.code) : false
	end
end
