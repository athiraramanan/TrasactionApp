FactoryBot.define do
  factory :currency_deposited,   class: 'Currency'  do
    code { "USD" }
    name { "USD" }
  end
  factory :currency_pay_back,   class: 'Currency'  do
    code { "INR" }
    name { "INR" }
  end
end

