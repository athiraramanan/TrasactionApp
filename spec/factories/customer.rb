FactoryBot.define do
  factory :customer do
    first_name { "John" }
    last_name { "Job" }
    email { 'johnjob@gmail.com' }
  end
end