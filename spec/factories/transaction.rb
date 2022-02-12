FactoryBot.define do
  factory :transaction do
    association :customer
    association :currency_deposited
    association :currency_pay_back
    amount_deposited { 100 }
    amount_pay_back { Concurrency.convert(100, currency_deposited.code, currency_pay_back.code)}
    transaction_date{"2022-02-01"}
  end
end