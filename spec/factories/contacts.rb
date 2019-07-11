# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    zip_code { Faker::Address.zip_code.to_i }
    cell_phone { Faker::PhoneNumber.valid_cell_phone }
  end
end
