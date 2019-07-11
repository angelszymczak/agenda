# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    contact

    description { Faker::TvShows::TheITCrowd.quote }
  end
end
